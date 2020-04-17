%The analysis code that was used in: Vetter P., Bola L., Reich L., Bennett M., Muckli L., Amedi A. (2020). Decoding natural sounds in early “visual” cortex of congenitally blind individuals. Current Biology.
%The code was originally created by Fraser W. Smith (see Smith & Muckli 2010 PNAS)and was adapted to this project by Petra Vetter and Lukasz Bola.

function run_single_sub_CollapseHem_get_unbiased_conf_mats(subject,Patch_ind,CondClass,POIfile_ind)
% this is the later version incorporating the non-biased computation of the
% confusion matrices

% subject='DHE05';
% Patch_ind=1;  %% poi index (eg. 1 for V1, 2 for V2v etc. depending on how
% many pois and in which order they are defined)
% CondClass=[1 2 3];   %% CRUCIAL- which conditions to classify
%needs to correspond to the numbers (condition definitions) in the trial sequence

%% CHANGE file name under which the results are saved - see below

permGP=0;     %% set to zero for standard analysis, set to 1 when doing permutation analysis

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



% perform classification
[svmOut]=singleSVM(outD, permGP);

% t test across runs
%nConditions=length(outD.S{5}.CondClass);  %% conditions being classified
%[hST,pST,ci,statsST]=ttest(svmOut.pc,1/nConditions,.05,'right'); % single trial
%[hAV,pAV,ci,statsAV]=ttest(svmOut.av,1/nConditions,.05,'right'); % average


% to save the output
outname=sprintf('%s_UnbiasedConfMatsCollapseHem_Patch%d_POI%d.mat', subject, Patch_ind, POIfile_ind);
save(outname, 'subject','Patch_ind','permGP','outD','svmOut');
