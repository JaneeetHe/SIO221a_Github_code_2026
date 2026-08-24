%Demonstrate a simple wavenumber frequency spectrum.
%MHA 11/16/2017
%sio221c
%
%First run the DATA LOAD BLOCK 1 for synthetic data or 2 for real data - 
%Then run the SPECTRAL CALCULATION BLOCKS to generate and plot the
%wavenumber frequency spectrum.

%% DATA LOAD BLOCK 1: generate a synthetic signal
H=1000;

dt=0.05; %time interval about 20 times a day
dz=10; %10-m
t=0:dt:10; %time in days
z=(0:dz:H)'; %depth in m

%indices for the calculation
iz=1:length(z);
it=1:length(t);

%force them to be even - makes everything easier
if rem(length(iz),2)==1
    iz=iz(1:end-1);
end

if rem(length(it),2)==1
    it=it(1:end-1);
end

%Generate a propagating signal.
[tt,zz]=meshgrid(t,z);
sig1=sin(3*pi*zz/H - 2*pi*1/3*tt);%+0.1*rand(length(z),length(t)); %mode 1, 3 day timescale
%Change the sign to make propagation go the other way.

t=t(it);
z=z(iz);

data=sig1(iz,it);%+i*Vel.v(iz,it);

% PLOT
figure(2)
ezpc(t,z,data);colorbar


%% DATA LOAD BLOCK 2: Load real data - see me for the data if you are interested.
load('Vel_2008-2009.mat')
% limits - stay away from NANs
tmin=165;
tmax=895;

zmin=120; 
zmax=790;


%indices for the calculation
iz=find(Vel.z > zmin & Vel.z < zmax);
it=find(Vel.yday > tmin & Vel.yday < tmax);

%force them to be even
if rem(length(iz),2)==1
    iz=iz(1:end-1);
end

if rem(length(it),2)==1
    it=it(1:end-1);
end

%sample intervals in time and depth
dt=nanmean(diff(Vel.yday(it)));
dz=nanmean(diff(Vel.z(iz)));
%
time=Vel.yday(it);
z=Vel.z(iz);

data=Vel.u(iz,it);%+i*Vel.v(iz,it);

% remove NaN's
for c=1:length(iz)
    data(c,:)=naninterp(data(c,:));
%    data(c,:)=detrend(data(c,:));
end
%
for c=1:length(it)
    data(:,c)=naninterp(data(:,c)');
%    data(c,:)=detrend(data(c,:));
end

% Plot
ezpc(time,z,data);caxis([-.25 .25]);colorbar
shg

size(find(isnan(data)))

%% SPECTRAL CALCULATION BLOCK A: Detrend if needed
do_detrend = 0;

%detrend
if do_detrend
%next demean and detrend each column
data=detrend(data,'constant');
data=detrend(data);

%then do the rows
data=detrend(data.','constant').';
data=detrend(data.').';
%for c=1:length(it)
%    data(:,c)=detrend(data(:,c));
%end
end

%% SPECTRAL CALCULATION BLOCK B: Compute the wavenumber frequency spectrum given data, dt, dz. 
[m,n]=size(data);

fn=1/2/dt;
kn=1/2/dz;


%fundamental frequency and wavenumber
df=1./n./dt;
dk=1./m./dz;


f=[-fliplr(1:(n/2)) 0 (1:(n/2-1))].*df;
k=[-fliplr(1:(m/2)) 0 (1:(m/2-1))].'.*dk;


% Make a matrix of group velocity values
%We'll want to sum cgE over the -k, -omega part of the spectrum to get downward energy flux 
%
[fm,km]=meshgrid(f,k);

st=fftshift(fft2(data))/m/n;
%normalization: with matlab's fft2, if st=fft2(data), then sum(sum(st.*conj(st)))/m/n is the same as
%sum(sum(data.*conj(data))).
%
%Hence we normalize the transform such that Parseval's theorem is upheld.  

%So the spectrum is then given by
spec=st.*conj(st)./df./dk; %UNITS: (m/s)^2/cpd/cpm

%And has the property that sum(sum(spec)*df*dk is the variance.  
% integrals
speck=sum(spec,2)*df; %wavenumber spectrum.  UNITS: (m/s)^2/cpm
specf=sum(spec,1)*dk; %frequency spectrum.  UNITS: (m/s)^2/cpd

%% SPECTRAL CALCULATION BLOCK C: PLOT
figure(11)
ezpc(f,k,log10(spec))
colormap(jet)
shg
xlabel('\omega / cpd')
ylabel('m / cpm')

xl=[0 max(f)];
xlim(xl)

% Plot the frequency spectrum.
figure(12)
loglog(f,specf)
shg

% Plot the wavenumber spectrum.
figure(13)
loglog(k,speck)
shg


%SEGMENTING
% chopping into segments
for i=1:19
data2(:,1:3500,i)=data(:,(i-1)*3500/2 + (1:3500));
end

n=3500;
for i=1:19
 fdata2(:,:,i)=abs(fftshift(fft2(data2(:,:,i)))).^2/m/n;
end

df=1./n./dt;
f=[-fliplr(1:(n/2)) 0 (1:(n/2-1))].*df;
dk=1./m./dz;
spec=mean(fdata2,3)/(m*n*df*dk);

imagesc(f(n/2:end),k,log10(spec(:,n/2:end)))
