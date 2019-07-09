% Unilateral connection within EI connection;
% Model basis: Hodgkin huxley model
% Description: within 20 neurons (5E-5I, intra(E-I & I-E), inter (I-I))
% Main content: 1) parameter; 2) function; 3) solver;

%% Basic function relations
% DIFFERENTIAL EQUATIONS:
%  E_v' = ((E_input1_Iapp+E_input1_noise*randn(1,E_Npop)))+((E_ina_INa(E_v,E_ina_m,E_ina_h))+((E_ik_IK(E_v,E_ik_n))))+((-E_I_igaba_ISYN(E_v,E_I_igaba_s)))
%  E_ina_m' =  E_ina_aM(E_v).*(1-E_ina_m)-E_ina_bM(E_v).*E_ina_m
%  E_ina_h' =  E_ina_aH(E_v).*(1-E_ina_h)-E_ina_bH(E_v).*E_ina_h
%  E_ik_n' =  E_ik_aN(E_v).*(1-E_ik_n)-E_ik_bN(E_v).*E_ik_n
%  I_v' = ((I_input1_Iapp+I_input1_noise*randn(1,I_Npop)))+((I_ina_INa(I_v,I_ina_m,I_ina_h))+((I_ik_IK(I_v,I_ik_n))))+((-I_E_iampa_ISYN(I_v,I_E_iampa_s)))
%  I_ina_m' =  I_ina_aM(I_v).*(1-I_ina_m)-I_ina_bM(I_v).*I_ina_m
%  I_ina_h' =  I_ina_aH(I_v).*(1-I_ina_h)-I_ina_bH(I_v).*I_ina_h
%  I_ik_n' =  I_ik_aN(I_v).*(1-I_ik_n)-I_ik_bN(I_v).*I_ik_n
%  E_I_igaba_s' = -E_I_igaba_s./E_I_igaba_tauD+((1-E_I_igaba_s)/E_I_igaba_tauR).*(1+tanh(I_v/10))
%  I_E_iampa_s' = -I_E_iampa_s./I_E_iampa_tauD+((1-I_E_iampa_s)/I_E_iampa_tauR).*(1+tanh(E_v/10))
% Initial conditions:
%  E_v(0) = -65 * ones(1,E_Npop)
%  E_ina_m(0) = .1*ones(1,E_Npop)
%  E_ina_h(0) = .1*ones(1,E_Npop)
%  E_ik_n(0) = 0*ones(1,E_Npop)
%  I_v(0) = -65 * ones(1,I_Npop)
%  I_ina_m(0) = .1*ones(1,I_Npop)
%  I_ina_h(0) = .1*ones(1,I_Npop)
%  I_ik_n(0) = 0*ones(1,I_Npop)
%  E_I_igaba_s(0) = .1*ones(1,I_Npop)
%  I_E_iampa_s(0) = .1*ones(1,E_Npop)

clc;
clear all;

%% Parameter Space:
% Sodium conductance:120; Potasium condunctance:36; 
% E-Input current:5; I-Input current:0;
% E-num:1; E-num:1;
  E_ina_gNa = +120.0000; E_ik_gK = +36.0000; 
  E_input1_Iapp = +5.0000; E_input1_noise = +0.0000; 
  E_Npop = +1.0000;     % represent for the number in each neuron groups;
  I_ina_gNa = +120.0000; I_ik_gK = +36.0000;
  I_input1_Iapp = +0.0000; I_input1_noise = +0.0000; 
  I_Npop = +1.0000;
  E3_ina_gNa = +120.0000; E3_ik_gK = +36.0000;
  E3_input1_Iapp = +5.0000; E3_input1_noise = +0.0000; 
  E3_Npop = +1.0000;
  I4_ina_gNa = +120.0000; I4_ik_gK = +36.0000; 
  I4_input1_Iapp = +0.0000; I4_input1_noise = +0.0000; 
  I4_Npop = +1.0000;
  E5_ina_gNa = +120.0000; E5_ik_gK = +36.0000;
  E5_input1_Iapp = +5.0000; E5_input1_noise = +0.0000; 
  E5_Npop = +1.0000;
  I6_ina_gNa = +120.0000; I6_ik_gK = +36.0000;
  I6_input1_Iapp = +0.0000; I6_input1_noise = +0.0000; 
  I6_Npop = +1.0000;
  E7_ina_gNa = +120.0000; E7_ik_gK = +36.0000;
  E7_input1_Iapp = +5.0000; E7_input1_noise = +0.0000; 
  E7_Npop = +1.0000;
  I8_ina_gNa = +120.0000; I8_ik_gK = +36.0000;
  I8_input1_Iapp = +0.0000; I8_input1_noise = +0.0000; 
  I8_Npop = +1.0000;
  E9_ina_gNa = +120.0000; E9_ik_gK = +36.0000;
  E9_input1_Iapp = +5.0000; E9_input1_noise = +0.0000; 
  E9_Npop = +1.0000;
  I10_ina_gNa = +120.0000; I10_ik_gK = +36.0000;
  I10_input1_Iapp = +0.0000; I10_input1_noise = +0.0000; 
  I10_Npop = +1.0000;
