%The analysis code that was used in: Vetter P., Bola L., Reich L., Bennett M., Muckli L., Amedi A. (2020). Decoding natural sounds in early “visual” cortex of congenitally blind individuals. Current Biology.
%The code was originally created by Fraser W. Smith (see Smith & Muckli 2010 PNAS)and was adapted to this project by Petra Vetter and Lukasz Bola.

function pooled_confusionMatrix_unbiased_visual
%this pools the results of the new analysis without bias
%here confusion matrices are computed for both single trials and average

subjects = {'EL','EMA','GAG','MF','MM','OB','OG','SA'};
%change n accordingly in figure title

cd C:\Users\bolal\Desktop\Sound_decoding_in_the_blind\ROI_classification_code

confMat_sb.cm = []; %single block
confMat_av.cm = []; %average
poi = 3;


for participant = 1: length(subjects)
   
        for patch = 1:16
            
            filename = [subjects{participant},'_UnbiasedConfMatsCollapseHem_Patch',int2str(patch),'_POI',int2str(poi),'.mat'];
            
            load(filename);
            
            propCorr= mean(svmOut.cmR ./6,3);
            %divide the numbers (how often the classifier got it right out of 6 cases)
            %by 6 to get the proportion correct and average along the 3rd dimension,
            %i.e. across cross-validation runs

            confMat_sb(patch).cm(:,:,participant)= propCorr;
           confMat_av(patch).cm(:,:,participant) = svmOut.cmAvR;

        end;
        
  

end

save('pooled_ConfMat_visual','confMat_sb','confMat_av');

for patch = 1:16
mean_confMat_sb(patch).cm = mean(confMat_sb(patch).cm,3);
mean_confMat_av(patch).cm = mean(confMat_av(patch).cm,3);
end
%average across subjects

save('mean_ConfMat_unbiased_visual','mean_confMat_sb','mean_confMat_av');

%plot - first single block
figure;
title ('Confusion Matrices - single blocks');
labels = {'V1 fov','V1 peri', 'V1 far peri','V2 fov','V2 peri','V2 far peri','V3 fov','V3 peri','V3 far peri', 'V1','V2','V3','EVC fov', 'EVC peri', 'EVC far peri', 'EVC'};
colormap(jet(256))
for i = 1:16
subplot(2,8,i);
imagesc(mean_confMat_sb(i).cm,[0 1]); %plots the matrix on a colour scale
set(gca,'xtick',[],'ytick',[]);
title(labels{i});
end
 %subplot(2,,13)
 %imagesc(mean_confMat_sb(12).cm,[0 .5]);
  colorbar;
hgsave('Confusion Matrices - single blocks');

%plot - then average
figure;
title ('Confusion Matrices - average');
labels = {'V1 fov','V1 peri', 'V1 far peri','V2 fov','V2 peri','V2 far peri','V3 fov','V3 peri','V3 far peri', 'V1','V2','V3','EVC fov', 'EVC peri', 'EVC far peri', 'EVC'};
colormap(jet(256))
for i = 1:16
subplot(2,8,i);
imagesc(mean_confMat_av(i).cm,[0 1]); %plots the matrix on a colour scale
set(gca,'xtick',[],'ytick',[]);
title(labels{i});
end
 %subplot(2,6,13)
 %imagesc(mean_confMat_av(12).cm,[0 .5]);
  colorbar;
hgsave('Confusion Matrices - average');

