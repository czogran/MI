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

% ZMIENNE WAŻNE
% u
% (feedWaterFlowA+feedWaterFlowB)/2 furnanceMaster (furnanceA furnanceB)/2
% (rightAirFlow+leftAirFlow)/2  
% y
% drumLVL oxygen (drumPR1+drumPR2)/2   
% ZMIENNE POMINIĘTE
% load steamFlow steamPreasure steamTemp 

feedWater= (feedWaterFlowAE+feedWaterFlowBE)/2;
furnance=(furnanceAE + furnanceBE)/2;
airFlow=(rightAirFlowE+leftAirFlowE)/2;

amount=min([length(feedWater),length(furnance),length(furnanceMasterE), length(drumLVLE), length(steamFlowE), length(airFlow)]);

drumLVLE=drumLVLE(1:amount);
feedWater=feedWater(1:amount);
furnance=furnance(1:amount);
furnanceMasterE=furnanceMasterE(1:amount);
steamFlowE=steamFlowE(1:amount);
airFlow=airFlow(1:amount);


% feedWater=1:200;
% drumLVLE=1:200;
corLenght=6000;

correlationFeedWaterToDrumLevel=zeros(1,corLenght);
correlationFurnanceToDrumLevel=zeros(1,corLenght);
correlationFurnanceMasterToDrumLevel=zeros(1,corLenght);
correlationAirFlowToDrumLevel=zeros(1,corLenght);

correlationFeedWaterToSteamFlow=zeros(1,corLenght);
correlationFurnanceToSteamFlow=zeros(1,corLenght);
correlationFurnanceMasterToSteamFlow=zeros(1,corLenght);
correlationAirFlowToSteamFlow=zeros(1,corLenght);

correlationSteamFlowToDrumLevel=zeros(1,corLenght);

for i=1:corLenght
    %Level
    cor=corrcoef(feedWater(1:(end-i+1)),drumLVLE(i:end));
    correlationFeedWaterToDrumLevel(i)=cor(1,2);
    
    cor=corrcoef(furnance(1:(end-i+1)),drumLVLE(i:end));
    correlationFurnanceToDrumLevel(i)=cor(1,2);
    
    cor=corrcoef(furnanceMasterE(1:(end-i+1)),drumLVLE(i:end));
    correlationFurnanceMasterToDrumLevel(i)=cor(1,2);
    
    cor=corrcoef(airFlow(1:(end-i+1)),drumLVLE(i:end));
    correlationAirFlowToDrumLevel(i)=cor(1,2);
    
    %Steam
    cor=corrcoef(feedWater(1:(end-i+1)),steamFlowE(i:end));
    correlationFeedWaterToSteamFlow(i)=cor(1,2);
    
    cor=corrcoef(furnance(1:(end-i+1)),steamFlowE(i:end));
    correlationFurnanceToSteamFlow(i)=cor(1,2);
    
    cor=corrcoef(furnanceMasterE(1:(end-i+1)),steamFlowE(i:end));
    correlationFurnanceMasterToSteamFlow(i)=cor(1,2);
    
    cor=corrcoef(airFlow(1:(end-i+1)),steamFlowE(i:end));
    correlationAirFlowToSteamFlow(i)=cor(1,2);
    
    
    
    cor=corrcoef(steamFlowE(1:(end-i+1)),drumLVLE(i:end));
    correlationSteamFlowToDrumLevel(i)=cor(1,2);
end

plotVariable(correlationFeedWaterToDrumLevel)
plotVariable(correlationFurnanceToDrumLevel)
plotVariable(correlationFurnanceMasterToDrumLevel)
plotVariable(correlationAirFlowToDrumLevel)

plotVariable(correlationFeedWaterToSteamFlow)
plotVariable(correlationFurnanceToSteamFlow)
plotVariable(correlationFurnanceMasterToSteamFlow)
plotVariable(correlationAirFlowToSteamFlow)

plotVariable(correlationSteamFlowToDrumLevel)

function plotVariable(variable)
    variableMean=movmean(variable,200);
    figure
    plot(variable,'c')
    hold on
    plot(variableMean,'b')
    title(inputname(1));
    legend(inputname(1),inputname(1)+ " mean", 'Location','best')
    xlabel("opóźnienie czasowe")
    hold off
    saveas(gcf,"docs/cor-e/"+inputname(1)+".png")

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