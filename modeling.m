function [T,X,data_out,matrix_vPphi,matrix_vSphi,matrix_rcc,tDensity,time_series,offset] = modeling(depth,Vp,Vs,rho_i)

%initial parameters
start_log_time = 0;
tf = 0.5;
dt = 0.002;
dx = 500;
nr = 20;
offset = 0:dx:(dx*(nr-1));
V1 = 10;
length = 0;
fq = 30;

%computing the five elastic constants through Backus averaging
%l is the averaging length
l = 101;

[A,C,F,L,N,rho_eff] = backus(Vp,Vs,rho_i,l);

[Vpo,Vso,epslon,delta,gamma] = thomsen_eff(A,C,F,L,N,rho_eff);


Vpo = Vpo';
Vso = Vso';
rho_eff = rho_eff';
epslon = epslon';
delta = delta';
gamma = gamma';
A=A';
C=C';
F=F';
L=L';
N=N';



%I believe I should change everything to time domain right here.
%the depth-to-time discretization
Vpo = Vpo./(30.48);
Vso = Vso./(30.48);

%taking care of NaN
pNAN = find(isnan(Vpo));
depth(pNAN) = [];
epslon(pNAN) = [];
delta(pNAN) = [];
gamma(pNAN) = [];
A(pNAN) = [];
C(pNAN) = [];
F(pNAN) = [];
L(pNAN) = [];
N(pNAN) = [];
rho_eff(pNAN) = [];
Vso(pNAN) = [];
Vpo(pNAN) = [];

%taking care of Inf
pINF = find(isinf(Vpo));
depth(pINF) = [];
epslon(pINF) = [];
delta(pINF) = [];
gamma(pINF) = [];
A(pINF) = [];
C(pINF) = [];
F(pINF) = [];
L(pINF) = [];
N(pINF) = [];
rho_eff(pINF) = [];
Vso(pINF) = [];
Vpo(pINF) = [];

sonic_vti_ft = ((1./Vpo).*10^(6));    %sonic curve in us/ft from the Vpo velocity from Thomsen effective medium

%taking care of Inf
pINF = find(isinf(sonic_vti_ft));
depth(pINF) = [];
epslon(pINF) = [];
delta(pINF) = [];
gamma(pINF) = [];
A(pINF) = [];
C(pINF) = [];
F(pINF) = [];
L(pINF) = [];
N(pINF) = [];
rho_eff(pINF) = [];
Vso(pINF) = [];
sonic_vti_ft(pINF) = [];

 
[time_series,tVp,tVs,tDensity,tEpslon,tDelta,tGamma,tA,tC,tF,tL,tN] = td_chart(depth,sonic_vti_ft,epslon,delta,gamma,A,C,F,L,N,Vso,rho_eff,dt,start_log_time,tf);
% 
% 
% 
% 
% %modeling
theta = (0:1:89).*pi/180;
theta_p = theta;
theta_s = theta;
%theta = 0.506145483078356;
%theta = 90*pi/180;
matrix_theta_P = theta_p;
matrix_theta_S = theta_s;


for i = 1:size(tA,2)
    
    [vP_phi,P_phi,P_p,vP] = vp_ray(tA(i),tC(i),tF(i),tN(i),tL(i),tDensity(i),theta_p);
    [vS_phi,S_phi,S_p,vS] = vs_ray(tA(i),tC(i),tF(i),tN(i),tL(i),tDensity(i),theta_p);
    
    if i <= size(tA,2)-1
        [theta_p] = p_next(tA(i+1),tC(i+1),tF(i+1),tL(i+1),tDensity(i+1),P_p,1); %when P wave is used on the quartic equation I can always
        %choose the largest solution as the angle for the transmitted ray.

%         [theta_s] = p_next(tA(i+1),tC(i+1),tF(i+1),tL(i+1),tDensity(i+1),S_p,2); %indx = 2 means SV wave       
         matrix_theta_P(i+1,:) = theta_p;
