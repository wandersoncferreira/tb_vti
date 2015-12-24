

%benchmark

vp = [4000.*ones(1,2000),6500.*ones(1,2000)]';
vs = [2800.*ones(1,2000),3000.*ones(1,2000)]';
rho = [2.02.*ones(1,2000),2.2.*ones(1,2000)]';

sonic = (1./vp).*10^(6);
depth = 1:4000;
depth = depth';

