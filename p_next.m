function [theta_new] = p_next(A2,C2,F2,L2,rho2,p,indx)

%tThe indx indicate if we are using this function for P wave or SV wave
%velocities. 

%When indx = 1 we have P wave
%When indx = 2 we have S wave


gama = 0;
%angle of the next layer!
a2 = L2/rho2;
b2 = (A2-L2)/rho2;
c2 = (C2-L2)/rho2;
d2 = ((A2-L2)*(C2-L2) - (F2+L2)^(2))/(rho2^(2));
p2 = p.^(2);




%term of tan(theta)
tan0 = ((a2 + c2).*p2 - (sin(gama)).^(2)).*(a2.*p2 - (sin(gama)).^(2));
tan1 = -((2.*a2 + c2).^(p2) - 2.*(sin(gama)).^(2)).*sin(2*gama);
tan2 = (d2 + a2.*b2 + a2.*c2 + 2.*(a2)^(2)).*p2.^(2) - (2.*a2 + b2.*(sin(gama)).^(2) + c2*(cos(gama)).^(2)).*p2 + 6.*(sin(2*gama)).^(2);  
tan3 = -((2*a2 + b2)*p2 - 2*(cos(gama))^(2)).*sin(2*gama);
tan4 = ((a2 + b2).*p2 - (cos(gama)).^(2)).*(a2.*p2 - (cos(gama)).^(2));



coefficients = [tan4;tan3;tan2;tan1;tan0]';
indx
if indx == 1 || indx == 2 
    for i = 1:size(coefficients,1)

    coefficients(i,1:5)   ; 
    root = roots(coefficients(i,1:5));
    root = atan(root);
    if indx == 2
        root
    end
    theta_new(i) = max(root);
    
    end
end

if indx == 3
    for i = 1:size(coefficients,1)

    root = roots(coefficients(i,1:5));
    root = atan(root);
    theta_new(i) = min(root);
    end
end
    