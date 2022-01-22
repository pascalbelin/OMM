%% analyse data serveur
% 19 nov 2021

clear all; close all;
cd('C:\Users\pbeli\Documents\GitHub\OMM');
% start_date=datetime(2021,09,21,13,49,18); % début manip
% 21-Sep-2021 13:49:18

%% load excel file
[NUM0,TXT0,RAW0]=xlsread('data_20211119115608.csv');
%% analyse trial times
figure(1); hold on
I=find(NUM0(:,13)==1); % correct trials
ms=milliseconds(NUM0(I,73)); % time_new_touch_response
dates=start_date+ms; % date exacte de chaque trial
plot(dates, 'r-')

I=find(NUM1(:,13)==1); % correct trials
ms=milliseconds(NUM1(I,73)); % time_new_touch_response
dates=start_date+ms; % date exacte de chaque trial
plot(dates, 'b-')

