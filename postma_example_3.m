%postma_example_2
%  

%theta

%theta = [0,pi/24,pi/8,pi/6,5*pi/24,pi/4,7*pi/24,pi/3,3*pi/8,5*pi/12,11*pi/24,pi/2];
theta = (0:1:90).*pi/180;

%the five elastic constants of the transversely isotropic medium
A = 7.25*10^(11);
C = 5.82*10^(11);
F = 1.98*10^(11);
N = 2.47*10^(11);
L = 0*10^(11);
rho = 2.48;

gama  = 0;  %if gamma is zero, the axis of velocity symmetry will be normal to the plane interface 
beta = theta + gama;



%new implementation 

X1 = L./rho;
X2 = (A-L)./(2.*rho);
X3 = (C-L)./(2.*rho);
X4 = ( (F+L).^(2)  - (A-L).*(C-L) )./(4.*(rho.^(2)));

%velocity
T1 = X1 + X2.*((sin(theta)).^(2)) + X3.*((cos(theta)).^(2));
T2 = sqrt( ( X2.*((sin(theta)).^(2)) + X3.*((cos(theta)).^(2)) ).^(2)  + X4.*(sin(2*theta)).^(2));

%velocity for p-wave and sv-wave
vp = sqrt(T1 + T2);
vsv = sqrt(T1 - T2);


%derivative
P8 = (X2 - X3).*sin(2.*theta); 
U_theta = sqrt (   (X2.*((sin(theta)).^(2)) + X3.*((cos(theta)).^(2))).^(2) + X4.*((sin(2.*theta)).^(2))     );
P9 = ((X2 - X3).*(sin(2.*theta))).*( X2.*((sin(theta)).^(2)) + X3.*((cos(theta)).^(2)) )./U_theta;
P10 = X4.*sin(4.*theta)./(U_theta);



%for p -wave and sv derivative
dv_dtheta_p = (P8 + P9 + P10)./(2.*vp);
dv_dtheta_sv = (P8 - (P9 + P10))./(2.*vsv);




%computing the ray velocity and ray angle phi!!
v_phi_p = sqrt( vp.^(2) + dv_dtheta_p.^(2) );
phi_p   = atan((1./vp).*dv_dtheta_p) + theta;

v_phi_sv = sqrt( vsv.^(2) + dv_dtheta_sv.^(2) );
phi_sv   = atan((1./vsv).*dv_dtheta_sv) + theta;

%computing the ray parameter for this interface:
p = sin(beta)./vp;

%ploting
plot(theta.*180/pi,vp./10^(5),'-r','linewidth',2);
hold on
plot(theta.*180/pi,vsv./10^(5),'-k','linewidth',2);
set(gca,'fontsize',18)
ylabel('Velocities (km/s)')
xlabel('Ray angle (degrees)');
xlim([0 90])
%ylim([3 4])
legend('P-wave velocity','SV-velocity')
grid on





