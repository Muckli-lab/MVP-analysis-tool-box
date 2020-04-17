%The analysis code that was used in: Vetter P., Bola L., Reich L., Bennett M., Muckli L., Amedi A. (2020). Decoding natural sounds in early “visual” cortex of congenitally blind individuals. Current Biology.
%The code was originally created by Fraser W. Smith (see Smith & Muckli 2010 PNAS)and was adapted to this project by Petra Vetter and Lukasz Bola.

function [input_file_info]=getFileInfo(subject, Hem, CondClass, POIfile_ind)

%%% important parameters
nVols=218;
nPreds=18+1;   %% number of stimulation blocks plus 1 for baseline 
%CondClass=1:3;   %% the conditions to classify, their codes in txt file
nTrials=18; %number of stimulation blocks (without baseline) per run
nPerRun=6;   %% number of blocks per condition per run

if(strcmp(subject,'EL'))
    nVols=113; % EL underwent a short version of the experiment 
    
    % the path to the files
    dir_name='C:\Users\bolal\Desktop\Sound_decoding_in_the_blind\EL\';
    % (note the slashes change direction on a pc) 
    % the poi file - patch of interest
    
    if(Hem=='LH')
        if POIfile_ind == 1
            poi_name='POIs\Auditory_LH.poi';
         elseif POIfile_ind == 2
             poi_name='POIs\Motor_LH.poi';
         else
             poi_name = 'POIs\Visual_LH_ALIGNED_TO_EL.poi';
        end
        
    elseif(Hem=='RH')
        if POIfile_ind ==1
            poi_name='POIs\Auditory_RH.poi';
         elseif POIfile_ind ==2
             poi_name='POIs\Motor_RH.poi';
         else
             poi_name = 'POIs\Visual_RH_ALIGNED_TO_EL.poi';
        end
    end
    
    % the mtc file - mesh time course files
    if(Hem=='LH')
        mtc_name{1}='EL_AVScenes_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{2}='EL_AVScenes_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{3}='EL_AVScenes_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{4}='EL_AVScenes_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        
    elseif(Hem=='RH')
        mtc_name{1}='EL_AVScenes_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{2}='EL_AVScenes_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{3}='EL_AVScenes_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{4}='EL_AVScenes_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        
    end
    
    % the design matrix files (single trial, single block based)
    dm_name{1}='EL_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{2}='EL_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{3}='EL_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{4}='EL_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    
    dm_name2{1}='EL_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{2}='EL_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{3}='EL_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{4}='EL_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    
    % the condition specifier files
    % crucial file, maps single trials or blocks onto experimental conditions
    cond_locs_name{1}='EL_run1_AVScenesBlind_trialseq.txt';
    cond_locs_name{2}='EL_run2_AVScenesBlind_trialseq.txt';
    cond_locs_name{3}='EL_run3_AVScenesBlind_trialseq.txt';
    cond_locs_name{4}='EL_run4_AVScenesBlind_trialseq.txt';
    
elseif(strcmp(subject,'EMA'))
    
        % the path to the files
    dir_name='C:\Users\bolal\Desktop\Sound_decoding_in_the_blind\EMA\';
    % (note the slashes change direction on a pc) 
    % the poi file - patch of interest
    
    if(Hem=='LH')
        if POIfile_ind ==1
            poi_name='POIs\Auditory_LH.poi';
         elseif POIfile_ind ==2
             poi_name='POIs\Motor_LH.poi';
        else
             poi_name = 'POIs\Visual_LH_ALIGNED_TO_EMA.poi';
        end
        
    elseif(Hem=='RH')
        if POIfile_ind ==1
            poi_name='POIs\Auditory_RH.poi';
         elseif POIfile_ind ==2
             poi_name='POIs\Motor_RH.poi';
        else
             poi_name = 'POIs\Visual_RH_ALIGNED_TO_EMA.poi';
        end
    end
    
    % the mtc file - mesh time course files
    if(Hem=='LH')
        mtc_name{1}='EMA_AVScenes_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{2}='EMA_AVScenes_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{3}='EMA_AVScenes_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{4}='EMA_AVScenes_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        
    elseif(Hem=='RH')
        mtc_name{1}='EMA_AVScenes_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{2}='EMA_AVScenes_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{3}='EMA_AVScenes_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{4}='EMA_AVScenes_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        
    end
    
    % the design matrix files (single trial, single block based)
    dm_name{1}='EMA_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{2}='EMA_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{3}='EMA_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{4}='EMA_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    
    dm_name2{1}='EMA_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{2}='EMA_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{3}='EMA_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{4}='EMA_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    
    % the condition specifier files
    % crucial file, maps single trials or blocks onto experimental conditions
    cond_locs_name{1}='EMA_run1_AVScenesBlind_trialseq.txt';
    cond_locs_name{2}='EMA_run2_AVScenesBlind_trialseq.txt';
    cond_locs_name{3}='EMA_run3_AVScenesBlind_trialseq.txt';
    cond_locs_name{4}='EMA_run4_AVScenesBlind_trialseq.txt';
    
