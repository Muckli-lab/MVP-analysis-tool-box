%The analysis code that was used in: Vetter P., Bola L., Reich L., Bennett M., Muckli L., Amedi A. (2020). Decoding natural sounds in early “visual” cortex of congenitally blind individuals. Current Biology.
%The code was originally created by Fraser W. Smith (see Smith & Muckli 2010 PNAS)and was adapted to this project by Petra Vetter and Lukasz Bola.


function sMask2=findCommonMask()

% goal is to make a nice common mask of all activated voxels
% to do a searchlight analysis within
% BVQX uses a mean BOLD > 100 threshold to select voxels
% then just a big intersection
% of course spatial normalization (TAL) plays a key role here

subs{1}='EL';
subs{2}='EMA';
subs{3}='GAG';
subs{4}='MF';
subs{5}='MM';
subs{6}='OB';
subs{7}='OG';
subs{8}='SA';

nSubs=length(subs);
maskG=zeros(87,60,69,nSubs);
%addpath(genpath('/analyse/Project0008/BVQXtools_v07g'))

for s=1:nSubs
    names=getFileInfo_vtc(subs{s});
    maskS=ones(87,60,69);
    
    for j=1:length(names.vtc_name)
        
        vtc=BVQXfile([names.dir_name names.vtc_name{j}]);
        data=vtc.VTCData;
        mask=zeros(87,60,69);
        
        mD=squeeze(mean(data,1));
        locs=find(mD>100);  %% good vox thresh BVQX
        
        mask(locs)=1;  %% good locs for this run
        tab(s,j)=length(find(mask));

        maskS=mask&maskS;  %% accumlate to do grand intersection
        
    end
    
    gt(s)=length(find(maskS));
    maskG(:,:,:,s)=maskS;
    
end


sMask1=sum(maskG,4);
ff=find(sMask1==nSubs);
sMask2=zeros(size(maskS));
sMask2(ff)=1;

length(find(sMask2))

% write out the common mask file
outname=sprintf('8BlindSub_commonMaskFile.vmp');
multiplier=1;  % scale input
lThresh=0;  % lower threshold
write_vmp_v2(outname,sMask2,multiplier,lThresh);
%movefile(outname,'/home/fsmith23/tmp');

% and save a mat file
outname='8BlindSub_commonMaskFile.mat';
save(outname,'sMask2');

