
function [nfig]=raster_plot(k,population_ts,gaussFilter,FS,bin,spkTs,spkLabel,n_phases,i,subphase,lenPh,dur,evector,nChsRFA,Duration_fix,Res_fold,type,nfig)
Res_folder=fullfile([Res_fold '/Plot/Raster']);
if exist(Res_folder,'dir')==0
    mkdir(Res_folder)
end

if Duration_fix == '1'
lenPh_fixed=dur*60;
else
lenPh_fixed=k*dur*60;
end

edges=(bin*FS:bin*FS:lenPh_fixed*FS);%samples
population_rate=hist(population_ts,edges);
IFRPopulationTrain=conv(population_rate,gaussFilter,'same');
IFRPopulationTrain=IFRPopulationTrain*(FS/10^3);
xtime=(1:length(IFRPopulationTrain))./(FS/(bin*FS));
%
%% Raster Plot & IFR
scrsz = get(0,'ScreenSize');
fh = figure('Position',[1+100 scrsz(1)+100 scrsz(3)-200 scrsz(4)-200]);
set(gcf,'Color','w')
grid on; hold on
subplot(3,1,[1:2])
if ~isempty(spkTs)
    spkTs_s = spkTs/FS;
    plot(spkTs_s, spkLabel,'.b','markersize',3);
end

xlim([(lenPh-(dur*60)) lenPh]) %lenPh

set(gca,'ytick',1:nChsRFA,'yticklabel',num2str(evector),'ylim',[0 nChsRFA+1]);
xlabel('Time [s]')
ylabel('Unit')
if type == 'R'
    title(['RFA ' num2str(n_phases(i).name) '  subPhase:' num2str(subphase)],'Interpreter','none')
else
    title(['S1 ' num2str(n_phases(i).name) '  subPhase:' num2str(subphase)], 'Interpreter','none')
end
subplot(3,1,3)
plot(xtime,IFRPopulationTrain)

xlabel('Time [s]')
ylabel('Spikes per s')

title(['IFR Population Rate ' 'Bin [sec]:' num2str(bin)])

xlim([(lenPh-(dur*60)) lenPh]) %lenPh

if type == 'R'
    if Duration_fix == '1'
        saveas(gcf,fullfile(Res_folder,[num2str(nfig) '_Raster_Sorted_PopulationRate_RFA_' num2str(n_phases(i).name) '_Original_Bin_' num2str(bin) '_default' '.png']))
                saveas(gcf,fullfile(Res_folder,[num2str(nfig) '_Raster_Sorted_PopulationRate_RFA_' num2str(n_phases(i).name) '_Original_Bin_' num2str(bin) '.fig']))
        %         saveas(gcf,fullfile(Res_folder,[num2str(nfig) 'LIM_Raster_Sorted_PopulationRate_RFA_' num2str(n_phases(i).name) '_Original']),'png')
    else
        saveas(gcf,fullfile(Res_folder,[num2str(nfig) '_Raster_Sorted_PopulationRate_RFA_' num2str(n_phases(i).name) '_Suphase_' num2str(subphase) '_Bin_' num2str(bin)  '.png']))
                saveas(gcf,fullfile(Res_folder,[num2str(nfig) '_Raster_Sorted_PopulationRate_RFA_' num2str(n_phases(i).name) '_Suphase_' num2str(subphase) '_Bin_' num2str(bin) '.fig']))
        %             saveas(gcf,fullfile(Res_folder,[num2str(nfig) 'No Limit' num2str(n_phases(i).name) '_Raster_Sorted_PopulationRate_RFA_' num2str(subphase)]),'fig')
    end
