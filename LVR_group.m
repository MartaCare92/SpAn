function [Group_LVR_RFA,LVR_Group_RFA,SPONT_Group_LVR_RFA,Group_LVR_RFA_Spont,GROUP_LVR_RS_RFA,GROUP_LVR_ES_RFA,GROUP_LVR_SS_RFA,Group_LVR_S1,LVR_Group_S1,SPONT_Group_LVR_S1,Group_LVR_S1_Spont,GROUP_LVR_RS_S1,GROUP_LVR_ES_S1,GROUP_LVR_SS_S1]= LVR_group(exp_folder,Num_Exp,LVR_Group_RFA,SPONT_Group_LVR_RFA,GROUP_LVR_RS_RFA,GROUP_LVR_ES_RFA,GROUP_LVR_SS_RFA,LVR_Group_S1,SPONT_Group_LVR_S1,GROUP_LVR_RS_S1,GROUP_LVR_ES_S1,GROUP_LVR_SS_S1)

[LVR_All_Phases_RFA,SPONT_AllPhases_RFA,SPONT_RS_RFA,~,SPONT_ES_RFA,~,SPONT_SS_RFA,~,~,~,n,r,e,s]=define_ResGroup;

load(fullfile(exp_folder,[Num_Exp,'_LVR_Original.mat']))
Split_stim=str2num(Num_Exp(end-1:end));
%% RFA
%% Order Phases in Experiments without some phase
if length(LvR_out_RFA)<19
    for j=1:19
        if j==1 && LvR_out_RFA{2, j}(:,12)~= '1'
            LVR=LvR_out_RFA;
            for i=1:16
                LvR_out_RFA{1, j}{1,i}=NaN;
            end
            LvR_out_RFA{2, j}='01_00-basal1';
            for k=j:length(LvR_out_RFA)
                LvR_out_RFA{1,k+1}=LVR{1,k};
                LvR_out_RFA{2,k+1}=LVR{2,k};
            end
        elseif j==2 && LvR_out_RFA{2, j}(:,12)~= '1'
            LVR=LvR_out_RFA;
            for i=1:16
                LvR_out_RFA{1, j}{1,i}=NaN;
            end
            LvR_out_RFA{2, j}='02_00-basal1';
            for k=j:length(LvR_out_RFA)
                LvR_out_RFA{1,k+1}=LVR{1,k};
                LvR_out_RFA{2,k+1}=LVR{2,k};
            end
        elseif j==3 && LvR_out_RFA{2, j}(:,12)~= '2'
            LVR=LvR_out_RFA;
            for i=1:16
                LvR_out_RFA{1, j}{1,i}=NaN;
            end
            LvR_out_RFA{2, j}='03_00-basal2';
            for k=j:length(LvR_out_RFA)
                LvR_out_RFA{1,k+1}=LVR{1,k};
                LvR_out_RFA{2,k+1}=LVR{2,k};
            end
        elseif j==4 && LvR_out_RFA{2, j}(:,9)~= '-'
            LVR=LvR_out_RFA;
            for i=1:16
                LvR_out_RFA{1, j}{1,i}=NaN;
            end
            LvR_out_RFA{2, j}='04_00-cm';
            for k=j:length(LvR_out_RFA)
                LvR_out_RFA{1,k+1}=LVR{1,k};
                LvR_out_RFA{2,k+1}=LVR{2,k};
            end
        elseif j==5 && LvR_out_RFA{2, j}(:,9)~= '2'
            LVR=LvR_out_RFA;
            for i=1:16
                LvR_out_RFA{1, j}{1,i}=NaN;
            end
            LvR_out_RFA{2, j}='05_00-cm2';
            for k=j:length(LvR_out_RFA)
                LvR_out_RFA{1,k+1}=LVR{1,k};
                LvR_out_RFA{2,k+1}=LVR{2,k};
            end
        elseif j==6 && LvR_out_RFA{2, j}(:,12)~= '1'
            LVR=LvR_out_RFA;
            for i=1:16
                LvR_out_RFA{1, j}{1,i}=NaN;
            end
            LvR_out_RFA{2, j}='06_01-basal1';
            for k=j:length(LvR_out_RFA)
                LvR_out_RFA{1,k+1}=LVR{1,k};
                LvR_out_RFA{2,k+1}=LVR{2,k};
            end
        elseif j==7 &&LvR_out_RFA{2, j}(:,12)~= '1'
            LVR=LvR_out_RFA;
            for i=1:16
                LvR_out_RFA{1, j}{1,i}=NaN;
            end
            LvR_out_RFA{2, j}='07_01-basal1';
            for k=j:length(LvR_out_RFA)
                LvR_out_RFA{1,k+1}=LVR{1,k};
                LvR_out_RFA{2,k+1}=LVR{2,k};
            end
        elseif j==8 && LvR_out_RFA{2, j}(:,9)~= '-'
            LVR=LvR_out_RFA;
            for i=1:16
                LvR_out_RFA{1, j}{1,i}=NaN;
            end
            LvR_out_RFA{2, j}='08_01-cm';
            for k=j:length(LvR_out_RFA)
                LvR_out_RFA{1,k+1}=LVR{1,k};
                LvR_out_RFA{2,k+1}=LVR{2,k};
            end
        elseif j==9 && LvR_out_RFA{2, j}(:,9)~= '2'
            LVR=LvR_out_RFA;
            for i=1:16
                LvR_out_RFA{1, j}{1,i}=NaN;
            end
            LvR_out_RFA{2, j}='09_01-cm2';
            for k=j:length(LvR_out_RFA)
                LvR_out_RFA{1,k+1}=LVR{1,k};
                LvR_out_RFA{2,k+1}=LVR{2,k};
            end
        elseif j==10 && LvR_out_RFA{2, j}(:,7)~= 's'
            LVR=LvR_out_RFA;
            for i=1:16
                LvR_out_RFA{1, j}{1,i}=NaN;
            end
            LvR_out_RFA{2, j}='10_02-stim';
            for k=j:length(LvR_out_RFA)
                LvR_out_RFA{1,k+1}=LVR{1,k};
                LvR_out_RFA{2,k+1}=LVR{2,k};
            end
        elseif j==11 && LvR_out_RFA{2, j}(:,7)~= 's'
            LVR=LvR_out_RFA;
            for i=1:16
                LvR_out_RFA{1, j}{1,i}=NaN;
            end
            LvR_out_RFA{2, j}='11_02-stim';
            for k=j:length(LvR_out_RFA)
                LvR_out_RFA{1,k+1}=LVR{1,k};
                LvR_out_RFA{2,k+1}=LVR{2,k};
            end
        elseif j==12 && LvR_out_RFA{2, j}(:,7)~= 's'
            LVR=LvR_out_RFA;
            for i=1:16
                LvR_out_RFA{1, j}{1,i}=NaN;
            end
            LvR_out_RFA{2, j}='12_02-stim';
            for k=j:length(LvR_out_RFA)
                LvR_out_RFA{1,k+1}=LVR{1,k};
                LvR_out_RFA{2,k+1}=LVR{2,k};
            end
        elseif j==13 && LvR_out_RFA{2, j}(:,7)~= 's'
            LVR=LvR_out_RFA;
            for i=1:16
                LvR_out_RFA{1, j}{1,i}=NaN;
            end
            LvR_out_RFA{2, j}='13_02-stim';
            for k=j:length(LvR_out_RFA)
                LvR_out_RFA{1,k+1}=LVR{1,k};
                LvR_out_RFA{2,k+1}=LVR{2,k};
            end
        elseif j==14 && LvR_out_RFA{2, j}(:,7)~= 's'
            LVR=LvR_out_RFA;
            for i=1:16
                LvR_out_RFA{1, j}{1,i}=NaN;
            end
            LvR_out_RFA{2, j}='14_02-stim';
            for k=j:length(LvR_out_RFA)
                LvR_out_RFA{1,k+1}=LVR{1,k};
                LvR_out_RFA{2,k+1}=LVR{2,k};
            end
        elseif j==15 && LvR_out_RFA{2, j}(:,7)~= 's'
            LVR=LvR_out_RFA;
            for i=1:16
                LvR_out_RFA{1, j}{1,i}=NaN;
            end
            LvR_out_RFA{2, j}='15_02-stim';
            for k=j:length(LvR_out_RFA)
                LvR_out_RFA{1,k+1}=LVR{1,k};
                LvR_out_RFA{2,k+1}=LVR{2,k};
            end
        elseif j==16 && LvR_out_RFA{2, j}(:,7)~= 'b'
            LVR=LvR_out_RFA;
            for i=1:16
                LvR_out_RFA{1, j}{1,i}=NaN;
            end
            LvR_out_RFA{2, j}='16_03-basal1';
            for k=j:length(LvR_out_RFA)
                LvR_out_RFA{1,k+1}=LVR{1,k};
                LvR_out_RFA{2,k+1}=LVR{2,k};
            end
        elseif j==17 && LvR_out_RFA{2, j}(:,7)~= 'b'
            LVR=LvR_out_RFA;
            for i=1:16
                LvR_out_RFA{1, j}{1,i}=NaN;
            end
            LvR_out_RFA{2, j}='17_03-basal1';
            for k=j:length(LvR_out_RFA)
                LvR_out_RFA{1,k+1}=LVR{1,k};
                LvR_out_RFA{2,k+1}=LVR{2,k};
            end
        elseif j==18 && LvR_out_RFA{2, j}(:,9)~= '-'
            LVR=LvR_out_RFA;
            for i=1:16
                LvR_out_RFA{1, j}{1,i}=NaN;
            end
            LvR_out_RFA{2, j}='18_03-cm';
            for k=j:length(LvR_out_RFA)
                LvR_out_RFA{1,k+1}=LVR{1,k};
                LvR_out_RFA{2,k+1}=LVR{2,k};
            end
        elseif j==19 && LvR_out_RFA{2, j}(:,9)~= '2'
            LVR=LvR_out_RFA;
            for i=1:16
                LvR_out_RFA{1, j}{1,i}=NaN;
            end
            LvR_out_RFA{2, j}='19_03-cm2';
            for k=j:length(LvR_out_RFA)
                LvR_out_RFA{1,k+1}=LVR{1,k};
                LvR_out_RFA{2,k+1}=LVR{2,k};
            end
        end
    end
