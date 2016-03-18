%
% AmericanPut.m (�񍀃��f���ɂ��A�����J���v�b�g�I�v�V�������)
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. �p�����[�^�̐ݒ�
% 
% S0; �����Y�����l:            sigma; �{���e�B���e�B:        
% r; ���X�N�t���[���[�g:       rho; �z����(�z�������̏ꍇ��0):
% T; �I�v�V��������(�N):       N; ���Ԑ�:   
% K; �s�g���i:                 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

S0 = 100; sigma = 0.4; r = 0.1; K = 100; T = 3/12; 

rho = 0; %rho = 0.1; rho = 0.2;  
    % �z����(�z�������̏ꍇ��0).
N = 8;      % ���֐�
dt = T/N;   % �e���Ԃ̒���
af = exp((r-rho)*dt); 
    % �z�����l������1���Ԃ�accumulation factor

u = exp(sigma*sqrt(dt)); d = 1/u; % �㏸���A����щ��~��
p = (af-d)/(u-d); q = 1-p;        % ���X�N�����m�� (p;�㏸, q; ���~)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. �����Y�񍀃��f���̌v�Z
% 
% S; �����Y���i�s�� (N+1�sN+1��)
%    �������AS(jj,nn)��nn-1�X�e�b�v�ɂ�����ォ��jj�Ԗڂ̃m�[�h
%    �ɂ����錴���Y���i
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

S = NaN*ones(N+1,N+1);

for nn = 1:N+1,
  for jj = 1:nn,
     S(jj,nn)=u^(nn-jj)*d^(jj-1)*S0;
  end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. �v�b�g�I�v�V�����񍀃��f���̌v�Z
% 
% Ap; �A�����J���v�b�g�I�v�V�������i�s�� (N+1�sN+1��)
%     Ap(jj,nn)��nn-1�X�e�b�v�ɂ�����ォ��jj�Ԗڂ̃m�[�h�ɂ�����
%     �I�v�V�������l
% Sk; �A�����J���v�b�g�I�v�V�����s�g���l�s�� (N+1�sN+1��)
%     Sk(jj,nn)��nn-1�X�e�b�v�ɂ�����ォ��jj�Ԗڂ̃m�[�h�ɂ�����
%     �s�g���l
% Dk; �A�����J���v�b�g�I�v�V�����s�g����s�� (N+1�sN+1��)
%     Dk(jj,nn)��nn-1�X�e�b�v�ɂ�����ォ��jj�Ԗڂ̃m�[�h���A�p��
%     �̈�ɓ���ꍇ�͗�A�s�g�̈�ɓ���ꍇ��1������
% ex_period; �����s�g���n�߂ċN�������s���I�h(���_)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Sk=max(K-S,0);                 % �s�g���l�s��̌v�Z
Dk=NaN*ones(N+1,N+1);          % �s�g����s��̏�����
Ap = NaN*ones(N+1,N+1);        % ���i�s��̏�����

Ap(:,N+1) = max(K-S(:,N+1),0); 
Dk(:,N+1) = max(K-S(:,N+1),0)./max(K-S(:,N+1),eps);
ex_period = N; 
for nn = N:-1:1,
  for jj = 1:nn,
    Ap_d = exp(-r*dt)*(p*Ap(jj,nn+1)+q*Ap(jj+1,nn+1)); % �p�����l�̌v�Z
    Ap(jj,nn)= max(Ap_d,Sk(jj,nn));                    % �s�g���l�Ƃ̔�r
    Dk(jj,nn)=0;
    if Ap(jj,nn)==Sk(jj,nn)&Sk(jj,nn)>0,
      Dk(jj,nn)=1;             % �p���̈�ɂ���ꍇ�͗�
      ex_period = nn-1;        % �����s�g���_�̍X�V
    end
  end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. �I�v�V�����������i�̕\���ƍs�g�̈�̌���
% 
% ex_time; �����s�g���n�߂ċN����������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ap0 = Ap(1,1); % �񍀃��f���ɂ�����I�v�V�����������i
     
disp('  �A�����J���v�b�g�I�v�V�������i Ap0 = ');
disp(Ap0)

ex_time = ex_period*dt;

disp('  �ł������s�g���� ex_time = ');
disp(ex_time)


