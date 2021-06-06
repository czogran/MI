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

furnanceMasterAll=[furnanceMasterA; furnanceMaster; furnanceMasterF];
furnPartialAAll=[furnanceAA; furnanceA; furnanceAF];
furnPartialBAll=[furnanceBA; furnanceB; furnanceBF];


loadAll=[loadA;load;loadF];
drumLVLAll=[drumLVLA; drumLVL; drumLVLF];
feedWaterFlowAAll=[feedWaterFlowAA;feedWaterFlowA;feedWaterFlowAF];
oxygenAll=[oxygenA; oxygen; oxygenF];
rightAirFlowAll=[rightAirFlowA; rightAirFlow; rightAirFlowF];
leftAirFlowAll=[leftAirFlowA; leftAirFlow; leftAirFlowF];
drumPR1All = [drumPR1A; drumPR1; drumPR1F];
drumPR2All = [drumPR2A; drumPR2; drumPR2F];
steamPreassureAll=[steamPressureA;steamPressure;steamPressureF];
steamFlowAll=[steamFlowA;steamFlow;steamFlowF];

airFlowAll=(rightAirFlowAll+leftAirFlowAll)/2;



% plotVariable(furnAll);
% plotVariable(furnPartialAAll);
% % plotVariable(furnPartialBAll);
% 
% 
% plotVariable(loadAll);
% % plotVariable(drumLevelAll);
% plotVariable(leftAirFlowAll);
% plotVariable(oxygenAll);
% plotVariable(rightAirFlowAll);
% % plotVariable(drumPR1All);
% plotVariable(steamFlowAll);

% drumLVLAll=circshift(drumLVLAll,-200)+310;
drumLVLAll=circshift(drumLVLAll,-200);

drumLVLAll=drumLVLAll(1:end-200);
helpL=min(length(feedWaterFlowAAll),length(steamFlowAll));
variable1=(feedWaterFlowAAll(1:helpL)-steamFlowAll(1:helpL)+25)*2;
variable2=drumLVLAll;
amount=min([length(variable1),length(variable2)]);
a=corrcoef(variable1(1:amount),variable2(1:amount))

far=0.00000009;
airq=1/40;
len=min([length(airFlowAll),length(furnanceMasterAll)]);
ox2=100*(airFlowAll(1:len)-furnanceMasterAll(1:len)*far)./((airFlowAll(1:len)+furnanceMasterAll(1:len))*airq);

arLen=min([length(airFlowAll),length(oxygenAll)]);

air3=(airFlowAll(1:arLen)-105)*0.2;
ox3=oxygenAll(1:arLen);

plotTwoVariables(air3,ox3)

plotVariable(ox2)
plotVariable(oxygenAll)
plotVariable(airFlowAll)
plotVariable(furnanceMasterAll)

% plotVariable(drumLVLAll);

plotTwoVariables(drumLVLAll, variable1);

% plotTwoVariables(drumLVLAll, feedWaterFlowAAll);





% drumLVLEF=[drumLVL; drumLVLF];
% oxygenEF=[oxygen; oxygenF];
% funMEF=[furnanceMaster; furnanceMasterF];
% furnA=[furnanceA; furnanceAF];
% loadEF=[load; loadF];
% steamEF=[steamFlow; steamFlowF];
% feedWater =[feedWaterFlowA; feedWaterFlowAF];
% plotVariable(funMEF);
% plotVariable(loadEF);
% plotVariable(drumLVLEF);
% plotVariable(feedWater);
% plotVariable(oxygenEF);
% plotVariable(steamEF);
% plotVariable(furnA);
% 
% % plotTwoVariables(drumPR1,drumPR2);
% % plotTwoVariables(leftAirFlow,rightAirFlow);
% % 
% % % fMeam = (furnanceA+furnanceB)/2;
% % % fox=fMeam.*oxygen;
% % % 
% % plotVariable(furnanceA);
% % plotVariable(feedWaterFlowA);
% % 
% % plotVariable(furnanceMaster);
% % plotVariable(drumLVL);
% % 
% % plotVariable(oxygen);
% % plotVariable(load);
% % 



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