end
%% Group All ordered Phases
for j = 1:length(LvR_out_RFA)
    if length(LvR_out_RFA{1, j})<16
        LvR_out_RFA{1, j}{1,length(LvR_out_RFA{1, j})+1}=NaN;
    end
    if LvR_out_RFA{2, j}(:,7)== 'b'
        SPONT_AllPhases_RFA(:,n) = cell2mat(LvR_out_RFA{1, j}(1,:))';
        Group_LVR_RFA_Spont(1,n)= LvR_out_RFA(2,j);
        n=n+1;
    end
    %% Split Stimulation mode
    if j==1 || j==2 || j==6 || j==7 || j==16 || j==17
        if Split_stim==9||Split_stim==10||Split_stim==11||Split_stim==17||Split_stim==20||Split_stim==24||Split_stim==28 %OL: Reapeted Stimulation
            if LvR_out_RFA{2, j}(:,7)== 'b'
                SPONT_RS_RFA(:,r) = cell2mat(LvR_out_RFA{1, j}(:,:))';
                RS_LVR_RFA_Spont(1,r)= LvR_out_RFA(2,j);
                r=r+1;
            end
        end
        if Split_stim==12 || Split_stim==13 ||Split_stim== 14 ||Split_stim== 15 || Split_stim==16 ||Split_stim== 18 ||Split_stim== 19 %OL: Exponential Stimulation
            if LvR_out_RFA{2, j}(:,7)== 'b'
                SPONT_ES_RFA(:,e) = cell2mat(LvR_out_RFA{1, j}(:,:))';
                ES_LVR_RFA_Spont(1,e)= LvR_out_RFA(2,j);
                e=e+1;
            end
        end
        if Split_stim==21 ||Split_stim== 22 ||Split_stim== 26 ||Split_stim== 23 ||Split_stim== 25 ||Split_stim== 27 ||Split_stim== 29 ||Split_stim== 30 %OL: Shuffled Stimulation
            if LvR_out_RFA{2, j}(:,7)== 'b'
                SPONT_SS_RFA(:,s) = cell2mat(LvR_out_RFA{1, j}(:,:))';
                SS_LVR_RFA_Spont(1,s)= LvR_out_RFA(2,j);
                s=s+1;
            end
        end
    end
    LVR_All_Phases_RFA(:,j) = cell2mat(LvR_out_RFA{1,j}(:,:))';
