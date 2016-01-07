function outseis(outfilename,tr);
%
% function writing an su file; 
% function was more or less copied from the outseis.c function
% of SOFI2D (see http://www.gpi.kit.edu/SOFI2D.php for source code of SOFI2D)
%
% Input:
%    outfilename    :    name of the su file
%    tr             :    struct containing the seismic unix header fields
%
%
% ---------

% Copyright (c) 2013 by Lisa Groos (Karlsruhe Institute of Technology) 
%
% ----
% This function is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version. 
% 
% This function is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program; if not, see 
% <http://www.gnu.org/licenses/gpl-2.0.html>.
%
% ---------
%

fid=fopen(outfilename,'w');

for tracl1=1:length(tr)      % /*SEGY (without file-header)*/
   
		
				

% Schreiben der Spur
count = fwrite(fid,tr(tracl1).tracl,'int');
count = fwrite(fid,tr(tracl1).tracr,'int');
count = fwrite(fid,tr(tracl1).fldr,'int');
count = fwrite(fid,tr(tracl1).tracf,'int');
count = fwrite(fid,tr(tracl1).ep,'int');
count = fwrite(fid,tr(tracl1).cdp,'int');
count = fwrite(fid,tr(tracl1).cdpt,'int');
count = fwrite(fid,tr(tracl1).trid,'short');
count = fwrite(fid,tr(tracl1).nvs,'short');
count = fwrite(fid,tr(tracl1).nhs,'short');
count = fwrite(fid,tr(tracl1).duse,'short');
count = fwrite(fid,tr(tracl1).offset,'int');
count = fwrite(fid,tr(tracl1).gelev,'int');
count = fwrite(fid,tr(tracl1).selev,'int');
count = fwrite(fid,tr(tracl1).sdepth,'int');
count = fwrite(fid,tr(tracl1).gdel,'int');
count = fwrite(fid,tr(tracl1).sdel,'int');
count = fwrite(fid,tr(tracl1).swdep,'int');
count = fwrite(fid,tr(tracl1).gwdep,'int');
count = fwrite(fid,tr(tracl1).scalel,'short');
count = fwrite(fid,tr(tracl1).scalco,'short');
count = fwrite(fid,tr(tracl1).sx,'int');
count = fwrite(fid,tr(tracl1).sy,'int');
count = fwrite(fid,tr(tracl1).gx,'int');
count = fwrite(fid,tr(tracl1).gy,'int');
count = fwrite(fid,tr(tracl1).counit,'short');
count = fwrite(fid,tr(tracl1).wevel,'short');
count = fwrite(fid,tr(tracl1).swevel,'short');
count = fwrite(fid,tr(tracl1).sut,'short');
count = fwrite(fid,tr(tracl1).gut,'short');
count = fwrite(fid,tr(tracl1).sstat,'short');
count = fwrite(fid,tr(tracl1).gstat,'short');
count = fwrite(fid,tr(tracl1).tstat,'short');
count = fwrite(fid,tr(tracl1).laga,'short');
count = fwrite(fid,tr(tracl1).lagb,'short');
count = fwrite(fid,tr(tracl1).delrt,'short');
count = fwrite(fid,tr(tracl1).muts,'short');
count = fwrite(fid,tr(tracl1).mute,'short');
count = fwrite(fid,tr(tracl1).ns,'ushort');
count = fwrite(fid,tr(tracl1).dt,'ushort');
count = fwrite(fid,tr(tracl1).gain,'short');	
count = fwrite(fid,tr(tracl1).igc,'short');
count = fwrite(fid,tr(tracl1).igi,'short');
count = fwrite(fid,tr(tracl1).corr,'short');
count = fwrite(fid,tr(tracl1).sfs,'short');
count = fwrite(fid,tr(tracl1).sfe,'short');
count = fwrite(fid,tr(tracl1).slen,'short');
count = fwrite(fid,tr(tracl1).styp,'short');
count = fwrite(fid,tr(tracl1).stas,'short');
count = fwrite(fid,tr(tracl1).stae,'short');
count = fwrite(fid,tr(tracl1).tatyp,'short');
count = fwrite(fid,tr(tracl1).afilf,'short');
count = fwrite(fid,tr(tracl1).afils,'short');
count = fwrite(fid,tr(tracl1).nofilf,'short');
count = fwrite(fid,tr(tracl1).nofils,'short');
count = fwrite(fid,tr(tracl1).lcf,'short');
count = fwrite(fid,tr(tracl1).hcf,'short');
count = fwrite(fid,tr(tracl1).lcs,'short');
count = fwrite(fid,tr(tracl1).hcs,'short');
count = fwrite(fid,tr(tracl1).year,'short');
count = fwrite(fid,tr(tracl1).day,'short');
count = fwrite(fid,tr(tracl1).hour,'short');
count = fwrite(fid,tr(tracl1).minute,'short');
count = fwrite(fid,tr(tracl1).sec,'short');
count = fwrite(fid,tr(tracl1).timbas,'short');
count = fwrite(fid,tr(tracl1).trwf,'short');
count = fwrite(fid,tr(tracl1).grnors,'short');
count = fwrite(fid,tr(tracl1).grnofr,'short');
count = fwrite(fid,tr(tracl1).grnlof,'short');
count = fwrite(fid,tr(tracl1).gaps,'short');
count = fwrite(fid,tr(tracl1).otrav,'short');
count = fwrite(fid,tr(tracl1).d1,'float');
count = fwrite(fid,tr(tracl1).f1,'float');
count = fwrite(fid,tr(tracl1).d2,'float');
count = fwrite(fid,tr(tracl1).f2,'float');
count = fwrite(fid,tr(tracl1).ungpow,'float');
count = fwrite(fid,tr(tracl1).unscale,'float');
count = fwrite(fid,tr(tracl1).ntr,'int');
count = fwrite(fid,tr(tracl1).mark,'short');
count = fwrite(fid,tr(tracl1).shortpad,'short');
count = fwrite(fid,tr(tracl1).unass,'short');
count = fwrite(fid,tr(tracl1).unass,'short');
count = fwrite(fid,tr(tracl1).unass,'short');
count = fwrite(fid,tr(tracl1).unass,'short');
count = fwrite(fid,tr(tracl1).unass,'short');
count = fwrite(fid,tr(tracl1).unass,'short');
count = fwrite(fid,tr(tracl1).unass,'short');
count = fwrite(fid,tr(tracl1).unass,'short');
count = fwrite(fid,tr(tracl1).unass,'short');
count = fwrite(fid,tr(tracl1).unass,'short');
count = fwrite(fid,tr(tracl1).unass,'short');
count = fwrite(fid,tr(tracl1).unass,'short');
count = fwrite(fid,tr(tracl1).unass,'short');
count = fwrite(fid,tr(tracl1).unass,'short');

%for ii=1:length(tr(tracl1).trace)
%   count = fwrite(fid,tr(tracl1).trace(ii),'float');
%end
count = fwrite(fid,tr(tracl1).trace,'float');
end
fclose(fid);