% Synaptic connection:(GDL-A27h-GDL)
  E_I_igaba_gSYN = +0.2500; E_I_igaba_ESYN = -80.0000;
  E_I_igaba_tauD = +10.0000; E_I_igaba_tauR = +0.4000;
  I4_I_igaba_gSYN = +0.2500; I4_I_igaba_ESYN = -80.0000;
  I4_I_igaba_tauD = +10.0000; I4_I_igaba_tauR = +0.4000;
  E3_I4_igaba_gSYN = +0.2500; E3_I4_igaba_ESYN = -80.0000;
  E3_I4_igaba_tauD = +10.0000; E3_I4_igaba_tauR = +0.4000;
  I6_I4_igaba_gSYN = +0.2500; I6_I4_igaba_ESYN = -80.0000;
  I6_I4_igaba_tauD = +10.0000; I6_I4_igaba_tauR = +0.4000; 
  E5_I6_igaba_gSYN = +0.2500; E5_I6_igaba_ESYN = -80.0000;
  E5_I6_igaba_tauD = +10.0000; E5_I6_igaba_tauR = +0.4000;
  I8_I6_igaba_gSYN = +0.2500; I8_I6_igaba_ESYN = -80.0000;
  I8_I6_igaba_tauD = +10.0000; I8_I6_igaba_tauR = +0.4000;
  E7_I8_igaba_gSYN = +0.2500; E7_I8_igaba_ESYN = -80.0000;
  E7_I8_igaba_tauD = +10.0000; E7_I8_igaba_tauR = +0.4000;
  I10_I8_igaba_gSYN = +0.2500; I10_I8_igaba_ESYN = -80.0000;
  I10_I8_igaba_tauD = +10.0000; I10_I8_igaba_tauR = +0.4000;
  E9_I10_igaba_gSYN = +0.2500; E9_I10_igaba_ESYN = -80.0000;
  E9_I10_igaba_tauD = +10.0000; E9_I10_igaba_tauR = +0.4000;
  I_I10_igaba_gSYN = +0.2500; I_I10_igaba_ESYN = -80.0000;
  I_I10_igaba_tauD = +10.0000; I_I10_igaba_tauR = +0.4000;
  % with E-I intra connection
  I_E_iampa_gSYN = +0.1000; I_E_iampa_ESYN = +0.0000;
  I_E_iampa_tauD = +2.0000; I_E_iampa_tauR = +0.4000;
  I4_E3_iampa_gSYN = +0.1000; I4_E3_iampa_ESYN = +0.0000;
  I4_E3_iampa_tauD = +2.0000; I4_E3_iampa_tauR = +0.4000;
  I6_E5_iampa_gSYN = +0.1000; I6_E5_iampa_ESYN = +0.0000;
  I6_E5_iampa_tauD = +2.0000; I6_E5_iampa_tauR = +0.4000;
  I8_E7_iampa_gSYN = +0.1000; I8_E7_iampa_ESYN = +0.0000;
  I8_E7_iampa_tauD = +2.0000; I8_E7_iampa_tauR = +0.4000;
  I10_E9_iampa_gSYN = +0.1000; I10_E9_iampa_ESYN = +0.0000;
  I10_E9_iampa_tauD = +2.0000; I10_E9_iampa_tauR = +0.4000;
  
