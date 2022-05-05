function []= MFR_Group_plot(Duration_fix,Res_folder,Res_folder_Plot,Group_MFR_RFA,MFR_Group_RFA,SPONT_Group_RFA,Group_MFR_RFA_Spont,GROUP_RS_RFA,GROUP_ES_RFA,GROUP_SS_RFA,Group_MFR_S1,MFR_Group_S1,SPONT_Group_S1,Group_MFR_S1_Spont,GROUP_RS_S1,GROUP_ES_S1,GROUP_SS_S1)
%% RFA
if Duration_fix == '1'
    save([Res_folder '/Group_MFR_Original'],'MFR_Group_RFA','Group_MFR_RFA','MFR_Group_S1','Group_MFR_S1');
    save([Res_folder '/Group_MFR_Original_Spont'],'Group_MFR_RFA_Spont','SPONT_Group_RFA','Group_MFR_S1_Spont','SPONT_Group_S1');
    if isempty(GROUP_RS_RFA)== 0
        save([Res_folder '/Group_MFR_Spont_RS'],'GROUP_RS_RFA','GROUP_RS_S1');
    end
    if isempty(GROUP_ES_RFA)== 0
        save([Res_folder '/Group_MFR_Spont_ES'],'GROUP_ES_RFA','GROUP_ES_S1');
    end
    if isempty(GROUP_SS_RFA)== 0
        save([Res_folder '/Group_MFR_Spont_SS'],'GROUP_SS_RFA','GROUP_SS_S1');
    end
else
    save([Res_folder '/Group_MFR_' num2str(Duration_fix)],'MFR_Group_RFA','Group_MFR_RFA','MFR_Group_S1','Group_MFR_S1','Group_MFR_RFA_Spont','SPONT_Group_RFA','Group_MFR_S1_Spont','SPONT_Group_S1');
end
Res_folder_Plot_MFR=fullfile([Res_folder_Plot '/MFR']);
if exist(Res_folder_Plot_MFR,'dir')==0
    mkdir(Res_folder_Plot_MFR)
end

figure
boxplot(MFR_Group_RFA,Group_MFR_RFA,'PlotStyle','compact')
xlabel('Phase')
ylabel('MFR [spikes/s]')
if Duration_fix == '1'
    title(['BoxPlot RFA' 'Time Window: Original'])
else
    title(['BoxPlot RFA' 'Time Window:' num2str(Duration_fix)])
end
saveas(gcf,fullfile(Res_folder_Plot_MFR,'BoxPlot_RFA_Group'),'fig')
saveas(gcf,fullfile(Res_folder_Plot_MFR,'BoxPlot_RFA_Group'),'png')
close gcf


%% S1

if Duration_fix == '1'
    save([Res_folder '/Group_MFR_Original'],'MFR_Group_S1','Group_MFR_S1');
else
    save([Res_folder '/Group_MFR_' num2str(Duration_fix)],'MFR_Group_S1','Group_MFR_S1');
end

figure
boxplot(MFR_Group_S1,Group_MFR_S1,'PlotStyle','compact')
xlabel('Phase')
ylabel('MFR [spikes/s]')
if Duration_fix == '1'
    title(['BoxPlot S1' 'Time Window: Original'])
else
    title(['BoxPlot S1' 'Time Window:' num2str(Duration_fix)])
end
saveas(gcf,fullfile(Res_folder_Plot_MFR,'BoxPlot_S1_Group'),'fig')
saveas(gcf,fullfile(Res_folder_Plot_MFR,'BoxPlot_S1_Group'),'png')
close gcf

%% Baseline Only spontaneous activity

figure;
hold on
boxplot(SPONT_Group_RFA(:,1:end),Group_MFR_RFA_Spont(1,1:end),'PlotStyle','compact')
xlabel('Phase')
ylabel('MFR [spikes/s]')
if Duration_fix == 1
    title(['BoxPlot RFA' 'Time Window: Original'])
else
    title(['BoxPlot RFA' 'Time Window:' num2str(Duration_fix)])
end
saveas(gcf,fullfile(Res_folder_Plot_MFR,'BoxPlot_RFA_Spont'),'fig')
saveas(gcf,fullfile(Res_folder_Plot_MFR,'BoxPlot_RFA_Spont'),'png')
close gcf

figure;
hold on
boxplot(SPONT_Group_S1(:,1:end),Group_MFR_S1_Spont(1,1:end),'PlotStyle','compact')
xlabel('Phase')
ylabel('MFR [spikes/s]')
if Duration_fix == 1
    title(['BoxPlot S1' 'Time Window: Original'])
else
    title(['BoxPlot S1' 'Time Window:' num2str(Duration_fix)])
end
saveas(gcf,fullfile(Res_folder_Plot_MFR,'BoxPlot_S1_Spont'),'fig')
saveas(gcf,fullfile(Res_folder_Plot_MFR,'BoxPlot_S1_Spont'),'png')
close gcf

clear Group_MFR_RFA Group_MFR_RFA_Spont Group_MFR_S1 Group_MFR_S1_Spont
end