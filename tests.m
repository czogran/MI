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



% plotVariable(load)
% plotVariable(oxygen)
% plotVariable(feedWaterFlowA)
% plotVariable(feedWaterFlowB)
% plotVariable(furnanceMaster)
% plotVariable(furnanceA)
% plotVariable(furnanceB)
% plotVariable(steamFlow)
% plotVariable(steamPressure)
% plotVariable(steamTemp)
% plotVariable(drumPR1)
% plotVariable(drumPR2)
% plotVariable(drumLVL)
% plotVariable(leftAirFlow)
% plotVariable(rightAirFlow)

drumLVLEF=[drumLVL; drumLVLF];
funMEF=[furnanceMaster; furnanceMasterF];
loadEF=[load; loadF];
plotVariable(funMEF);
plotVariable(furnanceMaster);
plotVariable(loadEF);
plotVariable(drumLVLEF);

% plotTwoVariables(drumPR1,drumPR2);
% plotTwoVariables(leftAirFlow,rightAirFlow);
% 
% % fMeam = (furnanceA+furnanceB)/2;
% % fox=fMeam.*oxygen;
% % 
% plotVariable(furnanceA);
% plotVariable(feedWaterFlowA);
% 
% plotVariable(furnanceMaster);
% plotVariable(drumLVL);
% 
% plotVariable(oxygen);
% plotVariable(load);
% 



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