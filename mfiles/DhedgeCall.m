%
% DhedgeCall.m (�����|�[�g�t�H���I�̒Ǐ]���\�ƃ��o�����X�̉�)
%

disp('  ');
disp('  �R�[���I�v�V�����ɑ΂��ĕ����|�[�g�t�H���I���\�����܂��B');
disp('  GBmotion.m, BScall.m�����s������ɁA���s���Ă��������B');
input('  �������ł��Ă���Ȃ�΁A�����L�[�������Ă��������B');

disp('  ');
disp('  ���o�����X�̐���ݒ肵�܂��B��������菭�Ȃ�����ݒ肵�ĉ������B');
M=input('    ���o�����X�̐� = ');

Omega = []; Cdel = []; 
  Omega(1) = vecC(1); 
if M > 0,
  Cdel(1)=blsdelta(vecS(1),K,r,vectau(1),sigma,0);
  CDtmp = []; CDtmp(1) = Cdel(1);
  kk = 1; jj=N/M;
  for nn = 1:N,
    if nn/jj <= kk,
      Cdel(nn)=CDtmp(kk);
    else, 
      Cdel(nn)=blsdelta(vecS(nn),K,r,vectau(nn),sigma,0);
      CDtmp(kk+1) = Cdel(nn); kk = kk+1;
    end
    Omega(nn+1)=exp(r*dt)*Omega(nn)+Cdel(nn)*(vecS(nn+1)-exp(r*dt)*vecS(nn));
  end
else,
  Omega = vecC(1)*ones(size(vecC));
end

disp('  ');
disp('  �����|�[�g�t�H���I�̉��i�ϓ�(����)��\�����܂��B');
disp('  �_���́A�������_�ɂ�����R�[���I�v�V�����̉��i�ł��B');

figure(3)
hold off;
plot(vecT,Omega,'b-',vecT,vecC,'r:');
xlabel('����(�N)')
ylabel('�����|�[�g�t�H���I���i(����)�ƃR�[���I�v�V�������i(�_��)')

disp('  ');
disp('  �w�b�W�덷(�������_�̃I�v�V�����ƃ|�[�g�t�H���I���l�̍�)���v�Z���܂��B');
disp('  ');
stat = sprintf('  ���o�����X��%2.0f��̃w�b�W�덷�� %2.4f �ł��B',...
M,Omega(length(vecC))-vecC(length(vecC)));
disp(stat);


