%% generate stim Task 4

close all; clear all
cd('C:\Users\pbeli\Documents\GitHub\OMM\stimuli_Task4')

%% load 16 mobjects and plot coos in f0-F1
f0=zeros(1,16); F1=zeros(1,16);
mobjs=cell(1,16);
figure; hold on
xlabel('F0'); ylabel('F1'); title('16 coos in f0-F1 space');
for k=1:16
    if k>9 S=''; else S=num2str(0); end
    load (['C:\AMUBOX\STIMULI-EXPS\COO_MORPH\original_coos\NORMCoo_',S,num2str(k),'.mat']);
    mobjs{1,k}=mObject;
    f0(1,k)=mean(mObject.F0);
    F1(1,k)=mObject.anchorFrequency(1,1);
    plot(f0(1,k), F1(1,k),'o'); text (f0(1,k), F1(1,k),['Coo_',S,num2str(k)]);
end
plot(mean(f0), mean(F1),'r*'); text(mean(f0), mean(F1),'AVG')

%%  generate average (target - Avg16.wav)
we=ones(1,16)/16; % vector of mObjects weights all 16 same weight
rates.F0=we;  rates.spectralamplitude=we; rates.aperiodicity=we; rates.time=we; rates.frequency=we;
fs=mobjs{1,1}.samplingFrequency;
mObjectM=voicemultimorph(mobjs,rates);
sy=executeSTRAIGHTsynthesisM(mObjectM);
sy=.95*sy/max(abs(sy)); % normalise
audiowrite('Avg16.wav',sy,fs);
save ('avg16.mat','mObjectM');

%% generate resynthesized Coos at average duration

for kk=1:16 %
    if kk==1 we=[1 zeros(1,15)];
    elseif kk==16 we=[zeros(1,15) 1];
    else we=[zeros(1,kk-1) 1 zeros(1,16-kk)];
    end
    rates.F0=we;  rates.spectralamplitude=we; rates.aperiodicity=we;  rates.frequency=we;
    rates.time=ones(1,16)/16; % same average duration for all morphs
    mObjectM=voicemultimorph(mobjs,rates);    sy=executeSTRAIGHTsynthesisM(mObjectM);
    sy=.95*sy/max(abs(sy)); % normalise
    if kk>9 X='';
    else X='0';
    end
    audiowrite(['Coo_',X,num2str(kk),'.wav'],sy,mObjectM.samplingFrequency);
end



%% Generate continua Avg-Coo for coos 08, 12, 15 and 16 - relatively far form Avg in different directions

for kk=[8 12 15 16] % coo Id number    4 IDs
    for k= [.25 .5 .75 ] % 3 stim per continuum
        we=[ones(1,kk-1)*(1-k)/16, k+(1-k)/16, ones(1,16-kk)*(1-k)/16];
        rates.F0=we;  rates.spectralamplitude=we; rates.aperiodicity=we;  rates.frequency=we;
        rates.time=ones(1,16)/16; % same average duration for all morphs
        mObjectM=voicemultimorph(mobjs,rates);
        sy=executeSTRAIGHTsynthesisM(mObjectM);
        sy=.95*sy/max(abs(sy)); % normalise
        if kk>9 X=''; 
            else X='0';
        end
        audiowrite(['Coo_',X,num2str(kk),'_',num2str(100*k),'.wav'],sy,mObjectM.samplingFrequency);
    end
end

%% generate Avgf0 - Coos 12 et 15

for kk=[12 15] % 
    for k= [.25 .5 .75 1] % 4 stim per continuum
        we=[ones(1,kk-1)*(1-k)/16, k+(1-k)/16, ones(1,16-kk)*(1-k)/16];
        rates.spectralamplitude=we; rates.aperiodicity=we;  rates.frequency=we;
        rates.time=ones(1,16)/16; % same average duration for all morphs
        rates.F0=ones(1,16)/16; % average f0
        mObjectM=voicemultimorph(mobjs,rates);
        sy=executeSTRAIGHTsynthesisM(mObjectM);
        sy=.95*sy/max(abs(sy)); % normalise
        if kk>9 X=''; 
            else X='0';
        end
        audiowrite(['Coo_',X,num2str(kk),'_Avgf0_',num2str(100*k),'.wav'],sy,mObjectM.samplingFrequency);
    end
end

%% generate AvgF - Coos 12 et 15

for kk=[12 15] % 
    for k= [.25 .5 .75 1] % 4 stim per continuum
        we=[ones(1,kk-1)*(1-k)/16, k+(1-k)/16, ones(1,16-kk)*(1-k)/16];
        rates.spectralamplitude=we; rates.aperiodicity=we;  rates.F0=we;
        rates.time=ones(1,16)/16; % same average duration for all morphs
        rates.requency=ones(1,16)/16; % average F
        mObjectM=voicemultimorph(mobjs,rates);
        sy=executeSTRAIGHTsynthesisM(mObjectM);
        sy=.95*sy/max(abs(sy)); % normalise
        if kk>9 X=''; 
            else X='0';
        end
        audiowrite(['Coo_',X,num2str(kk),'_AvgF_',num2str(100*k),'.wav'],sy,mObjectM.samplingFrequency);
    end
end