% Neuron population setting:
  E_I_igaba_netcon = ones(I_Npop,E_Npop);
  I4_I_igaba_netcon = ones(I_Npop,I4_Npop);
  E3_I4_igaba_netcon = ones(I4_Npop,E3_Npop);
  I6_I4_igaba_netcon = ones(I4_Npop,I6_Npop);
  E5_I6_igaba_netcon = ones(I6_Npop,E5_Npop);
  I8_I6_igaba_netcon = ones(I6_Npop,I8_Npop);
  E7_I8_igaba_netcon = ones(I8_Npop,E7_Npop);
  I10_I8_igaba_netcon = ones(I8_Npop,I10_Npop);
  E9_I10_igaba_netcon = ones(I10_Npop,E9_Npop);
  I_I10_igaba_netcon = ones(I10_Npop,I_Npop);
  % with E-I intra connection
  I_E_iampa_netcon = ones(E_Npop,I_Npop);
  I4_E3_iampa_netcon = ones(E3_Npop,I4_Npop);
  I6_E5_iampa_netcon = ones(E5_Npop,I6_Npop);
  I8_E7_iampa_netcon = ones(E7_Npop,I8_Npop);
  I10_E9_iampa_netcon = ones(E9_Npop,I10_Npop);
  
  
%% Functions:
  E_ina_INa = @(E_v,E_ina_m,E_ina_h) -E_ina_gNa.*E_ina_m.^3.*E_ina_h.*(E_v-50);
  E_ina_aM = @(E_v) (2.5-.1*(E_v+65))./(exp(2.5-.1*(E_v+65))-1);
  E_ina_bM = @(E_v) 4*exp(-(E_v+65)/18);
  E_ina_aH = @(E_v) .07*exp(-(E_v+65)/20);
  E_ina_bH = @(E_v) 1./(exp(3-.1*(E_v+65))+1);
  E_ik_IK = @(E_v,E_ik_n) -E_ik_gK.*E_ik_n.^4.*(E_v+77);
  E_ik_aN = @(E_v) (.1-.01*(E_v+65))./(exp(1-.1*(E_v+65))-1);
  E_ik_bN = @(E_v) .125*exp(-(E_v+65)/80);
  I_ina_INa = @(I_v,I_ina_m,I_ina_h) -I_ina_gNa.*I_ina_m.^3.*I_ina_h.*(I_v-50);
  I_ina_aM = @(I_v) (2.5-.1*(I_v+65))./(exp(2.5-.1*(I_v+65))-1);
  I_ina_bM = @(I_v) 4*exp(-(I_v+65)/18);
  I_ina_aH = @(I_v) .07*exp(-(I_v+65)/20);
  I_ina_bH = @(I_v) 1./(exp(3-.1*(I_v+65))+1);
  I_ik_IK = @(I_v,I_ik_n) -I_ik_gK.*I_ik_n.^4.*(I_v+77);
  I_ik_aN = @(I_v) (.1-.01*(I_v+65))./(exp(1-.1*(I_v+65))-1);
  I_ik_bN = @(I_v) .125*exp(-(I_v+65)/80);
  E3_ina_INa = @(E3_v,E3_ina_m,E3_ina_h) -E3_ina_gNa.*E3_ina_m.^3.*E3_ina_h.*(E3_v-50);
  E3_ina_aM = @(E3_v) (2.5-.1*(E3_v+65))./(exp(2.5-.1*(E3_v+65))-1);
  E3_ina_bM = @(E3_v) 4*exp(-(E3_v+65)/18);
  E3_ina_aH = @(E3_v) .07*exp(-(E3_v+65)/20);
  E3_ina_bH = @(E3_v) 1./(exp(3-.1*(E3_v+65))+1);
  E3_ik_IK = @(E3_v,E3_ik_n) -E3_ik_gK.*E3_ik_n.^4.*(E3_v+77);
  E3_ik_aN = @(E3_v) (.1-.01*(E3_v+65))./(exp(1-.1*(E3_v+65))-1);
  E3_ik_bN = @(E3_v) .125*exp(-(E3_v+65)/80);
  I4_ina_INa = @(I4_v,I4_ina_m,I4_ina_h) -I4_ina_gNa.*I4_ina_m.^3.*I4_ina_h.*(I4_v-50);
  I4_ina_aM = @(I4_v) (2.5-.1*(I4_v+65))./(exp(2.5-.1*(I4_v+65))-1);
  I4_ina_bM = @(I4_v) 4*exp(-(I4_v+65)/18);
  I4_ina_aH = @(I4_v) .07*exp(-(I4_v+65)/20);
  I4_ina_bH = @(I4_v) 1./(exp(3-.1*(I4_v+65))+1);
  I4_ik_IK = @(I4_v,I4_ik_n) -I4_ik_gK.*I4_ik_n.^4.*(I4_v+77);
  I4_ik_aN = @(I4_v) (.1-.01*(I4_v+65))./(exp(1-.1*(I4_v+65))-1);
  I4_ik_bN = @(I4_v) .125*exp(-(I4_v+65)/80);
  E5_ina_INa = @(E5_v,E5_ina_m,E5_ina_h) -E5_ina_gNa.*E5_ina_m.^3.*E5_ina_h.*(E5_v-50);
  E5_ina_aM = @(E5_v) (2.5-.1*(E5_v+65))./(exp(2.5-.1*(E5_v+65))-1);
  E5_ina_bM = @(E5_v) 4*exp(-(E5_v+65)/18);
  E5_ina_aH = @(E5_v) .07*exp(-(E5_v+65)/20);
  E5_ina_bH = @(E5_v) 1./(exp(3-.1*(E5_v+65))+1);
  E5_ik_IK = @(E5_v,E5_ik_n) -E5_ik_gK.*E5_ik_n.^4.*(E5_v+77);
  E5_ik_aN = @(E5_v) (.1-.01*(E5_v+65))./(exp(1-.1*(E5_v+65))-1);
  E5_ik_bN = @(E5_v) .125*exp(-(E5_v+65)/80);
  I6_ina_INa = @(I6_v,I6_ina_m,I6_ina_h) -I6_ina_gNa.*I6_ina_m.^3.*I6_ina_h.*(I6_v-50);
  I6_ina_aM = @(I6_v) (2.5-.1*(I6_v+65))./(exp(2.5-.1*(I6_v+65))-1);
  I6_ina_bM = @(I6_v) 4*exp(-(I6_v+65)/18);
  I6_ina_aH = @(I6_v) .07*exp(-(I6_v+65)/20);
  I6_ina_bH = @(I6_v) 1./(exp(3-.1*(I6_v+65))+1);
  I6_ik_IK = @(I6_v,I6_ik_n) -I6_ik_gK.*I6_ik_n.^4.*(I6_v+77);
  I6_ik_aN = @(I6_v) (.1-.01*(I6_v+65))./(exp(1-.1*(I6_v+65))-1);
  I6_ik_bN = @(I6_v) .125*exp(-(I6_v+65)/80);
  E7_ina_INa = @(E7_v,E7_ina_m,E7_ina_h) -E7_ina_gNa.*E7_ina_m.^3.*E7_ina_h.*(E7_v-50);
  E7_ina_aM = @(E7_v) (2.5-.1*(E7_v+65))./(exp(2.5-.1*(E7_v+65))-1);
  E7_ina_bM = @(E7_v) 4*exp(-(E7_v+65)/18);
  E7_ina_aH = @(E7_v) .07*exp(-(E7_v+65)/20);
  E7_ina_bH = @(E7_v) 1./(exp(3-.1*(E7_v+65))+1);
  E7_ik_IK = @(E7_v,E7_ik_n) -E7_ik_gK.*E7_ik_n.^4.*(E7_v+77);
  E7_ik_aN = @(E7_v) (.1-.01*(E7_v+65))./(exp(1-.1*(E7_v+65))-1);
  E7_ik_bN = @(E7_v) .125*exp(-(E7_v+65)/80);
  I8_ina_INa = @(I8_v,I8_ina_m,I8_ina_h) -I8_ina_gNa.*I8_ina_m.^3.*I8_ina_h.*(I8_v-50);
  I8_ina_aM = @(I8_v) (2.5-.1*(I8_v+65))./(exp(2.5-.1*(I8_v+65))-1);
  I8_ina_bM = @(I8_v) 4*exp(-(I8_v+65)/18);
  I8_ina_aH = @(I8_v) .07*exp(-(I8_v+65)/20);
  I8_ina_bH = @(I8_v) 1./(exp(3-.1*(I8_v+65))+1);
  I8_ik_IK = @(I8_v,I8_ik_n) -I8_ik_gK.*I8_ik_n.^4.*(I8_v+77);
  I8_ik_aN = @(I8_v) (.1-.01*(I8_v+65))./(exp(1-.1*(I8_v+65))-1);
  I8_ik_bN = @(I8_v) .125*exp(-(I8_v+65)/80);
  E9_ina_INa = @(E9_v,E9_ina_m,E9_ina_h) -E9_ina_gNa.*E9_ina_m.^3.*E9_ina_h.*(E9_v-50);
  E9_ina_aM = @(E9_v) (2.5-.1*(E9_v+65))./(exp(2.5-.1*(E9_v+65))-1);
  E9_ina_bM = @(E9_v) 4*exp(-(E9_v+65)/18);
  E9_ina_aH = @(E9_v) .07*exp(-(E9_v+65)/20);
  E9_ina_bH = @(E9_v) 1./(exp(3-.1*(E9_v+65))+1);
  E9_ik_IK = @(E9_v,E9_ik_n) -E9_ik_gK.*E9_ik_n.^4.*(E9_v+77);
  E9_ik_aN = @(E9_v) (.1-.01*(E9_v+65))./(exp(1-.1*(E9_v+65))-1);
  E9_ik_bN = @(E9_v) .125*exp(-(E9_v+65)/80);
  I10_ina_INa = @(I10_v,I10_ina_m,I10_ina_h) -I10_ina_gNa.*I10_ina_m.^3.*I10_ina_h.*(I10_v-50);
  I10_ina_aM = @(I10_v) (2.5-.1*(I10_v+65))./(exp(2.5-.1*(I10_v+65))-1);
  I10_ina_bM = @(I10_v) 4*exp(-(I10_v+65)/18);
  I10_ina_aH = @(I10_v) .07*exp(-(I10_v+65)/20);
  I10_ina_bH = @(I10_v) 1./(exp(3-.1*(I10_v+65))+1);
  I10_ik_IK = @(I10_v,I10_ik_n) -I10_ik_gK.*I10_ik_n.^4.*(I10_v+77);
  I10_ik_aN = @(I10_v) (.1-.01*(I10_v+65))./(exp(1-.1*(I10_v+65))-1);
  I10_ik_bN = @(I10_v) .125*exp(-(I10_v+65)/80);
  E_I_igaba_ISYN = @(E_v,E_I_igaba_s)(E_I_igaba_gSYN.*(E_I_igaba_s*E_I_igaba_netcon).*(E_v-E_I_igaba_ESYN));
  I4_I_igaba_ISYN = @(I4_v,I4_I_igaba_s)(I4_I_igaba_gSYN.*(I4_I_igaba_s*I4_I_igaba_netcon).*(I4_v-I4_I_igaba_ESYN));
  E3_I4_igaba_ISYN = @(E3_v,E3_I4_igaba_s)(E3_I4_igaba_gSYN.*(E3_I4_igaba_s*E3_I4_igaba_netcon).*(E3_v-E3_I4_igaba_ESYN)); 
  I6_I4_igaba_ISYN = @(I6_v,I6_I4_igaba_s)(I6_I4_igaba_gSYN.*(I6_I4_igaba_s*I6_I4_igaba_netcon).*(I6_v-I6_I4_igaba_ESYN)); 
  E5_I6_igaba_ISYN = @(E5_v,E5_I6_igaba_s)(E5_I6_igaba_gSYN.*(E5_I6_igaba_s*E5_I6_igaba_netcon).*(E5_v-E5_I6_igaba_ESYN));
  I8_I6_igaba_ISYN = @(I8_v,I8_I6_igaba_s)(I8_I6_igaba_gSYN.*(I8_I6_igaba_s*I8_I6_igaba_netcon).*(I8_v-I8_I6_igaba_ESYN));
  E7_I8_igaba_ISYN = @(E7_v,E7_I8_igaba_s)(E7_I8_igaba_gSYN.*(E7_I8_igaba_s*E7_I8_igaba_netcon).*(E7_v-E7_I8_igaba_ESYN));
  I10_I8_igaba_ISYN = @(I10_v,I10_I8_igaba_s)(I10_I8_igaba_gSYN.*(I10_I8_igaba_s*I10_I8_igaba_netcon).*(I10_v-I10_I8_igaba_ESYN));
  E9_I10_igaba_ISYN = @(E9_v,E9_I10_igaba_s)(E9_I10_igaba_gSYN.*(E9_I10_igaba_s*E9_I10_igaba_netcon).*(E9_v-E9_I10_igaba_ESYN));
  I_I10_igaba_ISYN = @(I_v,I_I10_igaba_s)(I_I10_igaba_gSYN.*(I_I10_igaba_s*I_I10_igaba_netcon).*(I_v-I_I10_igaba_ESYN));
  % with E-I intra connection
  I_E_iampa_ISYN = @(I_v,I_E_iampa_s)(I_E_iampa_gSYN.*(I_E_iampa_s*I_E_iampa_netcon).*(I_v-I_E_iampa_ESYN));
  I4_E3_iampa_ISYN = @(I4_v,I4_E3_iampa_s)(I4_E3_iampa_gSYN.*(I4_E3_iampa_s*I4_E3_iampa_netcon).*(I4_v-I4_E3_iampa_ESYN));
  I6_E5_iampa_ISYN = @(I6_v,I6_E5_iampa_s)(I6_E5_iampa_gSYN.*(I6_E5_iampa_s*I6_E5_iampa_netcon).*(I6_v-I6_E5_iampa_ESYN));
  I8_E7_iampa_ISYN = @(I8_v,I8_E7_iampa_s)(I8_E7_iampa_gSYN.*(I8_E7_iampa_s*I8_E7_iampa_netcon).*(I8_v-I8_E7_iampa_ESYN));
  I10_E9_iampa_ISYN = @(I10_v,I10_E9_iampa_s)(I10_E9_iampa_gSYN.*(I10_E9_iampa_s*I10_E9_iampa_netcon).*(I10_v-I10_E9_iampa_ESYN));