elseif(strcmp(subject,'GAG'))
    
        % the path to the files
    dir_name='C:\Users\bolal\Desktop\Sound_decoding_in_the_blind\GAG\';
    % (note the slashes change direction on a pc) 
    % the poi file - patch of interest
    
    if(Hem=='LH')
        if POIfile_ind ==1
            poi_name='POIs\Auditory_LH.poi';
         elseif POIfile_ind ==2
             poi_name='POIs\Motor_LH.poi';
        else
             poi_name = 'POIs\Visual_LH_ALIGNED_TO_GAG.poi';
        end
        
    elseif(Hem=='RH')
        if POIfile_ind ==1
            poi_name='POIs\Auditory_RH.poi';
         elseif POIfile_ind ==2
             poi_name='POIs\Motor_RH.poi';
        else
             poi_name = 'POIs\Visual_RH_ALIGNED_TO_GAG.poi';
        end
    end
    
    % the mtc file - mesh time course files
    if(Hem=='LH')
        mtc_name{1}='GAG_AVScenes_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{2}='GAG_AVScenes_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{3}='GAG_AVScenes_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{4}='GAG_AVScenes_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        
    elseif(Hem=='RH')
        mtc_name{1}='GAG_AVScenes_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{2}='GAG_AVScenes_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{3}='GAG_AVScenes_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{4}='GAG_AVScenes_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        
    end
    
    % the design matrix files (single trial, single block based)
    dm_name{1}='GAG_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{2}='GAG_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{3}='GAG_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{4}='GAG_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    
    dm_name2{1}='GAG_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{2}='GAG_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{3}='GAG_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{4}='GAG_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    
    % the condition specifier files
    % crucial file, maps single trials or blocks onto experimental conditions
    cond_locs_name{1}='GAG_run1_AVScenesBlind_trialseq.txt';
    cond_locs_name{2}='GAG_run2_AVScenesBlind_trialseq.txt';
    cond_locs_name{3}='GAG_run3_AVScenesBlind_trialseq.txt';
    cond_locs_name{4}='GAG_run4_AVScenesBlind_trialseq.txt';

elseif(strcmp(subject,'MF'))
    
        % the path to the files
    dir_name='C:\Users\bolal\Desktop\Sound_decoding_in_the_blind\MF\';
    % (note the slashes change direction on a pc) 
    % the poi file - patch of interest
    
    if(Hem=='LH')
        if POIfile_ind ==1
            poi_name='POIs\Auditory_LH.poi';
         elseif POIfile_ind ==2
             poi_name='POIs\Motor_LH.poi';
        else
             poi_name = 'POIs\Visual_LH_ALIGNED_TO_MF.poi';
        end
        
    elseif(Hem=='RH')
        if POIfile_ind ==1
            poi_name='POIs\Auditory_RH.poi';
         elseif POIfile_ind ==2
             poi_name='POIs\Motor_RH.poi';
        else
             poi_name = 'POIs\Visual_RH_ALIGNED_TO_MF.poi';
        end
    end
    
    % the mtc file - mesh time course files
    if(Hem=='LH')
        mtc_name{1}='MF_AVScenes_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{2}='MF_AVScenes_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{3}='MF_AVScenes_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{4}='MF_AVScenes_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        
    elseif(Hem=='RH')
        mtc_name{1}='MF_AVScenes_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{2}='MF_AVScenes_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{3}='MF_AVScenes_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{4}='MF_AVScenes_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        
    end
    
    % the design matrix files (single trial, single block based)
    dm_name{1}='MF_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{2}='MF_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{3}='MF_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{4}='MF_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    
    dm_name2{1}='MF_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{2}='MF_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{3}='MF_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{4}='MF_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    
    % the condition specifier files
    % crucial file, maps single trials or blocks onto experimental conditions
    cond_locs_name{1}='MF_run1_AVScenesBlind_trialseq.txt';
    cond_locs_name{2}='MF_run2_AVScenesBlind_trialseq.txt';
    cond_locs_name{3}='MF_run3_AVScenesBlind_trialseq.txt';
    cond_locs_name{4}='MF_run4_AVScenesBlind_trialseq.txt';

