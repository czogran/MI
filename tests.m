clc
clear
close all 

load=readmatrix('data/load.txt');
oxygen=readmatrix('data/oxygen.txt');
feedWaterFlowA=readmatrix('data/feedwater-flow-A.txt');
feedWaterFlowB=readmatrix('data/feedwater-flow-B.txt');
furnanceA=readmatrix('data/furnance-A.txt');
furnanceB=readmatrix('data/furnance-B.txt');
steamFlow=readmatrix('data/steam-flow.txt');
steamPressure=readmatrix('data/steam-pressure.txt');
steamTemp=readmatrix('data/steam-temp.txt');
drumPR1=readmatrix('data/drum-PR1.txt');
drumPR2=readmatrix('data/drum-PR2.txt');
drumLVL=readmatrix('data/drum-LVL.txt');



plotVariable(load)
plotVariable(oxygen)
plotVariable(feedWaterFlowA)
plotVariable(feedWaterFlowB)
plotVariable(furnanceA)
plotVariable(furnanceB)
plotVariable(steamFlow)
plotVariable(steamPressure)
plotVariable(steamTemp)
plotVariable(drumPR1)
plotVariable(drumPR2)
plotVariable(drumLVL)



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

function out = getVarName(var)
    out = inputname(1);
end