%The analysis code that was used in: Vetter P., Bola L., Reich L., Bennett M., Muckli L., Amedi A. (2020). Decoding natural sounds in early “visual” cortex of congenitally blind individuals. Current Biology.
%The code was originally created by Fraser W. Smith (see Smith & Muckli 2010 PNAS)and was adapted to this project by Petra Vetter and Lukasz Bola.


function [betas,t]=computeGLM(data, dm, zTimeSeries,zBetas)


if(zTimeSeries==1)
    data=zscore(data);  %% zscore data, voxel-wise (column wise), crucial 
end

nVox=size(data,2);
nVols=size(data,1);
betas=zeros(size(dm,2),nVox);
t=zeros(size(betas));

% independently for each voxel, fit GLM
for vox=1:nVox
    [B,dev,stats]=glmfit(dm,data(:,vox),'normal','constant','off');
    % no adding of additional column of ones
    betas(:,vox)=B;
    t(:,vox)=stats.t;
end

% zscore betas within each voxel, across trials
if(zBetas)
    betas=zscore(betas);  %% zscore betas, voxel wise
end


% X=DM;
% iXX=pinv(X'*X);
% betas=zeros(size(iXX,1),nVox);
% yhat=zeros(size(data));
% res=zeros(size(data));
% 
% for vox=1:nVox
%     
%     Y=data(:,vox);  %% one voxel at a time
%     
%     betas(:,vox)=iXX*X'*Y;   %% the beta values
%     yhat(:,vox)=(X*betas(:,vox));
%     res(:,vox)=(Y-yhat(:,vox)).^2;
%   %  ssqRes(vox)=sum(res(:,vox));
%   %  ssqReg(vox)=sum((Y-mean(Y)).^2);
% end
% 
% out=[];
% out.data=data;
% out.betas=betas;
% out.yhat=yhat;
% out.res=res;