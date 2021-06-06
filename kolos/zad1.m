clc;
clear all
close all

K=4.2;
T=2.8;

g= tf(K, [T, 1])

bode(g)

