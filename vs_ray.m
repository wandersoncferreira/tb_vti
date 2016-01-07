function [v_phi,phi,p,v] = vs_ray(A,C,F,N,L,rho,theta)

%CALCULATING FOR S - WAVE VELOCITY

gama  = 0;  %if gamma is zero, the axis of velocity symmetry will be normal to the plane interface 
beta = theta + gama;


%new implementation 

X1  = L./rho;
X2  = (A-L)./(2*rho);
X2p = (A-L); % Test to see the difference
X3  = (C-L)./(2*rho);
X3p = (C-L);
X4  = ( (F + L).^(2)  - (A-L).*(C-L) )./(4*(rho.^(2)));

%velocity
 
T1 = X1 + X2.*((sin(theta)).^(2)) + X3.*((cos(theta)).^(2));
T2 = sqrt( (0.5*rho).*( X2p.*((sin(theta)).^(2)) + X3p.*((cos(theta)).^(2)) ).^(2)  + X4.*(sin(2*theta)).^(2));

v = sqrt (T1 - T2);  %the sign is MINUS for SV-wave 


%derivative
P8 = (X2 - X3).*sin(2.*theta); 
U_theta = sqrt (   (X2.*((sin(theta)).^(2)) + X3.*((cos(theta)).^(2))).^(2) + X4.*((sin(2.*theta)).^(2))     );
P9 = ((X2 - X3).*(sin(2.*theta))).*( X2.*((sin(theta)).^(2)) + X3.*((cos(theta)).^(2)) )./U_theta;
P10 = X4.*sin(4.*theta)./(U_theta);


dv_dtheta = (P8 - (P9 + P10))./(2.*v);



%computing the ray velocity and ray angle phi!!

v_phi = sqrt( v.^(2) + dv_dtheta.^(2) );

phi   = atan((1./v).*dv_dtheta) + theta;

%computing the ray parameter for this interface:
p = sin(beta)./v;




end