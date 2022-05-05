function [mfr_RFA,mfr_mean_RFA,mfr_S1,mfr_mean_S1]=MFR_func(PTSD,SWTTEO,Duration_fix,nPhases,Res_fold,exp_num,Duration_fixed,mfr_RFA,mfr_mean_RFA,mfr_S1,mfr_mean_S1,indRFA,chsRFA,indS1,chsS1,i,sorted_fold,nSub,lenPhSample_fixed,lenPh_fixed)

for nChsRFA=1: length(chsRFA{:,i}) %length(indRFA(:,i))
%     load(fullfile(sorted_fold,'RFA',chsRFA{i}{indRFA(nChsRFA,i)}))
%     %% Originale
%     el= str2double(chsRFA{i}{indRFA(nChsRFA,i)}(end-7:end-6));     % current electrode [double]
%     clu=str2double(chsRFA{i}{indRFA(nChsRFA,i)}(end-4:end-4));
    load(fullfile(sorted_fold,'RFA',chsRFA{i}{nChsRFA}))
    %% Originale
    el= str2double(chsRFA{i}{nChsRFA}(end-7:end-6));     % current electrode [double]
    clu=str2double(chsRFA{i}{nChsRFA}(end-4:end-4));
    z=3;
    mfr_table(nChsRFA,1)= el;
    mfr_table(nChsRFA,2)= clu;
    if Duration_fix == '1'
        numpeaks(nChsRFA)=length(find(peak_train));
        numpeaks(nChsRFA)=numpeaks(nChsRFA);
        mfr_table(nChsRFA, z)= numpeaks(nChsRFA)/lenPh_fixed(1,i); % Mean Firing Rate [spikes/sec]
        mfr_table(nChsRFA, z+1)= numpeaks(nChsRFA);
    else
        for j=1:length(nSub{i})
            if j==1
                numpeaks(nChsRFA,j)=length(find(peak_train(1:lenPhSample_fixed)));
                np=numpeaks(nChsRFA,j);
                mfr_table(nChsRFA, z)= numpeaks(nChsRFA,j)/lenPh_fixed; % Mean Firing Rate [spikes/sec]
                mfr_table(nChsRFA, z+1)= numpeaks(nChsRFA,j);
                z=z+2;
            elseif j == length(nSub{i})
                numpeaks(nChsRFA,j)=length(find(peak_train));
                numpeaks(nChsRFA,j)=numpeaks(nChsRFA,j)-np;
                mfr_table(nChsRFA, z)= numpeaks(nChsRFA,j)/lenPh_fixed; % Mean Firing Rate [spikes/sec]
                mfr_table(nChsRFA, z+1)= numpeaks(nChsRFA,j);
                z=z+2;
            else
                numpeaks(nChsRFA,j)=length(find(peak_train(1:(j)*lenPhSample_fixed)));
                numpeaks(nChsRFA,j)=numpeaks(nChsRFA,j)-np;
                np=np+numpeaks(nChsRFA,j);
                mfr_table(nChsRFA, z)= numpeaks(nChsRFA,j)/lenPh_fixed; % Mean Firing Rate [spikes/sec]
                mfr_table(nChsRFA, z+1)= numpeaks(nChsRFA,j);
                z=z+2;
            end
        end
    end
end

mfr_RFA{1,i}= mfr_table;
mfr_mean_RFA{1,i}=mean(mfr_table(:,3:2:end));
if i<10
mfr_RFA{2,i}=['0',num2str(i),'_',chsRFA{i}{nChsRFA}(1:9)];
mfr_mean_RFA{2,i}=['0',num2str(i),'_',chsRFA{i}{nChsRFA}(1:9)];
else
    mfr_RFA{2,i}=[num2str(i),'_',chsRFA{i}{nChsRFA}(1:9)];
mfr_mean_RFA{2,i}=[num2str(i),'_',chsRFA{i}{nChsRFA}(1:9)];
end
% mfr_RFA{2,i}=[num2str(i),'_',chsRFA{i}{indRFA(nChsRFA,i)}(1:9)];
% mfr_mean_RFA{2,i}=[num2str(i),'_',chsRFA{i}{indRFA(nChsRFA,i)}(1:9)];

clear mfr_table numpeaks
% if chsS1 == 0
%     mfr_S1{i}= 0;
%     mfr_mean_S1{i}=0;   
% else
    for nChsS1=1:length(chsS1{:,i}) %(indS1(:,i))