else
    if Duration_fix == '1'
        saveas(gcf,fullfile(Res_folder,[num2str(nfig) '_Raster_Sorted_PopulationRate_S1_' num2str(n_phases(i).name) '_Original_Bin_' num2str(bin) '_default' '.png']))
                saveas(gcf,fullfile(Res_folder,[num2str(nfig) '_Raster_Sorted_PopulationRate_S1_' num2str(n_phases(i).name) '_Original_Bin_' num2str(bin) '.fig']))
        %         saveas(gcf,fullfile(Res_folder,[num2str(nfig) 'LIM_Raster_Sorted_PopulationRate_S1_' num2str(n_phases(i).name) '_Original']),'png')
    else
        saveas(gcf,fullfile(Res_folder,[num2str(nfig) '_Raster_Sorted_PopulationRate_S1_' num2str(n_phases(i).name) '_Suphase_' num2str(subphase) '_Bin_' num2str(bin) '.png']))
                saveas(gcf,fullfile(Res_folder,[num2str(nfig) '_Raster_Sorted_PopulationRate_S1_' num2str(n_phases(i).name) '_Suphase_' num2str(subphase) '_Bin_' num2str(bin) '.fig']))
        %     saveas(gcf,fullfile(Res_folder,[num2str(nfig) 'No Limit' num2str(n_phases(i).name) '_Raster_Sorted_PopulationRate_S1_' num2str(subphase)]),'fig')
    end
end

