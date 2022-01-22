%% analyse data serveur
% 19 nov 2021

clear all; close all;
cd('C:\Users\pbeli\Documents\GitHub\OMM');
% start_date=datetime(2021,09,21,13,49,18); % début manip
% 21-Sep-2021 13:49:18

%% load excel file
[NUM0,TXT0,RAW0]=xlsread('data_20211124132825.csv');
% données Maurice 80 essais le 24/11/21 sur exp : OMMBackgroundTaskv5
% col 7: accuracy 0-100 (correct touch of the image)
% col 12: response (number of screen part touched (corrects are 6,7,10,11), or 'None' if no touch
% col 13: timestamp - text but seems the most relaible time marker - use
% 'datetime' to read
% col 16: Response Time (between display of screen and touch response -
% time out 3s)
%% visualize trial times
T=datetime(TXT0(2:end,13)); % skip 1st line
[TT,I] = sort(T);
figure(1); 
plot(TT, NUM0(I,7),'*');

%% display RT histogram for correct and incorrect
figure (2);
hist(NUM0(find(NUM0(:,22)==1),16), 20);

%% calculate percent correct
N=length(NUM0); % N essais
PCcorrect=100*length(find(NUM0(:,22)==1))/N;

%% calculate proportion of touch when detected
J=find(isnan(NUM0(:,12))); % number of time out (no touch)
PCtouch=100*(N-length(J))/N;
