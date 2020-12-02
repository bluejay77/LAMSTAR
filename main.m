% -*- Mode: octave -*-
%
% Daniel Graupe
%
% PRINCIPLES OF ARTIFICIAL NEURAL NETWORKS (2nd Edition)
%
% ISBN-13 978-981-270-624-9
% ISBN-10 981-270-624-0
%
% The LAMSTAR example, pp. 273 - 280
%
% Main.m
%
% Dr Antti Juhani Ylikoski 2020-09-27
%
% Usage:
% sudo apt-get install octave
% sudo apt-get install octave-doc
% octave main.m test_pattern.m training_pattern.m




clear all
close all
X = training_pattern;

%pause(1)
%close all
n = 12 % Number of subwords
flag = zeros(1,n);
% To make 12 subwords from 1 input
for i = 1:min(size(X)),
  X_r{i} = reshape(X(:,i),6,6);
  for j = 1:n,
    if (j<=6),
      X_in{i}(j,:) = X_r{i}(:,j)';
    else
      X_in{i}(j,:) = X_r{i}(j-6,:);
    end
end
% To check if a subword is all ’0’s and makes it normalized value equal to zero
% and to normalize all other input subwords

p(1,:) = zeros(1,6);
for k = 1:n,
  for t = 1:6,
    if (X_in{i}(k,t)~= p(1,t)),
      X_norm{i}(k,:) = X_in{i}(k,:)/sqrt(sum(X_in{i}(k,:).^2))
    else
      X_norm{i}(k,:) = zeros(1,6);
    end
  end
end
end%%%End of for
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dynamic Building of neurons
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Building of the first neuron is done as Kohonen Layer neuron
%(this is for all the subwords in the first input pattern for all SOM modules
i = 1;
ct = 1;
while (i<=n),
  i
  cl = 0;
  for t = 1:6,
    if (X_norm{ct}(i,t)==0),
      cl = cl+1;
    end
end
if (cl == 6),
  Z{ct}(i) = 0;
elseif (flag(i) == 0),
  W{i}(:,ct) = rand(6,1);
flag(i) = ct;
W_norm{i}(:,ct) = W{i}(:,ct)/sqrt(sum(W{i}(:,ct).^2));
Z{ct}(i)= X_norm{ct}(i,:)*W_norm{i};
alpha =0.8;
tol = 1e-5;
while(Z{ct}(i) <= (1-tol)),
  W_norm{i}(:,ct) = W_norm{i}(:,ct) + alpha*(X_norm{ct}(i,:) + W_norm{i}(:,ct));
  Z{ct}(i) = X_norm{ct}(i,:)*W_norm{i}(:,ct);
end%%%%%End of while
end%%%%End of if
r(ct,i) = 1;
i = i+1;
end%%%%End of while
r(ct,:) = 1;
ct = ct+1;
while (ct <= min(size(X))),
  for i = 1:n,
    cl = 0;
    for t = 1:6,
      if (X_norm{ct}(i,t)==0),
	cl = cl+1;
      end
if (cl == 6),
  Z{ct}(i) = 0;
else
  i
  r(ct,i) = flag(i);
  r_new=0;
  for k = 1:max(r(ct,i)),
    Z{ct}(i) = X_norm{ct}(i,:)*W_norm{i}(:,k);
    if Z{ct}(i)>=0.95,
      r_new = k;
      flag(i) = r_new;
      r(ct,i) = flag(i);
      break;
end%%%End of if
end%%%%%%%End of for
if (r_new==0),
  flag(i) = flag(i)+1;
  r(ct,i) = flag(i);
  W{i}(:,r(ct,i)) = rand(6,1);
				%flag(i) = r
  W_norm{i}(:,r(ct,i)) = W{i}(:,r(ct,i))/sqrt(sum(W{i}(:,r(ct,i)).^2));
  Z{ct}(i) = X_norm{ct}(i,:)*W_norm{i}(:,r(ct,i));
  alpha =0.8;
  tol = 1e-5;
  while(Z{ct}(i) <= (1-tol)),
    W_norm{i}(:,r(ct,i)) = W_norm{i}(:,r(ct,i)) + alpha*(X_norm{ct}(i,:)' - W_norm{i}(:,r(ct,i)));
    Z{ct}(i) = X_norm{ct}(i,:)*W_norm{i}(:,r(ct,i));
end%%%End of while
end%%%End of if
%r_new
%disp(’Flag’)
%flag(i)
end%%%%End of if
end
ct = ct+1;
end
save W_norm W_norm
for i = 1:5,
  d(i,:) = [0 0];
  d(i+5,:) = [0 1];
  d(i+10,:) = [1 0];
end
d(16,:) = [1 1];
%%%%%%%%%%%%%%%
% Link Weights
%%%%%%%%%%%%%%%
ct = 1
m_r = max(r);
for i = 1:n,
  L_w{i} = zeros(m_r(i),2);
end
ct = 1;
%%% Link weights and output calculations
Z_out = zeros(16,2);
while (ct <= 16),
  ct
				%for mn = 1:2
  L = zeros(12,2);
%
  for count = 1:20,
    for i = 1:n,
      if (r(ct,i)~=0),
	for j = 1:2,
	  if (d(ct,j)==0),
	    L_w{i}(r(ct,i),j) = L_w{i}(r(ct,i),j)-0.05*20;
	  else
	    L_w{i}(r(ct,i),j) = L_w{i}(r(ct,i),j)+0.05*20;
	  end %%End if loop
	end %%% End for loop
	L(i,:) = L_w{i}(r(ct,i),:);
      end %%%End for loop
    end
%
  end %%% End for loop
Z_out(ct,:) = sum(L);
ct = ct+1;
end
save L_w L_w

end

