function [TS_RFA_p,TS_S1_p,spkLabel_RFA_p,spkLabel_S1_p,evector_RFA,evector_S1]=TS_func(evector_RFA,evector_S1,Phases_ordered,Duration_fix,nPhases,Res_fold,exp_num,Duration_fixed,TS_RFA_p,TS_S1_p,spkLabel_RFA_p,spkLabel_S1_p,indRFA,chsRFA,indS1,chsS1,i,sorted_fold,nSub,lenPhSample_fixed,bin,gaussFilter,FS,RFA,S1,PC,RASTER,f)
for nChsRFA=1:length(indRFA(:,i))
    load(fullfile(sorted_fold,'RFA',chsRFA{i}{indRFA(nChsRFA,i)}))
    el= str2double(chsRFA{i}{indRFA(nChsRFA,i)}(end-7:end-6));     % current electrode [double]
    evector_RFA = [evector_RFA; el];
    if Duration_fix == '1'
        ts= find(peak_train);
        if isempty(ts)
            ts =0;
        end
        TS_RFA_p{i}{nChsRFA}=ts;
        
        spiketimes = ts;
        nspkTsCurElec = length(spiketimes);
        spkLabel_RFA_p{i}{nChsRFA}= nChsRFA.*ones(nspkTsCurElec,1);
    else
        for j=1:length(nSub{i})
            if j==1
                ts= find(peak_train(1:lenPhSample_fixed));
                if isempty(ts)
                    ts =0;
                end
                TS_RFA_p{i,j}{nChsRFA}=ts;
                
                spiketimes = ts;
                nspkTsCurElec = length(spiketimes);
                spkLabel_RFA_p{i,j}{nChsRFA}= nChsRFA.*ones(nspkTsCurElec,1);
                
            elseif j == length(nSub{i})
                ts= find(peak_train);
                ind_end=find(ts == TS_RFA_p{i,j-1}{nChsRFA}(end));
                ts= ts(ind_end+1:end);
                if isempty(ts)
                    ts =0;
                end
                TS_RFA_p{i,j}{nChsRFA}=ts;
                
                spiketimes = ts;
                nspkTsCurElec = length(spiketimes);
                spkLabel_RFA_p{i,j}{nChsRFA}= nChsRFA.*ones(nspkTsCurElec,1);
            else
                ts= find(peak_train(1:((j)*lenPhSample_fixed)));
                ind_end=find(ts == TS_RFA_p{i,j-1}{nChsRFA}(end));
                ts= ts(ind_end+1:end);
                if isempty(ts)
                    ts =0;
                end
                TS_RFA_p{i,j}{nChsRFA}=ts;
                
                spiketimes = ts;
                nspkTsCurElec = length(spiketimes);
                spkLabel_RFA_p{i,j}{nChsRFA}= nChsRFA.*ones(nspkTsCurElec,1);
            end
        end
    end
end
clear peak_train ts

if isempty(chsS1)
        TS_S1_p = 0;
        spkLabel_S1_p = 0;
        evector_S1 = 0;
        nChsS1 = 0;
