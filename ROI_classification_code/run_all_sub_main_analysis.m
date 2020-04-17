%The analysis code that was used in: Vetter P., Bola L., Reich L., Bennett M., Muckli L., Amedi A. (2020). Decoding natural sounds in early “visual” cortex of congenitally blind individuals. Current Biology.
%The code was originally created by Fraser W. Smith (see Smith & Muckli 2010 PNAS)and was adapted to this project by Petra Vetter and Lukasz Bola.

%this runs the single SVM for all subjects

subjects = {...
    'EL','EMA','GAG','MF','MM','OB','OG','SA'...
    };
CondClass = [1 2 3];


for subject = 1:length(subjects)
    for POIfile_ind = 1:3    
        if POIfile_ind == 3
            for patch = 1:16
                run_single_sub_CollapseHem_main_analysis_parallel(subjects{subject},patch,CondClass,POIfile_ind);
            end
        else
            patch = 1;
            run_single_sub_CollapseHem_main_analysis_parallel(subjects{subject},patch,CondClass,POIfile_ind);
        end
    end
end
