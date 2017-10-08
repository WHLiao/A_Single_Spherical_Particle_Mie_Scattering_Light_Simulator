tic

clear all

lambda = 550 * 10^-9; % ���N�J���J�g���i��, ��� <m>
k0 = 2 * pi / lambda; % wave munber
k = k0*1.5; % �w�q�Ѽ�k
r = 50 * 10^-9; % �ɮ|�j�p, ��� <m>
m = 2/1.5; % �ɤl��g�v
x = k * r; % �w�q�Ѽ�x
z = m * x; % �w�q�Ѽ�z
i = sqrt(-1); % �w�q���i
N = round( x + 4.05*x^(1/3) + 2 ); % �w�q�L�a�żƪ��������
Z = 0.001; % �ɤl��Z�y�Ц�m 

Er = cos(pi/4); % �w�q�J�g���������q
El = sin(pi/4); % �w�q�J�g���������q

hold on
grid on

% �H�U�p��L�{�аѦҽפ�
for th = 0:1:90 % th �����g���PZ�b������, 1 ��@�׬��@�Ӷ��j
    
    theta = th * pi / 180; % �N th ���⦨�|��
    R = sec(theta) * Z; % �ɤl���y�Э��I���Z��

    PI(0 + 1) = 0;
    PI(1 + 1) = 1; 
    TAU(0 + 1) = 0;
    u = cos(theta);

    for p = 2:N+1
        s = u * PI(p);
        t = s - PI(p - 1);
        PI(p + 1) = s + t + t / (p - 1);
        TAU(p) = (p - 1) * t - PI(p - 1);
    end
 
    for t=1:N  
        T(t) = TAU(t+1);
        P(t) = PI(t+1);
    end
   
    for n = 1:N
        D(n) = -n/z + phi(n-1, z)/phi(n, z);
        a(n) =  ( (D(n)/m + n/x) * phi(n, x) - phi(n-1, x) ) / ( (D(n)/m + n/x) * kersi(n, x) - kersi(n-1, x) );
        b(n) = ( (m*D(n) + n/x) * phi(n, x) - phi(n-1, x) ) / ( (m*D(n) + n/x) * kersi(n, x) - kersi(n-1, x) );   
    end

    for u = 1:N 
        s1(u) = ( 2*u + 1 ) / ( u*(u+1) ) * ( a(u)*P(u) + b(u)*T(u) );
        s2(u) = ( 2*u + 1 ) / ( u*(u+1) ) * ( b(u)*P(u) + a(u)*T(u) );
    end
    
    S1 = sum(s1);
    S2 = sum(s2);
    Eout = (exp(-i*k*R + i*k*Z) / (i*k*R)) * [ S1, 0; 0, S2 ] * [ Er; El ];

    X(th+1, :) = Eout(1, 1); % �������g�����������q
    Y(th+1, :) = Eout(2, 1); % �������g�����������q

    ang1 = angle( Eout(2, 1)/Eout(1, 1) ) * 180 / pi; % �p�� phase
    ANG1(th+1, :) = ang1; % ���� phase

    plot(th, ang1, 'bo'); % �@���g���Pphase�����Y��
end

xlabel('���g�� <deg.>')
ylabel('�ۦ�t <deg.>')

toc