%how to get the Vp, Vs and rho curves from 1107.las file with the correct
%dimensions, without missing files.


r = read_las_file('1107_shear.las');

depth = r.curves(1:end-2,1);
vp    = (1./r.curves(1:end-2,8)).*10^(6);
vs    = (1./r.curves(1:end-2,6)).*10^(6);
rho   =  r.curves(1:end-2,7);

