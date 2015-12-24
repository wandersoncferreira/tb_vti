function trace_out = array_effect(trace,RC,L,v,E,time,tl,dt)


%RC = trace(1,201);
N = size(trace,2);



f = (L/v)*sin(E);
it = -0.5:0.05:0.5;

factor = f.*it;

tnew = time + factor;

%fid = fopen('variables.txt','a');

%taking care of values smaller than zero (casuality) and after end log time
tnew(tnew <= 0) = 0;
tnew(tnew > max(tl(:))) = max(tl(:))- dt;


RCweight = RC/21;

%positioning, spliting amplitudes of the 21 geophones
new_trace = zeros(1,N);
new_trace1 = zeros(1,N);
trace_out = zeros(1,N);

for i=1:21

    tnew1 = tnew(1,i);
    its = tnew1/dt + 10e-10;
    it1 = floor(tnew1/dt + 10e-10);
    it2 = it1 + 1;
    a = its - it1;
    
    %fprintf(fid, 'tnew1: %f  \n  its: %f  \n  it1: %f \n a: %f \n', tnew1,its,it1,a);
   
   
    
    new_trace(it1) = (1 - a)*RCweight + new_trace(it1);
    new_trace1(it2) = a*RCweight + new_trace1(it2);

end


new_trace_end = new_trace + new_trace1;
trace_out = trace + new_trace_end;


return
