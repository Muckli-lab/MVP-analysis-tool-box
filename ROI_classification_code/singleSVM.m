%The analysis code that was used in: Vetter P., Bola L., Reich L., Bennett M., Muckli L., Amedi A. (2020). Decoding natural sounds in early “visual” cortex of congenitally blind individuals. Current Biology.
%The code was originally created by Fraser W. Smith (see Smith & Muckli 2010 PNAS)and was adapted to this project by Petra Vetter and Lukasz Bola.

function [svmOut]=singleSVM(outD, permGP)

% to do single SVM analysis - once for whole of POI - no-subsampling
% only use SVM since LDA will not compute (cov will be singular)
% thus these results show --- method not dependent on voxel sub-sampling
% for significance!!!!! 

%addpath(genpath('/analyse/6/fMRI/Project8/SVM/libsvm-mat-2.86-1')); % SVM toolbox
%addpath(genpath('\_fMRI\7TdataMinnesota\SVM\libsvm-mat-2.86-1')); % SVM toolbox


% get betas and pars
betasC=outD.betasC;
p=outD.S{3};  

nTrials=p(1);
nConditions=p(2);
nPerRun=p(3);
nVert=size(betasC,2);  %% always take updated value from betasC matrix
nRuns=p(5);

CondClass=outD.S{5}.CondClass;   %% conditions to classify

% parse for cross-validation cycles
[train_set, test_set, anovas]=parse_runs_surf(betasC);


% output variables
svm_ws=cell(1,nRuns);
svm_class=[];%zeros(nPerRun*(nRuns-1),nRuns);
svma_class=zeros(3,nRuns);
svm_cm=zeros(3,3,nRuns);
svm_cmR=zeros(size(svm_cm)); % ties rnd
svm_pc=zeros(nRuns,1);
svm_pcR=zeros(size(svm_pc)); % ties rnd
svm_av=zeros(nRuns,1);
svm_avR=zeros(nRuns,1);
svm_mod=cell(1,nRuns);
predL1=[]; predL2=[]; predL1a=[]; predL2a=[];
   
% main loop - over cross-validation cycles    

