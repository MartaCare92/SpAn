function []=PC_func(Duration_fix,nPhases,Res_fold,exp_num,i,Duration_fixed,lenPhSample_fixed,bin,gaussFilter,FS,RFA,S1,TS_RFA,TS_S1)

Res_folder=fullfile([Res_fold '/Analysis/']);
if exist(Res_folder,'dir')==0
    mkdir(Res_folder)
end

nsubPhases=length(TS_RFA);
    if Duration_fix == '1'
        
        [PC_RFA, PC_S1,func]=PC_inj(bin,gaussFilter,FS,nsubPhases,lenPhSample_fixed,TS_RFA,TS_S1,RFA,S1);
        
        save([Res_folder '/' exp_num '_PC_Original'],'PC_RFA', 'PC_S1','func');
    else

        [PC_RFA, PC_S1,func]=PC_inj(bin,gaussFilter,FS,nsubPhases,lenPhSample_fixed,TS_RFA,TS_S1,RFA,S1);
        
        save([Res_folder '/' exp_num '_PC_' num2str(Duration_fixed)],'PC_RFA', 'PC_S1','func');
    end
end