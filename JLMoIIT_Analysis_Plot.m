function []=JLMoIIT_Analysis_Plot(nSub,nPhases,Result_folder,exp_num,Duration_fixed,Duration_fix,SPK,MFR,LVR,BOOT,PC,YES)

if MFR == 1
    if Duration_fixed == 1
        load(fullfile(Result_folder,'/Analysis/SWTTEO/',[exp_num '_MFR_Original.mat']));
    else
        load(fullfile(Result_folder,'/Analysis/SWTTEO/',[exp_num '_MFR_' Duration_fix '.mat']));
    end
    
    f=waitbar(.95,'Processing MFR Plot');
    pause(1)
    
    Res_folder=fullfile([Result_folder '/Plot/MFR/SWTTEO']);
    if exist(Res_folder,'dir')==0
        mkdir(Res_folder)
    end
    
    Group_MFR_RFA = mfr_RFA(2,:);
    PRE_POST_MFR_RFA=[];
    PRE_POST_MFR_RFA_Baseline=[];
    SPONT_MFR_RFA=[];
    n=1;
    for i= 1:length(mfr_RFA)
        if length(mfr_RFA{1, i})<16 % #channels
            mfr_RFA{1, i}(length(mfr_RFA{1, i})+1,:)=NaN;
        end
        PRE_POST_MFR_RFA=[PRE_POST_MFR_RFA,mfr_RFA{1, i}(:,3:2:end)];
        if mfr_RFA{2, i}(:,6)== 'b' || mfr_RFA{2, i}(:,7)== 'b'
            SPONT_MFR_RFA=[SPONT_MFR_RFA,mfr_RFA{1, i}(:,3:2:end)];
            Group_MFR_RFA_Spont(1,n)=mfr_RFA(2,i);
            n=n+1;
        end
    end
    PRE_POST_MFR_RFA_Baseline=(PRE_POST_MFR_RFA(:,2:end)./PRE_POST_MFR_RFA(:,1));
    clear n
    
    Group_MFR_S1 = mfr_S1(2,:);
    PRE_POST_MFR_S1=[];
    PRE_POST_MFR_S1_Baseline=[];
    SPONT_MFR_S1=[];
    n=1;
    for i= 1:length(mfr_S1)
        if length(mfr_S1{1, i})<16
            mfr_S1{1, i}(length(mfr_S1{1, i})+1,:)=NaN;
        end
        PRE_POST_MFR_S1=[PRE_POST_MFR_S1,mfr_S1{1, i}(:,3:2:end)];
        if mfr_S1{2, i}(:,6)== 'b' || mfr_S1{2, i}(:,7)== 'b'
            SPONT_MFR_S1=[SPONT_MFR_S1,mfr_S1{1, i}(:,3:2:end)];
            Group_MFR_S1_Spont(1,n)=mfr_S1(2,i);
            n=n+1;
        end
    end
    PRE_POST_MFR_S1_Baseline=(PRE_POST_MFR_S1(:,2:end)./PRE_POST_MFR_S1(:,1));
    
    %% No Baseline All Phases
    figure;
    hold on
    boxplot(PRE_POST_MFR_RFA(:,1:end),Group_MFR_RFA(1,1:end),'PlotStyle','compact')
    xlabel('Phase')
    ylabel('MFR [spikes/s]')
    if Duration_fixed == 1
        title(['BoxPlot RFA' 'Time Window: Original'])
    else
        title(['BoxPlot RFA' 'Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'BoxPlot_RFA_AllPhases'),'fig')
    saveas(gcf,fullfile(Res_folder,'BoxPlot_RFA_AllPhases'),'png')
    close gcf
    
    figure;
    hold on
    boxplot(PRE_POST_MFR_S1(:,1:end),Group_MFR_S1(1,1:end),'PlotStyle','compact')
    xlabel('Phase')
    ylabel('MFR [spikes/s]')
    if Duration_fixed == 1
        title(['BoxPlot S1' 'Time Window: Original'])
    else
        title(['BoxPlot S1' 'Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'BoxPlot_S1_AllPhases'),'fig')
    saveas(gcf,fullfile(Res_folder,'BoxPlot_S1_AllPhases'),'png')
    close gcf
    
    %% Baseline All Phases
    figure;
    hold on
    boxplot(PRE_POST_MFR_RFA_Baseline(:,1:end),Group_MFR_RFA(1,2:end),'PlotStyle','compact')
    xlabel('Phase')
    ylabel('POST/PreLesion_1 [%]')
    yline(1, '--')
    if Duration_fixed == 1
        title(['BoxPlot RFA' 'Time Window: Original'])
    else
        title(['BoxPlot RFA' 'Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'AllPhases_BoxPlot_RFA_vs_B1_1'),'fig')
    saveas(gcf,fullfile(Res_folder,'AllPhases_BoxPlot_RFA_vs_B1_1'),'png')
    close gcf
    
    figure;
    hold on
    boxplot(PRE_POST_MFR_S1_Baseline(:,1:end),Group_MFR_S1(1,2:end),'PlotStyle','compact')
    xlabel('Phase')
    ylabel('POST/PreLesion_1 [%]')
    yline(1, '--')
    if Duration_fixed == 1
        title(['BoxPlot S1' 'Time Window: Original'])
    else
        title(['BoxPlot S1' 'Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'AllPhases_BoxPlot_S1_vs_B1_1'),'fig')
    saveas(gcf,fullfile(Res_folder,'AllPhases_BoxPlot_S1_vs_B1_1'),'png')
    close gcf
    
    %% Baseline Only spontaneous activity
    figure;
    hold on
    boxplot(SPONT_MFR_RFA(:,1:end),Group_MFR_RFA_Spont(1,1:end),'PlotStyle','compact')
    xlabel('Phase')
    ylabel('MFR [spikes/s]')
    if Duration_fixed == 1
        title(['BoxPlot RFA' 'Time Window: Original'])
    else
        title(['BoxPlot RFA' 'Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'BoxPlot_RFA_Spont'),'fig')
    saveas(gcf,fullfile(Res_folder,'BoxPlot_RFA_Spont'),'png')
    close gcf
    
    figure;
    hold on
    boxplot(SPONT_MFR_S1(:,1:end),Group_MFR_S1_Spont(1,1:end),'PlotStyle','compact')
    xlabel('Phase')
    ylabel('MFR [spikes/s]')
    if Duration_fixed == 1
        title(['BoxPlot S1' 'Time Window: Original'])
    else
        title(['BoxPlot S1' 'Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'BoxPlot_S1_Spont'),'fig')
    saveas(gcf,fullfile(Res_folder,'BoxPlot_S1_Spont'),'png')
    close gcf
    
    clear Group_MFR_RFA Group_MFR_RFA_Spont Group_MFR_S1 Group_MFR_S1_Spont
    close(f)
end

if LVR == 1
    if Duration_fixed == 1
        load(fullfile(Result_folder,'/Analysis/SWTTEO/',[exp_num '_LVR_Original.mat']));
    else
        load(fullfile(Result_folder,'/Analysis/SWTTEO/',[exp_num '_LVR_' Duration_fix '.mat']));
    end
    
    f=waitbar(.95,'Processing LVR Plot');
    pause(1)
    
    Res_folder=fullfile([Result_folder '/Plot/LVR/SWTTEO']);
    if exist(Res_folder,'dir')==0
        mkdir(Res_folder)
    end
    
    n=1;
    Group_LVR_RFA = LvR_out_RFA(2,:);
    PRE_POST_LVR_RFA=[];
    PRE_POST_LVR_RFA_Baseline=[];
    SPONT_LVR_RFA=[];
    for i= 1:length(LvR_out_RFA)
        if length(LvR_out_RFA{1, i})<16
            LvR_out_RFA{1, i}{1,length(LvR_out_RFA{1, i})+1}=NaN;
        end
        PRE_POST_LVR_RFA=[PRE_POST_LVR_RFA,cell2mat(LvR_out_RFA{1, i})'];
        if LvR_out_RFA{2, i}(:,6)== 'b' || LvR_out_RFA{2, i}(:,7)== 'b'
            SPONT_LVR_RFA=[SPONT_LVR_RFA,cell2mat(LvR_out_RFA{1, i})'];
            Group_LVR_RFA_Spont(1,n)=LvR_out_RFA(2,i);
            n=n+1;
        end
    end
    PRE_POST_LVR_RFA_Baseline=(PRE_POST_LVR_RFA(:,2:end)./PRE_POST_LVR_RFA(:,1));
    clear n
    
    n=1;
    Group_LVR_S1 = LvR_out_S1(2,:);
    PRE_POST_LVR_S1=[];
    PRE_POST_LVR_S1_Baseline=[];
    SPONT_LVR_S1=[];
    for i=1:length(LvR_out_S1)
        if length(LvR_out_S1{1, i})<16
            LvR_out_S1{1, i}{1,length(LvR_out_S1{1, i})+1}=NaN;
        end
        PRE_POST_LVR_S1=[PRE_POST_LVR_S1,cell2mat(LvR_out_S1{1, i})'];
        if LvR_out_S1{2, i}(:,6)== 'b' || LvR_out_S1{2, i}(:,7)== 'b'
            SPONT_LVR_S1=[SPONT_LVR_S1,cell2mat(LvR_out_S1{1, i})'];
            Group_LVR_S1_Spont(1,n)=LvR_out_S1(2,i);
            n=n+1;
        end
    end
    PRE_POST_LVR_S1_Baseline=(PRE_POST_LVR_S1(:,2:end)./PRE_POST_LVR_S1(:,1));
    clear n
    
    %% No Baseline AllPhases
    
    figure;
    hold on
    boxplot(PRE_POST_LVR_RFA(:,1:end),Group_LVR_RFA(1,1:end),'PlotStyle','compact')
    xlabel('Phase')
    ylabel('LvR')
    if Duration_fixed == 1
        title(['LvR RFA' ' Time Window: Original'])
    else
        title(['LvR RFA' ' Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'BoxPlot_LvR_RFA_AllPhases'),'fig')
    saveas(gcf,fullfile(Res_folder,'BoxPlot_LvR_RFA_AllPhases'),'png')
    close gcf
    
    figure;
    hold on
    boxplot(PRE_POST_LVR_S1(:,1:end),Group_LVR_S1(1,1:end),'PlotStyle','compact')
    xlabel('Phase')
    ylabel('LvR')
    if Duration_fixed == 1
        title(['LvR S1' ' Time Window: Original'])
    else
        title(['LvR S1' ' Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'BoxPlot_LvR_S1_AllPhases'),'fig')
    saveas(gcf,fullfile(Res_folder,'BoxPlot_LvR_S1_AllPhases'),'png')
    close gcf
    
    %% Baseline All Phases
    figure;
    hold on
    boxplot(PRE_POST_LVR_RFA_Baseline(:,1:end),Group_LVR_RFA(1,2:end),'PlotStyle','compact')
    xlabel('Phase')
    ylabel('POST/PreLesion_1 [%]')
    yline(1, '--')
    if Duration_fixed == 1
        title(['LvR RFA' ' Time Window: Original'])
    else
        title(['LvR RFA' ' Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'AllPhases_BoxPlot_LvR_RFA_vs_B1_1'),'fig')
    saveas(gcf,fullfile(Res_folder,'AllPhases_BoxPlot_LvR_RFA_vs_B1_1'),'png')
    close gcf
    
    figure;
    hold on
    boxplot(PRE_POST_LVR_S1_Baseline(:,1:end),Group_LVR_S1(1,2:end),'PlotStyle','compact')
    xlabel('Phase')
    ylabel('POST/PreLesion_1 [%]')
    yline(1, '--')
    if Duration_fixed == 1
        title(['LvR S1' ' Time Window: Original'])
    else
        title(['LvR S1' ' Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'AllPhases_BoxPlot_Lvr_S1_vs_B1_1'),'fig')
    saveas(gcf,fullfile(Res_folder,'AllPhases_BoxPlot_Lvr_S1_vs_B1_1'),'png')
    close gcf
    
    %% Baseline Only spontaneous activity
    figure;
    hold on
    boxplot(SPONT_LVR_RFA(:,1:end),Group_LVR_RFA_Spont(1,1:end),'PlotStyle','compact')
    xlabel('Phase')
    ylabel('LVR')
    if Duration_fixed == 1
        title(['BoxPlot RFA' 'Time Window: Original'])
    else
        title(['BoxPlot RFA' 'Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'BoxPlot_RFA_Spont'),'fig')
    saveas(gcf,fullfile(Res_folder,'BoxPlot_RFA_Spont'),'png')
    close gcf
    
    figure;
    hold on
    boxplot(SPONT_LVR_S1(:,1:end),Group_LVR_S1_Spont(1,1:end),'PlotStyle','compact')
    xlabel('Phase')
    ylabel('LVR')
    if Duration_fixed == 1
        title(['BoxPlot S1' 'Time Window: Original'])
    else
        title(['BoxPlot S1' 'Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'BoxPlot_S1_Spont'),'fig')
    saveas(gcf,fullfile(Res_folder,'BoxPlot_S1_Spont'),'png')
    close gcf
    
    close(f)
end

if BOOT == 1
    if Duration_fixed == 1
        load(fullfile(Result_folder,'/Analysis/',[exp_num '_FR_Original.mat']));
    else
        load(fullfile(Result_folder,'/Analysis/',[exp_num '_FR_' Duration_fix '.mat']));
    end
    waitbar(.95,f,'Processing FR Plot');
    pause(1)
    Res_folder=fullfile([Result_folder '/Plot/FR']);
    if exist(Res_folder,'dir')==0
        mkdir(Res_folder)
    end
    
    n=1;
    for i= 1:nPhases
        for j=1:length(nSub{i})
            if size(nSub,2) == 2
                if i==1
                    Group_FR(1,n)={['B1_' num2str(j)]};
                elseif i==2
                    Group_FR(1,n)={['B2_' num2str(j)]};
                end
            else
                if i==1
                    Group_FR(1,n)={['B0_' num2str(j)]};
                elseif i==2
                    Group_FR(1,n)={['PI_' num2str(j)]};
                elseif i==3
                    Group_FR(1,n)={['B1_' num2str(j)]};
                end
            end
            n=n+1;
        end
    end
    
    fr_RFA(1,:)=boot_stats.RFA.increased;
    fr_RFA(2,:)=boot_stats.RFA.decreased;
    fr_RFA(3,:)=boot_stats.RFA.no_change;
    fr_S1(1,:)=boot_stats.S1.increased;
    fr_S1(2,:)=boot_stats.S1.decreased;
    fr_S1(3,:)=boot_stats.S1.no_change;
    
    scrsz = get(0,'ScreenSize');
    fig = figure('Position',[1+100 scrsz(1)+100 scrsz(3)-200 scrsz(4)-200]);
    set(gcf,'Color','w')
    bar(fr_RFA(:,1:end)*100,'DisplayName','fr_RFA')% R1892 (:,1:end-1)
    hold on
    xticklabels({'increased', 'decreased','no change'})
    legend(Group_FR(1,2:end))
    if size(nSub,2) == 2
        ylabel('POST/Basal1(B1) [%]')
    else
        ylabel('POST/Basal0(B0) [%]')
    end
    if Duration_fixed == 1
        title(['FR RFA' ' Time Window: Original'])
    else
        title(['FR RFA' ' Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'FR_RFA'),'fig')
    
    scrsz = get(0,'ScreenSize');
    fig = figure('Position',[1+100 scrsz(1)+100 scrsz(3)-200 scrsz(4)-200]);
    set(gcf,'Color','w')
    bar(fr_S1(:,1:end)*100,'DisplayName','fr_S1')
    hold on
    xticklabels({'increased', 'decreased','no change'})
    legend(Group_FR(1,2:end))
    if size(nSub,2) == 2
        ylabel('POST/Basal1(B1) [%]')
    else
        ylabel('POST/Basal0(B0) [%]')
    end
    if Duration_fixed == 1
        title(['FR S1' ' Time Window: Original'])
    else
        title(['FR S1' ' Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'FR_S1'),'fig')
end

if PC == 1
    if Duration_fixed == 1
        load(fullfile(Result_folder,'/Analysis/',[exp_num '_PC_Original.mat']));
    else
        load(fullfile(Result_folder,'/Analysis/',[exp_num '_PC_' Duration_fix '.mat']));
    end
    waitbar(.95,f,'Processing PC Plot');
    pause(1)
    Res_folder=fullfile([Result_folder '/Plot/PC']);
    if exist(Res_folder,'dir')==0
        mkdir(Res_folder)
    end
    
    n=1;
    for i= 1:nPhases
        for j=1:length(nSub{i})
            if size(nSub,2) == 2
                if i==1
                    Group_PC_RFA(1,n)={['B1_' num2str(j)]};
                elseif i==2
                    Group_PC_RFA(1,n)={['B2_' num2str(j)]};
                end
            else
                if i==1
                    Group_PC_RFA(1,n)={['B0_' num2str(j)]};
                elseif i==2
                    Group_PC_RFA(1,n)={['PI_' num2str(j)]};
                elseif i==3
                    Group_PC_RFA(1,n)={['B1_' num2str(j)]};
                end
            end
            n=n+1;
        end
    end
    
    n=1;
    for i= 1:nPhases
        for j=1:length(nSub{i})
            if size(nSub,2) == 2
                if i==1
                    Group_PC_S1(1,n)={['B1_' num2str(j)]};
                elseif i==2
                    Group_PC_S1(1,n)={['B2_' num2str(j)]};
                end
            else
                if i==1
                    Group_PC_S1(1,n)={['B0_' num2str(j)]};
                elseif i==2
                    Group_PC_S1(1,n)={['PI_' num2str(j)]};
                elseif i==3
                    Group_PC_S1(1,n)={['B1_' num2str(j)]};
                end
            end
            n=n+1;
        end
    end
    
    %% Normalized
    % normRFA=median(Population_Coupling_Shuffled_RFA(:,B),1,'omitnan');
    figure;
    hold on
    boxplot(PC_RFA.PCNormRFA,Group_PC_RFA)
    xlabel('Phase')
    ylabel('Population Coupling Shuffled')
    yline(1, '--')
    if Duration_fixed == 1
        title(['PC RFA Normalized ' 'Time Window: Original'])
    else
        title(['PC RFA Normalized ' 'Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'PC_RFA_Norm'),'fig')
    saveas(gcf,fullfile(Res_folder,'PC_RFA_Norm'),'png')
    
    figure;
    hold on
    boxplot(PC_S1.PCNormS1,Group_PC_S1)
    xlabel('Phase')
    ylabel('Population Coupling Shuffled')
    yline(1, '--')
    if Duration_fixed == 1
        title(['PC S1 Normalized ' 'Time Window: Original'])
    else
        title(['PC S1 Normalized ' 'Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'PC_S1_Norm'),'fig')
    saveas(gcf,fullfile(Res_folder,'PC_S1_Norm'),'png')
end
end