for r=1:size(train_set,3)  

    % Define train and test for this cycle of cross-validation
    train=train_set(:,:,r);  
    test2=test_set(:,:,r);

    % coding variable for TRAINING - assumes leave one run out
    % cross-validation
    
    gp=[]; k=1; l=nPerRun*(nRuns-1);
    for ii=1:nConditions
        gp(k:l,1)=ii;
        k=k+nPerRun*(nRuns-1);
        l=l+nPerRun*(nRuns-1);
    end
    
    % allow for possibility to permute label vector
    % this will allow the creation of a randomization distribution
    % for good comparison purposes
    if(permGP==1)
        f=randperm(length(gp));
        gp=gp(f);
    end
    
    
    if(size(train,1)~=size(gp,1))
        error('Training and gp vector mismatch');
    end


    % also run it on the average for each condition in test run
    in=zeros(nConditions, size(test2,2));
    k=1; l=nPerRun;
    for i=1:nConditions
        in(i,:)=mean(test2(k:l,:));
        k=k+nPerRun; l=l+nPerRun;
    end


    % ***single trial SVM prediction***
    
    % put on -1 to 1 scale
    [train, pars]=stretch_cols_ind(train, -1,1); 
    
    % train svm model
    svm_model=svmtrain(gp, train,'-t 0 -c 1');    % -t 0 = linear SVM, -c 1 = cost value of 1
    svm_mod{r}=svm_model;
    
    % get the weights from model
    svm_weights=svm_DefineWeights(svm_model);  
    svm_ws{r}=svm_weights;

    %% define test coding variable
    gp_test=[]; k=1; l=nPerRun;
    for ii=1:nConditions
        gp_test(k:l,1)=ii;
        k=k+nPerRun;
        l=l+nPerRun;
    end

    % test svm model
    %[test2, pars]=stretch_cols_ind(test2, -1,1);
    [test2]=stretchWithGivenPars(test2,[-1 1],pars);  %% put on same scale

    [svm_class(:,r),accuracy,dec]=svmpredict(gp_test,test2,svm_model);

    sortL=1; doCorr=1; % rnd assign when tied
    [predL1(:,r),predL2(:,r)]=Pereira_decVals2Classes(dec,svm_model,sortL,doCorr);
    
    pf=length(find(svm_class(:,r)==predL1(:,r)));
    if(pf~=length(svm_class(:,r)))
        error('svm class and predL1 error/n');
    else
        % compute performance on test runs
        fRnd=zeros(nConditions);  %% confusion matrix 

        k=1; l=nPerRun;
        for i=1:nConditions
            for j=1:nConditions
                fRnd(i,j)=length(find(predL2(k:l,r)==j));
            end
            k=k+nPerRun; l=l+nPerRun;
        end

        svm_cmR(:,:,r)=fRnd;
        svm_pcR(r)=trace(fRnd)/(nPerRun*(nConditions));
    end

    % compute performance on test runs
    f=zeros(nConditions);  %% confusion matrix 

    k=1; l=nPerRun;
    for i=1:nConditions
        for j=1:nConditions
            f(i,j)=length(find(svm_class(k:l,r)==j));
        end
        k=k+nPerRun; l=l+nPerRun;
    end

    svm_cm(:,:,r)=f;
    svm_pc(r)=trace(f)/(nPerRun*(nConditions));  


    %% **Test SVM Prediction of Condition Average in Test Run**
    [in]=stretchWithGivenPars(in,[-1 1],pars);  %% put on same scale

    [svma_class(:,r),accuracy,dec]=svmpredict([1 2 3]',in,svm_model);
    
    [predL1a(:,r),predL2a(:,r)]=Pereira_decVals2Classes(dec,svm_model,sortL,doCorr);

    svm_av(r)=length(find(svma_class(:,r)==[1 2 3]')) ./ (nConditions);
    
    pfA=length(find(svma_class(:,r)==predL1a(:,r)));
    if(pfA~=length(svma_class(:,r)))
        error('svm class av and predL1a error/n');
    else
        svm_avR(r)=length(find(predL2a(:,r)==[1 2 3]')) ./ (nConditions);
    end

end   %% end cross-validation loop (runs)


% derive CM of average data
nClass=length(CondClass);
for i=1:size(svma_class,1)
    for j=1:nClass
        cmAv(i,j)=length(find(svma_class(i,:)==j));
    end
end
cmAv=cmAv./(size(svma_class,2));

for i=1:size(predL2a,1)
    for j=1:nClass
        cmAvR(i,j)=length(find(predL2a(i,:)==j));
    end
end
cmAvR=cmAvR./(size(predL2a,2));

% format to output nicely
data{1}=train_set;
data{2}=test_set;
data{3}=anovas;

svmOut=[];
svmOut.models=svm_mod;    %% the SVM model for each cross-validation fold
svmOut.ws=svm_ws;         %% weights for each binary classification pbm
svmOut.class=svm_class;   %% single trial/block classifications
svmOut.Aclass=svma_class; %% average classification
svmOut.cm=svm_cm;         %% confusion matrices for single trial/block classifications
svmOut.pc=svm_pc;         %% percentage correct single trial/block
svmOut.av=svm_av;         %% percentage correct average
svmOut.data=data;         %% parsed data used in classifier
svmOut.cmAv=cmAv;         %% average confusion matrix

% these are new 4/4/12 from unbiased multiclass (ie rnd assign observation
% to group here - rather than just always pick first class - libSVM issue)
svmOut.pcR=svm_pcR;       %% accuracy from unbiases confusion matrices (single trial/block)
svmOut.cmR=svm_cmR;       %% unbiased confusion matrices (single trial/block)
svmOut.avR=svm_avR;       %% accuracy from unbiased multiclass (average)
svmOut.AclassR=predL2a;   %% average classification unbiased multiclass
svmOut.cmAvR=cmAvR;       %% average confusion matrix bias free




% t=[];
% p=[];
% 
% if(marker==1 || marker==2)
%         
%     % single block
%     m=mean(svm_pc);  %% one mean per subject
%     t=(mean(m)-1/3)./(std(m)./sqrt(length(m)));
% 
%     df=length(m)-1;
%     p=1-tcdf(t,df);  %% one tailed p for m>1/3
% 
%     % average
%     m=mean(svm_av);  %% one mean per subject
%     t(2)=(mean(m)-1/3)./(std(m)./sqrt(length(m)));
% 
%     df=length(m)-1;
%     p(2)=1-tcdf(t(2),df);
%     
% elseif(marker==3)
%     
%     % single block
%     for r=1:2
%         m=svm_pc(r,:);  %% one mean per subject
%         t(r)=(mean(m)-1/3)./(std(m)./sqrt(length(m)));
% 
%         df=length(m)-1;
%         p(r)=1-tcdf(t(r),df);
%     end
% 
%     % average
%     for r=1:2
%         m=(svm_av(r,:));  %% one mean per subject
%         tAv(r)=(mean(m)-1/3)./(std(m)./sqrt(length(m)));
% 
%         df=length(m)-1;
%         pAv(r)=1-tcdf(tAv(r),df);
%     end
% end
%     
% 
% 
% outname=sprintf('SingleSVM_BlockDesign_Patch%d_Marker%d_zBetas%d_notUni%d.mat', Patch_ind,marker,zBetas,notUni);
% 
% save(outname);

