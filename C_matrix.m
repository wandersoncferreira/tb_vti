function [C11,C13,C33,C44,C55,C66] = C_matrix(Vp,Vs,rho,epslon,delta,gamma)

C33 = Vp.^(2)  .* rho ;
C55 = Vs.^(2)  .* rho ;
C44 = C55;
C11 = (1 + 2.*epslon).*C33;
C66 = (1 + 2.*gamma).*C44;
C13 = sqrt(2.*delta.*C33.*(C33 - C55) + (C33 - C55).^(2) - C55 );

end

 
