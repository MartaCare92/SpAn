function []=Main_Analysis_Plot(start_folder,Result_folder,exp_num,bin_size,bin,numOfIterations,Duration_fix,SPK,MFR,LVR,BOOT,PC,YES,PTSD,SWTTEO) 
close all 
f = waitbar(0,'Please wait...');
close(f)
    
[~,Duration_fixed,~,nSub,~,~,~,nPhases,~,~,~,~]=setting_start(PTSD,SWTTEO,start_folder,Result_folder,Duration_fix,bin_size,bin,numOfIterations,YES);
t=waitbar(.50,'Processing your data');

% BMC_Analysis_Plot(nSub,Result_folder,exp_num,Duration_fixed,Duration_fix,MFR,LVR,BOOT,PC); %Alberto data anesthetized published on Bioelectronic Medicine
JLMoIIT_Analysis_Plot(nSub,nPhases,Result_folder,exp_num,Duration_fixed,Duration_fix,SPK,MFR,LVR,BOOT,PC,YES);
close(t)
f=waitbar(1,'Finishing');
pause(1)
close(f)
end
