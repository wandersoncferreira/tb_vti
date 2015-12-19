function RC = reflection_well_ani(Vp1,Vp2,Vs1,Vs2,rho1,rho2,phi,delta1,delta2,epslon1,epslon2)

%Aki and Richard (1980) came up with a matrix form of the Knott-Zoeppritz equation for 
%Reflection Coefficient as a function of the incident angle.

%Using only S-wave and P-wave velocities and density of the medium is
%possible to determine the sixteen possible reflection coefficients.


%Vpp = dVp/Vp
%Vss = dVs/Vs
%rhoo = drho/rho
%Vp = (Vp1+Vp2)/2
%Vs = (Vs1+Vs2)/2


Vp = (Vp1+Vp2)/2;
Vs = (Vs1+Vs2)/2;
rho = (rho2+rho1)/2;
%theta = (incident + transmitted)/2;


Vpp = (Vp2-Vp1)/Vp;
Vss = (Vs2-Vs1)/Vs;
drhoo = (rho2-rho1)/rho;

A = (1/2)*(Vpp + drhoo);
B = (1/2)*Vpp -(2*(Vs/Vp)^2)*(2*Vss + drhoo) + (delta2 - delta1);
C =  (1/2).*(Vpp - (delta2 - delta1 - epslon2 + epslon1));



theta = sum(phi)/2;
RC = A + B.*sin(theta).^2 + C.*(sin(theta).^2).*(tan(theta).^2);


%for i=1:size(phi,2)
 %   theta(i) = (phi(1,i)+phi(2,i))/2;
  %  RC(i) = A + B*sin(theta(i)).^2 + C*(sin(theta(i)).^2)*(tan(theta(i)).^2);
%end


end




