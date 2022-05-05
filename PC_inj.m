
function [PC_RFA, PC_S1,func]=PC_inj(bin,gaussFilter,FS,nPhases,dur,TS_RFA,TS_S1,RFA,S1)
% Population coupling

%   bin=0.001;
%   E = exp(-1*(-15:1:15).^2/50);
%   E = E/sum(E); % smoothing kernel  
E = gaussFilter;
  
  for B=1:nPhases

        population_ts_RFA=[];
        edges=[];
        A=[];

        for U=1:length(TS_RFA{B})
            el= str2num(RFA{U}(end-3:end-2));     % current electrode [double]
            clu=str2num(RFA{U}(end));
            ts=TS_RFA{B}{U};
            population_ts_RFA=union(population_ts_RFA,ts);
%             edges=(bin*FS:bin*FS:dur(B)); %old
            edges=(bin*FS:bin*FS:dur);
            A(:,U)=hist(ts,edges);
            clear ts
        end
        A_shuffled_RFA= Kshuffle_MEX(A,uint16(678),10*nchoosek(size(A,2),2));
          
         population_ts_S1=[];
         edges=[]; 
         A=[];

        for U=1:length(TS_S1{B})
            el= str2num(S1{U}(end-3:end-2));     % current electrode [double]
            clu=str2num(S1{U}(end));
            ts=TS_S1{B}{U};
            population_ts_S1=union(population_ts_S1,ts);
%             edges=(bin*FS:bin*FS:dur(B)); %old
            edges=(bin*FS:bin*FS:dur);
            A(:,U)=hist(ts,edges);
            clear ts
        end
        A_shuffled_S1=Kshuffle_MEX(A,uint16(678),10*nchoosek(size(A,2),2));
       
        for U=1:length(TS_RFA{B})
            
            stPRneuron_shuffled_RFA=[];

            ts1=TS_RFA{B}{U};
            [int indexp index]=intersect(population_ts_RFA,ts1);
            
            population_ts_RFA(indexp)=[];%pop time stamps without the k neuron
            %         population_train(population_ts)=1;
            population_rate=hist(population_ts_RFA,edges);
            
            neuron_rate=hist(ts1,edges);
            
            s=neuron_rate; % spike train of one neuron (in 1ms resolution)
            pr=population_rate; % population rate (in 1ms resolution)
            
            stpr = wconv1(E, xcorr(pr, s, 500)/sum(s)); % if pr includes the spikes of s, use pr-s instead of pr here
            
            stpr= stpr(:,16:end-16); % drop the edges
            
            stpr = stpr - mean(stpr([10:100 900:990])); % subtract the baseline
            stpr=stpr.*(FS/10^3);
            stpr_RFA{B}(U,:)=stpr;
            Population_Coupling_RFA(U,B)=stpr(500);
            
            xtime=-0.5:1/(length(stpr)-1):0.5;
            %Shuffled stpr
            neuron_rate1=A_shuffled_RFA(:,U);
            s1=neuron_rate1';
            stpr1 = wconv1(E, xcorr(pr, s1, 500)/sum(s1)); % if pr includes the spikes of s, use pr-s instead of pr here
            stpr1= stpr1(:,16:end-16); % drop the edges
            stpr1 = stpr1 - mean(stpr1([10:100 900:990])); % subtract the baseline
            stpr1=stpr1.*(FS/10^3);
            stpr_Shuffled_RFA{B}(U,:)=stpr1;
            Population_Coupling_Shuffled_RFA(U,B)=stpr1(500);
            population_ts_RFA=union(population_ts_RFA,ts1);
            clear ts1 ts_neuron_rate population_rate stpr s pr s1 neuron_rate1 stpr1 indexp
        end
        
        
         for U=1:length(TS_S1{B})
           
            stPRneuron_shuffled_S1=[];

            ts1=TS_S1{B}{U};
            [int indexp index]=intersect(population_ts_S1,ts1);
            
            population_ts_S1(indexp)=[];%pop time stamps without the k neuron
            %         population_train(population_ts)=1;
            population_rate=hist(population_ts_S1,edges);
            
            neuron_rate=hist(ts1,edges);
            
            s=neuron_rate; % spike train of one neuron (old:in 1ms resolution)
            pr=population_rate; % population rate (old:1ms resolution)
            
            stpr = wconv1(E, xcorr(pr, s, 500)/sum(s)); % if pr includes the spikes of s, use pr-s instead of pr here
            
            stpr= stpr(:,16:end-16); % drop the edges
            
            stpr = stpr - mean(stpr([10:100 900:990])); % subtract the baseline
            stpr=stpr.*(FS/10^3);
            stpr_S1{B}(U,:)=stpr;
            Population_Coupling_S1(U,B)=stpr(500);
            
            xtime=-0.5:1/(length(stpr)-1):0.5;
            %Shuffled stpr
            neuron_rate1=A_shuffled_S1(:,U);
            s1=neuron_rate1';
            stpr1 = wconv1(E, xcorr(pr, s1, 500)/sum(s1)); % if pr includes the spikes of s, use pr-s instead of pr here
            stpr1= stpr1(:,16:end-16); % drop the edges
            stpr1 = stpr1 - mean(stpr1([10:100 900:990])); % subtract the baseline
            stpr1=stpr1.*(FS/10^3);
            stpr_Shuffled_S1{B}(U,:)=stpr1;
            Population_Coupling_Shuffled_S1(U,B)=stpr1(500);
            population_ts_S1=union(population_ts_S1,ts1);
            clear ts1 ts_neuron_rate population_rate stpr s pr s1 neuron_rate1 stpr1 indexp
         end
         
        
        normRFA=median(Population_Coupling_Shuffled_RFA(:,B),1,'omitnan');
        normS1=median(Population_Coupling_Shuffled_S1(:,B),1,'omitnan');
        PCNormRFA(:,B)=Population_Coupling_RFA(:,B)./normRFA;
        PCNormS1(:,B)=Population_Coupling_S1(:,B)./normS1;
        
        clear A_shuffled_S1 A_shuffled_RFA normRFA normS1
        
  end  
  
  PC_RFA=table(RFA',Population_Coupling_RFA,PCNormRFA,'VariableNames',{'SingleUnits','PCRFA','PCNormRFA'});
  func.RFA=table(stpr_RFA',stpr_Shuffled_RFA','VariableNames',{'stpr_RFA','stpr_Shuffled_RFA'});      
  PC_S1=table(S1',Population_Coupling_S1,PCNormS1,'VariableNames',{'SingleUnits','PCS1','PCNormS1'});
  func.S1=table(stpr_S1',stpr_Shuffled_S1','VariableNames',{'stpr_S1','stpr_Shuffled_S1'});           