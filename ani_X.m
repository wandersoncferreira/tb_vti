function X = ani_X(phi,h)

m=size(phi,2);

%layers

layer=h';
matrix_layer = layer(:,ones(1,m));


X = 2.*matrix_layer.*tan(phi);
X = cumsum(X);



for i=1:size(X,1)
   for j=1:size(X,2)
   if isreal(X(i,j)) == 0
    X(i,j) = NaN;
   end

end
end

X(:,end) = Inf;

end
