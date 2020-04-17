%The analysis code that was used in: Vetter P., Bola L., Reich L., Bennett M., Muckli L., Amedi A. (2020). Decoding natural sounds in early “visual” cortex of congenitally blind individuals. Current Biology.
%The code was originally created by Fraser W. Smith (see Smith & Muckli 2010 PNAS)and was adapted to this project by Petra Vetter and Lukasz Bola.

function groupAnalysis_Perm
%this pools the results of the permutation analysis across subjects

subjects = {'EL','EMA','GAG','MF','MM','OB','OG','SA'};
%change n accordingly in figure title


for subject_nr = 1: length(subjects)

    for poifile = 1:3
        if poifile == 3 %this is for the visual areas
            for patch = 1:16
                filename = [subjects{subject_nr},'_MainAnalysis_CollapseHem_Patch',num2str(patch),'_POI',num2str(poifile)];
                load(filename);
                pooledApc_Poi3(patch).permAcc(1:1000,subject_nr) = Apc;
                pooledSpc_Poi3(patch).permAcc(1:1000,subject_nr) = Spc;
                %for the observed values
                pooledApc_Poi3(patch).obsAcc(1,subject_nr) = mean(svmOutObs.av);
                pooledSpc_Poi3(patch).obsAcc(1,subject_nr) = mean(svmOutObs.pc);   
            end
        elseif poifile ==2 %this is for the motor cortex
            patch = 1;
            filename = [subjects{subject_nr},'_MainAnalysis_CollapseHem_Patch',num2str(patch),'_POI',num2str(poifile)];
            load(filename);
            pooledApc_Poi2(patch).permAcc(1:1000,subject_nr) = Apc;
            pooledSpc_Poi2(patch).permAcc(1:1000,subject_nr) = Spc;
            %for the observed values
            pooledApc_Poi2(patch).obsAcc(1,subject_nr) = mean(svmOutObs.av);
            pooledSpc_Poi2(patch).obsAcc(1,subject_nr) = mean(svmOutObs.pc);
        else %this is for the auditory cortex 
            patch = 1;
            filename = [subjects{subject_nr},'_MainAnalysis_CollapseHem_Patch',num2str(patch),'_POI',num2str(poifile)];
            load(filename);
            pooledApc_Poi1(patch).permAcc(1:1000,subject_nr) = Apc;
            pooledSpc_Poi1(patch).permAcc(1:1000,subject_nr) = Spc;
            %for the observed values
            pooledApc_Poi1(patch).obsAcc(1,subject_nr) = mean(svmOutObs.av);
            pooledSpc_Poi1(patch).obsAcc(1,subject_nr) = mean(svmOutObs.pc);
            
        end
    end
end


save('pooledPermResults','pooledApc_Poi3','pooledSpc_Poi3','pooledApc_Poi2','pooledSpc_Poi2','pooledApc_Poi1','pooledSpc_Poi1');
meanApc.Auditory = mean(pooledApc_Poi1(1).permAcc,2);
meanApc.Motor = mean(pooledApc_Poi2(1).permAcc,2);
meanApc.V1fov = mean(pooledApc_Poi3(1).permAcc,2);
meanApc.V1peri = mean(pooledApc_Poi3(2).permAcc,2);
meanApc.V1farperi = mean(pooledApc_Poi3(3).permAcc,2);
meanApc.V2fov = mean(pooledApc_Poi3(4).permAcc,2);
meanApc.V2peri = mean(pooledApc_Poi3(5).permAcc,2);
meanApc.V2farperi = mean(pooledApc_Poi3(6).permAcc,2);
meanApc.V3fov = mean(pooledApc_Poi3(7).permAcc,2);
meanApc.V3peri = mean(pooledApc_Poi3(8).permAcc,2);
meanApc.V3farperi = mean(pooledApc_Poi3(9).permAcc,2);
meanApc.V1allecc = mean(pooledApc_Poi3(10).permAcc,2);
meanApc.V2allecc = mean(pooledApc_Poi3(11).permAcc,2);
meanApc.V3allecc = mean(pooledApc_Poi3(12).permAcc,2);
meanApc.V1V2V3fov = mean(pooledApc_Poi3(13).permAcc,2);
meanApc.V1V2V3peri = mean(pooledApc_Poi3(14).permAcc,2);
meanApc.V1V2V3farperi = mean(pooledApc_Poi3(15).permAcc,2);
meanApc.V1V2V3allecc = mean(pooledApc_Poi3(16).permAcc,2);

