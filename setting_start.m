function [Res_fold,Duration_fixed,gaussFilter,nSub,Phases_ordered,RFA,S1,nPhases,indRFA,chsRFA,indS1,chsS1]=setting_start(PTSD,SWTTEO,start_folder,Result_folder,Duration_fix,~,~,~,YES)

Res_fold = Result_folder;
if exist(Res_fold,'dir')==0
    mkdir(Res_fold)
end
% set starting parameter
gaussFilter = exp(-1*(-15:1:15).^2/50);
gaussFilter = gaussFilter/sum(gaussFilter); % smoothing kernelbin=0.001;

Duration_fixed=str2num(Duration_fix);

ndir=0;
AllPhases = dir(fullfile(start_folder));
for ii = 1:numel(AllPhases)
    if AllPhases(ii).isdir
        ndir=1+ndir;
        phases(ndir)=AllPhases(ii);
        disp(AllPhases(ii).name); % disp displays the value of the input variable
    end
end
nPhases = ndir;
Phases_ordered = phases(3:nPhases);
nPhases = length(Phases_ordered);
clear ndir

d=waitbar(.33,'Loading your data');
pause(1)

for i=1:nPhases
    if YES == 1
        sorted_fold=(fullfile(start_folder, Phases_ordered(i).name,[Phases_ordered(i).name '_Sorted_splitted']));
    else
        if PTSD == 1
            sorted_fold=(fullfile(start_folder, Phases_ordered(i).name,[Phases_ordered(i).name '_NOTSorted_splitted']));
        elseif SWTTEO == 1
            sorted_fold=(fullfile(start_folder, Phases_ordered(i).name,[Phases_ordered(i).name '_NOTSorted_SWTTEO_splitted']));
        end
    end
    chsR=what(fullfile(sorted_fold,'RFA'));
    chsRFA{i}=chsR.mat;
    chsS=what(fullfile(sorted_fold,'S1'));
    chsS1{i}=chsS.mat;
    
end

for i=1:nPhases
    for j=1:length(chsRFA{i})
        chsRFA_{i}{j}=chsRFA{i}{j}(end-7:end-4);
    end
end

for i=1:nPhases
    for j=1:length(chsS1{i})
        chsS1_{i}{j}=chsS1{i}{j}(end-7:end-4);
    end
end

RFA=chsRFA_{1};
if isempty(chsS1{1,1}) == 0
    S1=chsS1_{1};
end
% for i=1:nPhases
%     RFA=intersect(RFA,chsRFA_{i});
%     if isempty(chsS1{1,1}) == 0
%         S1=intersect(S1,chsS1_{i});
%     end
% end
RFA2=chsRFA_;
S12=chsS1_;
for i=1:nPhases
%     [C,ia,indRFA(:,i)]=intersect(RFA,chsRFA_{i});
%     if isempty(chsS1{1,1}) == 0
%         [C,ia,indS1(:,i)]=intersect(S1,chsS1_{i});
%     end
    [C,ia,indRFA(:,i)]=intersect(RFA,chsRFA_{1});
    if isempty(chsS1{1,1}) == 0
        [C,ia,indS1(:,i)]=intersect(S1,chsS1_{1});
    end
end
nSub=[];
for i=1:nPhases
    
    if YES == 1
        sorted_fold=(fullfile(start_folder,Phases_ordered(i).name,[Phases_ordered(i).name '_Sorted_splitted']));
    else
        if PTSD == 1
            sorted_fold=(fullfile(start_folder, Phases_ordered(i).name,[Phases_ordered(i).name '_NOTSorted_splitted']));
        elseif SWTTEO == 1
            sorted_fold=(fullfile(start_folder, Phases_ordered(i).name,[Phases_ordered(i).name '_NOTSorted_SWTTEO_splitted']));
        end
    end
    load(fullfile(start_folder,[Phases_ordered(i).name '_Block.mat']))
    
    lenPh_min=blockObj.Samples./blockObj.SampleRate./60; %min
    if Duration_fixed ==1
        ndur = 1;
    else
        ndur = round(lenPh_min/Duration_fixed);
    end
    for j=1:ndur
        nsubPhases(j)=j;
    end
    nSub{i}=nsubPhases;
    nsubPhases=0;
end
if isempty(chsS1{1,1}) == 1
    S1=0;
    indS1=0;
    chsS1=0;
end
close(d)
end