% Prepare ODEFUN for use with built-in Matlab solvers:
ODEFUN = @(t,X)[((5+0*randn(1,1)))+((E_ina_INa(X(1:1)',X(2:2)',X(3:3)'))+((E_ik_IK(X(1:1)',X(4:4)'))))+((-E_I_igaba_ISYN(X(1:1)',X(41:41)'))),...
    E_ina_aM(X(1:1)').*(1-X(2:2)')-E_ina_bM(X(1:1)').*X(2:2)',...
    E_ina_aH(X(1:1)').*(1-X(3:3)')-E_ina_bH(X(1:1)').*X(3:3)',...
    E_ik_aN(X(1:1)').*(1-X(4:4)')-E_ik_bN(X(1:1)').*X(4:4)',...
    ((0+0*randn(1,1)))+((I_ina_INa(X(5:5)',X(6:6)',X(7:7)'))+((I_ik_IK(X(5:5)',X(8:8)'))))+(-I_E_iampa_ISYN(X(5:5)',X(51:51)'))+((-I_I10_igaba_ISYN(X(5:5)',X(50:50)'))),...
    I_ina_aM(X(5:5)').*(1-X(6:6)')-I_ina_bM(X(5:5)').*X(6:6)',...
    I_ina_aH(X(5:5)').*(1-X(7:7)')-I_ina_bH(X(5:5)').*X(7:7)',...
    I_ik_aN(X(5:5)').*(1-X(8:8)')-I_ik_bN(X(5:5)').*X(8:8)',...
    ((5+0*randn(1,1)))+((((E3_ina_INa(X(9:9)',X(10:10)',X(11:11)'))+((E3_ik_IK(X(9:9)',X(12:12)'))))))+((-E3_I4_igaba_ISYN(X(9:9)',X(43:43)'))),...
    E3_ina_aM(X(9:9)').*(1-X(10:10)')-E3_ina_bM(X(9:9)').*X(10:10)',...
    E3_ina_aH(X(9:9)').*(1-X(11:11)')-E3_ina_bH(X(9:9)').*X(11:11)',...
    E3_ik_aN(X(9:9)').*(1-X(12:12)')-E3_ik_bN(X(9:9)').*X(12:12)',...
    ((0+0*randn(1,1)))+((((I4_ina_INa(X(13:13)',X(14:14)',X(15:15)'))+((I4_ik_IK(X(13:13)',X(16:16)'))))))+(-I4_E3_iampa_ISYN(X(13:13)',X(52:52)')+((-I4_I_igaba_ISYN(X(13:13)',X(42:42)')))),...
    I4_ina_aM(X(13:13)').*(1-X(14:14)')-I4_ina_bM(X(13:13)').*X(14:14)',...
    I4_ina_aH(X(13:13)').*(1-X(15:15)')-I4_ina_bH(X(13:13)').*X(15:15)',...
    I4_ik_aN(X(13:13)').*(1-X(16:16)')-I4_ik_bN(X(13:13)').*X(16:16)',...
    ((5+0*randn(1,1)))+((((E5_ina_INa(X(17:17)',X(18:18)',X(19:19)'))+((E5_ik_IK(X(17:17)',X(20:20)'))))))+((-E5_I6_igaba_ISYN(X(17:17)',X(45:45)'))),...
    E5_ina_aM(X(17:17)').*(1-X(18:18)')-E5_ina_bM(X(17:17)').*X(18:18)',...
    E5_ina_aH(X(17:17)').*(1-X(19:19)')-E5_ina_bH(X(17:17)').*X(19:19)',...
    E5_ik_aN(X(17:17)').*(1-X(20:20)')-E5_ik_bN(X(17:17)').*X(20:20)',...
    ((0+0*randn(1,1)))+((((I6_ina_INa(X(21:21)',X(22:22)',X(23:23)'))+((I6_ik_IK(X(21:21)',X(24:24)'))))))+(-I6_E5_iampa_ISYN(X(21:21)',X(53:53)'))+((-I6_I4_igaba_ISYN(X(21:21)',X(44:44)'))),...
    I6_ina_aM(X(21:21)').*(1-X(22:22)')-I6_ina_bM(X(21:21)').*X(22:22)',...
    I6_ina_aH(X(21:21)').*(1-X(23:23)')-I6_ina_bH(X(21:21)').*X(23:23)',...
    I6_ik_aN(X(21:21)').*(1-X(24:24)')-I6_ik_bN(X(21:21)').*X(24:24)',...
    ((5+0*randn(1,1)))+((((E7_ina_INa(X(25:25)',X(26:26)',X(27:27)'))+((E7_ik_IK(X(25:25)',X(28:28)'))))))+((-E7_I8_igaba_ISYN(X(25:25)',X(47:47)'))),...
    E7_ina_aM(X(25:25)').*(1-X(26:26)')-E7_ina_bM(X(25:25)').*X(26:26)',...
    E7_ina_aH(X(25:25)').*(1-X(27:27)')-E7_ina_bH(X(25:25)').*X(27:27)',...
    E7_ik_aN(X(25:25)').*(1-X(28:28)')-E7_ik_bN(X(25:25)').*X(28:28)',...
    ((0+0*randn(1,1)))+((((I8_ina_INa(X(29:29)',X(30:30)',X(31:31)'))+((I8_ik_IK(X(29:29)',X(32:32)'))))))+(-I8_E7_iampa_ISYN(X(29:29)',X(54:54)'))+((-I8_I6_igaba_ISYN(X(29:29)',X(46:46)'))),...
    I8_ina_aM(X(29:29)').*(1-X(30:30)')-I8_ina_bM(X(29:29)').*X(30:30)',...
    I8_ina_aH(X(29:29)').*(1-X(31:31)')-I8_ina_bH(X(29:29)').*X(31:31)',...
    I8_ik_aN(X(29:29)').*(1-X(32:32)')-I8_ik_bN(X(29:29)').*X(32:32)',...
    ((5+0*randn(1,1)))+((((E9_ina_INa(X(33:33)',X(34:34)',X(35:35)'))+((E9_ik_IK(X(33:33)',X(36:36)'))))))+((-E9_I10_igaba_ISYN(X(33:33)',X(49:49)'))),...
    E9_ina_aM(X(33:33)').*(1-X(34:34)')-E9_ina_bM(X(33:33)').*X(34:34)',...
    E9_ina_aH(X(33:33)').*(1-X(35:35)')-E9_ina_bH(X(33:33)').*X(35:35)',...
    E9_ik_aN(X(33:33)').*(1-X(36:36)')-E9_ik_bN(X(33:33)').*X(36:36)',...
    ((0+0*randn(1,1)))+((((I10_ina_INa(X(37:37)',X(38:38)',X(39:39)'))+((I10_ik_IK(X(37:37)',X(40:40)'))))))+(-I10_E9_iampa_ISYN(X(37:37)',X(55:55)'))+((-I10_I8_igaba_ISYN(X(37:37)',X(48:48)'))),...
    I10_ina_aM(X(37:37)').*(1-X(38:38)')-I10_ina_bM(X(37:37)').*X(38:38)',...
    I10_ina_aH(X(37:37)').*(1-X(39:39)')-I10_ina_bH(X(37:37)').*X(39:39)',...
    I10_ik_aN(X(37:37)').*(1-X(40:40)')-I10_ik_bN(X(37:37)').*X(40:40)',...
    -X(41:41)'./10+((1-X(41:41)')/0.4).*(1+tanh(X(5:5)'/10)),...
    -X(42:42)'./2+((1-X(42:42)')/0.4).*(1+tanh(X(5:5)'/10)),...
    -X(43:43)'./10+((1-X(43:43)')/0.4).*(1+tanh(X(13:13)'/10)),...
    -X(44:44)'./2+((1-X(44:44)')/0.4).*(1+tanh(X(13:13)'/10)),...
    -X(45:45)'./10+((1-X(45:45)')/0.4).*(1+tanh(X(21:21)'/10)),...
    -X(46:46)'./2+((1-X(46:46)')/0.4).*(1+tanh(X(21:21)'/10)),...
    -X(47:47)'./10+((1-X(47:47)')/0.4).*(1+tanh(X(29:29)'/10)),...
    -X(48:48)'./2+((1-X(48:48)')/0.4).*(1+tanh(X(29:29)'/10)),...    
    -X(49:49)'./10+((1-X(49:49)')/0.4).*(1+tanh(X(37:37)'/10)),...
    -X(50:50)'./2+((1-X(50:50)')/0.4).*(1+tanh(X(37:37)'/10)),...
    -X(51:51)'./2+((1-X(51:51)')/0.4).*(1+tanh(X(1:1)'/10)),...
    -X(52:52)'./2+((1-X(52:52)')/0.4).*(1+tanh(X(9:9)'/10)),...
    -X(53:53)'./2+((1-X(53:53)')/0.4).*(1+tanh(X(17:17)'/10)),...
    -X(54:54)'./2+((1-X(54:54)')/0.4).*(1+tanh(X(25:25)'/10)),...
    -X(55:55)'./2+((1-X(55:55)')/0.4).*(1+tanh(X(33:33)'/10))]';
IC = [-65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1];

%% Solve system using built-in Matlab solver:
options=odeset('RelTol',1e-2,'AbsTol',1e-4,'InitialStep',.01);
[t,y]=ode23(ODEFUN,[0 100],IC,options);

%% Plot results
set(0,'defaultFigureColor','w');
figure(1)
subplot(5,1,1)
plot(t,y(:,1),t,y(:,5));
title('Response for GDL-A27h connection');
legend('A27h','GDL');
ylabel('Vm(mV)');
subplot(5,1,2)
plot(t,y(:,9),t,y(:,13));
legend('A27h','GDL');
ylabel('Vm(mV)');
subplot(5,1,3)
plot(t,y(:,17),t,y(:,21));
legend('A27h','GDL');
ylabel('Vm(mV)');
subplot(5,1,4)
plot(t,y(:,25),t,y(:,29));
legend('A27h','GDL');
ylabel('Vm(mV)');
subplot(5,1,5)
plot(t,y(:,33),t,y(:,37));
legend('A27h','GDL');
ylabel('Vm(mV)');
xlabel('time(ms)');

% choose the middle segment response as the phase plane analysis
figure(2)
plot(y(:,17),y(:,21));
title('Phase plane E3-I3');
ylabel('Membrane potential of I3 (mV)');
xlabel('Membrane potential of E3 (mV)');