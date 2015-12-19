function [vv,vh] = vv_vh(v_phi,phi,theta)

vv = sqrt( (v_phi.^(2)).*cos(phi-theta).*cos(phi)./cos(theta) );
vh = sqrt( (v_phi.^(2)).*cos(phi-theta).*sin(phi)./sin(theta) );

end