elseif(strcmp(subject,'MM'))
    
        % the path to the files
    dir_name='C:\Users\bolal\Desktop\Sound_decoding_in_the_blind\MM\';
    % (note the slashes change direction on a pc) 
    % the poi file - patch of interest
    
    if(Hem=='LH')
        if POIfile_ind ==1
            poi_name='POIs\Auditory_LH.poi';
         elseif POIfile_ind ==2
             poi_name='POIs\Motor_LH.poi';
        else
             poi_name = 'POIs\Visual_LH_ALIGNED_TO_MM.poi';
        end
        
    elseif(Hem=='RH')
        if POIfile_ind ==1
            poi_name='POIs\Auditory_RH.poi';
         elseif POIfile_ind ==2
             poi_name='POIs\Motor_RH.poi';
        else
             poi_name = 'POIs\Visual_RH_ALIGNED_TO_MM.poi';
        end
    end
    
    % the mtc file - mesh time course files
    if(Hem=='LH')
        mtc_name{1}='MM_AVScenes_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{2}='MM_AVScenes_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{3}='MM_AVScenes_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{4}='MM_AVScenes_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        
    elseif(Hem=='RH')
        mtc_name{1}='MM_AVScenes_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{2}='MM_AVScenes_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{3}='MM_AVScenes_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{4}='MM_AVScenes_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        
    end
    
    % the design matrix files (single trial, single block based)
    dm_name{1}='MM_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{2}='MM_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{3}='MM_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{4}='MM_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    
    dm_name2{1}='MM_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{2}='MM_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{3}='MM_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{4}='MM_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    
    % the condition specifier files
    % crucial file, maps single trials or blocks onto experimental conditions
    cond_locs_name{1}='MM_run1_AVScenesBlind_trialseq.txt';
    cond_locs_name{2}='MM_run2_AVScenesBlind_trialseq.txt';
    cond_locs_name{3}='MM_run3_AVScenesBlind_trialseq.txt';
    cond_locs_name{4}='MM_run4_AVScenesBlind_trialseq.txt';

elseif(strcmp(subject,'OB'))
    
        % the path to the files
    dir_name='C:\Users\bolal\Desktop\Sound_decoding_in_the_blind\OB\';
    % (note the slashes change direction on a pc) 
    % the poi file - patch of interest
    
    if(Hem=='LH')
        if POIfile_ind ==1
            poi_name='POIs\Auditory_LH.poi';
         elseif POIfile_ind ==2
             poi_name='POIs\Motor_LH.poi';
        else
             poi_name = 'POIs\Visual_LH_ALIGNED_TO_OB.poi';
        end
        
    elseif(Hem=='RH')
        if POIfile_ind ==1
            poi_name='POIs\Auditory_RH.poi';
         elseif POIfile_ind ==2
             poi_name='POIs\Motor_RH.poi';
        else
             poi_name = 'POIs\Visual_RH_ALIGNED_TO_OB.poi';
        end
    end
    
    % the mtc file - mesh time course files
    if(Hem=='LH')
        mtc_name{1}='OB_AVScenes_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{2}='OB_AVScenes_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{3}='OB_AVScenes_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{4}='OB_AVScenes_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        
    elseif(Hem=='RH')
        mtc_name{1}='OB_AVScenes_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{2}='OB_AVScenes_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{3}='OB_AVScenes_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{4}='OB_AVScenes_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        
    end
    
    % the design matrix files (single trial, single block based)
    dm_name{1}='OB_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{2}='OB_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{3}='OB_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{4}='OB_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    
    dm_name2{1}='OB_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{2}='OB_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{3}='OB_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{4}='OB_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    
    % the condition specifier files
    % crucial file, maps single trials or blocks onto experimental conditions
    cond_locs_name{1}='OB_run1_AVScenesBlind_trialseq.txt';
    cond_locs_name{2}='OB_run2_AVScenesBlind_trialseq.txt';
    cond_locs_name{3}='OB_run3_AVScenesBlind_trialseq.txt';
    cond_locs_name{4}='OB_run4_AVScenesBlind_trialseq.txt';

