function [Group_MFR_RFA,MFR_Group_RFA,SPONT_Group_RFA,Group_MFR_RFA_Spont,GROUP_RS_RFA,GROUP_ES_RFA,GROUP_SS_RFA,Group_MFR_S1,MFR_Group_S1,SPONT_Group_S1,Group_MFR_S1_Spont,GROUP_RS_S1,GROUP_ES_S1,GROUP_SS_S1]= MFR_group(exp_folder,Num_Exp,MFR_Group_RFA,SPONT_Group_RFA,GROUP_RS_RFA,GROUP_ES_RFA,GROUP_SS_RFA,MFR_Group_S1,SPONT_Group_S1,GROUP_RS_S1,GROUP_ES_S1,GROUP_SS_S1)

[MFR_All_Phases_RFA,SPONT_AllPhases_RFA,SPONT_RS_RFA,~,SPONT_ES_RFA,~,SPONT_SS_RFA,~,~,~,n,r,e,s]=define_ResGroup;
load(fullfile(exp_folder,[Num_Exp,'_MFR_Original.mat']))
Split_stim=str2num(Num_Exp(end-1:end));
%% RFA
%% Order Phases in Experiments without some phase
if length(mfr_RFA)<19
    for j=1:19
        if j==1 && mfr_RFA{2, j}(:,12)~= '1'
            MfR=mfr_RFA;
            mfr_RFA{1, j}(1:16,:)=NaN;
            mfr_RFA{2, j}='01_00-basal1';
            for k=j:length(mfr_RFA)
                mfr_RFA{1,k+1}=MfR{1,k};
                mfr_RFA{2,k+1}=MfR{2,k};
            end
        elseif j==2 && mfr_RFA{2, j}(:,12)~= '1'
            MfR=mfr_RFA;
            mfr_RFA{1, j}(1:16,:)=NaN;
            mfr_RFA{2, j}='02_00-basal1';
            for k=j:length(mfr_RFA)
                mfr_RFA{1,k+1}=MfR{1,k};
                mfr_RFA{2,k+1}=MfR{2,k};
            end
        elseif j==3 && mfr_RFA{2, j}(:,12)~= '2'
            MfR=mfr_RFA;
            mfr_RFA{1, j}(1:16,:)=NaN;
            mfr_RFA{2, j}='03_00-basal2';
            for k=j:length(mfr_RFA)
                mfr_RFA{1,k+1}=MfR{1,k};
                mfr_RFA{2,k+1}=MfR{2,k};
            end
        elseif j==4 && mfr_RFA{2, j}(:,9)~= '-'
            MfR=mfr_RFA;
            mfr_RFA{1, j}(1:16,:)=NaN;
            mfr_RFA{2, j}='04_00-cm';
            for k=j:length(mfr_RFA)
                mfr_RFA{1,k+1}=MfR{1,k};
                mfr_RFA{2,k+1}=MfR{2,k};
            end
        elseif j==5 && mfr_RFA{2, j}(:,9)~= '2'
            MfR=mfr_RFA;
            mfr_RFA{1, j}(1:16,:)=NaN;
            mfr_RFA{2, j}='05_00-cm2';
            for k=j:length(mfr_RFA)
                mfr_RFA{1,k+1}=MfR{1,k};
                mfr_RFA{2,k+1}=MfR{2,k};
            end
        elseif j==6 && mfr_RFA{2, j}(:,12)~= '1'
            MfR=mfr_RFA;
            mfr_RFA{1, j}(1:16,:)=NaN;
            mfr_RFA{2, j}='06_01-basal1';
            for k=j:length(mfr_RFA)
                mfr_RFA{1,k+1}=MfR{1,k};
                mfr_RFA{2,k+1}=MfR{2,k};
            end
        elseif j==7 &&mfr_RFA{2, j}(:,12)~= '1'
            MfR=mfr_RFA;
            mfr_RFA{1, j}(1:16,:)=NaN;
            mfr_RFA{2, j}='07_01-basal1';
            for k=j:length(mfr_RFA)
                mfr_RFA{1,k+1}=MfR{1,k};
                mfr_RFA{2,k+1}=MfR{2,k};
            end
        elseif j==8 && mfr_RFA{2, j}(:,9)~= '-'
            MfR=mfr_RFA;
            mfr_RFA{1, j}(1:16,:)=NaN;
            mfr_RFA{2, j}='08_01-cm';
            for k=j:length(mfr_RFA)
                mfr_RFA{1,k+1}=MfR{1,k};
                mfr_RFA{2,k+1}=MfR{2,k};
            end
        elseif j==9 && mfr_RFA{2, j}(:,9)~= '2'
            MfR=mfr_RFA;
            mfr_RFA{1, j}(1:16,:)=NaN;
            mfr_RFA{2, j}='09_01-cm2';
            for k=j:length(mfr_RFA)
                mfr_RFA{1,k+1}=MfR{1,k};
                mfr_RFA{2,k+1}=MfR{2,k};
            end
        elseif j==10 && mfr_RFA{2, j}(:,7)~= 's'
            MfR=mfr_RFA;
            mfr_RFA{1, j}(1:16,:)=NaN;
            mfr_RFA{2, j}='10_02-stim';
            for k=j:length(mfr_RFA)
                mfr_RFA{1,k+1}=MfR{1,k};
                mfr_RFA{2,k+1}=MfR{2,k};
            end
        elseif j==11 && mfr_RFA{2, j}(:,7)~= 's'
            MfR=mfr_RFA;
            mfr_RFA{1, j}(1:16,:)=NaN;
            mfr_RFA{2, j}='11_02-stim';
            for k=j:length(mfr_RFA)
                mfr_RFA{1,k+1}=MfR{1,k};
                mfr_RFA{2,k+1}=MfR{2,k};
            end
        elseif j==12 && mfr_RFA{2, j}(:,7)~= 's'
            MfR=mfr_RFA;
            mfr_RFA{1, j}(1:16,:)=NaN;
            mfr_RFA{2, j}='12_02-stim';
            for k=j:length(mfr_RFA)
                mfr_RFA{1,k+1}=MfR{1,k};
                mfr_RFA{2,k+1}=MfR{2,k};
            end
        elseif j==13 && mfr_RFA{2, j}(:,7)~= 's'
            MfR=mfr_RFA;
            mfr_RFA{1, j}(1:16,:)=NaN;
            mfr_RFA{2, j}='13_02-stim';
            for k=j:length(mfr_RFA)
                mfr_RFA{1,k+1}=MfR{1,k};
                mfr_RFA{2,k+1}=MfR{2,k};
            end
        elseif j==14 && mfr_RFA{2, j}(:,7)~= 's'
            MfR=mfr_RFA;
            mfr_RFA{1, j}(1:16,:)=NaN;
            mfr_RFA{2, j}='14_02-stim';
            for k=j:length(mfr_RFA)
                mfr_RFA{1,k+1}=MfR{1,k};
                mfr_RFA{2,k+1}=MfR{2,k};
            end
        elseif j==15 && mfr_RFA{2, j}(:,7)~= 's'
            MfR=mfr_RFA;
            mfr_RFA{1, j}(1:16,:)=NaN;
            mfr_RFA{2, j}='15_02-stim';
            for k=j:length(mfr_RFA)
                mfr_RFA{1,k+1}=MfR{1,k};
                mfr_RFA{2,k+1}=MfR{2,k};
            end
        elseif j==16 && mfr_RFA{2, j}(:,7)~= 'b'
            MfR=mfr_RFA;
            mfr_RFA{1, j}(1:16,:)=NaN;
            mfr_RFA{2, j}='16_03-basal1';
            for k=j:length(mfr_RFA)
                mfr_RFA{1,k+1}=MfR{1,k};
                mfr_RFA{2,k+1}=MfR{2,k};
            end
        elseif j==17 && mfr_RFA{2, j}(:,7)~= 'b'
            MfR=mfr_RFA;
            mfr_RFA{1, j}(1:16,:)=NaN;
            mfr_RFA{2, j}='17_03-basal1';
            for k=j:length(mfr_RFA)
                mfr_RFA{1,k+1}=MfR{1,k};
                mfr_RFA{2,k+1}=MfR{2,k};
            end
        elseif j==18 && mfr_RFA{2, j}(:,9)~= '-'
            MfR=mfr_RFA;
            mfr_RFA{1, j}(1:16,:)=NaN;
            mfr_RFA{2, j}='18_03-cm';
            for k=j:length(mfr_RFA)
                mfr_RFA{1,k+1}=MfR{1,k};
                mfr_RFA{2,k+1}=MfR{2,k};
            end
        elseif j==19 && mfr_RFA{2, j}(:,9)~= '2'
            MfR=mfr_RFA;
            mfr_RFA{1, j}(1:16,:)=NaN;
            mfr_RFA{2, j}='19_03-cm2';
            for k=j:length(mfr_RFA)
                mfr_RFA{1,k+1}=MfR{1,k};
                mfr_RFA{2,k+1}=MfR{2,k};
            end
        end
    end
