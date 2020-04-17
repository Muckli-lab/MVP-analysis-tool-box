%The analysis code that was used in: Vetter P., Bola L., Reich L., Bennett M., Muckli L., Amedi A. (2020). Decoding natural sounds in early “visual” cortex of congenitally blind individuals. Current Biology.
%The code was originally created by Fraser W. Smith and was adapted to this project by Petra Vetter and Lukasz Bola.

%%% You need LibSVM (my version: 3.23) and NeuroElf (my version: 1.1 7251)
%%% to run this pipeline

%%% Run main ROI analysis
% Perform SVM classification
% Input files are defined in: getFileInfo.m
% Data preparation: readDataMtcPoi.m
% Script running actual classification for a single subject and 1000
% permutations with labels randomised: run_single_sub_CollapseHem_main_analysis_parallel.m
run run_all_sub_main_analysis.m
% Get averaged, across cross-classification folds, accuracy for each
% subject and ROI
run single_sub_meanClassAccu.m
% Compare actual classification accuracies with random permutations and get
% p-values
run groupAnalysis_Perm.m
% Correct general analyses using single threshold test
% Two separate corrections are calculated - one for EVC, auditory cortex
% and the motor cortex; and one for V1, V2 and V3
run multipleCompCorr_SingleThreshold.m
% Correct analysis by eccentricity using FDR (fdr_bh function) - see the script for the list of visual areas included 
run multipleCompCorr_fdr.m
%%% Run additional pipeline to get unbiased confusion matrices
% Perform SVM classification (note that "permGP" in run_single_sub_CollapseHem_get_unbiased_conf_mats.m 
% must be set to 0, to get actual classification accuracies, not the accuracies of random
% permutations)
run run_all_sub_get_unbiased_conf_mats.m
% get the confusion matrices
run pooled_confusionMatrix_unbiased_visual.m
