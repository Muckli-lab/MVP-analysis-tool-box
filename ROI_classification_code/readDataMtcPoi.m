%The analysis code that was used in: Vetter P., Bola L., Reich L., Bennett M., Muckli L., Amedi A. (2020). Decoding natural sounds in early “visual” cortex of congenitally blind individuals. Current Biology.
%The code was originally created by Fraser W. Smith (see Smith & Muckli 2010 PNAS)and was adapted to this project by Petra Vetter and Lukasz Bola.

function [outD]=readDataMtcPoi(subject,Patch_ind, Hem,CondClass,POIfile_ind)

% subject= subject code
% Hem = 'LH' or 'RH'
% Patch_ind - refers to number of Patch in POI file to consider (1,2 or 3)
% POIfile_ind: refers to the POI file that shall be used (1,2 or 3)

fileNames=getFileInfo(subject,Hem,CondClass,POIfile_ind);  %% getFileInfo, for given hemisphere and subject and task

zBetas=0;           %% z score betas AFTER GLM prior to classifier analyses

zTimeSeries=1;      %% this is critical - if zTimeSeries==1, then betas should
                    % be comparable to those computed by BV with zNorm on,
                    % otherwise betas are highly correlated but on diff scale

% load in BV toolbox
%addpath(genpath('/analyse/6/fMRI/Project8/BVQXtools_v07f'));

% sort file names from input
dirName=fileNames.dir_name;
poiName=fileNames.poi_name;
mtcName=fileNames.mtc_name;
dmName=fileNames.dm_name;
condLocs=fileNames.cond_locs;
p=fileNames.pars;  %% nClass and nVols
subject=fileNames.subject;

% some parameters
nRuns=length(mtcName);
nVols=p(1);
nPreds=p(2);
nTrials=p(3);
nPerRun=p(4);
CondClass=fileNames.CondClass;
nConditions=length(CondClass);

% load in POI FILE
poi=BVQXfile([dirName poiName]);
nPOI=poi.NrOfPOIs;  
locsV=[];

% note the **unique** function here
if(nPOI==1)
    locsV=unique(poi.POI.Vertices);
    %unique returns the same array without repetitions
else
    if(exist('Patch_ind', 'var'))
        locsV=unique(poi.POI(Patch_ind).Vertices);  
    end
end

nVert=length(locsV);
mtcData=zeros(nVols,nVert,nRuns);
DM=zeros(nVols,nPreds,nRuns);
betas=zeros(nPreds-1,nVert,nRuns);  %% minus one for mean confound
tvals=zeros(size(betas));

%In the following, a GLM is run for each run with the design matrix of each
%run. This basically does the "averaging" across time (mtc data is a time series).
%The resulting beta weights for each voxel (derived for each block
%of 12 sec) are then used as input for the pattern classification. I.e.
%there will be a multivariate pattern of betas across voxels (space) but not
%across time

% main loop
for r=1:nRuns

    % load in MTC DATA

    main=BVQXfile([dirName mtcName{r}]);
    mtcData(:,:,r)=double(main.MTCData(:,locsV));  %% get VERTS timecourses from POI file

    
    if(length(find(mtcData(:,:,r)==0))>0)
        error('Zeros in mtc data: requires further thought!');
    end
 

    % load in DESIGN MATRIX file
    dmTmp=BVQXfile([dirName dmName{r}]);
    DM(:,:,r)=dmTmp.SDMMatrix;

    if(size(DM,1)~=size(mtcData,1))
        error('Design Matrix and MTC data volume number does not match');
    end



    % PERFORM GLM COMPUTATION - SINGLE TRIAL / BLOCK COMPUTATION
    

    % glm performed single trial / block, not deconvolved (can't be)
    % importantly I am zscoring the timeseries here before running GLM
    % in order to obtain comparable values to BV output
    [out,out2]=computeGLM(mtcData(:,:,r), DM(:,:,r), zTimeSeries,zBetas);

    betas(:,:,r)=out(1:nPreds-1,:);  %% remove last beta, mean confound
    tvals(:,:,r)=out2(1:nPreds-1,:);  %% t values
    %the dimensions here (e.g. 1:nPreds-1) need to match whatever was defined above,
    %otherwise dimension mismatch
    
end   %% end loop across runs
    
    
   
% GET THE DESIGN SEQUENCE AND PARSE BETAS CONDITION-WISE

% load in sequence (condition data)
nTrials=size(betas,1);
%nPerRun=6;
betasC=zeros(nPerRun,nVert,nConditions,nRuns);  %% betas split by condition
tvalsC=zeros(nPerRun,nVert,nConditions,nRuns);

for r=1:nRuns
    
    seq=condLocs(:,r);
    %seq=load([dirName condLocs{r}]);
    %seq=seq';  %% flip for my data (in rows)
    %seq=seq(:);  %%concatenate into one trial vector of conditions codes

    for i=1:nConditions
        f=find(seq==CondClass(i));  %% find where each cond is present (across trials)
        if(length(f)==nPerRun)
            betasC(:,:,i,r)=betas(f,:,r);   %% separate out each condition
            tvalsC(:,:,i,r)=tvals(f,:,r);
        else
            error('Not correct number per condition');
        end
    end
end


%PUT IN NICE STRUCTURES for OUTPUTTING
p(1)=nTrials;
p(2)=nConditions;
p(3)=nPerRun;
p(4)=nVert;  
p(5)=nRuns;
p(6)=nVols;

s=cell(1,4);
s{1,1}=subject;
s{1,2}=dirName;         %% where to save any output files
s{1,3}=p;               %% useful parameters
s{1,4}=locsV;           %% all verts in POI
s{1,5}=fileNames;   


outD=[];
outD.betasC=betasC;     %% betas by condition
outD.betas=betas;       %% betas by runs
outD.tvalsC=tvalsC;     %% t vals by condition
outD.data=mtcData;      %% raw vertice timecourses for POI
outD.DM=DM;             %% design matrices
outD.S=s;               %% useful parameters



%%%% FINALLY COMPUTE UNIVARIATE ANOVAS  
% ** be careful ** not to select voxels on this basis for entry to classifier -
% is biased if selected across all runs, needs to be only training runs!!!
%anova=compute_ANOVAS(outD);  %% compute univariate discrimination across ALL RUNS
%outD.anova=anova;
%this univariate analysis is run just to see whether there are univariate
%effects in the data. This is independent from the pattern classification.





