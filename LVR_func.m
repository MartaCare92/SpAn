function [LvR_out_RFA_p,LvR_phase_RFA,TS_RFA,LvR_out_S1_p,LvR_phase_S1,TS_S1]=LVR_func(Duration_fix,nPhases,Res_fold,exp_num,Duration_fixed,LvR_out_RFA_p,LvR_phase_RFA,TS_RFA,LvR_out_S1_p,LvR_phase_S1,TS_S1,indRFA,chsRFA,indS1,chsS1,i,sorted_fold,nSub,lenPhSample_fixed)

for nChsRFA=1:length(chsRFA{:,i})
%     load(fullfile(sorted_fold,'RFA',chsRFA{i}{indRFA(nChsRFA,i)}))
    load(fullfile(sorted_fold,'RFA',chsRFA{i}{nChsRFA}))
    if Duration_fix == '1'
        ts= find(peak_train);
        if isempty(ts)
            ts =0;
        end
        LvR_out_RFA_p{i}{nChsRFA}= LvR(ts);
    else
        for j=1:length(nSub{i})
            if j==1
                ts= find(peak_train(1:lenPhSample_fixed));
                if isempty(ts)
                    ts =0;
                end
                LvR_out_RFA_p{i,j}{nChsRFA}= LvR(ts);
                TS_RFA{i,j}{nChsRFA}=ts;
            elseif j == length(nSub{i})
                ts= find(peak_train);
                ind_end=find(ts == TS_RFA{i,j-1}{nChsRFA}(end));
                ts= ts(ind_end+1:end);
                if isempty(ts)
                    ts =0;
                end
                LvR_out_RFA_p{i,j}{nChsRFA}= LvR(ts);
                TS_RFA{i,j}{nChsRFA}=ts;
            else
                ts= find(peak_train(1:((j)*lenPhSample_fixed)));
                ind_end=find(ts == TS_RFA{i,j-1}{nChsRFA}(end));
                ts= ts(ind_end+1:end);
                if isempty(ts)
                    ts =0;
                end
                LvR_out_RFA_p{i,j}{nChsRFA}= LvR(ts);
                TS_RFA{i,j}{nChsRFA}=ts;
            end
        end
    end
end
% LvR_phase_RFA{i} = [num2str(i),'_',chsRFA{i}{indRFA(nChsRFA,i)}(1:9)];
if i<10
LvR_phase_RFA{i} = ['0',num2str(i),'_',chsRFA{i}{nChsRFA}(1:9)];
else
LvR_phase_RFA{i} = [num2str(i),'_',chsRFA{i}{nChsRFA}(1:9)];    
end
clear peak_train ts

for nChsS1=1:length(chsS1{:,i})
%     load(fullfile(sorted_fold,'S1',chsS1{i}{indS1(nChsS1,i)}))
    load(fullfile(sorted_fold,'S1',chsS1{i}{nChsS1}))
    if Duration_fix == '1'
        ts= find(peak_train);
        if isempty(ts)
            ts =0;
        end
        LvR_out_S1_p{i}{nChsS1}= LvR(ts);
    else
        for j=1:length(nSub{i})
            if j==1
                ts= find(peak_train(1:lenPhSample_fixed));
                if isempty(ts)
                    ts =0;
                end
                LvR_out_S1_p{i,j}{nChsS1}= LvR(ts);
                TS_S1{i,j}{nChsS1}=ts;
            elseif j == length(nSub{i})
                ts= find(peak_train);
                ind_end=find(ts == TS_S1{i,j-1}{nChsS1}(end));
                ts= ts(ind_end+1:end);
                if isempty(ts)
                    ts =0;
                end
                LvR_out_S1_p{i,j}{nChsS1}= LvR(ts);
                TS_S1{i,j}{nChsS1}=ts;
            else
                ts= find(peak_train(1:((j)*lenPhSample_fixed)));
                ind_end=find(ts == TS_S1{i,j-1}{nChsS1}(end));
                ts= ts(ind_end+1:end);
                if isempty(ts)
                    ts =0;
                end
                LvR_out_S1_p{i,j}{nChsS1}= LvR(ts);
                TS_S1{i,j}{nChsS1}=ts;
            end
        end
    end
end
% LvR_phase_S1{i} = [num2str(i),'_',chsS1{i}{indS1(nChsS1,i)}(1:9)];
if i <10
    LvR_phase_S1{i} = ['0',num2str(i),'_',chsS1{i}{nChsS1}(1:9)];
else
LvR_phase_S1{i} = [num2str(i),'_',chsS1{i}{nChsS1}(1:9)];
end
clear peak_train ts

if i == nPhases(end)
Res_folder=fullfile([Res_fold '/Analysis/SWTTEO']);
if exist(Res_folder,'dir')==0
    mkdir(Res_folder)
end

    LvR_out_RFA_end_r = [];
    LvR_out_S1_end_r = [];
    if Duration_fix == '1'
        LvR_out_RFA(1,:) = LvR_out_RFA_p;
        LvR_out_RFA(2,:) = LvR_phase_RFA;
        LvR_out_S1(1,:) = LvR_out_S1_p;
        LvR_out_S1(2,:) = LvR_phase_S1;
        save([Res_folder '/' exp_num '_LVR_Original'],'LvR_out_RFA','LvR_out_S1');
    else
        for jj=1:nPhases
            LvR_out_RFA_end_r = [LvR_out_RFA_end_r,LvR_out_RFA_p(jj,:)];
            LvR_out_S1_end_r = [LvR_out_S1_end_r,LvR_out_S1_p(jj,:)];
        end
        
        LvR_out_RFA = LvR_out_RFA_end_r(~cellfun('isempty',LvR_out_RFA_end_r));
        LvR_out_S1 = LvR_out_S1_end_r(~cellfun('isempty',LvR_out_S1_end_r));
        
        save([Res_folder '/' exp_num '_LVR_' num2str(Duration_fixed)],'LvR_out_RFA','LvR_out_S1');
    end
end
end