clc
clear
close all 

path = "data/";

load=readmatrix(path+'load.txt');
oxygen=readmatrix(path+'oxygen.txt');
feedWaterFlowA=readmatrix(path+'feedwater-flow-A.txt');
feedWaterFlowB=readmatrix(path+'feedwater-flow-B.txt');
furnanceMaster=readmatrix(path+'furnance-master.txt');
furnanceA=readmatrix(path+'furnance-A.txt');
furnanceB=readmatrix(path+'furnance-B.txt');
steamFlow=readmatrix(path+'steam-flow.txt');
steamPressure=readmatrix(path+'steam-pressure.txt');
steamTemp=readmatrix(path+'steam-temp.txt');
drumPR1=readmatrix(path+'drum-PR1.txt');
drumPR2=readmatrix(path+'drum-PR2.txt');
drumLVL=readmatrix(path+'drum-LVL.txt');
leftAirFlow=readmatrix(path+'left-air-flow.txt');
rightAirFlow=readmatrix(path+'right-air-flow.txt');


% concat variables
feedWater=(feedWaterFlowA+feedWaterFlowB)/2;
furnance=(furnanceA + furnanceB)/2;
airFlow=(rightAirFlow+leftAirFlow)/2;

% simple model
feedWaterSimple=(feedWater(1:(end-205))-311)*1.3;
drumLVLSimple=drumLVL(205:end);
plotTwoVariables(feedWaterSimple,drumLVLSimple)

% medium model
feedWaterMedium=(feedWater(1:(end-205))-311)*1.3;
steamFlowMedium=-(steamFlow(1:end-205)-338)*0.5;
modelMedium=feedWaterMedium+steamFlowMedium;
drumLVLMedium=drumLVL(205:end);
plotTwoVariables(modelMedium,drumLVLMedium)

% medium plus model
feedWaterMediumPlus=(feedWater(1:(end-205))-311)*1.3;
steamFlowMediumPlus=-(steamFlow(1:end-205)-338)*0.5;

furnacneMediumPlus =-(furnance(1:end-205)+5)*1.2;

modelMediumPlus=feedWaterMediumPlus+steamFlowMediumPlus+furnacneMediumPlus;
drumLVLMediumPlus=drumLVL(205:end);
plotTwoVariables(modelMediumPlus,drumLVLMediumPlus)


% model full
delay=4000;
steamFlowFull=(steamFlow(delay:end)-212)*0.7;
feedWaterFull=(feedWater(1:(end-delay))-311)*0.02;
airFlowFull=(airFlow(1:(end-delay))-120)*0.3;

furnanceMasterFull = furnanceMaster(1:end-delay);

modelFull=furnanceMasterFull+feedWaterFull+airFlowFull;
plotTwoVariables(modelFull,steamFlowFull)


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
    
    saveas(gcf,"docs/models-e/"+inputname(1)+inputname(2)+".png")

end