end
LVR_Group_RFA = vertcat(LVR_Group_RFA, LVR_All_Phases_RFA);
SPONT_Group_LVR_RFA=vertcat(SPONT_Group_LVR_RFA,SPONT_AllPhases_RFA);
GROUP_LVR_RS_RFA=vertcat(GROUP_LVR_RS_RFA,SPONT_RS_RFA);
GROUP_LVR_ES_RFA=vertcat(GROUP_LVR_ES_RFA,SPONT_ES_RFA);
GROUP_LVR_SS_RFA=vertcat(GROUP_LVR_SS_RFA,SPONT_SS_RFA);

clear n r e s 
%% S1
[LVR_All_Phases_S1,SPONT_AllPhases_S1,SPONT_RS_S1,~,SPONT_ES_S1,~,SPONT_SS_S1,~,~,~,n,r,e,s]=define_ResGroup;
%% Order Phases in Experiments without some phase
if length(LvR_out_S1)<19
    for j=1:19
        if j==1 && LvR_out_S1{2, j}(:,12)~= '1'
            LVR=LvR_out_S1;
            for i=1:16
                LvR_out_S1{1, j}{1,i}=NaN;
            end
            LvR_out_S1{2, j}='01_00-basal1';
            for k=j:length(LvR_out_S1)
                LvR_out_S1{1,k+1}=LVR{1,k};
                LvR_out_S1{2,k+1}=LVR{2,k};
            end
        elseif j==2 && LvR_out_S1{2, j}(:,12)~= '1'
            LVR=LvR_out_S1;
            for i=1:16
                LvR_out_S1{1, j}{1,i}=NaN;
            end
            LvR_out_S1{2, j}='02_00-basal1';
            for k=j:length(LvR_out_S1)
                LvR_out_S1{1,k+1}=LVR{1,k};
                LvR_out_S1{2,k+1}=LVR{2,k};
            end
        elseif j==3 && LvR_out_S1{2, j}(:,12)~= '2'
            LVR=LvR_out_S1;
            for i=1:16
                LvR_out_S1{1, j}{1,i}=NaN;
            end
            LvR_out_S1{2, j}='03_00-basal2';
            for k=j:length(LvR_out_S1)
                LvR_out_S1{1,k+1}=LVR{1,k};
                LvR_out_S1{2,k+1}=LVR{2,k};
            end
        elseif j==4 && LvR_out_S1{2, j}(:,9)~= '-'
            LVR=LvR_out_S1;
            for i=1:16
                LvR_out_S1{1, j}{1,i}=NaN;
            end
            LvR_out_S1{2, j}='04_00-cm';
            for k=j:length(LvR_out_S1)
                LvR_out_S1{1,k+1}=LVR{1,k};
                LvR_out_S1{2,k+1}=LVR{2,k};
            end
        elseif j==5 && LvR_out_S1{2, j}(:,9)~= '2'
            LVR=LvR_out_S1;
            for i=1:16
                LvR_out_S1{1, j}{1,i}=NaN;
            end
            LvR_out_S1{2, j}='05_00-cm2';
            for k=j:length(LvR_out_S1)
                LvR_out_S1{1,k+1}=LVR{1,k};
                LvR_out_S1{2,k+1}=LVR{2,k};
            end
        elseif j==6 && LvR_out_S1{2, j}(:,12)~= '1'
            LVR=LvR_out_S1;
            for i=1:16
                LvR_out_S1{1, j}{1,i}=NaN;
            end
            LvR_out_S1{2, j}='06_01-basal1';
            for k=j:length(LvR_out_S1)
                LvR_out_S1{1,k+1}=LVR{1,k};
                LvR_out_S1{2,k+1}=LVR{2,k};
            end
        elseif j==7 && LvR_out_S1{2, j}(:,12)~= '1'
            LVR=LvR_out_S1;
            for i=1:16
                LvR_out_S1{1, j}{1,i}=NaN;
            end
            LvR_out_S1{2, j}='07_01-basal1';
            for k=j:length(LvR_out_S1)
                LvR_out_S1{1,k+1}=LVR{1,k};
                LvR_out_S1{2,k+1}=LVR{2,k};
            end
        elseif j==8 && LvR_out_S1{2, j}(:,9)~= '-'
            LVR=LvR_out_S1;
            for i=1:16
                LvR_out_S1{1, j}{1,i}=NaN;
            end
            LvR_out_S1{2, j}='08_01-cm';
            for k=j:length(LvR_out_S1)
                LvR_out_S1{1,k+1}=LVR{1,k};
                LvR_out_S1{2,k+1}=LVR{2,k};
            end
        elseif j==9 && LvR_out_S1{2, j}(:,9)~= '2'
            LVR=LvR_out_S1;
            for i=1:16
                LvR_out_S1{1, j}{1,i}=NaN;
            end
            LvR_out_S1{2, j}='09_01-cm2';
            for k=j:length(LvR_out_S1)
                LvR_out_S1{1,k+1}=LVR{1,k};
                LvR_out_S1{2,k+1}=LVR{2,k};
            end
        elseif j==10 && LvR_out_S1{2, j}(:,7)~= 's'
            LVR=LvR_out_S1;
            for i=1:16
                LvR_out_S1{1, j}{1,i}=NaN;
            end
            LvR_out_S1{2, j}='10_02-stim';
            for k=j:length(LvR_out_S1)
                LvR_out_S1{1,k+1}=LVR{1,k};
                LvR_out_S1{2,k+1}=LVR{2,k};
            end
        elseif j==11 && LvR_out_S1{2, j}(:,7)~= 's'
            LVR=LvR_out_S1;
            for i=1:16
                LvR_out_S1{1, j}{1,i}=NaN;
            end
            LvR_out_S1{2, j}='11_02-stim';
            for k=j:length(LvR_out_S1)
                LvR_out_S1{1,k+1}=LVR{1,k};
                LvR_out_S1{2,k+1}=LVR{2,k};
            end
        elseif j==12 && LvR_out_S1{2, j}(:,7)~= 's'
            LVR=LvR_out_S1;
            for i=1:16
                LvR_out_S1{1, j}{1,i}=NaN;
            end
            LvR_out_S1{2, j}='12_02-stim';
            for k=j:length(LvR_out_S1)
                LvR_out_S1{1,k+1}=LVR{1,k};
                LvR_out_S1{2,k+1}=LVR{2,k};
            end
        elseif j==13 && LvR_out_S1{2, j}(:,7)~= 's'
            LVR=LvR_out_S1;
            for i=1:16
                LvR_out_S1{1, j}{1,i}=NaN;
            end
            LvR_out_S1{2, j}='13_02-stim';
            for k=j:length(LvR_out_S1)
                LvR_out_S1{1,k+1}=LVR{1,k};
                LvR_out_S1{2,k+1}=LVR{2,k};
            end
        elseif j==14 && LvR_out_S1{2, j}(:,7)~= 's'
            LVR=LvR_out_S1;
            for i=1:16
                LvR_out_S1{1, j}{1,i}=NaN;
            end
            LvR_out_S1{2, j}='14_02-stim';
            for k=j:length(LvR_out_S1)
                LvR_out_S1{1,k+1}=LVR{1,k};
                LvR_out_S1{2,k+1}=LVR{2,k};
            end
        elseif j==15 && LvR_out_S1{2, j}(:,7)~= 's'
            LVR=LvR_out_S1;
            for i=1:16
                LvR_out_S1{1, j}{1,i}=NaN;
            end
            LvR_out_S1{2, j}='15_02-stim';
            for k=j:length(LvR_out_S1)
                LvR_out_S1{1,k+1}=LVR{1,k};
                LvR_out_S1{2,k+1}=LVR{2,k};
            end
        elseif j==16 && LvR_out_S1{2, j}(:,7)~= 'b'
            LVR=LvR_out_S1;
            for i=1:16
                LvR_out_S1{1, j}{1,i}=NaN;
            end
            LvR_out_S1{2, j}='16_03-basal1';
            for k=j:length(LvR_out_S1)
                LvR_out_S1{1,k+1}=LVR{1,k};
                LvR_out_S1{2,k+1}=LVR{2,k};
            end
        elseif j==17 && LvR_out_S1{2, j}(:,7)~= 'b'
            LVR=LvR_out_S1;
            for i=1:16
                LvR_out_S1{1, j}{1,i}=NaN;
            end
            LvR_out_S1{2, j}='17_03-basal1';
            for k=j:length(LvR_out_S1)
                LvR_out_S1{1,k+1}=LVR{1,k};
                LvR_out_S1{2,k+1}=LVR{2,k};
            end
        elseif j==18 && LvR_out_S1{2, j}(:,9)~= '-'
            LVR=LvR_out_S1;
            for i=1:16
                LvR_out_S1{1, j}{1,i}=NaN;
            end
            LvR_out_S1{2, j}='18_03-cm';
            for k=j:length(LvR_out_S1)
                LvR_out_S1{1,k+1}=LVR{1,k};
                LvR_out_S1{2,k+1}=LVR{2,k};
            end
        elseif j==19 && LvR_out_S1{2, j}(:,9)~= '2'
            LVR=LvR_out_S1;
            for i=1:16
                LvR_out_S1{1, j}{1,i}=NaN;
            end
            LvR_out_S1{2, j}='19_03-cm2';
            for k=j:length(LvR_out_S1)
                LvR_out_S1{1,k+1}=LVR{1,k};
                LvR_out_S1{2,k+1}=LVR{2,k};
            end
        end
    end
