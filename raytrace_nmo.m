function dout= raytrace_nmo(d,dt,control_time,ti,max_stretch)
%NMO: A program for NMO correction.


  [nt,nh] = size(d);
  dout = zeros(size(d));

  for it = 1:nt-1;
  for ih = 1:nh;

    time = control_time(it,ih);
    stretch = (time-ti(it))/(ti(it)+1e-10);
  
  
  if stretch < max_stretch/100
      
  its = time/dt + 10e-10;
  it1 = floor(time/dt + 10e-10);
  it2 = it1+1;
  a = its-it1;
  

      if it2 <= nt && it1 ~= 0; 
        dout(it,ih) = (1-a)*d(it1,ih)+a*d(it2,ih); % + dout(it,ih);  
      end

 
  end
  
 end;
 end;
 

 return;
    
