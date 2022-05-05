function [FR_RFA, FR_S1,stats]=bootstrapFR(nPhases,numOfIterations,dur,bsl_freq_RFA,bsl_freq_S1,RFA,S1)
% 
dist=@(x,y) x-y;
% Calculate 'real_dist_RFA/S1' real distance between the mean of subsequent spikes(bsl_freq_RFA/S1)
for i=1:nPhases
    if i<nPhases
        for n=1:length(bsl_freq_RFA{1}(1,:))
            real_dist_RFA{i}(n,1)= dist (mean(bsl_freq_RFA{1}(:,n),'omitnan'), mean(bsl_freq_RFA{i+1}(:,n),'omitnan'));
        end
        for n=1:length(bsl_freq_S1{1}(1,:))
            real_dist_S1{i}(n,1)= dist (mean(bsl_freq_S1{1}(:,n),'omitnan'), mean(bsl_freq_S1{i+1}(:,n),'omitnan'));
        end
    end
end
all_dist_RFA = cell(1,nPhases-1);

for i=1:nPhases
    if i<nPhases
        for n=1:length(bsl_freq_RFA{1}(1,:))
            for m=1:numOfIterations
                tmp = randperm(min(round(dur))*2)'; % random permutation of the integers (1:min(round(dur))*2)without repeating elements
                firstPositions = tmp(1:min(round(dur)),1);
                secondPositions = tmp(min(round(dur))+1:end);
                
                combined_freq_RFA=[bsl_freq_RFA{1}(1:min(round(dur)),n),bsl_freq_RFA{i+1}(1:min(round(dur)),n)];
                
                nonreal_bsl = combined_freq_RFA(firstPositions);
                nonreal_end = combined_freq_RFA(secondPositions);
                
                current_dist = dist(mean(nonreal_bsl) , mean(nonreal_end));
                all_dist_RFA{i}(m,n) = current_dist; % random distances
            end
            clear current_dist nonreal_end nonreal_bsl combined_freq_RFA secondPositions firstPositions tmp
        end
        for n=1:length(bsl_freq_S1{1}(1,:))
            for m=1:numOfIterations
                tmp = randperm(min(round(dur))*2)';
                firstPositions = tmp(1:min(round(dur)),1);
                secondPositions = tmp(min(round(dur))+1:end);
                
                combined_freq_S1=[bsl_freq_S1{1}(1:min(round(dur)),n),bsl_freq_S1{i+1}(1:min(round(dur)),n)];
                
                nonreal_bsl = combined_freq_S1(firstPositions);
                nonreal_end = combined_freq_S1(secondPositions);
                
                current_dist = dist(mean(nonreal_bsl) , mean(nonreal_end));
                all_dist_S1{i}(m,n) = current_dist;
            end
            clear current_dist nonreal_end nonreal_bsl combined_freq_RFA secondPositions firstPositions tmp
        end
        
    end
end


for i=1:nPhases-1
% Create a standard Normal distribution object with 
% the mean of all the random distances and the standard deviation of all the random distances.
    for n=1:length(bsl_freq_RFA{1}(1,:))
        confidence_interval_RFA{i}(n,:) = icdf('Normal',[0.025 0.975], mean(all_dist_RFA{i}(:,n)),std(all_dist_RFA{i}(:,n)) );
    end
    for n=1:length(bsl_freq_S1{1}(1,:))
        confidence_interval_S1{i}(n,:) = icdf('Normal',[0.025 0.975], mean(all_dist_S1{i}(:,n)),std(all_dist_S1{i}(:,n)) );
    end
end

for i=1:nPhases-1
    % Look where the real distance is in the confidential interval build by
    % random distances
    for n=1:length(bsl_freq_RFA{1}(1,:))
        if real_dist_RFA{i}(n) > confidence_interval_RFA{i}(n,2)
            resultsRFA(n,i) = 1; % significantly lower
        elseif real_dist_RFA{i}(n) < confidence_interval_RFA{i}(n,1)
            resultsRFA(n,i) = -1; % significantly higher
        else
            resultsRFA(n,i) = 0; %not changed
        end
    end
    for n=1:length(bsl_freq_S1{1}(1,:))
        if real_dist_S1{i}(n) > confidence_interval_S1{i}(n,2)
            resultsS1(n,i) = 1; % significantly lower
        elseif real_dist_S1{i}(n) < confidence_interval_S1{i}(n,1)
            resultsS1(n,i) = -1; % significantly higher
        else
            resultsS1(n,i) = 0; %not changed
        end
    end
    
end

for i=1:nPhases
    frRFA(:,i)=mean(bsl_freq_RFA{i});
    frS1(:,i)=mean(bsl_freq_S1{i});
end

for i =1:nPhases-1
statsRFA.increased(i)=numel(find(resultsRFA(:,i)== -1))/numel(resultsRFA(:,1));
statsRFA.decreased(i)=numel(find(resultsRFA(:,i)== 1))/numel(resultsRFA(:,1));
statsRFA.no_change(i)=numel(find(resultsRFA(:,i)== 0))/numel(resultsRFA(:,1));
end
FR_RFA=table(RFA',frRFA,resultsRFA,'VariableNames',{'SingleUnit','FiringRate','Boot'});
% FR_RFA=table(frRFA,resultsRFA,'VariableNames',{'FiringRate','Boot'});

for i =1:nPhases-1
statsS1.increased(i)=numel(find(resultsS1(:,i)== -1))/numel(resultsS1(:,1));
statsS1.decreased(i)=numel(find(resultsS1(:,i)== 1))/numel(resultsS1(:,1));
statsS1.no_change(i)=numel(find(resultsS1(:,i)== 0))/numel(resultsS1(:,1));
end
FR_S1=table(S1', frS1,resultsS1,'VariableNames',{'SingleUnit','FiringRate','Boot'});
% FR_S1=table(frS1,resultsS1,'VariableNames',{'FiringRate','Boot'});
stats.RFA=statsRFA;
stats.S1=statsS1;



