function [bsl_freq_RFA_p,TS_RFA_p,bsl_freq_S1_p,TS_S1_p]=BslFreq_func(Duration_fix,nPhases,Res_fold,exp_num,Duration_fixed,bsl_freq_RFA_p,TS_RFA_p,bsl_freq_S1_p,TS_S1_p,indRFA,chsRFA,indS1,chsS1,i,sorted_fold,nSub,lenPhSample_fixed,lenPh_fixed,numOfIterations,RFA,S1,bin_size,FS)
for nChsRFA=1:length(indRFA(:,i))
    load(fullfile(sorted_fold,'RFA',chsRFA{i}{indRFA(nChsRFA,i)}))
    start=0;
    if Duration_fix == '1'
        ts= find(peak_train);
        if isempty(ts)fullfile(sorted_fold,'RFA',chsRFA{i}{indRFA(nChsRFA,i)})
            ts =0;
        end
        bins=start:bin_size:lenPh_fixed;
        
        bsl_fr=histc(ts./FS,bins)/bin_size;
        bsl_fr=bsl_fr(1:numel(bins)-1);
        bsl_freq_RFA_p{i}(:,nChsRFA)=bsl_fr;
    else
        for j=1:length(nSub{i})
            if j==1
                ts= find(peak_train(1:lenPhSample_fixed));
                if isempty(ts)
                    ts =0;
                end
                TS_RFA_p{i,j}{nChsRFA}=ts;
                
                bins=start:bin_size:j*lenPh_fixed;
                start=bins(end);
                
                bsl_fr=histc(ts./FS,bins)/bin_size;
                bsl_fr=bsl_fr(1:numel(bins)-1);
                bsl_freq_RFA_p{i,j}(:,nChsRFA)=bsl_fr;
            elseif j == length(nSub{i})
                ts= find(peak_train);
                ind_end=find(ts == TS_RFA_p{i,j-1}{nChsRFA}(end));
                ts= ts(ind_end+1:end);
                if isempty(ts)
                    ts =0;
                end
                TS_RFA_p{i,j}{nChsRFA}=ts;
                
                bins=start:bin_size:j*lenPh_fixed;
                start=bins(end);
                
                bsl_fr=histc(ts./FS,bins)/bin_size;
                bsl_fr=bsl_fr(1:numel(bins)-1);
                bsl_freq_RFA_p{i,j}(:,nChsRFA)=bsl_fr;
            else
                ts= find(peak_train(1:((j)*lenPhSample_fixed)));
                ind_end=find(ts == TS_RFA_p{i,j-1}{nChsRFA}(end));
                ts= ts(ind_end+1:end);
                if isempty(ts)
                    ts =0;
                end
                TS_RFA_p{i,j}{nChsRFA}=ts;
                
                bins=start:bin_size:j*lenPh_fixed;
                start=bins(end);
                
                bsl_fr=histc(ts./FS,bins)/bin_size;
                bsl_fr=bsl_fr(1:numel(bins)-1);
                bsl_freq_RFA_p{i,j}(:,nChsRFA)=bsl_fr;
            end
        end
    end
end
clear peak_train ts spiketimes  bsl_fr end_fr

for nChsS1=1:length(indS1(:,i))
    load(fullfile(sorted_fold,'S1',chsS1{i}{indS1(nChsS1,i)}))
    start=0;
    if Duration_fix == '1'
        ts= find(peak_train);
        if isempty(ts)
            ts =0;
        end
        bins=start:bin_size:lenPh_fixed;
        
        bsl_fr=histc(ts./FS,bins)/bin_size;
        bsl_fr=bsl_fr(1:numel(bins)-1);
        bsl_freq_S1_p{i}(:,nChsS1)=bsl_fr;
    else
        for j=1:length(nSub{i})
            if j==1
                ts= find(peak_train(1:lenPhSample_fixed));
                if isempty(ts)
                    ts =0;
                end
                TS_S1_p{i,j}{nChsS1}=ts;
                
                bins=start:bin_size:j*lenPh_fixed;
                start=bins(end);
                
                bsl_fr=histc(ts./FS,bins)/bin_size;
                bsl_fr=bsl_fr(1:numel(bins)-1);
                bsl_freq_S1_p{i,j}(:,nChsS1)=bsl_fr;
                
            elseif j == length(nSub{i})
                ts= find(peak_train);
                ind_end=find(ts == TS_S1_p{i,j-1}{nChsS1}(end));
                ts= ts(ind_end+1:end);
                if isempty(ts)
                    ts =0;
                end
                
                TS_S1_p{i,j}{nChsS1}=ts;
                
                bins=start:bin_size:j*lenPh_fixed;
                start=bins(end);
                
                bsl_fr=histc(ts./FS,bins)/bin_size;
                bsl_fr=bsl_fr(1:numel(bins)-1);
                bsl_freq_S1_p{i,j}(:,nChsS1)=bsl_fr;
                
            else
                ts= find(peak_train(1:((j)*lenPhSample_fixed)));
                ind_end=find(ts == TS_S1_p{i,j-1}{nChsS1}(end));
                ts= ts(ind_end+1:end);
                if isempty(ts)
                    ts =0;
                end
                
                TS_S1_p{i,j}{nChsS1}=ts;
                
                bins=start:bin_size:j*lenPh_fixed;
                start=bins(end);
                
                bsl_fr=histc(ts./FS,bins)/bin_size;
                bsl_fr=bsl_fr(1:numel(bins)-1);
                bsl_freq_S1_p{i,j}(:,nChsS1)=bsl_fr;
            end
        end
    end
end
clear peak_train ts spiketimes_S1  bsl_fr_S1 end_fr

if i == nPhases(end)
Res_folder=fullfile([Res_fold '/Analysis/']);
if exist(Res_folder,'dir')==0
    mkdir(Res_folder)
end
    if Duration_fix == '1'
        Duration_fixed=round(Duration_fixed);
        bsl_freq_RFA = bsl_freq_RFA_p;
        bsl_freq_S1 = bsl_freq_S1_p;
        nsubPhases=length(bsl_freq_RFA);
        [FR_RFA, FR_S1,boot_stats]=bootstrapFR(nsubPhases,numOfIterations,Duration_fixed,bsl_freq_RFA,bsl_freq_S1,RFA,S1);
        
        save([Res_folder '/' exp_num '_FR_Original'],'FR_RFA', 'FR_S1','boot_stats');
    else
        bsl_freq_RFA_end_r = [];
        bsl_freq_S1_end_r = [];
        
        for jj=1:nPhases
            bsl_freq_RFA_end_r = [bsl_freq_RFA_end_r,bsl_freq_RFA_p(jj,:)];
            bsl_freq_S1_end_r = [bsl_freq_S1_end_r,bsl_freq_S1_p(jj,:)];
        end
        
        bsl_freq_RFA = bsl_freq_RFA_end_r(~cellfun('isempty',bsl_freq_RFA_end_r));
        bsl_freq_S1 = bsl_freq_S1_end_r(~cellfun('isempty',bsl_freq_S1_end_r));
        
        nsubPhases=length(bsl_freq_RFA);
        [FR_RFA, FR_S1,boot_stats]=bootstrapFR(nsubPhases,numOfIterations,Duration_fixed,bsl_freq_RFA,bsl_freq_S1,RFA,S1);
        
        save([Res_folder '/' exp_num '_FR_' num2str(Duration_fixed)],'FR_RFA', 'FR_S1','boot_stats');
    end
end
end