end
%% Group All ordered Phases
for j = 1:length(mfr_RFA)
    if length(mfr_RFA{1, j})<16
        mfr_RFA{1, j}(length(mfr_RFA{1, j})+1,:)=NaN;
    end
    if mfr_RFA{2, j}(:,7)== 'b'
        SPONT_AllPhases_RFA(:,n) = mfr_RFA{1, j}(:,3:2:end);
        Group_MFR_RFA_Spont(1,n)= mfr_RFA(2,j);
        n=n+1;
    end
    %% Split Stimulation mode
    if j==1 || j==2 || j==6 || j==7 || j==16 || j==17
        if Split_stim==9||Split_stim==10||Split_stim==11||Split_stim==17||Split_stim==20||Split_stim==24||Split_stim==28 %OL: Reapeted Stimulation
            if mfr_RFA{2, j}(:,7)== 'b'
                SPONT_RS_RFA(:,r) = mfr_RFA{1, j}(:,3:2:end);
                RS_MFR_RFA_Spont(1,r)= mfr_RFA(2,j);
                r=r+1;
            end
        end
        if Split_stim==12 || Split_stim==13 ||Split_stim== 14 ||Split_stim== 15 || Split_stim==16 ||Split_stim== 18 ||Split_stim== 19 %OL: Exponential Stimulation
            if mfr_RFA{2, j}(:,7)== 'b'
                SPONT_ES_RFA(:,e) = mfr_RFA{1, j}(:,3:2:end);
                ES_MFR_RFA_Spont(1,e)= mfr_RFA(2,j);
                e=e+1;
            end
        end
        if Split_stim==21 ||Split_stim== 22 ||Split_stim== 26 ||Split_stim== 23 ||Split_stim== 25 ||Split_stim== 27 ||Split_stim== 29 ||Split_stim== 30 %OL: Shuffled Stimulation
            if mfr_RFA{2, j}(:,7)== 'b'
                SPONT_SS_RFA(:,s) = mfr_RFA{1, j}(:,3:2:end);
                SS_MFR_RFA_Spont(1,s)= mfr_RFA(2,j);
                s=s+1;
            end
        end
    end
    MFR_All_Phases_RFA(:,j) = mfr_RFA{1,j}(:,3:2:end);
