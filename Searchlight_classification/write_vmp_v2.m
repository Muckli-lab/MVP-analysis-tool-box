%The analysis code that was used in: Vetter P., Bola L., Reich L., Bennett M., Muckli L., Amedi A. (2020). Decoding natural sounds in early “visual” cortex of congenitally blind individuals. Current Biology.
%The code was originally created by Fraser W. Smith (see Smith & Muckli 2010 PNAS)and was adapted to this project by Petra Vetter and Lukasz Bola.

function write_vmp_v2(outname,data,scale,lThresh,sflag)

% vmp from glm to work from
test=BVQXfile('/Users/lukasz/Desktop/Sound_decoding_in_the_blind_final/examplevmp.vmp');
%test=BVQXfile('/media/visionlab/Goodale_Lab/Fraser/Tvision/analysis_code/testQPZ.vmp');
fixBbox=1;
% if(strcmp(flag,'am'))
%     test.Map.LowerThreshold=pars(1).*pars(3);
%     test.Map.UpperThreshold=pars(2).*pars(3);
% elseif(strcmp(flag,'pm'))  % pm
%     test.Map.LowerThreshold=pars(1);
%     test.Map.UpperThreshold=pars(2);
% elseif(strcmp(flag,'data'))
%     test.Map.LowerThreshold=max(max(max(data)));
%     test.Map.UpperThreshold=min(min(min(data)));
% end

test.Map.Name=outname(1:end-4);
test.Map.LowerThreshold=lThresh;
nMap=size(data,4);

if(nMap==1)
    if(size(data)==size(test.Map.VMPData))
        test.Map.VMPData=single(data.*scale);
    else
        error('Data to be written not in right space');
    end
else
    
    test.NrOfMaps=nMap;
    test.Map(2:nMap)=test.Map(1);
    
    for i=1:nMap
        if(size(data(:,:,:,i))==size(test.Map(i).VMPData))
            test.Map(i).VMPData=single(data(:,:,:,i).*scale);  
            fprintf('Max %.4f\t Min %.4f\n',max(test.Map(i).VMPData(find(test.Map(i).VMPData))),min(test.Map(i).VMPData(find(test.Map(i).VMPData))));
        else
            error('Data to be written not in right space');
        end
    end
    
    if(sflag)
        % standard format
        test.Map(1).Name='Mean Accuracy';
        test.Map(2).Name='Std Across Subs';
        test.Map(3).Name='one sided t map against chance';
        test.Map(4).Name='t map no nans';
        test.Map(5).Name='p map';
        test.Map(6).Name='f map';
        
    end
    
end



if(fixBbox)
    
    % this makes the mask display identically to one created in BVQX
    % check testVOImap.m for tests of these issues
    test.XStart=test.XStart-1;
    test.YStart=test.YStart-1;
    test.ZStart=test.ZStart-1;

    test.XEnd=test.XEnd-1;
    test.YEnd=test.YEnd-1;
    test.ZEnd=test.ZEnd-1;
end

test.SaveAs(outname);

% make gray scale??
% test.Map.RGBLowerThreshPos= [0 0 0];
% test.Map.RGBUpperThreshPos= [255 255 255];