clc
clear
close all 

path = "data/";

loadE=readmatrix(path+'load.txt');
oxygenE=readmatrix(path+'oxygen.txt');
feedWaterFlowAE=readmatrix(path+'feedwater-flow-A.txt');
feedWaterFlowBE=readmatrix(path+'feedwater-flow-B.txt');
furnanceMasterE=readmatrix(path+'furnance-master.txt');
furnanceAE=readmatrix(path+'furnance-A.txt');
furnanceBE=readmatrix(path+'furnance-B.txt');
steamFlowE=readmatrix(path+'steam-flow.txt');
steamPressureE=readmatrix(path+'steam-pressure.txt');
steamTempE=readmatrix(path+'steam-temp.txt');
drumPR1E=readmatrix(path+'drum-PR1.txt');
drumPR2E=readmatrix(path+'drum-PR2.txt');
drumLVLE=readmatrix(path+'drum-LVL.txt');
leftAirFlowE=readmatrix(path+'left-air-flow.txt');
rightAirFlowE=readmatrix(path+'right-air-flow.txt');

path = "data-a/";

loadA=readmatrix(path+'load.txt');
oxygenA=readmatrix(path+'oxygen.txt');
feedWaterFlowAA=readmatrix(path+'feedwater-flow-A.txt');
feedWaterFlowBA=readmatrix(path+'feedwater-flow-B.txt');
furnanceMasterA=readmatrix(path+'furnance-master.txt');
furnanceAA=readmatrix(path+'furnance-A.txt');
furnanceBA=readmatrix(path+'furnance-B.txt');
steamFlowA=readmatrix(path+'steam-flow.txt');
steamPressureA=readmatrix(path+'steam-pressure.txt');
steamTempA=readmatrix(path+'steam-temp.txt');
drumPR1A=readmatrix(path+'drum-PR1.txt');
drumPR2A=readmatrix(path+'drum-PR2.txt');
drumLVLA=readmatrix(path+'drum-LVL.txt');
leftAirFlowA=readmatrix(path+'left-air-flow.txt');
rightAirFlowA=readmatrix(path+'right-air-flow.txt');


path = "data-f/";

loadF=readmatrix(path+'load.txt');
oxygenF=readmatrix(path+'oxygen.txt');
feedWaterFlowAF=readmatrix(path+'feedwater-flow-A.txt');
feedWaterFlowBF=readmatrix(path+'feedwater-flow-B.txt');
furnanceMasterF=readmatrix(path+'furnance-master.txt');
furnanceAF=readmatrix(path+'furnance-A.txt');
furnanceBF=readmatrix(path+'furnance-B.txt');
steamFlowF=readmatrix(path+'steam-flow.txt');
steamPressureF=readmatrix(path+'steam-pressure.txt');
steamTempF=readmatrix(path+'steam-temp.txt');
drumPR1F=readmatrix(path+'drum-PR1.txt');
drumPR2F=readmatrix(path+'drum-PR2.txt');
drumLVLF=readmatrix(path+'drum-LVL.txt');
leftAirFlowF=readmatrix(path+'left-air-flow.txt');
rightAirFlowF=readmatrix(path+'right-air-flow.txt');

furnanceMasterAll=[furnanceMasterA; furnanceMasterE; furnanceMasterF];
furnanceAAll=[furnanceAA; furnanceAE; furnanceAF];
furnanceBAll=[furnanceBA; furnanceBE; furnanceBF];

% concatenated variables
loadAll=[loadA;loadE;loadF];
drumLVLAll=[drumLVLA; drumLVLE; drumLVLF];
feedWaterFlowAAll=[feedWaterFlowAA;feedWaterFlowAE;feedWaterFlowAF];
feedWaterFlowBAll=[feedWaterFlowBA;feedWaterFlowBE;feedWaterFlowBF];

oxygenAll=[oxygenA; oxygenE; oxygenF];
rightAirFlowAll=[rightAirFlowA; rightAirFlowE; rightAirFlowF];
leftAirFlowAll=[leftAirFlowA; leftAirFlowE; leftAirFlowF];
drumPR1All = [drumPR1A; drumPR1E; drumPR1F];
drumPR2All = [drumPR2A; drumPR2E; drumPR2F];
steamPreassureAll=[steamPressureA;steamPressureE;steamPressureF];
steamFlowAll=[steamFlowA;steamFlowE;steamFlowF];

% ZMIENNE WAŻNE
% u
% (feedWaterFlowA+feedWaterFlowB)/2 furnanceMaster (furnanceA furnanceB)/2
% (rightAirFlow+leftAirFlow)/2  
% y
% drumLVL oxygen (drumPR1+drumPR2)/2   
% ZMIENNE POMINIĘTE
% load steamFlow steamPreasure steamTemp 

