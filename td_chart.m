function [time_domain_series,tVp,tVs,tDensity,tEpslon,tDelta,tGamma,tA,tC,tF,tL,tN]=td_chart(depth,sonic,epslon,delta,gamma,A,C,F,L,N,vs,density,dt,start_log_time,tf)
%the units of the output of this function are:
%time_domain_series = seconds
%tVp = P-wave velocity in time domain - cm/s
%tVs = S-wave velocity in time domain - cm/s
%tDensity = Density sampled in time domain - g/cc



n = size(sonic,1);

INCR = 10;
scaled_sonic = (sonic*INCR)/10e6;
td = start_log_time + 2*cumsum(scaled_sonic);


%calculating the depths related to each time-domain-series desired
time_domain_series = dt:dt:td(end,1);


figure;
plot(td,depth);
xlabel('Two-way traveltime (s)','Fontsize',18);
ylabel('Depth (ft)','Fontsize',18);
title('Time-Depth Chart','Fontsize',18);
axis ij

pp=round(start_log_time/dt+1);

td=td';
depth=depth';



profun = interp1(td(1,:),depth(1,:),time_domain_series(pp:end));
%profun(1,1)= depth(1,1);


depth=depth';

tsonicd = interp1(depth(:,1),sonic(:,1),profun);
tVs = interp1(depth(:,1),vs(:,1),profun);
tDensity = interp1(depth(:,1),density(:,1),profun);
tEpslon = interp1(depth(:,1),epslon(:,1),profun);
tDelta = interp1(depth(:,1),delta(:,1),profun);
tGamma = interp1(depth(:,1),gamma(:,1),profun);
tA = interp1(depth(:,1),A(:,1),profun);
tC = interp1(depth(:,1),C(:,1),profun);
tF = interp1(depth(:,1),F(:,1),profun);
tL = interp1(depth(:,1),L(:,1),profun);
tN = interp1(depth(:,1),N(:,1),profun);

tVp = 30.48.*((1./tsonicd).*10^(6));%cm/s


%beginning of the file until the start log time.
tVp = [tVp(1,1)*ones(1,pp-1),tVp];
tVs = [tVs(1,1)*ones(1,pp-1),tVs];
tDensity = [tDensity(1,1)*ones(1,pp-1),tDensity];
tEpslon = [tEpslon(1,1)*ones(1,pp-1),tEpslon];
tDelta = [tDelta(1,1)*ones(1,pp-1),tDelta];
tGamma = [tGamma(1,1)*ones(1,pp-1),tGamma];

tA = [tA(1,1)*ones(1,pp-1),tA];
tC = [tC(1,1)*ones(1,pp-1),tC];
tF = [tF(1,1)*ones(1,pp-1),tF];
tL = [tL(1,1)*ones(1,pp-1),tL];
tN = [tN(1,1)*ones(1,pp-1),tN];


ext = round(tf/dt);

tVp = [tVp, tVp(end)*ones(1,ext)];
tVs = [tVs, tVs(end)*ones(1,ext)];
tDensity = [tDensity, tDensity(end)*ones(1,ext)];
tEpslon = [tEpslon, tEpslon(end)*ones(1,ext)];
tDelta = [tDelta, tDelta(end)*ones(1,ext)];
tGamma = [tGamma, tGamma(end)*ones(1,ext)];
tA = [tA, tA(end)*ones(1,ext)];
tC = [tC, tC(end)*ones(1,ext)];
tF = [tF, tF(end)*ones(1,ext)];
tL = [tL, tL(end)*ones(1,ext)];
tN = [tN, tN(end)*ones(1,ext)];

time_domain_series = dt:dt:(td(end)+tf);



end




