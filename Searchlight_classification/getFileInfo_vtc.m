%The analysis code that was used in: Vetter P., Bola L., Reich L., Bennett M., Muckli L., Amedi A. (2020). Decoding natural sounds in early “visual” cortex of congenitally blind individuals. Current Biology.
%The code was originally created by Fraser W. Smith (see Smith & Muckli 2010 PNAS)and was adapted to this project by Petra Vetter and Lukasz Bola.


function [input_file_info]=getFileInfo_vtc(subject)

%%% important parameters
nVols=218;
nPreds=18+1;   %% number of stimulation blocks plus 1 for baseline
%CondClass=1:3;   %% the conditions to classify, their codes in txt file
nTrials=18; %number of stimulation blocks (without baseline) per run
nPerRun=6;   %% number of blocks per condition per run

if(strcmp(subject,'EL'))
    nVols=113; % EL underwent a short version of the experiment 
    dir_name='/Users/lukasz/Desktop/Sound_decoding_in_the_blind_final/EL/';
    % (note the slashes change direction on a pc vs mac/linux)
    
    vtc_name{1}='EL_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{2}='EL_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{3}='EL_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{4}='EL_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    
    % the design matrix files (single trial, single block based)
    dm_name{1}='EL_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{2}='EL_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{3}='EL_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{4}='EL_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    
    % the condition specifier files
    % crucial file, maps single trials or blocks onto experimental conditions
    cond_locs_name{1}='EL_run1_AVScenesBlind_trialseq.txt';
    cond_locs_name{2}='EL_run2_AVScenesBlind_trialseq.txt';
    cond_locs_name{3}='EL_run3_AVScenesBlind_trialseq.txt';
    cond_locs_name{4}='EL_run4_AVScenesBlind_trialseq.txt';

elseif(strcmp(subject,'EMA'))
    dir_name='/Users/lukasz/Desktop/Sound_decoding_in_the_blind_final/EMA/';
    % (note the slashes change direction on a pc vs mac/linux)
    
    vtc_name{1}='EMA_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{2}='EMA_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{3}='EMA_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{4}='EMA_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    
    % the design matrix files (single trial, single block based)
    dm_name{1}='EMA_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{2}='EMA_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{3}='EMA_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{4}='EMA_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    
    % the condition specifier files
    % crucial file, maps single trials or blocks onto experimental conditions
    cond_locs_name{1}='EMA_run1_AVScenesBlind_trialseq.txt';
    cond_locs_name{2}='EMA_run2_AVScenesBlind_trialseq.txt';
    cond_locs_name{3}='EMA_run3_AVScenesBlind_trialseq.txt';
    cond_locs_name{4}='EMA_run4_AVScenesBlind_trialseq.txt';    
elseif(strcmp(subject,'GAG'))
    dir_name='/Users/lukasz/Desktop/Sound_decoding_in_the_blind_final/GAG/';
    % (note the slashes change direction on a pc vs mac/linux)
    
    vtc_name{1}='GAG_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{2}='GAG_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{3}='GAG_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{4}='GAG_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    
    % the design matrix files (single trial, single block based)
    dm_name{1}='GAG_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{2}='GAG_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{3}='GAG_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{4}='GAG_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    
    % the condition specifier files
    % crucial file, maps single trials or blocks onto experimental conditions
    cond_locs_name{1}='GAG_run1_AVScenesBlind_trialseq.txt';
    cond_locs_name{2}='GAG_run2_AVScenesBlind_trialseq.txt';
    cond_locs_name{3}='GAG_run3_AVScenesBlind_trialseq.txt';
    cond_locs_name{4}='GAG_run4_AVScenesBlind_trialseq.txt'; 
elseif(strcmp(subject,'MF'))
    dir_name='/Users/lukasz/Desktop/Sound_decoding_in_the_blind_final/MF/';
    % (note the slashes change direction on a pc vs mac/linux)
    
    vtc_name{1}='MF_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{2}='MF_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{3}='MF_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{4}='MF_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    
    % the design matrix files (single trial, single block based)
    dm_name{1}='MF_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{2}='MF_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{3}='MF_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{4}='MF_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    
    % the condition specifier files
    % crucial file, maps single trials or blocks onto experimental conditions
    cond_locs_name{1}='MF_run1_AVScenesBlind_trialseq.txt';
    cond_locs_name{2}='MF_run2_AVScenesBlind_trialseq.txt';
    cond_locs_name{3}='MF_run3_AVScenesBlind_trialseq.txt';
    cond_locs_name{4}='MF_run4_AVScenesBlind_trialseq.txt'; 
