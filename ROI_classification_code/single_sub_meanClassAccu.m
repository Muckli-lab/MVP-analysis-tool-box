%The analysis code that was used in: Vetter P., Bola L., Reich L., Bennett M., Muckli L., Amedi A. (2020). Decoding natural sounds in early “visual” cortex of congenitally blind individuals. Current Biology.
%The code was originally created by Fraser W. Smith (see Smith & Muckli 2010 PNAS)and was adapted to this project by Petra Vetter and Lukasz Bola.

function single_sub_meanClassAccu
%this calculates the mean classification accuracy results for each subject
%across cross-validation cycles


subjects = {'EL','EMA','GAG','MF','MM','OB','OG','SA'};

for subject = 1:length(subjects)
sub = subjects{subject};
for poi = 1:3 
    if poi ==3
        %this is for the visual areas
        for patch = 1:16
            
            filename = [sub,'_MainAnalysis_CollapseHem_Patch',int2str(patch),'_POI',int2str(poi),'.mat'];
            load(filename);
            meanAccu_singleblock = mean(svmOutObs.pc);
            meanAccu_average = mean(svmOutObs.av);
            semAccu_singleblock = std(svmOutObs.pc)/sqrt(length(svmOutObs.pc));
            semAccu_average = std(svmOutObs.av)/sqrt(length(svmOutObs.pc));           
            results_visual(patch,:) = [meanAccu_singleblock,meanAccu_average, semAccu_singleblock, semAccu_average];
        end
        save([sub,'meanClassAccu_visual_cortex'],'results_visual');
    elseif poi ==2
        %this is for the motor cortex
        patch = 1;
            
        filename = [sub,'_MainAnalysis_CollapseHem_Patch',int2str(patch),'_POI',int2str(poi),'.mat'];
        load(filename);           
        meanAccu_singleblock = mean(svmOutObs.pc);
        meanAccu_average = mean(svmOutObs.av);
        semAccu_singleblock = std(svmOutObs.pc)/sqrt(length(svmOutObs.pc));
        semAccu_average = std(svmOutObs.av)/sqrt(length(svmOutObs.pc));
            
        results_motor(patch,:) = [meanAccu_singleblock,meanAccu_average, semAccu_singleblock, semAccu_average];
        save([sub,'meanClassAccu_motor_cortex'],'results_motor');
    else
        %this is for the auditory cortex
       patch = 1;
            
       filename = [sub,'_MainAnalysis_CollapseHem_Patch',int2str(patch),'_POI',int2str(poi),'.mat'];
       load(filename);
       meanAccu_singleblock = mean(svmOutObs.pc);
       meanAccu_average = mean(svmOutObs.av);
       semAccu_singleblock = std(svmOutObs.pc)/sqrt(length(svmOutObs.pc));
       semAccu_average = std(svmOutObs.av)/sqrt(length(svmOutObs.pc));
       
       results_auditory(patch,:) = [meanAccu_singleblock,meanAccu_average, semAccu_singleblock, semAccu_average];
       save([sub,'meanClassAccu_auditory_cortex'],'results_auditory');
    end
end
end





