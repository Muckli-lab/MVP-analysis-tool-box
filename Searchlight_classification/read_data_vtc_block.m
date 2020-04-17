%The analysis code that was used in: Vetter P., Bola L., Reich L., Bennett M., Muckli L., Amedi A. (2020). Decoding natural sounds in early “visual” cortex of congenitally blind individuals. Current Biology.
%The code was originally created by Fraser W. Smith (see Smith & Muckli 2010 PNAS)and was adapted to this project by Petra Vetter and Lukasz Bola.


function read_data_vtc_block(subject)

% function to read a series of VTCs and corresponding SDMs
% and extract average of relevant volumes for classification
% VTCs are masked with GLM .001 mask to delineate brain tissue
% also finds associated trial information (labels)

% modified from read_data_mtc_poi.m
% FWS 9/7/10
fileNames=getFileInfo_vtc(subject);  %% getFileInfo

zBetas=0;           %% z score betas AFTER GLM prior to classifier analyses

zTimeSeries=1;      %% this is critical - if zTimeSeries==1, then betas should
                    % be comparable to those computed by BV with zNorm on,
                    % otherwise betas are highly correlated but on diff scale


% sort file names from input
dirName=fileNames.dir_name;
%mskName=fileNames.msk_name{1};
vtcName=fileNames.vtc_name;
dmName=fileNames.dm_name;
p=fileNames.pars;  %% nClass and nVols
subject=fileNames.subject;
condLocs=fileNames.cond_locs;



% some parameters
nRuns=length(vtcName);
nVols=p(1);
nPreds=p(2);
nTrials=p(3);
nPerRun=p(4);
CondClass=1:3;%fileNames.CondClass;
nConditions=length(CondClass);

% load in msk FILE
%msk=BVQXfile([dirName mskName]); 
msk=load('8BlindSub_commonMaskFile.mat');  %% find common across all subject
locsV=find(msk.sMask2); %% location of brain voxels
nVox=length(locsV);

% define matrices
vtcData=zeros(nVols,nVox,nRuns);
DM=[];
cCodes=[];
betas2=zeros(nPreds-1,nVox,nRuns);  %% minus one for mean confound
tvals2=zeros(size(betas2));


% main loop
for r=1:nRuns

    % load in VTC DATA

    main=BVQXfile([dirName vtcName{r}]);
    %vtcData(:,:,r)=double(main.VTCData(:,locsV));  %% get VERTS timecourses from POI file

    for i=1:nVols
        tmp=[];
        tmp=squeeze(main.VTCData(i,:,:,:));  %% one volume all voxels
        vtcData(i,:,r)=tmp(locsV);
    end
    
%     if(length(find(vtcData(:,:,r)==0))>0)
%         error('Zeros in vtc data: requires further thought!');
%     end
 

    % load in DESIGN MATRIX file
     tmp2=BVQXfile([dirName dmName{r}]);
     DM(:,:,r)=tmp2.SDMMatrix;
% 
     if(size(DM,1)~=size(vtcData,1))
         error('Design Matrix and MTC data volume number does not match');
     end
   
    % PERFORM GLM COMPUTATION - SINGLE TRIAL / BLOCK COMPUTATION
    

    % glm performed single trial / block, not deconvolved (can't be)
    % importantly I am zscoring the timeseries here before running GLM
    % in order to obtain comparable values to BV output
   % [out,out2]=compute_glm2_test(vtcData(:,:,r), DM(:,:,r), zTimeSeries,zBetas);
   betas=[];
   tic
   [betas,t]=compute_glm2_parallel(vtcData(:,:,r), DM(:,:,r), zTimeSeries,zBetas);
   toc

    betas2(:,:,r)=betas(1:nPreds-1,:);  %% remove last beta, mean confound
    tvals2(:,:,r)=t(1:nPreds-1,:);  %% t values
    
    fprintf('Computed Run %d\n', r);
    
end   %% end loop across runs

%%%%%%%% THIS IS FOR NON-BETA ANALYSES (IE RAW SIGNAL)
% % % normalize the data - - mean correct each voxel
% % % each run - mean across entire timecourse per run
% % m=(mean(vtcData,1));  % mean across timecourse per vox & run
% % m2=repmat(m,[nVols 1 1]);
% % vtcDataN=vtcData-m2;
% % 
% % % get the estimates for the pattern classifier - a few different ways
% % vols=blockDesignSeq2;  % note the 2 here - for the tvision exp
% % f=find(vols(:,3)==2);  % find stim trials
% % expr_inds(:,1:3)=vols(f,:);  %vol onsets of visual objects - checked FWS 15/3/11
% % 
% % expr_inds(:,1:2)=expr_inds(:,1:2)+2;  %% in TRs not secs!!! %% hrf offset 4s (Walther et al, Kamitani + Tong,2005)
% % 
% % % extract data - 6TRS -12s stim, shifted by 2TRs (above) to capture HRF
% % obs=[];
% % for r=1:nRuns
% %     for i=1:nTrials
% %         tmp=vtcDataN(expr_inds(i,1):expr_inds(i,2),:,r);
% %         obs(r,i,1:6,:)=tmp;
% %     end
% % end
% % obs=squeeze(mean(obs,3));  %% average of stim period (K+T, Walther classifies each vol)


% % parse format for Searchmight toolbox 
% % (m*n matrix, obs by features,1*m class labels, 1*m labels gp for CV)
k=1; l=nTrials;
cumObs=zeros(nTrials*nRuns,nVox);
cumSeq=[];
runLabels=[];
for i=1:nRuns
    cumObs(k:l,:)=betas2(:,:,i);
    cumSeq(k:l,1)=condLocs(:,i);
    runLabels(k:l,1)=i;
    k=k+nTrials; l=l+nTrials;
end

% 
% % %PUT IN NICE STRUCTURES for OUTPUTTING
p(1)=nTrials;
p(2)=nConditions;
p(3)=nPerRun;
p(4)=nVox;  
p(5)=nRuns;
p(6)=nVols;
% 
s=cell(1,4);
s{1,1}=subject;
s{1,2}=dirName;         %% where to save any output files
s{1,3}=p;               %% useful parameters
s{1,4}=locsV;           %% all verts in POI
s{1,5}=fileNames;   
% 
% 
outD=[];
outD.cumObs=cumObs;
outD.cumSeq=cumSeq;
outD.runLabels=runLabels;
outD.S=s;


save(sprintf('%s_SingleBlockRespEstBetas_Searchlight.mat',subject),'outD');

% outD.betasC=betasC;     %% betas by condition
% outD.cumBetas=cumBetas; %% betas collapsed by runs
% outD.cumTvals=cumT;     %% t vals collapsed by runs
% outD.cumSeq=cumSeq;     %% condition codes
% outD.runLabels=runLabels;  %% run codes (needed for Searchmight)
% %outD.data=vtcData;     %% raw vertice timecourses for POI
% outD.DM=DM;             %% design matrices
% outD.S=s;               %% useful parameters
% 
% 
% 
% %%%% FINALLY COMPUTE UNIVARIATE ANOVAS  
% % ** be careful ** not to select voxels on this basis for entry to classifier -
% % is biased if selected across all runs, needs to be only training runs!!!
% anova=compute_ANOVAS(outD);  %% compute univariate discrimination across ALL RUNS
% outD.anova=anova;






