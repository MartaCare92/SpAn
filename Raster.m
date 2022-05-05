function []= Raster(Phases_ordered,TS_RFA,TS_S1,spkLabel_RFA_end,spkLabel_S1_end,gaussFilter,FS,bin,Duration_fixed,evector_RFA,nChsRFA,evector_S1,nChsS1,Duration_fix,Res_fold,nSub)
spkTs_RFA = cell(1,length(TS_RFA));
spkLabel_RFA = cell(1,length(TS_RFA));

for i=1:length(TS_RFA)
    for j=1:length(TS_RFA{1,i})
        spkTs_RFA{1,i} = [spkTs_RFA{1,i};TS_RFA{1,i}{1,j}];
        spkLabel_RFA{1,i} = [spkLabel_RFA{1,i};spkLabel_RFA_end{1,i}{1,j}];
    end
end

% if TS_S1 == 0
%     spkTs_S1{1,i} = 0;
%     spkLabel_S1{1,i} = 0;
% else
    spkTs_S1 = cell(1,length(TS_S1));
    spkLabel_S1 = cell(1,length(TS_S1));
    for i=1:length(TS_S1)
        for j=1:length(TS_S1{1,i})
            spkTs_S1{1,i} = [spkTs_S1{1,i};TS_S1{1,i}{1,j}];
            spkLabel_S1{1,i} = [spkLabel_S1{1,i};spkLabel_S1_end{1,i}{1,j}];
        end
    end
% end

k=0;
nfig=1;
for j=1:length(Phases_ordered)
    for i=1:length(nSub{j})
        if Duration_fix == '1'
            lenPh_fixed = Duration_fixed(1,j) *60;
            subphase=Duration_fixed(1,j)*i;
            Duration=Duration_fixed(1,j);
        else
            lenPh_fixed = Duration_fixed *60;
            subphase=Duration_fixed*i;
            Duration=Duration_fixed;
        end
        k=k+1;
        [nfig]=raster_plot(k,spkTs_RFA{1,k},gaussFilter,FS,bin,spkTs_RFA{1,k},spkLabel_RFA{1,k},Phases_ordered,j,subphase,i*lenPh_fixed,Duration,evector_RFA,nChsRFA,Duration_fix,Res_fold,'R',nfig);
    end
end
% if TS_S1 ==0
% else
    k=0;
    for j=1:length(Phases_ordered)
        for i=1:length(nSub{j})
            if Duration_fix == '1'
                lenPh_fixed = Duration_fixed(1,j) *60;
                subphase=Duration_fixed(1,j)*i;
                Duration=Duration_fixed(1,j);
            else
                lenPh_fixed = Duration_fixed *60;
                subphase=Duration_fixed*i;
                Duration=Duration_fixed;
            end
            k=k+1;
            [nfig]=raster_plot(k,spkTs_S1{1,k},gaussFilter,FS,bin,spkTs_S1{1,k},spkLabel_S1{1,k},Phases_ordered,j,subphase,i*lenPh_fixed,Duration,evector_S1,nChsS1,Duration_fix,Res_fold,'S',nfig);
        end
    end
% end
end