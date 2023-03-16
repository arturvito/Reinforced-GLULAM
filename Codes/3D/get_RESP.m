function [ux,uy,uz,SENE] = get_RESP(odir)

% get ux
filename =  [odir '/ux.dat'];
ux = readmatrix(filename);

% get uy
filename =  [odir '/uy.dat'];
uy = readmatrix(filename);

% get uz
filename =  [odir '/uz.dat'];
uz = readmatrix(filename);

% get SENE
filename =  [odir '/SENE.dat'];
SENE = readmatrix(filename);
end


