function C_eff(C11,C13,C33,C44,C55,C66)

for i = 1:size(Vp,1) - ((ls-1))
   

    C11_e     = C11(p(1)+i-1-h:p(1)+i-1+h);
    C13_e     = C13(p(1)+i-1-h:p(1)+i-1+h);
    C33_e     = C33(p(1)+i-1-h:p(1)+i-1+h);
    C44_e     = C44(p(1)+i-1-h:p(1)+i-1+h);
    C55_e     = C55(p(1)+i-1-h:p(1)+i-1+h);
    C66_e     = C66(p(1)+i-1-h:p(1)+i-1+h);
   
    
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