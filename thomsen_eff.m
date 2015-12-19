function [Vpo,Vso,epslon,delta,gamma] = thomsen_eff(A,C,F,L,M,rho_eff)


%the effective medium theory parameters as Thomsen parameters.

Vpo = sqrt(C./rho_eff);
Vso = sqrt(L./rho_eff);

epslon = (A-C)./(2.*C);
delta  = ((F+L).^(2) - (C-L).^(2))./(2.*C.*(C-L));
gamma  = (M-L)./(2.*L);


end