else
    for nChsS1=1:length(indS1(:,i))
        load(fullfile(sorted_fold,'S1',chsS1{i}{indS1(nChsS1,i)}))
        el_S1= str2double(chsS1{i}{indS1(nChsS1,i)}(end-7:end-6));     % current electrode [double]
        evector_S1 = [evector_S1; el_S1];
        if Duration_fix == '1'
            ts= find(peak_train);
            if isempty(ts)
                ts =0;
            end
            TS_S1_p{i}{nChsS1}=ts;
            
            spiketimes_S1 = ts;
            nspkTsCurElec_S1 = length(spiketimes_S1);
            spkLabel_S1_p{i}{nChsS1} =  nChsS1.*ones(nspkTsCurElec_S1,1);
        else
            for j=1:length(nSub{i})
                if j==1
                    ts= find(peak_train(1:lenPhSample_fixed));
                    if isempty(ts)
                        ts =0;
                    end
                    TS_S1_p{i,j}{nChsS1}=ts;
                    
                    spiketimes_S1 = ts;
                    nspkTsCurElec_S1 = length(spiketimes_S1);
                    spkLabel_S1_p{i,j}{nChsS1} =  nChsS1.*ones(nspkTsCurElec_S1,1);
                elseif j == length(nSub{i})
                    ts= find(peak_train);
                    ind_end=find(ts == TS_S1_p{i,j-1}{nChsS1}(end));
                    ts= ts(ind_end+1:end);
                    if isempty(ts)
                        ts =0;
                    end
                    TS_S1_p{i,j}{nChsS1}=ts;
                    
                    spiketimes_S1 = ts;
                    nspkTsCurElec_S1 = length(spiketimes_S1);
                    spkLabel_S1_p{i,j}{nChsS1} =  nChsS1.*ones(nspkTsCurElec_S1,1);
                else
                    ts= find(peak_train(1:((j)*lenPhSample_fixed)));
                    ind_end=find(ts == TS_S1_p{i,j-1}{nChsS1}(end));
                    ts= ts(ind_end+1:end);
                    if isempty(ts)
                        ts =0;
                    end
                    TS_S1_p{i,j}{nChsS1}=ts;
                    
                    spiketimes_S1 = ts;
                    nspkTsCurElec_S1 = length(spiketimes_S1);
                    spkLabel_S1_p{i,j}{nChsS1} =  nChsS1.*ones(nspkTsCurElec_S1,1);
                end
            end
        end
    end
end
clear peak_train ts

if i == nPhases(end)
    Res_folder=fullfile([Res_fold '/Analysis/']);
    if exist(Res_folder,'dir')==0
        mkdir(Res_folder)
    end
    
    if Duration_fix == '1'
        TS_RFA = TS_RFA_p;
        TS_S1 = TS_S1_p;
        spkLabel_RFA = spkLabel_RFA_p;
        spkLabel_S1 = spkLabel_S1_p;
        
        save([Res_folder '/' exp_num '_TS_Original'],'TS_RFA','TS_S1');
    else
        TS_RFA_end_r = [];
        TS_S1_end_r = [];
        spkLabel_RFA_end_r = [];
        spkLabel_S1_end_r = [];
        
        for jj=1:nPhases
            TS_RFA_end_r = [TS_RFA_end_r,TS_RFA_p(jj,:)];
            TS_S1_end_r = [TS_S1_end_r,TS_S1_p(jj,:)];
            spkLabel_RFA_end_r = [spkLabel_RFA_end_r,spkLabel_RFA_p(jj,:)];
            spkLabel_S1_end_r = [spkLabel_S1_end_r,spkLabel_S1_p(jj,:)];
        end
        
        TS_RFA = TS_RFA_end_r(~cellfun('isempty',TS_RFA_end_r));
        TS_S1 = TS_S1_end_r(~cellfun('isempty',TS_S1_end_r));
        spkLabel_RFA = spkLabel_RFA_end_r(~cellfun('isempty',spkLabel_RFA_end_r));
        spkLabel_S1 = spkLabel_S1_end_r(~cellfun('isempty',spkLabel_S1_end_r));
        
        save([Res_folder '/' exp_num '_TS_' num2str(Duration_fixed)],'TS_RFA','TS_S1');
        save([Res_folder '/' exp_num '_SpkLabel_' num2str(Duration_fixed)],'spkLabel_RFA','spkLabel_S1');
    end
    
    if PC == 1
        waitbar(.90,f,'Processing PC');
        pause(1)
        PC_func(Duration_fix,nPhases,Res_fold,exp_num,i,Duration_fixed,lenPhSample_fixed,bin,gaussFilter,FS,RFA,S1,TS_RFA,TS_S1);
    end
    if RASTER == 1
        waitbar(.95,f,'Processing Raster Plot');
        pause(1)
        Raster(Phases_ordered,TS_RFA,TS_S1,spkLabel_RFA,spkLabel_S1,gaussFilter,FS,bin,Duration_fixed,evector_RFA,nChsRFA,evector_S1,nChsS1,Duration_fix,Res_fold,nSub)
    end
end
end