%         load(fullfile(sorted_fold,'S1',chsS1{i}{indS1(nChsS1,i)}))
%         % Originale
%         el_S1= str2num(chsS1{i}{indS1(nChsS1,i)}(end-7:end-6));     % current electrode [double]
%         clu_S1=str2num(chsS1{i}{indS1(nChsS1,i)}(end-4:end-4));
        load(fullfile(sorted_fold,'S1',chsS1{i}{nChsS1}))
        % Originale
        el_S1= str2num(chsS1{i}{nChsS1}(end-7:end-6));     % current electrode [double]
        clu_S1=str2num(chsS1{i}{nChsS1}(end-4:end-4)); 
        z=3;
        
        mfr_table_S1(nChsS1,1)= el_S1;
        mfr_table_S1(nChsS1,2)= clu_S1;
        
        if Duration_fix == '1'
            numpeaks_S1(nChsS1)=length(find(peak_train));
            numpeaks_S1(nChsS1)=numpeaks_S1(nChsS1);
            mfr_table_S1(nChsS1, z)= numpeaks_S1(nChsS1)/lenPh_fixed(1,i); % Mean Firing Rate [spikes/sec]
            mfr_table_S1(nChsS1, z+1)= numpeaks_S1(nChsS1);
        else
            for j=1:length(nSub{i})
                if j==1
                    numpeaks_S1(nChsS1,j)=length(find(peak_train(1:lenPhSample_fixed)));
                    np_S1=numpeaks_S1(nChsS1,j);
                    mfr_table_S1(nChsS1, z)= numpeaks_S1(nChsS1,j)/lenPh_fixed; % Mean Firing Rate [spikes/sec]
                    mfr_table_S1(nChsS1, z+1)= numpeaks_S1(nChsS1,j);
                    z=z+2;
                elseif j == length(nSub{i})
                    numpeaks_S1(nChsS1,j)=length(find(peak_train));
                    numpeaks_S1(nChsS1,j)=numpeaks_S1(nChsS1,j)-np_S1;
                    mfr_table_S1(nChsS1, z)= numpeaks_S1(nChsS1,j)/lenPh_fixed; % Mean Firing Rate [spikes/sec]
                    mfr_table_S1(nChsS1, z+1)= numpeaks_S1(nChsS1,j);
                    z=z+2;
                else
                    numpeaks_S1(nChsS1,j)=length(find(peak_train(1:(j)*lenPhSample_fixed)));
                    numpeaks_S1(nChsS1,j)=numpeaks_S1(nChsS1,j)-np_S1;
                    np_S1=np_S1+numpeaks_S1(nChsS1,j);
                    mfr_table_S1(nChsS1, z)= numpeaks_S1(nChsS1,j)/lenPh_fixed; % Mean Firing Rate [spikes/sec]
                    mfr_table_S1(nChsS1, z+1)= numpeaks_S1(nChsS1,j);
                    z=z+2;
                end
            end
        end
    end
    
    mfr_S1{1,i}= mfr_table_S1;
    mfr_mean_S1{1,i}=mean(mfr_table_S1(:,3:2:end));
%     mfr_S1{2,i}=[num2str(i),'_',chsS1{i}{indS1(nChsS1,i)}(1:9)];
%     mfr_mean_S1{2,i}=[num2str(i),'_',chsS1{i}{indS1(nChsS1,i)}(1:9)];
if i<10
        mfr_S1{2,i}=['0',num2str(i),'_',chsS1{i}{nChsS1}(1:9)];
    mfr_mean_S1{2,i}=['0',num2str(i),'_',chsS1{i}{nChsS1}(1:9)];
else
    mfr_S1{2,i}=[num2str(i),'_',chsS1{i}{nChsS1}(1:9)];
    mfr_mean_S1{2,i}=[num2str(i),'_',chsS1{i}{nChsS1}(1:9)];
end
    clear mfr_table_S1 numpeaks_S1
% end

if i == nPhases(end)
    if PTSD == 1
        Res_folder=fullfile([Res_fold '/Analysis/']);
    elseif SWTTEO == 1
        Res_folder=fullfile([Res_fold '/Analysis/SWTTEO']);
    end
    if exist(Res_folder,'dir')==0
        mkdir(Res_folder)
    end
    if Duration_fix == '1'
        save([Res_folder '/' exp_num '_MFR_Original'],'mfr_RFA','mfr_mean_RFA','mfr_S1','mfr_mean_S1');
    else
        save([Res_folder '/' exp_num '_MFR_' num2str(Duration_fixed)],'mfr_RFA','mfr_mean_RFA','mfr_S1','mfr_mean_S1');
    end
end
end