end
%% Group All ordered Phases
for j = 1:length(LvR_out_S1)
    if length(LvR_out_S1{1, j})<16
        LvR_out_S1{1, j}{length(LvR_out_S1{1, j})+1}=NaN;
    end
    if LvR_out_S1{2, j}(:,7)== 'b'
        SPONT_AllPhases_S1(:,n) = cell2mat(LvR_out_S1{1, j}(:,:))';
        Group_LVR_S1_Spont(1,n)= LvR_out_S1(2,j);
        n=n+1;
    end
    %% Split Stimulation mode
    if j==1 || j==2 || j==6 || j==7 || j==16 || j==17
        if Split_stim==9||Split_stim==10||Split_stim==11||Split_stim==17||Split_stim==20||Split_stim==24||Split_stim==28 %OL: Reapeted Stimulation
            if LvR_out_S1{2, j}(:,7)== 'b'
                SPONT_RS_S1(:,r) = cell2mat(LvR_out_S1{1, j}(:,:))';
                RS_LVR_S1_Spont(1,r)= LvR_out_S1(2,j);
                r=r+1;
            end
        end
        if Split_stim==12 || Split_stim==13 ||Split_stim== 14 ||Split_stim== 15 || Split_stim==16 ||Split_stim== 18 ||Split_stim== 19 %OL: Exponential Stimulation
            if LvR_out_S1{2, j}(:,7)== 'b'
                SPONT_ES_S1(:,e) = cell2mat(LvR_out_S1{1, j}(:,:))';
                ES_LVR_S1_Spont(1,e)= LvR_out_S1(2,j);
                e=e+1;
            end
        end
        if Split_stim==21 ||Split_stim== 22 ||Split_stim== 26 ||Split_stim== 23 ||Split_stim== 25 ||Split_stim== 27 ||Split_stim== 29 ||Split_stim== 30 %OL: Shuffled Stimulation
            if LvR_out_RFA{2, j}(:,7)== 'b'
                SPONT_SS_S1(:,s) = cell2mat(LvR_out_S1{1, j}(:,:))';
                SS_LVR_S1_Spont(1,s)= LvR_out_S1(2,j);
                s=s+1;
            end
        end
    end
    LVR_All_Phases_S1(:,j) = cell2mat(LvR_out_S1{1,j}(:,:))';
end
LVR_Group_S1 = vertcat(LVR_Group_S1, LVR_All_Phases_S1);
SPONT_Group_LVR_S1=vertcat(SPONT_Group_LVR_S1,SPONT_AllPhases_S1);
GROUP_LVR_RS_S1=vertcat(GROUP_LVR_RS_S1,SPONT_RS_S1);
GROUP_LVR_ES_S1=vertcat(GROUP_LVR_ES_S1,SPONT_ES_S1);
GROUP_LVR_SS_S1=vertcat(GROUP_LVR_SS_S1,SPONT_SS_S1);

Group_LVR_RFA = LvR_out_RFA(2,:);
Group_LVR_S1  = LvR_out_S1(2,:);
end