%postma_example_1
%  

%theta

theta = [0,pi/24,pi/8,pi/6,5*pi/24,pi/4,7*pi/24,pi/3,3*pi/8,5*pi/12,11*pi/24,pi/2];

%the five elastic constants of the transversely isotropic medium
A = 3.36*10^(11);
C = 2.46*10^(11);
F = 0.97*10^(11);
N = 1.08*10^(11);
L = 0.74*10^(11);
rho = 2.4;

gama  = 0;  %if gamma is zero, the axis of velocity symmetry will be normal to the plane interface 
beta = theta + gama;


%computing the phase velocity from equation 1
%computing the phase velocity from equation 1
P = sqrt(A/L);
Q = sqrt(C/L);
R = sqrt(F/L);
S = sqrt(N/L);

delta = ((R.^(2) + 1).^(2) - (P.^(2) - 1).*(Q.^(2) - 1)).^(1/2);

p1 = (2 + (P^(2) - 1).*((sin(theta)).^(2)) + (Q.^(2) - 1).*((cos(theta)).^(2)))/2;
p2 = ((((P^(2) - 1).*((sin(theta)).^(2)) + (Q.^(2) - 1).*((cos(theta)).^(2))).^(2) + (delta.^(2)).*((sin(2.*theta)).^(2))).^(1/2))/2;

v2_p = sqrt(p1 + p2);
v2_sv = sqrt(p1 - p2);



t1 = (P^(2) - 1).*(sin(2.*theta))./2;
t2 = (Q^(2) - 1).*(sin(2.*theta))./2;
t3 = ((((P^(2) - 1).*((sin(theta)).^(2)) + (Q^(2) - 1).*((cos(theta)).^(2))).^(2))./4 + (delta.^(2)).*((sin(2.*theta)).^(2))./4 ).^(1/2);
t4 = (P.^(2) - Q^(2)).*(sin(theta)).*(cos(theta)).*( (P^(2) - 1 ).*((sin(theta)).^(2)) + (Q.^(2) - 1).*((cos(theta)).^(2)) );
t5 = (delta.^(2)).*(sin(2.*theta)).*cos(2.*theta);

%for p -wave derivative
dv_dtheta_p = ((t1 - t2) + ( (t4 + t5)./(2.*t3)   ) )./(2.*v2_p);
dv_dtheta_p = dv_dtheta_p.*sqrt(L/rho);
v2_p = v2_p*sqrt(L/rho);

%for sv -wave derivative
dv_dtheta_sv = ((t1 - t2) - ( (t4 + t5)./(2.*t3)   ) )./(2.*v2_sv);
dv_dtheta_sv = dv_dtheta_sv.*sqrt(L/rho);
v2_sv = v2_sv*sqrt(L/rho);


%computing the ray velocity and ray angle phi!!
v_phi_p = sqrt( v2_p.^(2) + dv_dtheta_p.^(2) );
phi_p   = atan((1./v2_p).*dv_dtheta_p) + theta;

v_phi_sv = sqrt( v2_sv.^(2) + dv_dtheta_sv.^(2) );
phi_sv   = atan((1./v2_sv).*dv_dtheta_sv) + theta;

%computing the ray parameter for this interface:
p = sin(beta)./v2_p;

%ploting
plot(phi_p.*180/pi,v2_p./10^(5),'-r','linewidth',2);
hold on
plot(phi_p.*180/pi,v_phi_p./10^(5),'-k','linewidth',2);
set(gca,'fontsize',18)
ylabel('Velocities (km/s)')
xlabel('Ray angle (degrees)');
xlim([0 90])
ylim([3 4])
legend('Phase velocity','Ray Velocity')
grid on





