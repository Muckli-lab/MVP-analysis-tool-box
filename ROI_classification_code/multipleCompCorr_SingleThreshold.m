%The analysis code that was used in: Vetter P., Bola L., Reich L., Bennett M., Muckli L., Amedi A. (2020). Decoding natural sounds in early “visual” cortex of congenitally blind individuals. Current Biology.
%The code was originally created by Fraser W. Smith (see Smith & Muckli 2010 PNAS)and was adapted to this project by Petra Vetter and Lukasz Bola.

function multipleCompCorr_SingleThreshold
%this function corrects for multiple comparisons in the permutation
%analysis with a single threshold test according to Nichols & Holmes 2001

load groupResults_Perm;

%first pool the classification accuracies for all rounds of permutation 

allApc1 = meanApc.Auditory;
allApc1(:,2) = meanApc.Motor;
allApc1(:,3) = meanApc.V1V2V3allecc;

allApc2 = meanApc.V1allecc;
allApc2(:,2) = meanApc.V2allecc;
allApc2(:,3) = meanApc.V3allecc;

%add more columns if more visual areas shall be included in the comparisons

%do the same for Spc

allSpc1 = meanSpc.Auditory;
allSpc1(:,2) = meanSpc.Motor;
allSpc1(:,3) = meanSpc.V1V2V3allecc;

allSpc2 = meanSpc.V1allecc;
allSpc2(:,2) = meanSpc.V2allecc;
allSpc2(:,3) = meanSpc.V3allecc;
%allSpc(:,4) = meanSpc.EVC;

maxApc1 = max(allApc1,[],2); 
maxApc2 = max(allApc2,[],2); 
%this extracts the maximum value of each row
maxSpc1 = max(allSpc1,[],2); 
maxSpc2 = max(allSpc2,[],2); 

%now calculate the p value for each visual area  using the maximum
%distribution

pPermCorr_Apc.Auditory = length(find(maxApc1 >= meanObsApc.Auditory)) ./1000;
pPermCorr_Apc.Motor = length(find(maxApc1 >= meanObsApc.Motor)) ./1000;
pPermCorr_Apc.V1V2V3allecc = length(find(maxApc1 >= meanObsApc.V1V2V3allecc)) ./1000;

pPermCorr_Apc.V1allecc = length(find(maxApc2 >= meanObsApc.V1allecc)) ./1000;
pPermCorr_Apc.V2allecc = length(find(maxApc2 >= meanObsApc.V2allecc)) ./1000;
pPermCorr_Apc.V3allecc = length(find(maxApc2 >= meanObsApc.V3allecc)) ./1000;

pPermCorr_Spc.Auditory = length(find(maxSpc1 >= meanObsSpc.Auditory)) ./1000;
pPermCorr_Spc.Motor = length(find(maxSpc1 >= meanObsSpc.Motor)) ./1000;
pPermCorr_Spc.V1V2V3allecc = length(find(maxSpc1 >= meanObsSpc.V1V2V3allecc)) ./1000;

pPermCorr_Spc.V1allecc = length(find(maxSpc2 >= meanObsSpc.V1allecc)) ./1000;
pPermCorr_Spc.V2allecc = length(find(maxSpc2 >= meanObsSpc.V2allecc)) ./1000;
pPermCorr_Spc.V3allecc = length(find(maxSpc2 >= meanObsSpc.V3allecc)) ./1000;


save('groupResults_SingleThreshold_corrected','pPermCorr_Apc','pPermCorr_Spc');