end
MFR_Group_RFA = vertcat(MFR_Group_RFA, MFR_All_Phases_RFA);
SPONT_Group_RFA=vertcat(SPONT_Group_RFA,SPONT_AllPhases_RFA);
GROUP_RS_RFA=vertcat(GROUP_RS_RFA,SPONT_RS_RFA);
GROUP_ES_RFA=vertcat(GROUP_ES_RFA,SPONT_ES_RFA);
GROUP_SS_RFA=vertcat(GROUP_SS_RFA,SPONT_SS_RFA);

clear n r e s 
%% S1
[MFR_All_Phases_S1,SPONT_AllPhases_S1,SPONT_RS_S1,~,SPONT_ES_S1,~,SPONT_SS_S1,~,~,~,n,r,e,s]=define_ResGroup;
%% Order Phases in Experiments without some phase
if length(mfr_S1)<19
    for j=1:19
        if j==1 && mfr_S1{2, j}(:,12)~= '1'
            MfR=mfr_S1;
            mfr_S1{1, j}(1:16,:)=NaN;
            mfr_S1{2, j}='01_00-basal1';
            for k=j:length(mfr_S1)
                mfr_S1{1,k+1}=MfR{1,k};
                mfr_S1{2,k+1}=MfR{2,k};
            end
        elseif j==2 && mfr_S1{2, j}(:,12)~= '1'
            MfR=mfr_S1;
            mfr_S1{1, j}(1:16,:)=NaN;
            mfr_S1{2, j}='02_00-basal1';
            for k=j:length(mfr_S1)
                mfr_S1{1,k+1}=MfR{1,k};
                mfr_S1{2,k+1}=MfR{2,k};
            end
        elseif j==3 && mfr_S1{2, j}(:,12)~= '2'
            MfR=mfr_S1;
            mfr_S1{1, j}(1:16,:)=NaN;
            mfr_S1{2, j}='03_00-basal2';
            for k=j:length(mfr_S1)
                mfr_S1{1,k+1}=MfR{1,k};
                mfr_S1{2,k+1}=MfR{2,k};
            end
        elseif j==4 && mfr_S1{2, j}(:,9)~= '-'
            MfR=mfr_S1;
            mfr_S1{1, j}(1:16,:)=NaN;
            mfr_S1{2, j}='04_00-cm';
            for k=j:length(mfr_S1)
                mfr_S1{1,k+1}=MfR{1,k};
                mfr_S1{2,k+1}=MfR{2,k};
            end
        elseif j==5 && mfr_S1{2, j}(:,9)~= '2'
            MfR=mfr_S1;
            mfr_S1{1, j}(1:16,:)=NaN;
            mfr_S1{2, j}='05_00-cm2';
            for k=j:length(mfr_S1)
                mfr_S1{1,k+1}=MfR{1,k};
                mfr_S1{2,k+1}=MfR{2,k};
            end
        elseif j==6 && mfr_S1{2, j}(:,12)~= '1'
            MfR=mfr_S1;
            mfr_S1{1, j}(1:16,:)=NaN;
            mfr_S1{2, j}='06_01-basal1';
            for k=j:length(mfr_S1)
                mfr_S1{1,k+1}=MfR{1,k};
                mfr_S1{2,k+1}=MfR{2,k};
            end
        elseif j==7 && mfr_S1{2, j}(:,12)~= '1'
            MfR=mfr_S1;
            mfr_S1{1, j}(1:16,:)=NaN;
            mfr_S1{2, j}='07_01-basal1';
            for k=j:length(mfr_S1)
                mfr_S1{1,k+1}=MfR{1,k};
                mfr_S1{2,k+1}=MfR{2,k};
            end
        elseif j==8 && mfr_S1{2, j}(:,9)~= '-'
            MfR=mfr_S1;
            mfr_S1{1, j}(1:16,:)=NaN;
            mfr_S1{2, j}='08_01-cm';
            for k=j:length(mfr_S1)
                mfr_S1{1,k+1}=MfR{1,k};
                mfr_S1{2,k+1}=MfR{2,k};
            end
        elseif j==9 && mfr_S1{2, j}(:,9)~= '2'
            MfR=mfr_S1;
            mfr_S1{1, j}(1:16,:)=NaN;
            mfr_S1{2, j}='09_01-cm2';
            for k=j:length(mfr_S1)
                mfr_S1{1,k+1}=MfR{1,k};
                mfr_S1{2,k+1}=MfR{2,k};
            end
        elseif j==10 && mfr_S1{2, j}(:,7)~= 's'
            MfR=mfr_S1;
            mfr_S1{1, j}(1:16,:)=NaN;
            mfr_S1{2, j}='10_02-stim';
            for k=j:length(mfr_S1)
                mfr_S1{1,k+1}=MfR{1,k};
                mfr_S1{2,k+1}=MfR{2,k};
            end
        elseif j==11 && mfr_S1{2, j}(:,7)~= 's'
            MfR=mfr_S1;
            mfr_S1{1, j}(1:16,:)=NaN;
            mfr_S1{2, j}='11_02-stim';
            for k=j:length(mfr_S1)
                mfr_S1{1,k+1}=MfR{1,k};
                mfr_S1{2,k+1}=MfR{2,k};
            end
        elseif j==12 && mfr_S1{2, j}(:,7)~= 's'
            MfR=mfr_S1;
            mfr_S1{1, j}(1:16,:)=NaN;
            mfr_S1{2, j}='12_02-stim';
            for k=j:length(mfr_S1)
                mfr_S1{1,k+1}=MfR{1,k};
                mfr_S1{2,k+1}=MfR{2,k};
            end
        elseif j==13 && mfr_S1{2, j}(:,7)~= 's'
            MfR=mfr_S1;
            mfr_S1{1, j}(1:16,:)=NaN;
            mfr_S1{2, j}='13_02-stim';
            for k=j:length(mfr_S1)
                mfr_S1{1,k+1}=MfR{1,k};
                mfr_S1{2,k+1}=MfR{2,k};
            end
        elseif j==14 && mfr_S1{2, j}(:,7)~= 's'
            MfR=mfr_S1;
            mfr_S1{1, j}(1:16,:)=NaN;
            mfr_S1{2, j}='14_02-stim';
            for k=j:length(mfr_S1)
                mfr_S1{1,k+1}=MfR{1,k};
                mfr_S1{2,k+1}=MfR{2,k};
            end
        elseif j==15 && mfr_S1{2, j}(:,7)~= 's'
            MfR=mfr_S1;
            mfr_S1{1, j}(1:16,:)=NaN;
            mfr_S1{2, j}='15_02-stim';
            for k=j:length(mfr_S1)
                mfr_S1{1,k+1}=MfR{1,k};
                mfr_S1{2,k+1}=MfR{2,k};
            end
        elseif j==16 && mfr_S1{2, j}(:,7)~= 'b'
            MfR=mfr_S1;
            mfr_S1{1, j}(1:16,:)=NaN;
            mfr_S1{2, j}='16_03-basal1';
            for k=j:length(mfr_S1)
                mfr_S1{1,k+1}=MfR{1,k};
                mfr_S1{2,k+1}=MfR{2,k};
            end
        elseif j==17 && mfr_S1{2, j}(:,7)~= 'b'
            MfR=mfr_S1;
            mfr_S1{1, j}(1:16,:)=NaN;
            mfr_S1{2, j}='17_03-basal1';
            for k=j:length(mfr_S1)
                mfr_S1{1,k+1}=MfR{1,k};
                mfr_S1{2,k+1}=MfR{2,k};
            end
        elseif j==18 && mfr_S1{2, j}(:,9)~= '-'
            MfR=mfr_S1;
            mfr_S1{1, j}(1:16,:)=NaN;
            mfr_S1{2, j}='18_03-cm';
            for k=j:length(mfr_S1)
                mfr_S1{1,k+1}=MfR{1,k};
                mfr_S1{2,k+1}=MfR{2,k};
            end
        elseif j==19 && mfr_S1{2, j}(:,9)~= '2'
            MfR=mfr_S1;
            mfr_S1{1, j}(1:16,:)=NaN;
            mfr_S1{2, j}='19_03-cm2';
            for k=j:length(mfr_S1)
                mfr_S1{1,k+1}=MfR{1,k};
                mfr_S1{2,k+1}=MfR{2,k};
            end
        end
    end
