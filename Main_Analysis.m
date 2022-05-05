function []=Main_Analysis(start_folder,Result_folder,exp_num,bin_size,bin,numOfIterations,Duration_fix,MFR,LVR,BOOT,PC,TS,RASTER,RAW,SPK,spk,mfr,lvr,boot,pc,YES,PTSD,SWTTEO,CH)
f = waitbar(0,'Please wait...');
pause(.5)
close(f)
if SPK==1||MFR==1||LVR==1||PC==1||BOOT==1||RASTER==1
    
    [Res_fold,Duration_fixed,gaussFilter,nSub,Phases_ordered,RFA,S1,nPhases,indRFA,chsRFA,indS1,chsS1]=setting_start(PTSD,SWTTEO,start_folder,Result_folder,Duration_fix,bin_size,bin,numOfIterations,YES);
    
elseif RAW == 1
    Res_fold = Result_folder;
    if exist(Res_fold,'dir')==0
        mkdir(Res_fold)
    end
    
    ndir=0;
    AllPhases = dir(fullfile(start_folder));
    for ii = 1:numel(AllPhases)
        if AllPhases(ii).isdir
            ndir=1+ndir;
            phases(ndir)=AllPhases(ii);
            disp(AllPhases(ii).name); % disp displays the value of the input variable
        end
    end
    nPhases = ndir;
    Phases_ordered = phases(3:nPhases);
    nPhases = length(Phases_ordered);
    clear ndir
end

h=waitbar(.5,'Processing your data');

