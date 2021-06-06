clear all
close all
clc

y =[2.2247; 5.7321; 11.1213; 18.4495; 27.7386];
u=[0.5; 1; 1.5; 2; 2.5];

yk2=y.^2;
uk2=u.^2;

yy = [yk2 - uk2];
uu = [u, uk2];

uu\yy

w=(uu'*uu)^(-1)*uu'*yy
a=w(1);
b=w(2);

yTest= zeros(length(u),1);

for k=2: length(u)
    yTest(k)=sqrt(a*u(k)+(b+1)*uk2(k));
end

figure
plot(yTest)