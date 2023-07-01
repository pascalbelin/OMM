%% generation stimuli for Task2v4

clear all; close all;
cd ('C:\Users\pbeli\Documents\GitHub\OMM');

%% load MObjects
mobjs=cell(1,2);
load ('C:\AMUBOX\STIMULI-EXPS\COO_MORPH\original_coos\NORMCoo_01.mat'); mobjs{1,1}=mObject;
load ('C:\AMUBOX\STIMULI-EXPS\COO_MORPH\original_coos\NORMCoo_03.mat'); mobjs{1,2}=mObject;

%% generate average
% define weight of each mobject in the interporaltion (here 50/50)
rates.F0=[0.5 0.5]; 
rates.spectralamplitude=[0.5 0.5];
rates.aperiodicity=[0.5 0.5];
rates.time=[0.5 0.5];
rates.frequency=[0.5 0.5];

% execute interpolation
mObjectM=voicemultimorph(mobjs,rates);
sy=executeSTRAIGHTsynthesisM(mObjectM); 
sy=.95*sy/max(abs(sy)); % normalise
audiowrite('Hybrid_f0avf_Favg.wav',sy,22050);

%% generate hybrid f0_Coo1 F_Coo3
% define weight of each mobject in the interporaltion (here 50/50)
rates.F0=[.75 .25]; 
rates.spectralamplitude=[.75 .25];
rates.aperiodicity=[.75 .25];
rates.time=[.75 .25];
rates.frequency=[.75 .25];

% execute interpolation
mObjectM=voicemultimorph(mobjs,rates);
sy=executeSTRAIGHTsynthesisM(mObjectM); 
sy=.95*sy/max(abs(sy)); % normalise
audiowrite('Hybrid_f25_F25.wav',sy,22050);
