function [v,dv_dtheta] = vti(theta)

%the five elastic constants of the transversely isotropic medium
A = 7.25*10^(11);
C = 5.82*10^(11);
F = 1.98*10^(11);
N = 2.47*10^(11);
L = 0*10^(11);

rho = 2.4;
gama  = 0;  %if gamma is zero, the axis of velocity symmetry will be normal to the plane interface 
beta = theta + gama;



%X = v2.*sin(theta) + dv_dtheta.*cos(theta);
%Z = v2.*cos(theta) - dv_dtheta.*sin(theta);


%new implementation 

X1 = L./rho;
X2 = (A-L)./(2.*rho);
X3 = (C-L)./(2.*rho);
X4 = ( (F+L).^(2)  - (A-L).*(C-L) )./(4.*(rho.^(2)));

%velocity
T1 = X1 + X2.*((sin(theta)).^(2)) + X3.*((cos(theta)).^(2));
T2 = sqrt( ( X2.*((sin(theta)).^(2)) + X3.*((cos(theta)).^(2)) ).^(2)  + X4.*(sin(2*theta)).^(2));

v = sqrt (T1 + T2);


%derivative
P8 = (X2 - X3).*sin(2.*theta); 
U_theta = sqrt (   (X2.*((sin(theta)).^(2)) + X3.*((cos(theta)).^(2))).^(2) + X4.*((sin(2.*theta)).^(2))     );
P9 = ((X2 - X3).*(sin(2.*theta))).*( X2.*((sin(theta)).^(2)) + X3.*((cos(theta)).^(2)) )./U_theta;
P10 = X4.*sin(4.*theta)./(U_theta);


dv_dtheta = (P8 + P9 + P10)./(2.*v);



%computing the ray velocity and ray angle phi!!

v_phi = sqrt( v.^(2) + dv_dtheta.^(2) );

phi   = atan((1./v).*dv_dtheta) + theta;

%computing the ray parameter for this interface:
p = sin(beta)./v;


%new parameters
rho2 = 2.35;
A2 = 28.5*10^(10);
C2 = 8.58*10^(10);
F2 = 4.29*10^(10);
L2 = 1.50*10^(10);
N2 = 9.8*10^(10);

%angle of the next layer!
a2 = L2/rho2;
b2 = (A2-L2)/rho2;
c2 = (C2-L2)/rho2;
d2 = ((A2-L2)*(C2-L2) - (F2+L2)^(2))/(rho2^(2));
p2 = p.^(2);


%term of tan(theta)
tan0 = ((a2 + c2).*p2 - (sin(gama))^(2)).*(a2*p2 - (sin(gama))^(2));
tan1 = -((2*a2 + c2).^(p2) - 2*(sin(gama))^(2)).*sin(2*gama);
tan2 = (d2 + a2*b2 + a2*c2 + 2*(a2)^(2)).*p2.^(2) - (2*a2 + b2*(sin(gama))^(2) + c2*(cos(gama))^(2)).*p2 + 6*(sin(2*gama))^(2);  
tan3 = -((2*a2 + b2)*p2 - 2*(cos(gama))^(2))*sin(2*gama);
tan4 = ((a2 + b2).*p2 - (cos(gama))^(2)).*(a2.*p2 - (cos(gama))^(2));


coefficients = [tan4,tan3,tan2,tan1,tan0];

%root = roots(coefficients);
%root = atan(root);
%p_new = max(root(:));



















