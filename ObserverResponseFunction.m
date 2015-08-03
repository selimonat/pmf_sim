function [ response] = ObserverResponseFunction(PFfit,aa,beta,gamma,lambda,x)
%Simulates an observer in a psychometric Experiment.
% Responses are generated following a Psychometric Function (PF) with
% Threshold aa, Slope ss (Beta = 1/ss), Gamma and Lambda.
% The Function has the shape defined by PFfit, e.g. PAL_CumulativeNormal

if PFfit([aa beta gamma lambda],x) >= rand(1);
    response = 1;
else
    response = 0;
end
end