%% 30sec_figure
% scrsz = get(0,'ScreenSize');
% ffh = figure('Position',[1+100 scrsz(1)+100 scrsz(3)-200 scrsz(4)-200]);
% set(gcf,'Color','w')
% grid on; hold on
% if ~isempty(spkTs)
%     spkTs_s = spkTs/FS;
%     plot(spkTs_s, spkLabel,'.b','markersize',3);
% end
% 
% xlim([800,830]) %lenPh
% 
% set(gca,'ytick',1:nChsRFA,'yticklabel',num2str(evector),'ylim',[0 nChsRFA+1]);
% xlabel('Time [s]')
% ylabel('Unit')
% if type == 'R'
%     title(['RFA ' num2str(n_phases(i).name) '  subPhase:' num2str(subphase)],'Interpreter','none')
% else
%     title(['S1 ' num2str(n_phases(i).name) '  subPhase:' num2str(subphase)], 'Interpreter','none')
% end
% if type == 'R'
%     if Duration_fix == '1'
%         saveas(gcf,fullfile(Res_folder,[num2str(nfig) '_Raster_Sorted_PopulationRate_RFA_' num2str(n_phases(i).name) '_Original_Bin_' num2str(bin) '_default_30sec' '.png']))
%                 saveas(gcf,fullfile(Res_folder,[num2str(nfig) '_Raster_Sorted_PopulationRate_RFA_' num2str(n_phases(i).name) '_Original_Bin_' num2str(bin) '_30sec' '.fig']))
%         %         saveas(gcf,fullfile(Res_folder,[num2str(nfig) 'LIM_Raster_Sorted_PopulationRate_RFA_' num2str(n_phases(i).name) '_Original']),'png')
%     else
%         saveas(gcf,fullfile(Res_folder,[num2str(nfig) '_Raster_Sorted_PopulationRate_RFA_' num2str(n_phases(i).name) '_Suphase_' num2str(subphase) '_Bin_' num2str(bin) '_30sec' '.png']))
%                 saveas(gcf,fullfile(Res_folder,[num2str(nfig) '_Raster_Sorted_PopulationRate_RFA_' num2str(n_phases(i).name) '_Suphase_' num2str(subphase) '_Bin_' num2str(bin) '_30sec' '.fig']))
%         %             saveas(gcf,fullfile(Res_folder,[num2str(nfig) 'No Limit' num2str(n_phases(i).name) '_Raster_Sorted_PopulationRate_RFA_' num2str(subphase)]),'fig')
%     end
% else
%     if Duration_fix == '1'
%         saveas(gcf,fullfile(Res_folder,[num2str(nfig) '_Raster_Sorted_PopulationRate_S1_' num2str(n_phases(i).name) '_Original_Bin_' num2str(bin) '_default_30sec' '.png']))
%                 saveas(gcf,fullfile(Res_folder,[num2str(nfig) '_Raster_Sorted_PopulationRate_S1_' num2str(n_phases(i).name) '_Original_Bin_' num2str(bin) '_30sec' '.fig']))
%         %         saveas(gcf,fullfile(Res_folder,[num2str(nfig) 'LIM_Raster_Sorted_PopulationRate_S1_' num2str(n_phases(i).name) '_Original']),'png')
%     else
%         saveas(gcf,fullfile(Res_folder,[num2str(nfig) '_Raster_Sorted_PopulationRate_S1_' num2str(n_phases(i).name) '_Suphase_' num2str(subphase) '_Bin_' num2str(bin) '_30sec' '.png']))
%                 saveas(gcf,fullfile(Res_folder,[num2str(nfig) '_Raster_Sorted_PopulationRate_S1_' num2str(n_phases(i).name) '_Suphase_' num2str(subphase) '_Bin_' num2str(bin) '_30sec' '.fig']))
%         %     saveas(gcf,fullfile(Res_folder,[num2str(nfig) 'No Limit' num2str(n_phases(i).name) '_Raster_Sorted_PopulationRate_S1_' num2str(subphase)]),'fig')
%     end
% end
% 
% nfig=nfig+1;
% close all
%% IFR Subplot Spontaneous
% if Duration_fix == '1'
% if i==1
%     scrsz = get(0,'ScreenSize');
%     gh = figure('Position',[1+100 scrsz(1)+100 scrsz(3)-200 scrsz(4)-200]);
%     set(gcf,'Color','w')
%     grid on;
% else
%     if type == 'R'
%         openfig(fullfile(Res_folder,['IFR_RFA_Original_Bin_' num2str(bin) '.fig']))
%     else
%         openfig(fullfile(Res_folder,['IFR_S1_Original_Bin_' num2str(bin) '.fig']))
%     end
% end
% hold on
% subplot(3,1,i)
% plot(xtime,IFRPopulationTrain)
% xlabel('Time [s]')
% ylabel('Spikes per s')
% if type == 'R'
%     title(['RFA ' num2str(n_phases(i).name) '  subPhase:' num2str(subphase) ' Bin [sec]:' num2str(bin)],'Interpreter','none')
% else
%     title(['S1 ' num2str(n_phases(i).name) '  subPhase:' num2str(subphase) ' Bin [sec]:' num2str(bin)], 'Interpreter','none')
% end
% xlim([(lenPh-(dur*60)) lenPh]) %lenPh
% if type == 'R'
%         saveas(gcf,fullfile(Res_folder,['IFR_RFA_Original_Bin_' num2str(bin)]),'png')
%         savefig(gcf,fullfile(Res_folder,['IFR_RFA_Original_Bin_' num2str(bin) '.fig']))
% else
%         saveas(gcf,fullfile(Res_folder,['IFR_S1_Original_Bin_' num2str(bin)]),'png')
%         savefig(gcf,fullfile(Res_folder,['IFR_S1_Original_Bin_' num2str(bin) '.fig']))
% 
% end
% if i==1
%     scrsz = get(0,'ScreenSize');
%     gh = figure('Position',[1+100 scrsz(1)+100 scrsz(3)-200 scrsz(4)-200]);
%     set(gcf,'Color','w')
%     grid on;
% else
%     if type == 'R'
% %         openfig(fullfile(Res_folder,['Raster_RFA_Bin_' num2str(bin) '.fig']))
%         openfig(fullfile(Res_folder,['Raster_RFA_Original_Bin_' num2str(bin) '.fig']))
%     else
%         openfig(fullfile(Res_folder,['Raster_S1_Original_Bin_' num2str(bin) '.fig']))
%     end
% end
% hold on
% subplot(3,1,i)
% if ~isempty(spkTs)
%     spkTs_s = spkTs/FS;
%     plot(spkTs_s, spkLabel,'.b','markersize',3);
% end
% xlabel('Time [s]')
% ylabel('Spikes per s')
% if type == 'R'
%     title(['RFA ' num2str(n_phases(i).name) '  subPhase:' num2str(subphase) ' Bin [sec]:' num2str(bin)],'Interpreter','none')
% else
%     title(['S1 ' num2str(n_phases(i).name) '  subPhase:' num2str(subphase) ' Bin [sec]:' num2str(bin)], 'Interpreter','none')
% end
% xlim([(lenPh-(dur*60)) lenPh]) %lenPh
% if type == 'R'
%         saveas(gcf,fullfile(Res_folder,['Raster_RFA_Original_Bin_' num2str(bin)]),'png')
%         savefig(gcf,fullfile(Res_folder,['Raster_RFA_Original_Bin_' num2str(bin) '.fig']))
% else
%         saveas(gcf,fullfile(Res_folder,['Raster_S1_Original_Bin_' num2str(bin)]),'png')
%         savefig(gcf,fullfile(Res_folder,['Raster_S1_Original_Bin_' num2str(bin) '.fig']))
% end
% end
end