%The analysis code that was used in: Vetter P., Bola L., Reich L., Bennett M., Muckli L., Amedi A. (2020). Decoding natural sounds in early “visual” cortex of congenitally blind individuals. Current Biology.
%The code was originally created by Fraser W. Smith (see Smith & Muckli 2010 PNAS)and was adapted to this project by Petra Vetter and Lukasz Bola.

function [train_set, test_set, anovas]=parse_runs_surf(mask_vox2)
% checked 7/9/09

[nPerRun, nVert, nConditions, nRuns]=size(mask_vox2);

% leave one run out cross-validation
code=nchoosek(1:nRuns,nRuns-1);  %% train on n-1, test nth
%if nRuns = 4, the function nchoosek will return a matrix where each row
%contains the numbers 1-4 with one number taken out, in each of the 4 rows
%there is a different number taken out
count=zeros(nRuns);
train_set=zeros((nRuns-1)*nPerRun*nConditions, nVert, nRuns);
test_set=zeros(nConditions*nPerRun, nVert, nRuns);


for r=1:nRuns  %% cross-validation folds
    
    % collapse across runs
    tmp=zeros(nPerRun,nVert,nConditions);
    for i=1:nRuns-1
        tmp=cat(1,tmp,mask_vox2(:,:,:,code(r,i)));
      %  fprintf('Training Runs:%d\t%d\t%d\n', code(r,i));
        count(r,code(r,i))=count(r,code(r,i))+1;
    end

    training=tmp(nPerRun+1:end,:,:);  %% should be nPerRun*(nRuns-1) by nVert by nCOnditions

    t=find(count(r,:)==0);
    test1=mask_vox2(:,:,:,t);  %% find non used run
    %fprintf('Test Run: %d\n\n\n',t);
    
    
    % collapse over conditions for both training and test
    
    % training
    tmp1=zeros(nPerRun*(nRuns-1),nVert);
    for i=1:nConditions
        tmp1=cat(1,tmp1,training(:,:,i));
    end
    
    train=tmp1(nPerRun*(nRuns-1)+1:end,:);  


    % test
    tmp2=zeros(nPerRun,nVert);
    for i=1:nConditions
        tmp2=cat(1,tmp2,test1(:,:,i));
    end
    
    test2=tmp2(nPerRun+1:end,:);
    
    
    train_set(:,:,r)=train;
    test_set(:,:,r)=test2;
    
    % add anova for each training set (ie not on all data, just training)
    gp=[]; k=1; l=nPerRun*(nRuns-1);
    for ii=1:nConditions
        gp(k:l,1)=ii;
        k=k+nPerRun*(nRuns-1);
        l=l+nPerRun*(nRuns-1);
    end
    
    [anovas(:,:,r)]=voi_ANOVA(squeeze(train_set(:,:,r)), gp);
    
end



    