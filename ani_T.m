function T = ani_T(vphi,phi,h)


m=size(phi,2);
%layers
layer=h';
matrix_layer = layer(:,ones(1,m));

T = 2.*matrix_layer./(vphi.*cos(phi));
T = cumsum(T);

for i=1:size(T,1)
   for j=1:size(T,2)
   if isreal(T(i,j)) == 0
    T(i,j) = NaN;
   end

end
end

T(:,end) = Inf;
end