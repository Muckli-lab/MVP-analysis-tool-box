%The analysis code that was used in: Vetter P., Bola L., Reich L., Bennett M., Muckli L., Amedi A. (2020). Decoding natural sounds in early “visual” cortex of congenitally blind individuals. Current Biology.
%The code was originally created by Fraser W. Smith (see Smith & Muckli 2010 PNAS)and was adapted to this project by Petra Vetter and Lukasz Bola.


subs{1}='EL';
subs{2}='EMA';
subs{3}='GAG';
subs{4}='MF';
subs{5}='MM';
subs{6}='OB';
subs{7}='OG';
subs{8}='SA';


nSubs=length(subs);
vs=[]; ams=[]; pms=[]; chance=1/3;

% note that when you run this classifier (Searchmight)
% accuracy from the svm will be zero since the labels vector
% is zeroed (dummy), see computeLocalClassifiers.m (lines 981-992)

% this computes the shared mask (all vox mean bold > 100 all subs)
sMask2=findCommonMask;
load('8BlindSub_commonMaskFile.mat');

addpath(genpath('/analyse/Project0008/SearchmightToolbox.Linux_x86_64.0.2.5'));
addpath(genpath('/analyse/Project0008/BVQXtools_v07g'))
% since same for each subject - to save recomputing each time
rr=3; %% radius - size of the searchlight

if(~exist(sprintf('AvScenes_Meta_radius%d.mat',rr)))
    [meta] = createMetaFromMask(sMask2, rr); % use common mask across subs
    save(sprintf('AvScenes_Meta_radius%d.mat',rr),'meta');
else
    load(sprintf('AvScenes_Meta_radius%d.mat',rr));
end

first=1; %% this should be set to 1 the first time the script is run to
%compute the GLM etc
%anytime after that, this should be set to 0 and it will skip the GLM step


if(first==1)
   
    for s=1:nSubs
        tic
     % get data from each subject-in right space for searchlight etc
    subject=subs{s};
    read_data_vtc_block(subs{s});
   % outname=sprintf('%s_SingleBlockRespEstBetas_Searchlight.mat',subject);
   % parsave(outname,'outD');
   toc
    end
    
end

!/bin/chmod 777 *.mat

parfor s=1:nSubs
    
    
    subject=subs{s};
    in=load(sprintf('%s_SingleBlockRespEstBetas_Searchlight.mat',subject));
    
    examples=in.outD.cumObs;
    labels=in.outD.cumSeq;
    runLabels=in.outD.runLabels;
    
    ams=[];
    pms=[];
    
    for c=3  % classifier

        if(c==1) 
           classifier = 'gnb_searchmight'; % fast GNB
        elseif(c==2)
            classifier= 'lda_shrinkage';
        elseif(c==3)
            classifier= 'svm_linear';
        end


          
        [am,pm] = computeInformationMap(examples,labels,runLabels,classifier,'searchlight', ...
                                        meta.voxelsToNeighbours,meta.numberOfNeighbours);
                                    % note this function should show zeros
                                    % in the output of SVM function (see
                                    % intro comments)
                                    
      % ams(:,jj)=am; pms(:,jj)=pm;
                              
       

        % place the accuracy map in a 3D volume using the meta structure
        %volume = repmat(NaN,meta.dimensions); 
        volume = zeros(meta.dimensions); 
        volume(meta.indicesIn3D) = am;

       outname=sprintf('%s_AVScenes_SearchLight%d.mat',subject,rr);
       parsave3(outname,am,pm,volume);

      
        % collect these
        vs(:,:,:,s)=volume;


        % store results
        ams(:,s)=am;
        pms(:,s)=pm;
     %   end
        
        
    end
                            
                            
                   


% place the accuracy map in a 3D volume using the meta structure
%volume = repmat(NaN,meta.dimensions); 
%volume(meta.indicesIn3D) = pm;

% plot proper
%for iz=1:46; figure, imagesc(volume(:,:,iz),[0 1]); end

% threshold a p-value map using a clone of Tom Nichols' FDR function FDR.m:
% q = 0.01;
% [thresholdID,thresholdN] = computeFDR(pm,q);  % produces two thresholds, use pN;
% binaryMap = pm <= thresholdN; % thresholded map


%    end  %% end task
    
end  %% end subject

%rmpath(genpath('/analyse/Project0008/SearchmightToolbox.Linux_x86_64.0.2.5'));

%%%% - after here is a bunch of analysis stuff %%%% 

% if run piecemeal - build up matrix across subs
vs=[];
for i=1:nSubs
    subject=subs{i};
    in=sprintf('%s_AVScenes_SearchLight%d.mat',subject,rr);
    in2=load(in);
    vs(:,:,:,i)=in2.i3; %% volume maps
end
    
    

 % set BVQX path
%addpath(genpath('/analyse/Project0008/BVQXtools_v07g'))
%save(sprintf('testTvis_8subs_CommonFuncMask_%d.mat',rr), 'vs', 'rr','classifier','subs');

% rescale
for i=1:nSubs
    vtmp=vs(:,:,:,i);
   
    %if(max(vtmp(:))==1 & min(vtmp(:))==0)
     %   xx=rescaleW(vtmp(:));
      %  mmaxmin(i,1:2)=[max(vtmp(:)) min(vtmp(:))];
   % else
        %xx=rescaleG(vtmp(:), max(vtmp(:))*10);
        %error('Not rescaling');
        xx=vtmp.*10; %multiply the values by 10 so that there are easier visible in BVQX
        %(values from 0-1 are difficult to see in the vmp in BVQX)
   % end
    vtmp2=zeros(87,60,69);
    vtmp2(:)=xx;  %% rescaled from zero to ten
    vtmp2(find(vtmp2))=vtmp2(find(vtmp2))-(chance)*10; %substract chance value
    vs2(:,:,:,i)=vtmp2;
   % figure, hist(vtmp2(find(vtmp2)))
end


% write vmp of voi coordinate positions - these should match VOIs in BVQX
outname=sprintf('AVScenes_%dsubs_r%d_searchlight_rescaled_minuschance.vmp',nSubs,rr);
multiplier=1;  % scale input
lThresh=chance*10;  % lower threshold
sflag=0;
write_vmp_v2(outname,vs2,multiplier,lThresh,sflag);
%movefile(outname,'/home/fsmith23/tmp');

% stats maps
mVS2=mean(vs2,4);  %% average across subs
sVS2=std(vs2,[],4);  %% std
tVS2=mVS2./(sVS2./(sqrt(nSubs)));  %% t stat
tVS2_2=zeros(size(tVS2));
locs=find(mVS2);
tVS2_2(locs)=mVS2(locs)./(sVS2(locs)./(sqrt(nSubs)));  %% t stat
fVS2=tVS2_2.^2;  %% make an fmap to use with BVs cluster threshold program
pVS2=1-tcdf(tVS2,nSubs-1); 

out=cat(4,mVS2,sVS2,tVS2,tVS2_2,pVS2,fVS2);
    
outname=sprintf('AvScenes_%dsubs_r%d_searchlight_statsMaps_2nd.vmp',nSubs,rr);
multiplier=1;  % scale input
lThresh=0; sflag=1;
write_vmp_v2(outname,out,multiplier,lThresh,sflag);
    
