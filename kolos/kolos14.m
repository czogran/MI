clc;
close all;
clear all;

u=[0; 1; -1; 1; 1; 1; -1; -1; 0; 0; 0];
y=[0; 1.1; -0.2; 0.1; 0.9; 1; 0.1; -1.1; -0.8; -0.1; 0];

uu=[u(2:length(u)),u(1:length(u)-1)];

yy=y(2:length(y));

w=uu\yy;

b0=w(1);
b1=w(1);

b0=0.61;
b1=0.51;

y2=uu*[b0;b1]
n=y2-yy

srednia=sum(n)/10

war1=0;
for j=1: 10
    war1=n(j)^2;
end