meanSpc.Auditory = mean(pooledSpc_Poi1(1).permAcc,2);
meanSpc.Motor = mean(pooledSpc_Poi2(1).permAcc,2);
meanSpc.V1fov = mean(pooledSpc_Poi3(1).permAcc,2);
meanSpc.V1peri = mean(pooledSpc_Poi3(2).permAcc,2);
meanSpc.V1farperi = mean(pooledSpc_Poi3(3).permAcc,2);
meanSpc.V2fov = mean(pooledSpc_Poi3(4).permAcc,2);
meanSpc.V2peri = mean(pooledSpc_Poi3(5).permAcc,2);
meanSpc.V2farperi = mean(pooledSpc_Poi3(6).permAcc,2);
meanSpc.V3fov = mean(pooledSpc_Poi3(7).permAcc,2);
meanSpc.V3peri = mean(pooledSpc_Poi3(8).permAcc,2);
meanSpc.V3farperi = mean(pooledSpc_Poi3(9).permAcc,2);
meanSpc.V1allecc = mean(pooledSpc_Poi3(10).permAcc,2);
meanSpc.V2allecc = mean(pooledSpc_Poi3(11).permAcc,2);
meanSpc.V3allecc = mean(pooledSpc_Poi3(12).permAcc,2);
meanSpc.V1V2V3fov = mean(pooledSpc_Poi3(13).permAcc,2);
meanSpc.V1V2V3peri = mean(pooledSpc_Poi3(14).permAcc,2);
meanSpc.V1V2V3farperi = mean(pooledSpc_Poi3(15).permAcc,2);
meanSpc.V1V2V3allecc = mean(pooledSpc_Poi3(16).permAcc,2);

meanObsApc.Auditory = mean(pooledApc_Poi1(1).obsAcc,2);
meanObsApc.Motor = mean(pooledApc_Poi2(1).obsAcc,2);
meanObsApc.V1fov = mean(pooledApc_Poi3(1).obsAcc,2);
meanObsApc.V1peri = mean(pooledApc_Poi3(2).obsAcc,2);
meanObsApc.V1farperi = mean(pooledApc_Poi3(3).obsAcc,2);
meanObsApc.V2fov = mean(pooledApc_Poi3(4).obsAcc,2);
meanObsApc.V2peri = mean(pooledApc_Poi3(5).obsAcc,2);
meanObsApc.V2farperi = mean(pooledApc_Poi3(6).obsAcc,2);
meanObsApc.V3fov = mean(pooledApc_Poi3(7).obsAcc,2);
meanObsApc.V3peri = mean(pooledApc_Poi3(8).obsAcc,2);
meanObsApc.V3farperi = mean(pooledApc_Poi3(9).obsAcc,2);
meanObsApc.V1allecc = mean(pooledApc_Poi3(10).obsAcc,2);
meanObsApc.V2allecc = mean(pooledApc_Poi3(11).obsAcc,2);
meanObsApc.V3allecc = mean(pooledApc_Poi3(12).obsAcc,2);
meanObsApc.V1V2V3fov = mean(pooledApc_Poi3(13).obsAcc,2);
meanObsApc.V1V2V3peri = mean(pooledApc_Poi3(14).obsAcc,2);
meanObsApc.V1V2V3farperi = mean(pooledApc_Poi3(15).obsAcc,2);
meanObsApc.V1V2V3allecc = mean(pooledApc_Poi3(16).obsAcc,2);

meanObsSpc.Auditory = mean(pooledSpc_Poi1(1).obsAcc,2);
meanObsSpc.Motor = mean(pooledSpc_Poi2(1).obsAcc,2);
meanObsSpc.V1fov = mean(pooledSpc_Poi3(1).obsAcc,2);
meanObsSpc.V1peri = mean(pooledSpc_Poi3(2).obsAcc,2);
meanObsSpc.V1farperi = mean(pooledSpc_Poi3(3).obsAcc,2);
meanObsSpc.V2fov = mean(pooledSpc_Poi3(4).obsAcc,2);
meanObsSpc.V2peri = mean(pooledSpc_Poi3(5).obsAcc,2);
meanObsSpc.V2farperi = mean(pooledSpc_Poi3(6).obsAcc,2);
meanObsSpc.V3fov = mean(pooledSpc_Poi3(7).obsAcc,2);
meanObsSpc.V3peri = mean(pooledSpc_Poi3(8).obsAcc,2);
meanObsSpc.V3farperi = mean(pooledSpc_Poi3(9).obsAcc,2);
meanObsSpc.V1allecc = mean(pooledSpc_Poi3(10).obsAcc,2);
meanObsSpc.V2allecc = mean(pooledSpc_Poi3(11).obsAcc,2);
meanObsSpc.V3allecc = mean(pooledSpc_Poi3(12).obsAcc,2);
meanObsSpc.V1V2V3fov = mean(pooledSpc_Poi3(13).obsAcc,2);
meanObsSpc.V1V2V3peri = mean(pooledSpc_Poi3(14).obsAcc,2);
meanObsSpc.V1V2V3farperi = mean(pooledSpc_Poi3(15).obsAcc,2);
meanObsSpc.V1V2V3allecc = mean(pooledSpc_Poi3(16).obsAcc,2);