%         matrix_theta_S(i+1,:) = theta_s;
    end 
    
    matrix_vPphi(i,:)  = vP_phi;
    matrix_vSphi(i,:)  = vS_phi;
    matrix_vP(i,:)     =  vP;
    matrix_vS(i,:)     =  vS;
    matrix_Pphi(i,:)   =  P_phi;
    matrix_Sphi(i,:)   =  S_phi;
    matrix_Pp(i,:)     = P_p;
    matrix_Sp(i,:)     = S_p;
           
end

%changing the velocities for ft/s

matrix_vPphi  =  matrix_vPphi./(30.48);
matrix_vSphi  =  matrix_vSphi./(30.48);
matrix_vP     =  matrix_vP./(30.48);
matrix_vS     =  matrix_vS./(30.48);


%computing the thicknesses
for i=1:size(time_series,2)-1
    h(i) = matrix_vPphi(i,1)*(time_series(i+1)-time_series(i))/2;
end
h(end+1) = (dt*matrix_vPphi(end,1))/2;


matrix_Pphi(:,end) = NaN;

for i=1:size(matrix_Pphi,1)
   for j=1:size(matrix_Pphi,2)
   if isreal(matrix_Pphi(i,j)) == 0
    matrix_Pphi(i,j) = NaN;
   end

end
end

X = ani_X(matrix_Pphi,h);
T = ani_T(matrix_vPphi,matrix_Pphi,h);


%calculating RC
matrix_rcc = zeros(size(matrix_Pphi,1)-1,size(matrix_Pphi,2));
n = size(theta,2);
for i=1:size(time_series,2)-1
    angles = matrix_theta_P(i:i+1,:);    
    rcc2 = reflection_well_ani(matrix_vPphi(i,1),matrix_vPphi(i+1,1),matrix_vSphi(i,1),matrix_vSphi(i+1,1),tDensity(1,i),tDensity(1,i+1),angles,tDelta(1,i),tDelta(1,i+1),tEpslon(1,i),tEpslon(1,i+1));
    matrix_rcc(i,1:n) =  rcc2;
end

for i=1:size(matrix_rcc,2)
    vv=find(~imag(matrix_rcc(:,i))==0,1,'first');
    matrix_rcc(vv:end,i)=0;
end

%calculating the reflectivity time series
[reflectivity,aa,control_time]=synthetic_well(X,T,matrix_rcc,matrix_Pphi,offset,time_series,dt,V1,length);

%calculating the wavelet
rw = ricker_wavelet(fq,0.04,dt)';



%convolving the reflectivity time series with the wavelet Ricker
synt_seismic = (conv2(reflectivity,rw,'same'))';


c = isnan(control_time);
control_time(c) = 0;


%figure
%calculating the NMO corrected data with d% of stretch mute
data_out = raytrace_nmo(synt_seismic,dt,control_time,time_series,100);
%data_out = seismic_trace;
%plotseismic(data_out,time_series,offset,'k');
%xlabel('Offset','Fontsize',18);
%ylabel('TWT (s)', 'Fontsize', 18);
%set(gca,'fontsize',18)



%figure
%subplot(1,3,1)
plotseismic(data_out(800:1200,:),time_series(800:1200),offset);
xlabel('Offset','Fontsize',7);
ylabel('TWT (s)', 'Fontsize', 7);
set(gca,'fontsize',10)
set(gcf, 'PaperUnits', 'inches');
x_width=5.8; y_width=5.1;
set(gcf, 'PaperPosition', [0 0 x_width y_width]); %

print(gcf, '-dpng', '-loose', '-r100', 'model_syn101');


% subplot(1,3,2)
% plot(tVp(775:950),time_series(775:950),'-r')
% hold on
% plot(tVs(775:950),time_series(775:950),'-b')
%plot(1000*tDensity(775:950),time_series(775:950),'-k')



