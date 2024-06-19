%% Model calibration
clc,clear,close all
load data.txt
X_ini=ones(6,1)*.1;
namefig='example';
[X,SMsim]=cal_SMestim_IE_02(data,X_ini,namefig);

%% Model Running
clc,clear,close all
load data.txt
load Xopt.txt
[WW,NS,KGE] = SMestim_IE_02(data,Xopt,1,'example');