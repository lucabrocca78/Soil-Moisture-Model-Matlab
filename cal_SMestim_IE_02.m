function [X,SMsim]=cal_SMestim_IE_02(PTSM,X_ini,namefig)
if nargin==1,X_ini=ones(6,1)*.5;end
[RES]=fmincon(@calibOK,X_ini,[],[],[],[],...
     zeros(6,1),ones(6,1),[],optimset('Display','iter','MaxIter',60,...
     'MaxFunEvals',500,'TolFun',1E-4,'TolCon',3,'Largescale','off'),PTSM);
X=convert_adim(RES);
[SMsim]=SMestim_IE_02(PTSM,X,1,namefig);
!del X_opt.txt
fid=fopen('X_opt.txt','w');
fprintf(fid,'%9.4f\n',X);
fclose(fid);

%---------------------------------------------------------------------------------
function [err]=calibOK(X_0,PTSM)

X=convert_adim(X_0);
[~,NS,KGE]=SMestim_IE_02(PTSM,X,0);
err=1-KGE;
save X_PAR

%---------------------------------------------------------------------------------
function X=convert_adim(X_0)
LOW=[ 0.0,   40,  1.0,  0.1,   1,  0.5]';
UP =[ 1.0, 1100, 15.0, 15.0,  45,  1.5]';
X=LOW+(UP-LOW).*X_0;