end
%% Group All ordered Phases
for j = 1:length(mfr_S1)
    if length(mfr_S1{1, j})<16
        mfr_S1{1, j}(length(mfr_S1{1, j})+1,:)=NaN;
    end
    if mfr_S1{2, j}(:,7)== 'b'
        SPONT_AllPhases_S1(:,n) = mfr_S1{1, j}(:,3:2:end);
        Group_MFR_S1_Spont(1,n)=mfr_S1(2,j);
        n=n+1;
    end
    %% Split Stimulation mode
    if j==1 || j==2 || j==6 || j==7 || j==16 || j==17
        if Split_stim==9||Split_stim==10||Split_stim==11||Split_stim==17||Split_stim==20||Split_stim==24||Split_stim==28 %OL: Reapeted Stimulation
            if mfr_S1{2, j}(:,7)== 'b'
                SPONT_RS_S1(:,r) = mfr_S1{1, j}(:,3:2:end);
                RS_MFR_S1_Spont(1,r)= mfr_S1(2,j);
                r=r+1;
            end
        end
        if Split_stim==12 || Split_stim==13 ||Split_stim== 14 ||Split_stim== 15 || Split_stim==16 ||Split_stim== 18 ||Split_stim== 19 %OL: Exponential Stimulation
            if mfr_S1{2, j}(:,7)== 'b'
                SPONT_ES_S1(:,e) = mfr_S1{1, j}(:,3:2:end);
                ES_MFR_S1_Spont(1,e)= mfr_S1(2,j);
                e=e+1;
            end
        end
        if Split_stim==21 ||Split_stim== 22 ||Split_stim== 26 ||Split_stim== 23 ||Split_stim== 25 ||Split_stim== 27 ||Split_stim== 29 ||Split_stim== 30 %OL: Shuffled Stimulation
            if mfr_RFA{2, j}(:,7)== 'b'
                SPONT_SS_S1(:,s) = mfr_S1{1, j}(:,3:2:end);
                SS_MFR_S1_Spont(1,s)= mfr_S1(2,j);
                s=s+1;
            end
        end
    end
    MFR_All_Phases_S1(:,j) = mfr_S1{1,j}(:,3:2:end);
end
MFR_Group_S1 = vertcat(MFR_Group_S1, MFR_All_Phases_S1);
SPONT_Group_S1=vertcat(SPONT_Group_S1,SPONT_AllPhases_S1);
GROUP_RS_S1=vertcat(GROUP_RS_S1,SPONT_RS_S1);
GROUP_ES_S1=vertcat(GROUP_ES_S1,SPONT_ES_S1);
GROUP_SS_S1=vertcat(GROUP_SS_S1,SPONT_SS_S1);

Group_MFR_RFA = mfr_RFA(2,:);
Group_MFR_S1  = mfr_S1(2,:);
end