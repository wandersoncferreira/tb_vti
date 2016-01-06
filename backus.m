function [A,C,F,L,M,rho_f] = backus(Vp,Vs,rho,l)

%the units of the elastic parameters in the end will be (dyne/cm2)


%converting velocity to cm/sec
Vp = (30.48).*Vp;
Vs = (30.48).*Vs;

%Lame' parameters for each isotropic thin layer
lambda = rho.*(Vp.^(2) - 2.*Vs.^(2));
mu = rho.*Vs.^(2);

%length of the average window (in samples)
ls = (l/1);
%force to be the nearest odd number
ls = ceil((ls+1)/2)*2 - 1;

%h is the half length
h = (ls-1)/2;

%padding the Lame parameters curves using a proper padding length in the
%beggining and end of the curves accordingly with the average window size

if(h > 1)
    mu_pi = [mu(1,1).*ones(h,1);mu];
    mu_pd = [mu_pi; mu(end,1).*ones((ceil((size(mu_pi,1)+h + 1)/2)*2 - 1) - size(mu_pi,1),1)];
else
    mu_pd = mu;
end

%lambda
if( h > 1)
    lambda_pi = [lambda(1,1).*ones(h,1);lambda];
    lambda_pd = [lambda_pi;lambda(end,1).*ones((ceil((size(lambda_pi,1)+h + 1)/2)*2 - 1) - size(lambda_pi,1) ,1)];
else
    lambda_pd = lambda;
end

%rho
if( h > 1)
    rho_pi = [rho(1,1).*ones(h,1);rho];
    rho_pd = [rho_pi;mu(1,1).*ones((ceil((size(rho_pi,1)+h + 1)/2)*2 - 1) - size(rho_pi,1),1)];
else
    rho_pd = rho;
end

%mu_pd = mu;
%rho_pd = rho;
%lambda_pd = lambda;

p = (h+1);
%Now the only thing we need to use is to apply the Backus averaging inside
%the window
%(size(mu_pd,1)-h-p(1)+1)

%prealocating arrays
A = zeros(1,size(Vp,1));
C = zeros(1,size(Vp,1));
F = zeros(1,size(Vp,1));
L = zeros(1,size(Vp,1));
M = zeros(1,size(Vp,1));
rho_f = zeros(1,size(Vp,1));


for i = 1:size(Vp,1) - ((ls-1))
   

    mu_e     = mu_pd(p(1)+i-1-h:p(1)+i-1+h);
    lambda_e = lambda_pd(p(1)+i-1-h:p(1)+i-1+h);
    rho_e    = rho_pd(p(1)+i-1-h:p(1)+i-1+h);
    
   
    
    %x
    xr = (1/ls) .*  (mu_e.*(lambda_e + mu_e)./(lambda_e + 2.*mu_e));
    xr(isinf(xr)) = 0;
    x = nansum(     xr    );
    
    %u
    ur = (1/ls) .*  ((1./(lambda_e + 2.*mu_e))); 
    ur(isinf(ur)) = 0;
    u = nansum(   ur   );
    
    %z
    zr = (1/ls) .*  ((lambda_e./(lambda_e +2.*mu_e))) ;
    zr(isinf(zr)) = 0;
    z = nansum(   zr   );
    
    %w
    wr = (1/ls) .*  (mu_e);
    wr(isinf(wr)) = 0;
    w = nansum(   wr   );
    
    %v
    vr = (1/ls) .*  (1./mu_e);
    vr(isinf(vr)) = 0;
    v = nansum(  vr  );
    
    %p(1) + i - 1
    A( p(1) + i - 1 ) = 4.*x + z.*z./u;
    C( p(1) + i - 1 ) = 1./u;
    F( p(1) + i - 1 ) = (z./u);
    L( p(1) + i - 1 ) = 1./v;
    M( p(1) + i - 1 ) = w;
    
    rho_f( p(1) + i - 1 ) = nansum((1/ls) .*rho_e); 
    
end

end









