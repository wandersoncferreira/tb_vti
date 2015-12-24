function [reflectivity,aa,control_time]=synthetic_well(x1,t,rc,matrix_phi,offset,array_time,dt,V1,length)


%time-lines
dim = size(offset,2);

t(isinf(t))=NaN;
%bb = array_time;

reflectivity = zeros(dim,size(array_time,2));
aa = zeros(size(array_time,2),dim);
control_time = zeros((size(rc,1)),dim);


p = ones(size(rc,1),1);  %counter which will be updated when the desired position were reached

for j = 1:dim   %will increase the offset value
    
    for m=1:(size(rc,1))  %loop to increase the layers
    
        for k=p(m,1):(size(rc,2))  %loop to search within layers
    
        if x1(m,k)>= offset(j) && isreal(x1(m,k))==1  && isinf(x1(m,k)) == 0
 
            p(m,1) = k;   %updating the vector position where the desired offset was found

%the normal incidence
           if k==1
             time = t(m,1);
             rcc = rc(m,1);
             angulos = matrix_phi(m,1);
             angE = matrix_phi(1,1);
     
            else  

            fac = (offset(j)^2 - x1(m,k-1)^2)/(x1(m,k)^2 - x1(m,k-1)^2); %interpolator coeff

            time =  sqrt( t(m,k-1).^2 + fac*(t(m,k)^2 - t(m,k-1)^2) );  %time

            rcc =  rc(m,k-1) + fac*(rc(m,k) - rc(m,k-1));  %reflection coeff

            angulos =  matrix_phi(m,k-1) + fac*(matrix_phi(m,k) - matrix_phi(m,k-1)) ; % angle

            angE = matrix_phi(1,k-1) + fac*(matrix_phi(1,k) - matrix_phi(1,k-1));  %angle of emergence

           end
   
           
        control_time(m,j) = time;  %table with the time arrival for every reflection
        aa(m,j) = angE; 
            
    
%calculating the reflection coefficient
        if isreal(rcc)==1 && angulos < (85)*pi/180 && rcc ~= 0
      
        reflectivity(j,:) = array_effect(reflectivity(j,:),rcc,length,V1,angE,time,array_time,dt);
  
        end
        break
 
        end
        end
    end
end


for z = 1:dim
    vv = find(isnan(reflectivity(z,:)),1,'last');
    reflectivity(z,1:vv) = 0;
end