group_pPerm_Apc.Auditory = length(find(meanApc.Auditory >= meanObsApc.Auditory)) ./ 1000;
group_pPerm_Apc.Motor = length(find(meanApc.Motor >= meanObsApc.Motor)) ./ 1000;
group_pPerm_Apc.V1fov = length(find(meanApc.V1fov >= meanObsApc.V1fov)) ./ 1000;
group_pPerm_Apc.V1peri = length(find(meanApc.V1peri >= meanObsApc.V1peri)) ./ 1000;
group_pPerm_Apc.V1farperi = length(find(meanApc.V1farperi >= meanObsApc.V1farperi)) ./ 1000;
group_pPerm_Apc.V2fov = length(find(meanApc.V2fov >= meanObsApc.V2fov)) ./ 1000;
group_pPerm_Apc.V2peri = length(find(meanApc.V2peri >= meanObsApc.V2peri)) ./ 1000;
group_pPerm_Apc.V2farperi = length(find(meanApc.V2farperi >= meanObsApc.V2farperi)) ./ 1000;
group_pPerm_Apc.V3fov = length(find(meanApc.V3fov >= meanObsApc.V3fov)) ./ 1000;
group_pPerm_Apc.V3peri = length(find(meanApc.V3peri >= meanObsApc.V3peri)) ./ 1000;
group_pPerm_Apc.V3farperi = length(find(meanApc.V3farperi >= meanObsApc.V3farperi)) ./ 1000;
group_pPerm_Apc.V1allecc = length(find(meanApc.V1allecc >= meanObsApc.V1allecc)) ./ 1000;
group_pPerm_Apc.V2allecc = length(find(meanApc.V2allecc >= meanObsApc.V2allecc)) ./ 1000;
group_pPerm_Apc.V3allecc = length(find(meanApc.V3allecc >= meanObsApc.V3allecc)) ./ 1000;
group_pPerm_Apc.V1V2V3fov = length(find(meanApc.V1V2V3fov >= meanObsApc.V1V2V3fov)) ./ 1000;
group_pPerm_Apc.V1V2V3peri = length(find(meanApc.V1V2V3peri >= meanObsApc.V1V2V3peri)) ./ 1000;
group_pPerm_Apc.V1V2V3farperi = length(find(meanApc.V1V2V3farperi >= meanObsApc.V1V2V3farperi)) ./ 1000;
group_pPerm_Apc.V1V2V3allecc = length(find(meanApc.V1V2V3allecc >= meanObsApc.V1V2V3allecc)) ./ 1000;

group_pPerm_Spc.Auditory = length(find(meanSpc.Auditory >= meanObsSpc.Auditory)) ./ 1000;
group_pPerm_Spc.Motor = length(find(meanSpc.Motor >= meanObsSpc.Motor)) ./ 1000;
group_pPerm_Spc.V1fov = length(find(meanSpc.V1fov >= meanObsSpc.V1fov)) ./ 1000;
group_pPerm_Spc.V1peri = length(find(meanSpc.V1peri >= meanObsSpc.V1peri)) ./ 1000;
group_pPerm_Spc.V1farperi = length(find(meanSpc.V1farperi >= meanObsSpc.V1farperi)) ./ 1000;
group_pPerm_Spc.V2fov = length(find(meanSpc.V2fov >= meanObsSpc.V2fov)) ./ 1000;
group_pPerm_Spc.V2peri = length(find(meanSpc.V2peri >= meanObsSpc.V2peri)) ./ 1000;
group_pPerm_Spc.V2farperi = length(find(meanSpc.V2farperi >= meanObsSpc.V2farperi)) ./ 1000;
group_pPerm_Spc.V3fov = length(find(meanSpc.V3fov >= meanObsSpc.V3fov)) ./ 1000;
group_pPerm_Spc.V3peri = length(find(meanSpc.V3peri >= meanObsSpc.V3peri)) ./ 1000;
group_pPerm_Spc.V3farperi = length(find(meanSpc.V3farperi >= meanObsSpc.V3farperi)) ./ 1000;
group_pPerm_Spc.V1allecc = length(find(meanSpc.V1allecc >= meanObsSpc.V1allecc)) ./ 1000;
group_pPerm_Spc.V2allecc = length(find(meanSpc.V2allecc >= meanObsSpc.V2allecc)) ./ 1000;
group_pPerm_Spc.V3allecc = length(find(meanSpc.V3allecc >= meanObsSpc.V3allecc)) ./ 1000;
group_pPerm_Spc.V1V2V3fov = length(find(meanSpc.V1V2V3fov >= meanObsSpc.V1V2V3fov)) ./ 1000;
group_pPerm_Spc.V1V2V3peri = length(find(meanSpc.V1V2V3peri >= meanObsSpc.V1V2V3peri)) ./ 1000;
group_pPerm_Spc.V1V2V3farperi = length(find(meanSpc.V1V2V3farperi >= meanObsSpc.V1V2V3farperi)) ./ 1000;
group_pPerm_Spc.V1V2V3allecc = length(find(meanSpc.V1V2V3allecc >= meanObsSpc.V1V2V3allecc)) ./ 1000;

save('groupResults_Perm','meanSpc','meanApc','meanObsApc','meanObsSpc','group_pPerm_Apc','group_pPerm_Spc');




