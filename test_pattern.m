% -*- Mode: octave -*-
%
%
% test pattern.m

function t_pat = test_pattern

  x1 = [0 0 0 0 0 0; 1 0 0 0 0 0; 1 1 1 1 1 0; 1 0 0 0 0 1; 1 0 0 0 0 1; 1 1 1 1 1 1];
  
x2 = zeros(6,6);
x2(:,1) = 1;
x2(3:6,6) = 1;
x2(6,:) = 1;
x2(3,5) = 1;
x2(4,4) = 1;
x2(5,3) = 1;

x3 = zeros(6,6);
x3(1,:) = 1;
x3(:,6) = 1;
x3(1:2,1) = 1;

x4 = zeros(6,6);
x4(1,3:6) = 1;
x4(1:5,6) = 1;

x5 = zeros(6,6);
for i = 1:6,
  x5(i,i) = 1;
end
x5(1,6) = 1;
x5(6,1) = 1;

x6 = x5;
x6(3,4) = 1;
x6(4,3) = 1;

x7 = zeros(6,6);
x7(:,4) = 1;

x8 = zeros(6,6);
x8(:,3:4) = 1;

xr1 = reshape(x1',1,36);
xr2 = reshape(x2',1,36);
xr3 = reshape(x3',1,36);
xr4 = reshape(x4',1,36);
xr5 = reshape(x5',1,36);
xr6 = reshape(x6',1,36);
xr7 = reshape(x7',1,36);
xr8 = reshape(x8',1,36);

t_pat = [xr1' xr2' xr3' xr4' xr5' xr6' xr7' xr8'];