feedWaterAll= (feedWaterFlowAAll+feedWaterFlowBAll)/2;
furnLength=min([length(furnanceAAll), length(furnanceBAll)]);
furnanceAll=(furnanceAAll(1:furnLength) + furnanceBAll(1:furnLength))/2;
airFlowAll=(leftAirFlowAll+rightAirFlowAll)/2;


amount=min([length(feedWaterAll),length(furnanceAll),length(furnanceMasterAll), length(drumLVLAll), length(steamFlowAll), length(airFlowAll)]);

drumLVLAll=drumLVLAll(1:amount);
feedWaterAll=feedWaterAll(1:amount);
furnanceAll=furnanceAll(1:amount);
furnanceMasterAll=furnanceMasterAll(1:amount);
steamFlowAll=steamFlowAll(1:amount);
airFlowAll=airFlowAll(1:amount);


% feedWater=1:200;
% drumLVLE=1:200;
corLenght=6000;

corFeedWaterLevel=zeros(1,corLenght);
corFurnanceLevel=zeros(1,corLenght);
corFurnanceMasterLevel=zeros(1,corLenght);
corAirFlowLevel=zeros(1,corLenght);

corFeedWaterSteam=zeros(1,corLenght);
corFurnanceSteam=zeros(1,corLenght);
corFurnanceMasterSteam=zeros(1,corLenght);
corAirFlowSteam=zeros(1,corLenght);

corSteamFlowLevel=zeros(1,corLenght);

for i=1:corLenght
    %Level
    cor=corrcoef(feedWaterAll(1:(end-i+1)),drumLVLAll(i:end));
    corFeedWaterLevel(i)=cor(1,2);
    
    cor=corrcoef(furnanceAll(1:(end-i+1)),drumLVLAll(i:end));
    corFurnanceLevel(i)=cor(1,2);
    
    cor=corrcoef(furnanceMasterAll(1:(end-i+1)),drumLVLAll(i:end));
    corFurnanceMasterLevel(i)=cor(1,2);
        
    cor=corrcoef(airFlowAll(1:(end-i+1)),drumLVLAll(i:end));
    corAirFlowLevel(i)=cor(1,2);
    
    %Steam
    cor=corrcoef(feedWaterAll(1:(end-i+1)),steamFlowAll(i:end));
    corFeedWaterSteam(i)=cor(1,2);
    
    cor=corrcoef(furnanceAll(1:(end-i+1)),steamFlowAll(i:end));
    corFurnanceSteam(i)=cor(1,2);
    
    cor=corrcoef(furnanceMasterAll(1:(end-i+1)),steamFlowAll(i:end));
    corFurnanceMasterSteam(i)=cor(1,2);
    
    cor=corrcoef(airFlowAll(1:(end-i+1)),steamFlowAll(i:end));
    corAirFlowSteam(i)=cor(1,2);
    
    % steam- level  
    cor=corrcoef(steamFlowAll(1:(end-i+1)),drumLVLAll(i:end));
    corSteamFlowLevel(i)=cor(1,2);
end

plotVariable(corFeedWaterLevel)
plotVariable(corFurnanceLevel)
plotVariable(corFurnanceMasterLevel)

plotVariable(corFeedWaterSteam)
plotVariable(corFurnanceSteam)
plotVariable(corFurnanceMasterSteam)

plotVariable(corSteamFlowLevel)
% 
% plotVariable(steamFlowAll)
% plotVariable(furnanceMasterAll)
% plotVariable(furnanceAll)
% plotVariable(feedWaterAll)
% plotVariable(drumLVLAll)
% plotVariable(airFlowAll)

function plotVariable(variable)
    variableMean=movmean(variable,200);
    figure
    plot(variable,'c')
    hold on
    plot(variableMean,'b')
    title(inputname(1));
    legend(inputname(1),inputname(1)+ " mean", 'Location','best')
    hold off
end

function plotTwoVariables(variable1, variable2)
    variableMean1=movmean(variable1,200);
    variableMean2=movmean(variable2,200);
convertCharsToStrings(inputname(1))
    figure
    plot(variable1,'c')
    hold on
    plot(variableMean1,'b')
    hold on
    plot(variable2,'y')
    hold on
    plot(variableMean2,'r')
    title(convertCharsToStrings(inputname(1))+newline+ convertCharsToStrings(inputname(2)));
    legend(inputname(1),inputname(1)+ " mean",inputname(2),inputname(2)+ " mean", 'Location','best')
    hold off
end