elseif(strcmp(subject,'OG'))
    
        % the path to the files
    dir_name='C:\Users\bolal\Desktop\Sound_decoding_in_the_blind\OG\';
    % (note the slashes change direction on a pc) 
    % the poi file - patch of interest
    
    if(Hem=='LH')
        if POIfile_ind ==1
            poi_name='POIs\Auditory_LH.poi';
         elseif POIfile_ind ==2
             poi_name='POIs\Motor_LH.poi';
        else
             poi_name = 'POIs\Visual_LH_ALIGNED_TO_OG.poi';
        end
        
    elseif(Hem=='RH')
        if POIfile_ind ==1
            poi_name='POIs\Auditory_RH.poi';
         elseif POIfile_ind ==2
             poi_name='POIs\Motor_RH.poi';
        else
             poi_name = 'POIs\Visual_RH_ALIGNED_TO_OG.poi';
        end
    end
    
    % the mtc file - mesh time course files
    if(Hem=='LH')
        mtc_name{1}='OG_AVScenes_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{2}='OG_AVScenes_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{3}='OG_AVScenes_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{4}='OG_AVScenes_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        
    elseif(Hem=='RH')
        mtc_name{1}='OG_AVScenes_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{2}='OG_AVScenes_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{3}='OG_AVScenes_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{4}='OG_AVScenes_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        
    end
    
    % the design matrix files (single trial, single block based)
    dm_name{1}='OG_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{2}='OG_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{3}='OG_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{4}='OG_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    
    dm_name2{1}='OG_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{2}='OG_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{3}='OG_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{4}='OG_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    
    % the condition specifier files
    % crucial file, maps single trials or blocks onto experimental conditions
    cond_locs_name{1}='OG_run1_AVScenesBlind_trialseq.txt';
    cond_locs_name{2}='OG_run2_AVScenesBlind_trialseq.txt';
    cond_locs_name{3}='OG_run3_AVScenesBlind_trialseq.txt';
    cond_locs_name{4}='OG_run4_AVScenesBlind_trialseq.txt';

elseif(strcmp(subject,'SA'))
    
        % the path to the files
    dir_name='C:\Users\bolal\Desktop\Sound_decoding_in_the_blind\SA\';
    % (note the slashes change direction on a pc) 
    % the poi file - patch of interest
    
    if(Hem=='LH')
        if POIfile_ind ==1
            poi_name='POIs\Auditory_LH.poi';
         elseif POIfile_ind ==2
             poi_name='POIs\Motor_LH.poi';
        else
             poi_name = 'POIs\Visual_LH_ALIGNED_TO_SA.poi';
        end
        
    elseif(Hem=='RH')
        if POIfile_ind ==1
            poi_name='POIs\Auditory_RH.poi';
         elseif POIfile_ind ==2
             poi_name='POIs\Motor_RH.poi';
        else
             poi_name = 'POIs\Visual_RH_ALIGNED_TO_SA.poi';
        end
    end
    
    % the mtc file - mesh time course files
    if(Hem=='LH')
        mtc_name{1}='SA_AVScenes_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{2}='SA_AVScenes_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{3}='SA_AVScenes_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        mtc_name{4}='SA_AVScenes_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_LH_SPH.mtc';
        
    elseif(Hem=='RH')
        mtc_name{1}='SA_AVScenes_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{2}='SA_AVScenes_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{3}='SA_AVScenes_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        mtc_name{4}='SA_AVScenes_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_RH_SPH.mtc';
        
    end
    
    % the design matrix files (single trial, single block based)
    dm_name{1}='SA_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{2}='SA_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{3}='SA_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    dm_name{4}='SA_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL_condsep.sdm';
    
    dm_name2{1}='SA_AVScenesLong_Run1_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{2}='SA_AVScenesLong_Run2_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{3}='SA_AVScenesLong_Run3_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    dm_name2{4}='SA_AVScenesLong_Run4_SCSAI_3DMCTS_LTR_THPGLMF3c_TAL.sdm';
    
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
input_file_info.poi_name=poi_name;
input_file_info.mtc_name=mtc_name;
input_file_info.dm_name=dm_name;  %% block or trial wise
input_file_info.dm2=dm_name2; %% condition wise
input_file_info.cond_locs=cond_locs;
input_file_info.pars=pars;
input_file_info.CondClass=CondClass; %commented out at the beginning
input_file_info.subject=subject;
input_file_info.Hem=Hem;






