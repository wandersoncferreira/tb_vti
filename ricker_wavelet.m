function amplitude = ricker_wavelet(Fc,time,dt)
   % Fc = Central frequency
   % time = Time length
   % dt = sample rate

                 
   t = (-(time):dt:time)';
   N = size(t,1);
   
   p = Fc.*Fc.*t.*t;
   amplitude = (1-2*pi*pi.*p).*exp(-pi*pi.*p);

   
   %%Calculating the area under the wavelet
   m = size(amplitude,1);
   coeff = 2*ones(1,m-2);
   coeff = [1, coeff, 1];
   int = (0.5)*sum(amplitude'.*coeff); %trapezoid method
   
   %% Plot the spectrum:
   figure;
   plot(t,amplitude)
   xlabel('time (s)','Fontsize',18);
   title(['Area under the curve: ',num2str(int)],'Fontsize',20);
   
end