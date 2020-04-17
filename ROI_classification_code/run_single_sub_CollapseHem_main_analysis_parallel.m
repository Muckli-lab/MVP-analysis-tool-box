%The analysis code that was used in: Vetter P., Bola L., Reich L., Bennett M., Muckli L., Amedi A. (2020). Decoding natural sounds in early “visual” cortex of congenitally blind individuals. Current Biology.
%The code was originally created by Fraser W. Smith (see Smith & Muckli 2010 PNAS)and was adapted to this project by Petra Vetter and Lukasz Bola.

function run_single_sub_CollapseHem_main_analysis_parallel(subject,Patch_ind,CondClass,POIfile_ind)
% subject = 'CGY09';
% CondClass = [1 2 3];
% Patch_ind=1;
% POIfile_ind=2;
% %this is the script to be run for the permutation analysis

tic
% subject='DHE05';
% Patch_ind=1;  %% poi index (eg. 1 for V1, 2 for V2v etc. depending on how
% many pois and in which order they are defined)
% CondClass=[1 2 3];   %% CRUCIAL- which conditions to classify
%needs to correspond to the numbers (condition definitions) in the trial sequence

%% CHANGE file name under which the results are saved - see below

permGP=1;     %% set to zero for standard analysis, set to 1 when doing permutation analysis

% prepare data - get timeseries, do GLM etc
[outDL]=readDataMtcPoi(subject,Patch_ind, 'LH',CondClass,POIfile_ind);
[outDR]=readDataMtcPoi(subject,Patch_ind, 'RH',CondClass,POIfile_ind);

% concatenate across vertice dimension - hemispheres
outD=[];
f1=size(outDL.betasC);
f2=size(outDR.betasC);
if(f1(1)==f2(1) && f1(3)==f2(3) && f1(4)==f2(4))
    betasC=cat(2,outDL.betasC,outDR.betasC); 
    S{3}=outDL.S{3};
    S{3}(4)=f1(2)+f2(2);
    f=[]; 
    f.CondClass=CondClass;
    S{5}=f;
    outD.betasC=betasC;
    outD.S=S;
    
else
    error('Hemispheric Data mismatch');
end

%load the randomisation vector for the permutation analysis
load randVecPerm;
inputRandVec = f;
%this vector needs to be the same for each subject!

% perform classification for Permutation Analysis
Spc=zeros(1000,1); Apc=zeros(1000,1);
betasC=outD.betasC;
p=outD.S{3};
CondClass=outD.S{5}.CondClass;

toc % gives time for GLM / load data etc
tic
% parse for cross-validation cycles
[train_set, test_set, anovas]=parse_runs_surf(betasC);


toc % gives time for above line
tic
parfor (i=1:1000)
    %randVec=inputRandVec(:,i);
    [svmOutPerm]=singleSVM_PermP(train_set,test_set,p, CondClass, permGP,inputRandVec(:,i));
    Spc(i)=mean(svmOutPerm.pc);
    Apc(i)=mean(svmOutPerm.av);
end
toc  %% time for 1000 perms in parallel

% perform classification for real data
permGP = 0;
[svmOutObs]=singleSVMP(betasC,p,CondClass,permGP);
Obs_Spc=mean(svmOutObs.pc);
Obs_Apc=mean(svmOutObs.av);

pPerm_Spc=length(find(Spc >= Obs_Spc)) ./ 1000;
pPerm_Apc=length(find(Apc >= Obs_Apc)) ./ 1000;

% t test across runs
%nConditions=length(outD.S{5}.CondClass);  %% conditions being classified
%[hST,pST,ci,statsST]=ttest(svmOut.pc,1/nConditions,.05,'right'); % single trial
%[hAV,pAV,ci,statsAV]=ttest(svmOut.av,1/nConditions,.05,'right'); % average

%save FWStestCGY09_V5.mat
% to save the output
 outname=sprintf('%s_MainAnalysis_CollapseHem_Patch%d_POI%d.mat', subject, Patch_ind,POIfile_ind);
save(outname, 'subject','Patch_ind','permGP','outD','svmOutObs','pPerm_Spc','pPerm_Apc','Spc','Apc');
