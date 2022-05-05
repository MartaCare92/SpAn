function []=BMC_Analysis_Plot(nSub,Result_folder,exp_num,Duration_fixed,Duration_fix,MFR,LVR,BOOT,PC) 
close all 
f = waitbar(0,'Please wait...');

f=waitbar(.50,'Processing your data');

       
if MFR == 1
    if Duration_fixed == 1
        load(fullfile(Result_folder,'/Analysis/',[exp_num '_MFR_Original.mat']));
    else
        load(fullfile(Result_folder,'/Analysis/',[exp_num '_MFR_' Duration_fix '.mat']));
    end
    waitbar(.95,f,'Processing MFR Plot');
    pause(1)
    Res_folder=fullfile([Result_folder '/Plot/MFR']);
    if exist(Res_folder,'dir')==0
        mkdir(Res_folder)
    end
    
    n=1;
    PRE_POST_MFR_RFA=[];
    PRE_POST_MFR_RFA_Baseline=[];
    for i= 1:length(mfr_RFA)
        for j=1:length(nSub{i})
            if size(nSub,2) == 2
                if i==1
                    Group_MFR_RFA(1,n)={['B1_' num2str(j)]};
                elseif i==2
                    Group_MFR_RFA(1,n)={['B2_' num2str(j)]};
                end
            else
                if i==1
                    Group_MFR_RFA(1,n)={['B0_' num2str(j)]};
                elseif i==2
                    Group_MFR_RFA(1,n)={['PI_' num2str(j)]};
                elseif i==3
                    Group_MFR_RFA(1,n)={['B1_' num2str(j)]};
                end
            end
            n=n+1;            
        end
        PRE_POST_MFR_RFA=[PRE_POST_MFR_RFA,mfr_RFA{1, i}(:,3:2:end)];
                if i==1 && length(nSub{1}) > 1
            PRE_POST_MFR_RFA_Baseline=[PRE_POST_MFR_RFA_Baseline,mfr_RFA{1, 1}(:,5:2:end)./mfr_RFA{1,1}(:,3)];
        elseif i==2 || i== 3
            PRE_POST_MFR_RFA_Baseline=[PRE_POST_MFR_RFA_Baseline,mfr_RFA{1, i}(:,3:2:end)./mfr_RFA{1,1}(:,3)];
        end
    end

    n=1;
    PRE_POST_MFR_S1=[];
    PRE_POST_MFR_S1_Baseline=[];
    for i= 1:length(mfr_S1)
        for j=1:length(nSub{i})
            if size(nSub,2) == 2
                if i==1
                    Group_MFR_S1(1,n)={['B1_' num2str(j)]};
                elseif i==2
                    Group_MFR_S1(1,n)={['B2_' num2str(j)]};
                end
            else
                if i==1
                    Group_MFR_S1(1,n)={['B0_' num2str(j)]};
                elseif i==2
                    Group_MFR_S1(1,n)={['PI_' num2str(j)]};
                elseif i==3
                    Group_MFR_S1(1,n)={['B1_' num2str(j)]};
                end
            end
            n=n+1;
        end
        PRE_POST_MFR_S1=[PRE_POST_MFR_S1,mfr_S1{1, i}(:,3:2:end)];
        if i==1 && length(nSub{1}) > 1
            PRE_POST_MFR_S1_Baseline=[PRE_POST_MFR_S1_Baseline,mfr_S1{1, 1}(:,5:2:end)./mfr_S1{1,1}(:,3)];
        elseif i==2 || i== 3
            PRE_POST_MFR_S1_Baseline=[PRE_POST_MFR_S1_Baseline,mfr_S1{1, i}(:,3:2:end)./mfr_S1{1,1}(:,3)];
        end
    end
    
    %% No Baseline
    
    figure;
    hold on
    boxplot(PRE_POST_MFR_RFA(:,1:end),Group_MFR_RFA(1,1:end)) %R18-92 (1,1:end-1)
    xlabel('Phase')
    ylabel('MFR [spikes/s]')
    if Duration_fixed == 1
        title(['BoxPlot RFA' 'Time Window: Original'])
    else
        title(['BoxPlot RFA' 'Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'BoxPlot_RFA'),'fig')
    
    figure;
    hold on
    boxplot(PRE_POST_MFR_S1(:,1:end),Group_MFR_S1(1,1:end))
    xlabel('Phase')
    ylabel('MFR [spikes/s]')
     if Duration_fixed == 1
        title(['BoxPlot S1' 'Time Window: Original'])
    else
        title(['BoxPlot S1' 'Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'BoxPlot_S1'),'fig')
    %% Baseline
    figure;
    hold on
    boxplot(PRE_POST_MFR_RFA_Baseline(:,1:end),Group_MFR_RFA(1,2:end))
    xlabel('Phase')
    if size(nSub,2) == 2
    ylabel('POST/Basal1(B1) [%]')
    else
    ylabel('POST/Basal0(B0) [%]')
    end
    yline(1, '--')
    if Duration_fixed == 1
        title(['BoxPlot RFA' 'Time Window: Original'])
    else
        title(['BoxPlot RFA' 'Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'BoxPlot_RFA_vs_B1_1'),'fig')
    
    figure;
    hold on
    boxplot(PRE_POST_MFR_S1_Baseline(:,1:end),Group_MFR_S1(1,2:end))
    xlabel('Phase')
    if size(nSub,2) == 2
    ylabel('POST/Basal1(B1) [%]')
    else
    ylabel('POST/Basal0(B0) [%]')
    end
    yline(1, '--')
    if Duration_fixed == 1
        title(['BoxPlot S1' 'Time Window: Original'])
    else
        title(['BoxPlot S1' 'Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'BoxPlot_S1__vs_B1_1'),'fig')
end
if LVR == 1
    if Duration_fixed == 1
        load(fullfile(Result_folder,'/Analysis/',[exp_num '_LVR_Original.mat']));
    else
        load(fullfile(Result_folder,'/Analysis/',[exp_num '_LVR_' Duration_fix '.mat']));
    end
    waitbar(.95,f,'Processing LVR Plot');
    pause(1)
    Res_folder=fullfile([Result_folder '/Plot/LVR']);
    if exist(Res_folder,'dir')==0
        mkdir(Res_folder)
    end
    
    n=1;
    PRE_POST_LVR_RFA=[];
    PRE_POST_LVR_RFA_Baseline=[];
    for i= 1:nPhases
        for j=1:length(nSub{i})
            if size(nSub,2) == 2
                if i==1
                    Group_LVR_RFA(1,n)={['B1_' num2str(j)]};
                elseif i==2
                    Group_LVR_RFA(1,n)={['B2_' num2str(j)]};
                end
            else
                if i==1
                    Group_LVR_RFA(1,n)={['B0_' num2str(j)]};
                elseif i==2
                    Group_LVR_RFA(1,n)={['PI_' num2str(j)]};
                elseif i==3
                    Group_LVR_RFA(1,n)={['B1_' num2str(j)]};
                end
            end
            n=n+1;
        end
    end
    for k=1:length(LvR_out_RFA)
        PRE_POST_LVR_RFA=[PRE_POST_LVR_RFA,cell2mat(LvR_out_RFA{1, k})'];
        if k > 1
            PRE_POST_LVR_RFA_Baseline=[PRE_POST_LVR_RFA_Baseline,(cell2mat(LvR_out_RFA{1, k})./cell2mat(LvR_out_RFA{1,1}))'];
        end
    end
    
    n=1;
    PRE_POST_LVR_S1=[];
    PRE_POST_LVR_S1_Baseline=[];
    for i= 1:nPhases
        for j=1:length(nSub{i})
            if size(nSub,2) == 2
                if i==1
                    Group_LVR_S1(1,n)={['B1_' num2str(j)]};
                elseif i==2
                    Group_LVR_S1(1,n)={['B2_' num2str(j)]};
                end
            else
                if i==1
                    Group_LVR_S1(1,n)={['B0_' num2str(j)]};
                elseif i==2
                    Group_LVR_S1(1,n)={['PI_' num2str(j)]};
                elseif i==3
                    Group_LVR_S1(1,n)={['B1_' num2str(j)]};
                end
            end
                n=n+1;
            end
    end
    for k=1:length(LvR_out_S1)
        PRE_POST_LVR_S1=[PRE_POST_LVR_S1,cell2mat(LvR_out_S1{1, k})'];
        if k>1
            PRE_POST_LVR_S1_Baseline=[PRE_POST_LVR_S1_Baseline,(cell2mat(LvR_out_S1{1, k})./cell2mat(LvR_out_S1{1,1}))'];
        end
    end
    
    %% No Baseline
    
    figure;
    hold on
    boxplot(PRE_POST_LVR_RFA(:,1:end),Group_LVR_RFA(1,1:end))
    xlabel('Phase')
    ylabel('LvR')
    if Duration_fixed == 1
        title(['LvR RFA' ' Time Window: Original'])
    else
        title(['LvR RFA' ' Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'BoxPlot_LvR_RFA'),'fig')
    
    figure;
    hold on
    boxplot(PRE_POST_LVR_S1(:,1:end),Group_LVR_S1(1,1:end))
    xlabel('Phase')
    ylabel('LvR')
    if Duration_fixed == 1
        title(['LvR S1' ' Time Window: Original'])
    else
        title(['LvR S1' ' Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'BoxPlot_LvR_S1'),'fig')
    %% Baseline
    figure;
    hold on
    boxplot(PRE_POST_LVR_RFA_Baseline(:,1:end),Group_LVR_RFA(1,2:end))
    xlabel('Phase')
    if size(nSub,2) == 2
    ylabel('POST/Basal1(B1)')
    else
    ylabel('POST/Basal0(B0)')
    end
    yline(1, '--')
    if Duration_fixed == 1
        title(['LvR RFA' ' Time Window: Original'])
    else
        title(['LvR RFA' ' Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'BoxPlot_LvR_RFA_vs_B1_1'),'fig')
    
    figure;
    hold on
    boxplot(PRE_POST_LVR_S1_Baseline(:,1:end),Group_LVR_S1(1,2:end))
    xlabel('Phase')
    if size(nSub,2) == 2
    ylabel('POST/Basal1(B1)')
    else
    ylabel('POST/Basal0(B0)')
    end
    yline(1, '--')
    if Duration_fixed == 1
        title(['LvR S1' ' Time Window: Original'])
    else
        title(['LvR S1' ' Time Window:' num2str(Duration_fixed)])
    end
    saveas(gcf,fullfile(Res_folder,'BoxPlot_Lvr_S1_vs_B1_1'),'fig')
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
% % if TS == 1
% %     load(fullfile(Result_folder,'/Analysis/',[exp_num '_TS_' Duration_fix '.mat']));
% %     waitbar(.95,f,'Processing TS Plot');
% %     pause(1)
% %     figure;
% %     % bar(cell2mat(mfr_mean_RFA))
% % end

waitbar(1,f,'Finishing');
pause(1)
close(f)
end
