%% analyse premiere semaine module 1

clear all; close all;
cd('C:\AMUBOX\Shared\Projet Covoprim_Rousset');
start_date=datetime(2021,09,21,13,49,18); % début manip
% 21-Sep-2021 13:49:18

%% load excel file
[NUM0,TXT0,RAW0]=xlsread('subject-0.csv');
[NUM1,TXT1,RAW1]=xlsread('subject-1.csv');
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

