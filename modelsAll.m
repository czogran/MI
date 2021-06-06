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


% simple model
feedWaterSimple=(feedWaterAll(1:(end-205))-311)*1.3;
drumLVLSimple=drumLVLAll(205:end);
plotTwoVariables(feedWaterSimple,drumLVLSimple)

% medium model
feedWaterMedium=(feedWaterAll(1:(end-205))-311)*1.3;
steamFlowMedium=-(steamFlowAll(1:end-205)-338)*1.2;
modelMedium=feedWaterMedium+steamFlowMedium;
drumLVLMedium=drumLVLAll(205:end);
plotTwoVariables(modelMedium,drumLVLMedium)

% medium plus model
feedWaterMediumPlus=(feedWaterAll(1:(end-205))-311)*1.3;
steamFlowMediumPlus=-(steamFlowAll(1:end-205)-338)*1.2;

furnacneMediumPlus =-(furnanceAll(1:end-205)+5)*1.2;

modelMediumPlus=feedWaterMediumPlus+steamFlowMediumPlus+furnacneMediumPlus;
drumLVLMedium=drumLVLAll(205:end);
plotTwoVariables(modelMediumPlus,drumLVLMedium)

% model full
delay=1;
steamFlowFull=(steamFlowAll(delay:end)-338)*1.2;
% feedWaterFull=(feedWaterAll(1:(end-delay))-430)*1.1;
feedWaterFull=(feedWaterAll(1:(end-delay))-430)*1.1;

airFlowFull=(airFlowAll(1:(end-delay))-120)*0.5;

furnanceMasterFull = furnanceMasterAll(1:end-delay)*1.5;

modelSteamWaterFull=furnanceMasterFull+feedWaterFull+airFlowFull;
% plotTwoVariables(modelFull,steamFlowFull)

% feedWaterFull=(feedWaterAll(1:(end-205-delay))-311)*1.3;
feedWaterFull=(feedWaterAll(1:(end-205-delay))-311)*1.3;

steamFlowFull=-modelSteamWaterFull(1:end-205);

furnacneFull =-(furnanceAll(1:end-205-delay)+5)*1.2;

modelPlus=feedWaterFull+steamFlowFull+furnacneFull;
drumLVLPlus=drumLVLAll(205+delay:end);
plotTwoVariables(modelPlus,drumLVLPlus)


function plotVariable(variable)
    variableMean=movmean(variable,200);
    

    
    figure
    plot(variable,'c')
    hold on
    plot(variableMean,'b')
    title(inputname(1));
    legend(inputname(1),inputname(1)+ " mean", 'Location','best')
    hold off
    
    saveas(gcf,"docs/models-all/"+inputname(1)+".png")
end

function plotTwoVariables(variable1, variable2)
    variableMean1=movmean(variable1,200);
    variableMean2=movmean(variable2,200);
    
    errorLength=min([length(variableMean1),length(variableMean2)]);
    error=immse(variableMean1(1:errorLength),variableMean2(1:errorLength));
    
    convertCharsToStrings(inputname(1))
    figure
    plot(variable1,'c')
    hold on
    plot(variableMean1,'b')
    hold on
    plot(variable2,'y')
    hold on
    plot(variableMean2,'r')
    title(convertCharsToStrings(inputname(1))+newline+ convertCharsToStrings(inputname(2))+newline+...
          "immse:" + error);
    legend(inputname(1),inputname(1)+ " mean",inputname(2),inputname(2)+ " mean", 'Location','best')
    hold off
    
    saveas(gcf,"docs/models-all/"+inputname(1)+inputname(2)+".png")

end