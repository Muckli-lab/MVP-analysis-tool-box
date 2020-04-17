%The analysis code that was used in: Vetter P., Bola L., Reich L., Bennett M., Muckli L., Amedi A. (2020). Decoding natural sounds in early “visual” cortex of congenitally blind individuals. Current Biology.
%The code was originally created by Fraser W. Smith (see Smith & Muckli 2010 PNAS)and was adapted to this project by Petra Vetter and Lukasz Bola.

function [res]=voi_ANOVA(data, gp)

% to be called from "read_SingleTrial_glm"
% to compute univariate ANOVAs for each voxel in VOI

%p=s{3};
%mSize=p(4);
mSize=size(data,2);
res=zeros(mSize+1,2);   %% one extra for ANOVA on mean betas

% compute one way ANOVA per voxel
for i=1:mSize
    [res(i,1), anovatab]=anova1(data(:,i),gp,'off');  %pval
    res(i,2)=anovatab{2,5}; %fval
end

% compute the ANOVA on the average betas
mdata=mean(data,2);  %% row means (over voxels)
[res(mSize+1,1), anovatab]=anova1(mdata,gp,'off');
res(mSize+1,2)=anovatab{2,5};

    

