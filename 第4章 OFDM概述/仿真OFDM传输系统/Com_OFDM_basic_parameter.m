
NgType=1; % NgType=1/2 for cyclic prefix/zero padding
if NgType==1
    nt='CP';  
elseif NgType==2
    nt='ZP';   
end
Ch=1;  % Ch=0/1 for AWGN/multipath channel
if Ch==0
    chType='AWGN'; 
    Target_neb=100; 
else
    chType='CH'; 
    Target_neb=500; 
end
figure(Ch+1), clf
PowerdB=[0 -8 -17 -21 -25]; % Channel tap power profile 'dB'
Delay=[0 3 5 6 8];          % Channel delay 'sample'
Power=10.^(PowerdB/10);     % Channel tap power profile 'linear scale'
Ntap=length(PowerdB);       % Chanel tap number
Lch=Delay(end)+1;           % Channel length

Nbps=4; 
M=2^Nbps;                   % Modulation order=2/4/6 for QPSK/16QAM/64QAM

CarrierNum=64;
Nfft=CarrierNum;                    % FFT size                    
Ng=16;                  % Guard interval length
Nsym=Nfft+Ng;               % Symbol duration
Nvc=Nfft/8;                 % Nvc=0: no virtual carrier
Nused=Nfft-Nvc;
Nframe=16;         % Number of symbols per frame
EbN0=[0:1:20];    % EbN0

N_iter=1e5;       % Number of iterations for each EbN0
sigPow=0;         % Signal power initialization

file_name=['OFDM_BER_' chType '_' nt '_' 'GL' num2str(Ng) '.dat'];
fid=fopen(file_name, 'w+');
norms=[1 sqrt(2) 0 sqrt(10) 0 sqrt(42)];     % BPSK 4-QAM 16-QAM

