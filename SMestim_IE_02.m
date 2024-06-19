%
%   SMestim_IE_02(name,PAR,FIG,namefig)
%
function [WW,NS,KGE] = SMestim_IE_02(PTSM,PAR,FIG,namefig)

% Loading input data
% PTSM=load([name,'.txt']);
[M]=size(PTSM,1);
D=PTSM(:,1); PIO=PTSM(:,2); TEMPER=PTSM(:,3); WWobs=PTSM(:,4);
dt=round(nanmean(diff(D))*24*10000)/10000;
MESE=month(D);

% Model parameter
W_p       = PAR(1);
W_max     = PAR(2);
alpha     = PAR(3);
m2        = PAR(4);
Ks        = PAR(5);
Kc        = PAR(6);
Ks=Ks.*dt;

% Potential Evapotranspiration parameter
L=[0.2100;0.2200;0.2300;0.2800;0.3000;0.3100;
    0.3000;0.2900;0.2700;0.2500;0.2200;0.2000];
Ka=1.26;
EPOT=(TEMPER>0).*(Kc*(Ka*L(MESE).*(0.46*TEMPER+8)-2))/(24/dt);
clear PTSM TEMPER MESE

% Initialization
WW=zeros(M,1);

% Main ROUTINE
W=W_p*W_max;
for t=1:M
    IE=PIO(t)*((W/W_max).^alpha);
    E=EPOT(t)*W/W_max;
    PERC=Ks*(W/W_max).^(m2);
    W=W+(PIO(t)-IE-PERC-E);
    if W>=W_max
        SE=W-W_max;
        W=W_max;
    else
        SE=0;
    end
    WW(t)=W./W_max;
end

% Calculation of model performance
RMSE=nanmean((WW-WWobs).^2).^0.5;
NS=1-nansum((WW-WWobs).^2)./nansum((WWobs-nanmean(WWobs)).^2);
NS_radQ=1-nansum((sqrt(WW+0.00001)-sqrt(WWobs+0.00001)).^2)./...
    nansum((sqrt(WWobs+0.00001)-nanmean(sqrt(WWobs+0.00001))).^2);
NS_lnQ=1-nansum((log(WW+0.0001)-log(WWobs+0.0001)).^2)...
    ./nansum((log(WWobs+0.0001)-nanmean(log(WWobs+0.0001))).^2);
NS_lnQ=real(NS_lnQ);
NS_radQ=real(NS_radQ);
X=[WW,WWobs]; X(any(isnan(X)'),:) = [];
RRQ=corrcoef(X).^2; RQ=RRQ(2);
KGE=klinggupta(WW,WWobs);

% Figure
if FIG==1
    set(gcf,'Position',[100 100 1000 700],'Color','white')
    
    h(1) = axes('Position',[0.1 0.5 0.8 0.40]);
    set(gca,'Fontsize',12)
    s=(['NS= ',num2str(NS,'%4.3f'),...
        ' NS(lnSD)= ',num2str(NS_lnQ,'%4.3f'),...
        ' NS(radSD)= ',num2str(NS_radQ,'%4.3f'),...
        ' RQ= ',num2str(RQ,'%4.3f'),...
        ' RMSE= ',num2str(RMSE,'%4.3f'),...
        ' KGE= ',num2str(KGE,'%4.3f')]);
    title(['\bf',s]);
    hold on
    plot(D,WWobs,'g','Linewidth',3)
    plot(D,WW,'r','Linewidth',2);
    
%     plot(D,t_mod,'r','Linewidth',2)
    legend('\theta_o_b_s','\theta_s_i_m');
    datetick('x',20)
    set(gca,'Xticklabel','')
    ylabel('relative soil moisture [-]')
    grid on, box on
    axis([D(1) D(end) min(WWobs)-0.05 max(WWobs)+0.05])
    
    h(2) = axes('Position',[0.1 0.1 0.8 0.40]);
    set(gca,'Fontsize',12)
    hold on
    plot(D,PIO,'color',[.5 .5 .5],'Linewidth',3)
%     plot(D,inf_sim,'r')
    grid on, box on
    ylabel('rain (mm/h)')
%     legend('rain','infiltration',0)
    datetick('x',20)
    grid on, box on
    axis([D(1) D(end) 0 1.05.*max(PIO)])
        
    export_fig(['IEmodel_',namefig], '-png','-q60','-r150')
end
