function []=Group_analysis(start_folder,Res_fold,bin_size,bin,numOfIterations,Duration_fix,MFR,LVR,BOOT,PC,TS,RASTER,RAW,SPK,spk,mfr,lvr,boot,pc,PTSD,SWTTEO)
cd(start_folder)
AllExp=dir(start_folder);
ndir=0;
if MFR == 1
    [MFR_Group_RFA,MFR_Group_S1,SPONT_Group_RFA,SPONT_Group_S1,GROUP_RS_RFA,GROUP_ES_RFA,GROUP_SS_RFA,GROUP_RS_S1,GROUP_ES_S1,GROUP_SS_S1,~,~]=define_ResGroup;
end
if LVR == 1
    [LVR_Group_RFA,LVR_Group_S1,SPONT_Group_LVR_RFA,SPONT_Group_LVR_S1,GROUP_LVR_RS_RFA,GROUP_LVR_ES_RFA,GROUP_LVR_SS_RFA,GROUP_LVR_RS_S1,GROUP_LVR_ES_S1,GROUP_LVR_SS_S1,~,~]=define_ResGroup;
end
for ii = 1:numel(AllExp)
    if AllExp(ii).isdir
        ndir=1+ndir;
        Exp(ndir)=AllExp(ii);
    end
end
Exp=Exp(3:end);
for i = 1:length(Exp)
    Num_Exp=Exp(i).name(1:6);
    if SWTTEO == 1
        if Duration_fix == '1'
            exp_folder =(fullfile(start_folder,Exp(i).name,[Num_Exp,'_DurationFixed_Original_binSize_',num2str(bin_size),'_bin_',num2str(bin),'_NoI_',num2str(numOfIterations)],'\Analysis\SWTTEO\'));
        else
            exp_folder =(fullfile(start_folder,Exp(i).name,[Num_Exp,'_',Duration_fix,'_binSize_',num2str(bin_size),'_bin_',num2str(bin),'_NoI_',num2str(numOfIterations)],'\Analysis\SWTTEO\'));
        end
    elseif PTSD == 1
        if Duration_fix == '1'
            exp_folder =(fullfile(start_folder,Exp(i).name,[Num_Exp,'_DurationFixed_Original_binSize_',num2str(bin_size),'_bin_',num2str(bin),'_NoI_',num2str(numOfIterations)],'\Analysis\'));
        else
            exp_folder =(fullfile(start_folder,Exp(i).name,[Num_Exp,'_',Duration_fix,'_binSize_',num2str(bin_size),'_bin_',num2str(bin),'_NoI_',num2str(numOfIterations)],'\Analysis\'));
        end
    end
    
    if Duration_fix == '1' % Original lenght of phase
        if MFR == 1
            [Group_MFR_RFA,MFR_Group_RFA,SPONT_Group_RFA,Group_MFR_RFA_Spont,GROUP_RS_RFA,GROUP_ES_RFA,GROUP_SS_RFA,Group_MFR_S1,MFR_Group_S1,SPONT_Group_S1,Group_MFR_S1_Spont,GROUP_RS_S1,GROUP_ES_S1,GROUP_SS_S1]= MFR_group(exp_folder,Num_Exp,MFR_Group_RFA,SPONT_Group_RFA,GROUP_RS_RFA,GROUP_ES_RFA,GROUP_SS_RFA,MFR_Group_S1,SPONT_Group_S1,GROUP_RS_S1,GROUP_ES_S1,GROUP_SS_S1);
        end
        if LVR == 1
            [Group_LVR_RFA,LVR_Group_RFA,SPONT_Group_LVR_RFA,Group_LVR_RFA_Spont,GROUP_LVR_RS_RFA,GROUP_LVR_ES_RFA,GROUP_LVR_SS_RFA,Group_LVR_S1,LVR_Group_S1,SPONT_Group_LVR_S1,Group_LVR_S1_Spont,GROUP_LVR_RS_S1,GROUP_LVR_ES_S1,GROUP_LVR_SS_S1]= LVR_group_2(exp_folder,Num_Exp,LVR_Group_RFA,SPONT_Group_LVR_RFA,GROUP_LVR_RS_RFA,GROUP_LVR_ES_RFA,GROUP_LVR_SS_RFA,LVR_Group_S1,SPONT_Group_LVR_S1,GROUP_LVR_RS_S1,GROUP_LVR_ES_S1,GROUP_LVR_SS_S1);
        end
    else
        % Subphases
    end
end

%% Results Folder: Analysis & Plot
if SWTTEO == 1
    Res_folder=fullfile([Res_fold '/Analysis/SWTTEO']);
    Res_folder_Plot=fullfile([Res_fold '/Plot/SWTTEO']);
elseif PTSD == 1
    Res_folder=fullfile([Res_fold '/Analysis/PTSD']);
    Res_folder_Plot=fullfile([Res_fold '/Plot/PTSD']);
end

if exist(Res_folder,'dir')==0
    mkdir(Res_folder)
end
if exist(Res_folder_Plot,'dir')==0
    mkdir(Res_folder_Plot)
end

if MFR == 1
  MFR_Group_plot(Duration_fix,Res_folder,Res_folder_Plot,Group_MFR_RFA,MFR_Group_RFA,SPONT_Group_RFA,Group_MFR_RFA_Spont,GROUP_RS_RFA,GROUP_ES_RFA,GROUP_SS_RFA,Group_MFR_S1,MFR_Group_S1,SPONT_Group_S1,Group_MFR_S1_Spont,GROUP_RS_S1,GROUP_ES_S1,GROUP_SS_S1);  
end
if LVR == 1
 LVR_Group_plot(Duration_fix,Res_folder,Res_folder_Plot,Group_LVR_RFA,LVR_Group_RFA,SPONT_Group_LVR_RFA,Group_LVR_RFA_Spont,GROUP_LVR_RS_RFA,GROUP_LVR_ES_RFA,GROUP_LVR_SS_RFA,Group_LVR_S1,LVR_Group_S1,SPONT_Group_LVR_S1,Group_LVR_S1_Spont,GROUP_LVR_RS_S1,GROUP_LVR_ES_S1,GROUP_LVR_SS_S1);
end


