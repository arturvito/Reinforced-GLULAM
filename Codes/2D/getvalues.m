function [nelem,nnodes,ELIST,NLIST,vol,centroids,K1,K2] = getvalues(odir)
    disp([' '])
    disp(['         Importing values from ansys.'])


% get ELIST values
filename =  [odir '/ELIST.dat'];
ELIST = readmatrix(filename);

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


% get ELIST values
filename =  [odir '/matkMMF1.txt'];
matk1 = readmatrix(filename);

filename =  [odir '/matkMMF2.txt'];
matk2 = readmatrix(filename);

K1 = create_matrix(matk1);

K2 = create_matrix(matk2);

end