elseif(strcmp(subject,'MM'))
    dir_name='/Users/lukasz/Desktop/Sound_decoding_in_the_blind_final/MM/';
    % (note the slashes change direction on a pc vs mac/linux)
    
    vtc_name{1}='MM_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{2}='MM_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{3}='MM_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{4}='MM_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    
    % the design matrix files (single trial, single block based)
    dm_name{1}='MM_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{2}='MM_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{3}='MM_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{4}='MM_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    
    % the condition specifier files
    % crucial file, maps single trials or blocks onto experimental conditions
    cond_locs_name{1}='MM_run1_AVScenesBlind_trialseq.txt';
    cond_locs_name{2}='MM_run2_AVScenesBlind_trialseq.txt';
    cond_locs_name{3}='MM_run3_AVScenesBlind_trialseq.txt';
    cond_locs_name{4}='MM_run4_AVScenesBlind_trialseq.txt';     
elseif(strcmp(subject,'OB'))
    dir_name='/Users/lukasz/Desktop/Sound_decoding_in_the_blind_final/OB/';
    % (note the slashes change direction on a pc vs mac/linux)
    
    vtc_name{1}='OB_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{2}='OB_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{3}='OB_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{4}='OB_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    
    % the design matrix files (single trial, single block based)
    dm_name{1}='OB_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{2}='OB_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{3}='OB_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{4}='OB_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    
    % the condition specifier files
    % crucial file, maps single trials or blocks onto experimental conditions
    cond_locs_name{1}='OB_run1_AVScenesBlind_trialseq.txt';
    cond_locs_name{2}='OB_run2_AVScenesBlind_trialseq.txt';
    cond_locs_name{3}='OB_run3_AVScenesBlind_trialseq.txt';
    cond_locs_name{4}='OB_run4_AVScenesBlind_trialseq.txt'; 
elseif(strcmp(subject,'OG'))
    dir_name='/Users/lukasz/Desktop/Sound_decoding_in_the_blind_final/OG/';
    % (note the slashes change direction on a pc vs mac/linux)
    
    vtc_name{1}='OG_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{2}='OG_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{3}='OG_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{4}='OG_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    
    % the design matrix files (single trial, single block based)
    dm_name{1}='OG_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{2}='OG_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{3}='OG_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{4}='OG_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    
    % the condition specifier files
    % crucial file, maps single trials or blocks onto experimental conditions
    cond_locs_name{1}='OG_run1_AVScenesBlind_trialseq.txt';
    cond_locs_name{2}='OG_run2_AVScenesBlind_trialseq.txt';
    cond_locs_name{3}='OG_run3_AVScenesBlind_trialseq.txt';
    cond_locs_name{4}='OG_run4_AVScenesBlind_trialseq.txt'; 
elseif(strcmp(subject,'SA'))
    dir_name='/Users/lukasz/Desktop/Sound_decoding_in_the_blind_final/SA/';
    % (note the slashes change direction on a pc vs mac/linux)
    
    vtc_name{1}='SA_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{2}='SA_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{3}='SA_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    vtc_name{4}='SA_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_correctTR_voxel_2mm_iso.vtc';
    
    % the design matrix files (single trial, single block based)
    dm_name{1}='SA_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{2}='SA_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{3}='SA_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{4}='SA_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    
    % the condition specifier files
    % crucial file, maps single trials or blocks onto experimental conditions
    cond_locs_name{1}='SA_run1_AVScenesBlind_trialseq.txt';
    cond_locs_name{2}='SA_run2_AVScenesBlind_trialseq.txt';
    cond_locs_name{3}='SA_run3_AVScenesBlind_trialseq.txt';
    cond_locs_name{4}='SA_run4_AVScenesBlind_trialseq.txt'; 
end

% find condition locations and put them into one variable, cond_locs
cond_locs=[];
for i=1:4 %n of runs (number of trial seq files)
    tmp=load([dir_name cond_locs_name{i}]);
    cond_locs(:,i)=tmp;
end

% put into structure for easy parsing
input_file_names=[]; %not used anywhere else in the script - what for?
pars(1)=nVols;
pars(2)=nPreds;  %% remember to add 1 for the constant column
pars(3)=nTrials;
pars(4)=nPerRun;

input_file_info.dir_name=dir_name;
%input_file_info.poi_name=poi_name;
input_file_info.vtc_name=vtc_name;
input_file_info.dm_name=dm_name;
input_file_info.cond_locs=cond_locs;
input_file_info.pars=pars;
%input_file_info.CondClass=CondClass; %commented out at the beginning
input_file_info.subject=subject;
%input_file_info.Hem=Hem;






