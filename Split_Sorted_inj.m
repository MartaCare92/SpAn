function []=Split_Sorted_inj(start_folder,YES)

if YES == 1
    Sort=1; % Sorted data
else
    Sort=0; % Not sorted data
end

f = waitbar(0,'Please wait...');
pause(.5)

cd(start_folder)

waitbar(.33,f,'Loading your data');
pause(1)

ndir=0;
AllPhases = dir(fullfile(start_folder));
%
for i = 1:numel(AllPhases)
    if AllPhases(i).isdir
        ndir=1+ndir;
        Phases(ndir)=AllPhases(i);
        disp(AllPhases(i).name); % disp displays the value of the input variable
    end
end
nPhases = ndir-2;

waitbar(.70,f,'Processing your data');
pause(1)

for i= 1:nPhases
    
    if Sort==1
        sorted_split=(fullfile(start_folder, Phases(i+2).name,[Phases(i+2).name '_Sorted_splitted']));
    else
        sorted_split=(fullfile(start_folder, Phases(i+2).name,[Phases(i+2).name '_NOTSorted_SWTTEO_splitted']));
%         sorted_split=(fullfile(start_folder, Phases(i+2).name,[Phases(i+2).name '_NOTSorted_splitted']));
    end
    
    if exist(sorted_split,'dir')==0
        mkdir(sorted_split)
    end
    
    RFA=(fullfile(sorted_split,'RFA'));
    
    if exist(RFA,'dir')==0
        mkdir(RFA)
    end
    
    S1=(fullfile(sorted_split,'S1'));
    
    if exist(S1,'dir')==0
        mkdir(S1)
    end
  
%     spikes_fold=(fullfile(start_folder, Phases(i+2).name,'_Spikes_SWTTEO'));
    spikes_fold=(fullfile(start_folder, Phases(i+2).name,'_Spikes'));
    if Sort==1
        sorted_fold=(fullfile(start_folder, Phases(i+2).name,'_Sorted'));
    else
        sorted_fold=spikes_fold;
    end
    
    load(fullfile(start_folder,[ Phases(i+2).name '_Block.mat']))
    
    FS=blockObj.SampleRate;
    lenPh_min=blockObj.Samples./blockObj.SampleRate./60; %min
    lenPh=blockObj.Samples./blockObj.SampleRate; %sec
    lenPhSample=floor((lenPh)*FS);
    chsS=dirr(fullfile(spikes_fold));
    if Sort==1
        chs=dirr(fullfile(sorted_fold));
    else
        chs=chsS;
    end
    
    for nChs= 1:length(chs)
        
        spks=load(fullfile(spikes_fold,chsS(nChs).name));
        if Sort==1
            sort=load(fullfile(sorted_fold,chs(nChs).name));
            nclu=unique(sort.data(:,2));
        else
            nclu=1;
        end
        
        for n=1:length(nclu)
            peak_train1=zeros(lenPhSample,1);
            if Sort==1
                ts=sort.data(find(sort.data(:,2)==nclu(n)),4)*FS;
            else
                ts=spks.data(:,4)*FS;
            end
            
            if isnan(ts)
                peak_train=0;
            else
                peak_train1(round(ts))=1;
                peak_train=peak_train1;
            end
            spikes=spks.data(:,5:end);
            artifact=[];
            
            if strfind(chs(nChs).name,'P1')
                if (str2double(chs(nChs).name(end-5:end-4)))<9
                    sorted=[Phases(i+2).name '_ptrain_Sorted_Ch_0' num2str(str2double(chs(nChs).name(end-5:end-4))+1) '_' num2str(nclu(n))];
                else
                    sorted=[Phases(i+2).name '_ptrain_Sorted_Ch_' num2str(str2double(chs(nChs).name(end-5:end-4))+1) '_' num2str(nclu(n))];
                end
                save(fullfile(RFA,sorted),'spikes','artifact','peak_train','-v7.3')
            elseif strfind(chs(nChs).name,'P2')
                if length(chs)<=32 % 2 arrays of 16-Ch
                    if (str2double(chs(nChs).name(end-5:end-4)))<9
                        sorted=[Phases(i+2).name '_ptrain_Sorted_Ch_0' num2str(str2double(chs(nChs).name(end-5:end-4))+1) '_' num2str(nclu(n))];
                    else
                        sorted=[Phases(i+2).name '_ptrain_Sorted_Ch_' num2str(str2double(chs(nChs).name(end-5:end-4))+1) '_' num2str(nclu(n))];
                    end
                    save(fullfile(S1,sorted),'spikes','artifact','peak_train','-v7.3') 
                else
                    sorted=[Phases(i+2).name '_ptrain_Sorted_Ch_' num2str(nChs) '_' num2str(nclu(n))];
                    save(fullfile(RFA,sorted),'spikes','artifact','peak_train','-v7.3')
                end
            elseif strfind(chs(nChs).name,'P3')
                if nChs<42
                    sorted=[Phases(i+2).name '_ptrain_Sorted_Ch_0' num2str(nChs-32) '_' num2str(nclu(n))];
                else
                    sorted=[Phases(i+2).name '_ptrain_Sorted_Ch_' num2str(nChs-32) '_' num2str(nclu(n))];
                end
                save(fullfile(S1,sorted),'spikes','artifact','peak_train','-v7.3')
            else
                sorted=[Phases(i+2).name '_ptrain_Sorted_Ch_' num2str(nChs-32) '_' num2str(nclu(n))];
                save(fullfile(S1,sorted),'spikes','artifact','peak_train','-v7.3')
            end
            clear peak_train spikes artifact ts peak_train1
        end
        clear nclu sort  spks
    end
end
if isempty(chs)
    g = uifigure;
    uialert(g,'Spike Detection required','Spikes not found');
end
waitbar(1,f,'Finishing');
pause(1)
close(f)
end