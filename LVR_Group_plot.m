function []= LVR_Group_plot(Duration_fix,Res_folder,Res_folder_Plot,Group_LVR_RFA,LVR_Group_RFA,SPONT_Group_LVR_RFA,Group_LVR_RFA_Spont,GROUP_LVR_RS_RFA,GROUP_LVR_ES_RFA,GROUP_LVR_SS_RFA,Group_LVR_S1,LVR_Group_S1,SPONT_Group_LVR_S1,Group_LVR_S1_Spont,GROUP_LVR_RS_S1,GROUP_LVR_ES_S1,GROUP_LVR_SS_S1)
%% RFA
if Duration_fix == '1'
    save([Res_folder '/Group_LVR_Original'],'LVR_Group_RFA','Group_LVR_RFA','LVR_Group_S1','Group_LVR_S1');
    save([Res_folder '/Group_LVR_Original_Spont'],'Group_LVR_RFA_Spont','SPONT_Group_LVR_RFA','Group_LVR_S1_Spont','SPONT_Group_LVR_S1');
    if isempty(GROUP_LVR_RS_RFA)== 0
        save([Res_folder '/Group_LVR_Spont_RS'],'GROUP_LVR_RS_RFA','GROUP_LVR_RS_S1');
    end
    if isempty(GROUP_LVR_ES_RFA)== 0
        save([Res_folder '/Group_LVR_Spont_ES'],'GROUP_LVR_ES_RFA','GROUP_LVR_ES_S1');
    end
    if isempty(GROUP_LVR_SS_RFA)== 0
        save([Res_folder '/Group_LVR_Spont_SS'],'GROUP_LVR_SS_RFA','GROUP_LVR_SS_S1');
    end
else
    save([Res_folder '/Group_LVR_' num2str(Duration_fix)],'LVR_Group_RFA','Group_LVR_RFA','LVR_Group_S1','Group_LVR_S1','Group_LVR_RFA_Spont','SPONT_Group_LVR_RFA','Group_LVR_S1_Spont','SPONT_Group_LVR_S1');
end

Res_folder_Plot_LVR = fullfile([Res_folder_Plot 'LVR']);

if exist(Res_folder_Plot_LVR,'dir')==0
    mkdir(Res_folder_Plot_LVR)
end

figure
boxplot(LVR_Group_RFA,Group_LVR_RFA,'PlotStyle','compact')
xlabel('Phase')
ylabel('LVR')
if Duration_fix == '1'
    title(['BoxPlot RFA' 'Time Window: Original'])
else
    title(['BoxPlot RFA' 'Time Window:' num2str(Duration_fix)])
end
saveas(gcf,fullfile(Res_folder_Plot_LVR,'BoxPlot_RFA_Group'),'fig')
saveas(gcf,fullfile(Res_folder_Plot_LVR,'BoxPlot_RFA_Group'),'png')
close gcf


%% S1

if Duration_fix == '1'
    save([Res_folder '/Group_LVR_Original'],'LVR_Group_S1','Group_LVR_S1');
else
    save([Res_folder '/Group_LVR_' num2str(Duration_fix)],'LVR_Group_S1','Group_LVR_S1');
end

figure
boxplot(LVR_Group_S1,Group_LVR_S1,'PlotStyle','compact')
xlabel('Phase')
ylabel('LVR')
if Duration_fix == '1'
    title(['BoxPlot S1' 'Time Window: Original'])
else
    title(['BoxPlot S1' 'Time Window:' num2str(Duration_fix)])
end
saveas(gcf,fullfile(Res_folder_Plot_LVR,'BoxPlot_S1_Group'),'fig')
saveas(gcf,fullfile(Res_folder_Plot_LVR,'BoxPlot_S1_Group'),'png')
close gcf

%% Baseline Only spontaneous activity

figure;
hold on
boxplot(SPONT_Group_LVR_RFA(:,1:end),Group_LVR_RFA_Spont(1,1:end),'PlotStyle','compact')
xlabel('Phase')
ylabel('LVR')
if Duration_fix == 1
    title(['BoxPlot RFA' 'Time Window: Original'])
else
    title(['BoxPlot RFA' 'Time Window:' num2str(Duration_fix)])
end
saveas(gcf,fullfile(Res_folder_Plot_LVR,'BoxPlot_RFA_Spont'),'fig')
saveas(gcf,fullfile(Res_folder_Plot_LVR,'BoxPlot_RFA_Spont'),'png')
close gcf

figure;
hold on
boxplot(SPONT_Group_LVR_S1(:,1:end),Group_LVR_S1_Spont(1,1:end),'PlotStyle','compact')
xlabel('Phase')
ylabel('LVR')
if Duration_fix == 1
    title(['BoxPlot S1' 'Time Window: Original'])
else
    title(['BoxPlot S1' 'Time Window:' num2str(Duration_fix)])
end
saveas(gcf,fullfile(Res_folder_Plot_LVR,'BoxPlot_S1_Spont'),'fig')
saveas(gcf,fullfile(Res_folder_Plot_LVR,'BoxPlot_S1_Spont'),'png')
close gcf

clear Group_LVR_RFA Group_LVR_RFA_Spont Group_LVR_S1 Group_LVR_S1_Spont
end