for i= 1:nPhases
    
    load(fullfile(start_folder,[Phases_ordered(i).name '_Block.mat']))
    
    if SPK==1||MFR==1||LVR==1||PC==1||BOOT==1||RASTER==1
        
        if YES == 1
            sorted_fold=(fullfile(start_folder,Phases_ordered(i).name,[Phases_ordered(i).name '_Sorted_splitted']));
        else
            if PTSD == 1
                sorted_fold=(fullfile(start_folder, Phases_ordered(i).name,[Phases_ordered(i).name '_NOTSorted_splitted']));
            elseif SWTTEO == 1
                sorted_fold=(fullfile(start_folder, Phases_ordered(i).name,[Phases_ordered(i).name '_NOTSorted_SWTTEO_splitted']));
            end
        end
        
        FS=blockObj.SampleRate;
        lenPh_min=blockObj.Samples./blockObj.SampleRate./60; %min
        Duration = lenPh_min;
        if Duration_fix == '1'
            Duration_fixed(1,i)=Duration;
            lenPh_fixed(1,i)=Duration_fixed(1,i)*60; % sec
            lenPhSample_fixed(1,i)=lenPh_fixed(1,i)*FS; % #samples
        else
            if Duration < Duration_fixed
                lenPh_fixed= Duration*60; % sec
                lenPhSample_fixed=lenPh_fixed*FS; % #samples
            else
                lenPh_fixed=Duration_fixed*60; % sec
                lenPhSample_fixed=lenPh_fixed*FS; % #samples
            end
        end
        
        if SPK == 1
            if PTSD == 1
                Res_folder_Spikes_Analysis=fullfile([Res_fold '/Analysis/PTSD']);
            elseif SWTTEO == 1
                Res_folder_Spikes_Analysis=fullfile([Res_fold '/Analysis/SWTTEO']);
            end
            if exist(Res_folder_Spikes_Analysis,'dir')==0
                mkdir(Res_folder_Spikes_Analysis)
            end
            if spk==1
                if PTSD == 1
                    Res_folder_Spikes_RFA=fullfile([Res_fold '/Plot/PTSD/Raw/Spikes/RFA']);
                    Res_folder_Spikes_S1=fullfile([Res_fold '/Plot/PTSD/Raw/Spikes/S1']);
                elseif SWTTEO == 1
                    Res_folder_Spikes_RFA=fullfile([Res_fold '/Plot/SWTTEO/Raw/Spikes/RFA']);
                    Res_folder_Spikes_S1=fullfile([Res_fold '/Plot/SWTTEO/Raw/Spikes/S1']);
                end
                if exist(Res_folder_Spikes_RFA,'dir')==0
                    mkdir(Res_folder_Spikes_RFA)
                end
                if exist(Res_folder_Spikes_S1,'dir')==0
                    mkdir(Res_folder_Spikes_S1)
                end
            end

            for j=1:length(chsRFA{1,i})
                ch=load(fullfile(sorted_fold,['\RFA\',chsRFA{1,i}{j,1}]));
                el= str2double(chsRFA{i}{indRFA(j,i)}(end-7:end-6));     % current electrode [double]
                    if isnan(ch.spikes)
                        N_Spk_RFA{i,el}=0;
                    else
                        N_Spk_RFA{i,el}=length(ch.spikes);
                        if spk==1
                            figure
                            hold on
                            title(['RFA Channel ',num2str(el),' N. Spikes: ', num2str(N_Spk_RFA{i,el})])
                            for k=1:length(ch.spikes)
                                plot(ch.spikes(k,:))
                            end
                            saveas(gcf,fullfile(Res_folder_Spikes_RFA,[num2str(Phases_ordered(i).name) '_RFA Channel_',num2str(el) '.png']))
                            close gcf
                        end
                    end
            end
            for j=1:length(chsS1{:,i})
                ch=load(fullfile(sorted_fold,['\S1\',chsS1{1,i}{j,1}]));
                el= str2double(chsS1{i}{indS1(j,i)}(end-7:end-6));     % current electrode [double]
                    if isnan(ch.spikes)
                        N_Spk_S1{i,el}=0;
                    else
                        N_Spk_S1{i,el}=length(ch.spikes);
                        if spk==1
                            figure
                            hold on
                            title(['S1 Channel ',num2str(el),' N. Spikes: ', num2str(N_Spk_S1{i,el})])
                            for k=1:length(ch.spikes(:,i))
                                plot(ch.spikes(k,:))
                            end
                            saveas(gcf,fullfile(Res_folder_Spikes_S1,[num2str(Phases_ordered(i).name) '_S1 Channel_',num2str(el) '.png']))
                            close gcf
                        end
                    end
            end
            
            if i == nPhases
                save(fullfile(Res_folder_Spikes_Analysis,'N_Spk'),'N_Spk_S1','N_Spk_RFA','-v7.3')
            end
        end
        
        if MFR == 1
            f = waitbar(.60,'Processing Mfr');
            pause(1)
            if i==1
                mfr_RFA={};
                mfr_mean_RFA={};
                mfr_S1={};
                mfr_mean_S1={};
            end
            [mfr_RFA,mfr_mean_RFA,mfr_S1,mfr_mean_S1]=MFR_func(PTSD,SWTTEO,Duration_fix,nPhases,Result_folder,exp_num,Duration_fixed,mfr_RFA,mfr_mean_RFA,mfr_S1,mfr_mean_S1,indRFA,chsRFA,indS1,chsS1,i,sorted_fold,nSub,lenPhSample_fixed,lenPh_fixed);
        close(f)
        end
        
        if LVR == 1
            f = waitbar(.70,'Processing LvR');
            pause(1)
            if i==1
                LvR_out_RFA_p={};
                LvR_phase_RFA={};
                TS_RFA={};
                LvR_out_S1_p={};
                LvR_phase_S1={};
                TS_S1={};
            end
            [LvR_out_RFA_p,LvR_phase_RFA,TS_RFA,LvR_out_S1_p,LvR_phase_S1,TS_S1]=LVR_func(Duration_fix,nPhases,Result_folder,exp_num,Duration_fixed,LvR_out_RFA_p,LvR_phase_RFA,TS_RFA,LvR_out_S1_p,LvR_phase_S1,TS_S1,indRFA,chsRFA,indS1,chsS1,i,sorted_fold,nSub,lenPhSample_fixed);
        close(f)
        end
        
        if BOOT == 1
            f = waitbar(.80,'Processing Bootstraps');
            pause(1)
            if i==1
                bsl_freq_RFA_p={};
                TS_RFA_p={};
                bsl_freq_S1_p={};
                TS_S1_p={};
            end
            [bsl_freq_RFA_p,TS_RFA_p,bsl_freq_S1_p,TS_S1_p]=BslFreq_func(Duration_fix,nPhases,Result_folder,exp_num,Duration_fixed,bsl_freq_RFA_p,TS_RFA_p,bsl_freq_S1_p,TS_S1_p,indRFA,chsRFA,indS1,chsS1,i,sorted_fold,nSub,lenPhSample_fixed,lenPh_fixed,numOfIterations,RFA,S1,bin_size,FS);
        close(f)
        end
        
        if TS ==1 || PC == 1 || RASTER == 1
            f = waitbar(.85,'Processing TS');
            pause(1)
            if i==1
                TS_RFA_p={};
                TS_S1_p={};
                spkLabel_RFA_p={};
                spkLabel_S1_p={};
                evector_RFA = [];
                evector_S1 = [];
            end
            [TS_RFA_p,TS_S1_p,spkLabel_RFA_p,spkLabel_S1_p,evector_RFA,evector_S1]=TS_func(evector_RFA,evector_S1,Phases_ordered,Duration_fix,nPhases,Res_fold,exp_num,Duration_fixed,TS_RFA_p,TS_S1_p,spkLabel_RFA_p,spkLabel_S1_p,indRFA,chsRFA,indS1,chsS1,i,sorted_fold,nSub,lenPhSample_fixed,bin,gaussFilter,FS,RFA,S1,PC,RASTER,f);
        end
        if i == nPhases(end)
            if mfr == 1 || lvr == 1 || boot == 1 || pc == 1
                Main_Analysis_Plot(start_folder,Result_folder,exp_num,bin_size,bin,numOfIterations,Duration_fix,SPK,MFR,LVR,BOOT,PC,YES,PTSD,SWTTEO);
            end
        end
        
    elseif RAW == 1
        
        Res_folder_Filtered_RFA=fullfile([Res_fold '/Plot/Raw/Filtered/RFA']);
        if exist(Res_folder_Filtered_RFA,'dir')==0
            mkdir(Res_folder_Filtered_RFA)
        end
        Res_folder_Filtered_S1=fullfile([Res_fold '/Plot/Raw/Filtered/S1']);
        if exist(Res_folder_Filtered_S1,'dir')==0
            mkdir(Res_folder_Filtered_S1)
        end
        
        CAR_fold=fullfile(start_folder,[Phases_ordered(i).name, '\FilteredCAR\']);
        AllChannels = dir(fullfile(CAR_fold));
        if (numel(AllChannels)-4) < CH*2
            for ii = 1:numel(AllChannels)
                if AllChannels(ii).isdir == 0
                    P = str2num(AllChannels(ii).name(end-11));
                    CH = AllChannels(ii).name(end-5:end-4);     % current electrode [double]
                    if CH(end) == 'F'
                    else
                        if P == 1
                            load(fullfile(start_folder,[Phases_ordered(i).name, '\FilteredCAR\','CAR_P1_Ch_0' num2str(CH)]));
                            
                            figure
                            hold on
                            title(['RFA Channel ',num2str(CH)])
                            plot(((1:length(data))./(blockObj.SampleRate*60)),data)
                            xlabel('min')
                            saveas(gcf,fullfile(Res_folder_Filtered_RFA,[num2str(Phases_ordered(i).name) '_RFA Channel_',num2str(CH) '.png']))
                            close gcf
                            
                        else
                            load(fullfile(start_folder,[Phases_ordered(i).name, '\FilteredCAR\','CAR_P2_Ch_0' num2str(CH)]));
                            
                            figure
                            hold on
                            title(['S1 Channel ',num2str(CH)])
                            plot(((1:length(data))./(blockObj.SampleRate*60)),data)
                            xlabel('min')
                            saveas(gcf,fullfile(Res_folder_Filtered_S1,[num2str(Phases_ordered(i).name) '_S1 Channel_',num2str(CH) '.png']))
                            close gcf
                        end
                    end
                end
            end
        else
            for k=1:CH
                if k<11
                    load(fullfile(start_folder,[Phases_ordered(i).name, '\FilteredCAR\','CAR_P1_Ch_00' num2str(k-1)]));
                else
                    load(fullfile(start_folder,[Phases_ordered(i).name, '\FilteredCAR\','CAR_P1_Ch_0' num2str(k-1)]));
                end
                figure
                hold on
                title(['RFA Channel ',num2str(k)])
                plot(((1:length(data))./(blockObj.SampleRate*60)),data)
                xlabel('min')
                saveas(gcf,fullfile(Res_folder_Filtered_RFA,[num2str(Phases_ordered(i).name) '_RFA Channel_',num2str(k) '.png']))
                close gcf
            end
            clear k
            for k=1:CH
                if k<11
                    load(fullfile(start_folder,[Phases_ordered(i).name, '\FilteredCAR\','CAR_P2_Ch_00' num2str(k-1)]));
                else
                    load(fullfile(start_folder,[Phases_ordered(i).name, '\FilteredCAR\','CAR_P2_Ch_0' num2str(k-1)]));
                end
                figure
                hold on
                title(['S1 Channel ',num2str(k)])
                plot(((1:length(data))./(blockObj.SampleRate*60)),data)
                xlabel('min')
                saveas(gcf,fullfile(Res_folder_Filtered_S1,[num2str(Phases_ordered(i).name) '_S1 Channel_',num2str(k) '.png']))
                close gcf
            end
            clear k
        end
    end
end
d = waitbar(1,'Finishing...');
pause(1)
close(d)

end