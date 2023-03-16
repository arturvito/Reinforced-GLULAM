function [nelem,nnodes,ELIST,NLIST,vol,centroids,nelem_bar,nnodes_bar] = getvalues(odir)
    disp([' '])
    disp(['         Importing values from ansys.'])


% get ELIST values
filename =  [odir '/ELIST.dat'];
ELIST = readmatrix(filename);
ELIST(1:4,:)=[];

% get NLIST values
filename =  [odir '/NLIST.dat'];
NLIST = readmatrix(filename);

% get element volume values
filename =  [odir '/ElementVolume.dat'];
vol = readmatrix(filename);

% get centroids
filename =  [odir '/Centroid_x.dat'];
centx = readmatrix(filename);
filename =  [odir '/Centroid_y.dat'];
centy = readmatrix(filename);
filename =  [odir '/Centroid_z.dat'];
centz = readmatrix(filename);


centroids = [centx centy centz];

% get mesh stats
filename =  [odir '/malha_stat.dat'];
geo_data = readmatrix(filename);
nelem = geo_data(1);
nnodes = geo_data(2);


% get mesh stats
filename =  [odir '/malha_stat_bar.dat'];
geo_data = readmatrix(filename);
nelem_bar = geo_data(1);
nnodes_bar = geo_data(2);

end