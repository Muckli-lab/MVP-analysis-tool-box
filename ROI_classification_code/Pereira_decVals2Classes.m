function [predictedLabels,predictedL2]=Pereira_decVals2Classes(svm_pred_dec_vals,svm_model,sortL,doCorr)

% code takes from computeLocalClassifiers.m
% from the searchmight toolbox
% explore to see if better solution than how libsvm deals with ties
% if there are ties, slightly different results when labels/data ordered
% versus not when running libsvm code - it chooses class with lower index
% which is really a bad criterion

% must have sortL=1 for this to make sense, see below
% FWS 12/3/12

% adjusted 20/3/12 by FWS - where there are ties there are now 2 options
% of how to deal with them - one - just rnd assign one cat to be correct
% two - take max abs dec value as correct category (two is a bad choice)
% doCorr=1 or 2 respectively (=0, same as libsvm, lowest indx)

%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
% what to do with decision values depends on the # labels
% WARNING: assumes the label of class 1 is less than the label of class 2
% (see below)
rand('state',sum(100*clock));
nC=length(svm_model.Label); cont=nchoosek(1:nC,2);

% transform decision values into vote counts for each class
if(sortL)
    tmp=svm_pred_dec_vals;
    nLabels=length(svm_model.Label);
    nTest=size(tmp,1);

    votes = zeros(nTest,nLabels);
    ip = 1;
    for ic1 = 1:(nLabels-1)
      for ic2 = (ic1+1):nLabels
        vmask = (tmp(:,ip) > 0);

        % positive are votes for the first class in the pair
        votes(:,ic1) = votes(:,ic1) +  vmask;
        % negative are votes for the second class in the pair
        votes(:,ic2) = votes(:,ic2) + ~vmask;
        % ties divide the vote
        vmask = (tmp(:,ip) == 0)/2;
        votes(:,ic1) = votes(:,ic1) + vmask;
        votes(:,ic2) = votes(:,ic2) + vmask;

        ip = ip + 1;
      end
    end
    scoresTest = votes;


    [maxScores,maxIndices] = max(scoresTest,[],2);  clear scoresTest;
    predictedLabels = svm_model.Label( maxIndices );
    predictedL2=predictedLabels;

    % do a check - this checks that there is only one vote winner for each example
    pp=[];
    for i=1:size(votes,1)
        pp(i)=length(find(votes(i,:)==max(votes(i,:))));
    end

    if(any(pp>1))
        fprintf('Voting mechanism stats: %d obs are tied\n', length(find(pp>1)));
        
        if(doCorr==1) % first method - randomly assign
            locs=find(pp>1);
            for j=1:length(locs)
                k=randperm(length(svm_model.Label)); % if tied assign at random
                predictedL2(locs(j))=svm_model.Label(k(1));
            end
        elseif(doCorr==2)  % second method - take max absolute decision val - not a great idea
%             locs=find(pp>1);
%             for j=1:length(locs)
%                 [cr,tt]=max(abs(svm_pred_dec_vals(locs(j),:)));
%                 if(sign(svm_pred_dec_vals(locs(j),tt))>0)
%                     guess=cont(tt,1);
%                 else
%                     guess=cont(tt,2);
%                 end              
%                 predictedL2(locs(j))=guess;
%             end
        end
    end
else
    predictedLabels=[]; predictedL2=[];
end