function [C11_vhr,C13_vhr,C33_vhr,C44_vhr,C55_vhr,C66_vhr] = C_bound(Vsh,C11_shale,C13_shale,C33_shale,C44_shale,C55_shale,C66_shale,C11_sand,C13_sand,C33_sand,C44_sand,C55_sand,C66_sand)



%The Reuss - Bound

for i = 1:size(Vsh,1)
    
    C11_br(i,1) = 1/((( 1 - Vsh(i,1) )/C11_sand(i,1)) + (Vsh/C11_shale(i,1)));
    C13_br(i,1) = 1/((( 1 - Vsh(i,1) )/C13_sand(i,1)) + (Vsh/C13_shale(i,1)));
    C33_br(i,1) = 1/((( 1 - Vsh(i,1) )/C33_sand(i,1)) + (Vsh/C33_shale(i,1)));
    C44_br(i,1) = 1/((( 1 - Vsh(i,1) )/C44_sand(i,1)) + (Vsh/C44_shale(i,1)));
    C55_br(i,1) = 1/((( 1 - Vsh(i,1) )/C55_sand(i,1)) + (Vsh/C55_shale(i,1)));
    C66_br(i,1) = 1/((( 1 - Vsh(i,1) )/C66_sand(i,1)) + (Vsh/C66_shale(i,1)));
    
end


%The Voigt - Bound

for i = 1:size(Vsh,1)
    
    C11_bv(i,1) = ( 1 - Vsh(i,1) )*C11_sand(i,1) + Vsh*C11_shale(i,1);
    C13_bv(i,1) = ( 1 - Vsh(i,1) )*C13_sand(i,1) + Vsh*C13_shale(i,1);
    C33_bv(i,1) = ( 1 - Vsh(i,1) )*C33_sand(i,1) + Vsh*C33_shale(i,1);
    C44_bv(i,1) = ( 1 - Vsh(i,1) )*C44_sand(i,1) + Vsh*C44_shale(i,1);
    C55_bv(i,1) = ( 1 - Vsh(i,1) )*C55_sand(i,1) + Vsh*C55_shale(i,1);
    C66_bv(i,1) = ( 1 - Vsh(i,1) )*C66_sand(i,1) + Vsh*C66_shale(i,1);

end



%The VHR - Bound

for i = 1:size(Vsh,1)
    
    C11_vhr(i,1) = (C11_br(i,1) + C11_bv(i,1))/2; 
    C13_vhr(i,1) = (C13_br(i,1) + C13_bv(i,1))/2; 
    C33_vhr(i,1) = (C33_br(i,1) + C33_bv(i,1))/2; 
    C44_vhr(i,1) = (C44_br(i,1) + C44_bv(i,1))/2; 
    C55_vhr(i,1) = (C55_br(i,1) + C55_bv(i,1))/2; 
    C66_vhr(i,1) = (C66_br(i,1) + C66_bv(i,1))/2; 
    
end

