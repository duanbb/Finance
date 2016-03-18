%
% DhedgePut.m
%

disp('  ');
disp('  �v�b�g�I�v�V�����ɑ΂��ĕ����|�[�g�t�H���I���\�����܂��B');
disp('  GBmotion.m, BSput.m�����s������ɁA���s���Ă��������B');
input('  �������ł��Ă���Ȃ�΁A�����L�[�������Ă��������B');

disp('  ');
disp('  ���o�����X�̐���ݒ肵�܂��B��������菭�Ȃ�����ݒ肵�ĉ������B');
M=input('    ���o�����X�̐� = ');

Omega = []; Pdel = []; 
if M > 0,
  Omega(1) = vecP(1); 
  [CD,PD]=blsdelta(vecS(1),K,r,vectau(1),sigma,0);
  Pdel(1)=PD;
  PDtmp = []; PDtmp(1) = Pdel(1);
  kk = 1; jj=N/M;
  for nn = 1:N,
    if nn/jj <= kk,
      Pdel(nn)=PDtmp(kk);
    else, 
      [CD,PD]=blsdelta(vecS(nn),K,r,vectau(nn),sigma,0);
      Pdel(nn)=PD;
      PDtmp(kk+1) = Pdel(nn); kk = kk+1;
    end
    Omega(nn+1)=exp(r*dt)*Omega(nn)+Pdel(nn)*(vecS(nn+1)-exp(r*dt)*vecS(nn));
  end
else,
  Omega = vecP(1)*ones(size(vecP));
end

disp('  ');
disp('  �����|�[�g�t�H���I�̉��i�ϓ�(����)��\�����܂��B');
disp('  �_���́A�������_�ɂ�����v�b�g�I�v�V�����̉��i�ł��B');

figure(3)
hold off;
plot(vecT,Omega,'b-',vecT,vecP,'r:');
xlabel('����(�N)')
ylabel('�����|�[�g�t�H���I���i(����)�ƃv�b�g�I�v�V�������i(�_��)')

disp('  ');
disp('  �w�b�W�덷(�������_�̃I�v�V�����ƃ|�[�g�t�H���I���l�̍�)���v�Z���܂��B');
disp('  ');
stat = sprintf('  ���o�����X��%2.0f��̃w�b�W�덷�� %2.4f �ł��B',...
M,Omega(length(vecP))-vecP(length(vecP)));
disp(stat);


