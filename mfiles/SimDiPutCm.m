%
% SimDiPutCm.m  �_�E���E�A���h�E�C���E�v�b�g�E�I�v�V�����Ə����t�������e�J�����@
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. �p�����[�^�ݒ�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

r=0.05;      % �����i100r ���^�N�j
sigma=0.25;  % �{���e�B���e�B�i100sigma ���^�N�j
T=4/12;      % �����i�N�j
S0=100;      % �������i
K=100;       % �s�g���i
Kb=90;       % �o���A
N=10000;     % �V�~�����[�V������ 
L=84;        % ���Ԃ̕�����
alpha=0.05;  % 1-�M������

randn('state',1);  % �����̏�����Ԃ̐ݒ�
delta=T/L;  % �P�ʎ��ԊԊu

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. �����Y���i�̃T���v���p�X�̐����C�y�C�I�t�̌v�Z
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h=zeros(1,N);

numin=0;  % �_�E���E�C���̔�����

for i=1:N  % �V�~�����[�V�����̔���
  S=zeros(1,L);
  for n=1:L  % �e�X�e�b�v�̔���
    if n==1
      S(1)=S0*exp((r-sigma^2/2)*delta+sigma*sqrt(delta)*randn);  % S1�̃T���v��
    else
      S(n)=S(n-1)*exp((r-sigma^2/2)*delta+sigma*sqrt(delta)*randn);
                                                                 % Sn�̃T���v��
    end
    if S(n)<Kb
      [BScall,BSput]=blsprice(S(n),K,r,T-n*delta,sigma,0);  % BS�I�v�V�������i
      h(i)=exp(r*(T-n)*delta)*BSput;  % �y�C�I�t�̌v�Z�i�_�E���E�C�������ꍇ�j
      numin=numin+1;  %  �_�E���E�C���̔����񐔂��J�E���g
      break;
    end
  end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. �I�v�V�������i�̕��ρE�M����Ԃ̌v�Z
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

YN=mean(h);
sd=std(h);

price=exp(-r*T)*YN;   % �I�v�V�������i
CI=[exp(-r*T)*(YN-norminv(1-alpha/2)*sd/sqrt(N)), ...
  exp(-r*T)*(YN+norminv(1-alpha/2)*sd/sqrt(N))];  % �M�����

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. ���ʂ̕\��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(sprintf('option price = %6.4f%n',price));
disp(sprintf('SD           = %6.4f%n',sd));
disp(sprintf('95%% C.I.     = [%6.4f, %6.4f]%n',CI(1),CI(2)));
disp(sprintf('#down in     = %d%n',numin));
