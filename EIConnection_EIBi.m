% Bilateral connection within EI connection;
% Model basis: Hodgkin huxley model
% Description: within 20 neurons (10E-10I, intra(E-I & I-E), inter (E-I))
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
%% Parameter space:
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
  E11_ina_gNa = +120.0000; E11_ik_gK = +36.0000;
  E11_input1_Iapp = +5.0000; E11_input1_noise = +0.0000;
  E11_Npop = +1.0000;
  I12_ina_gNa = +120.0000; I12_ik_gK = +36.0000;
  I12_input1_Iapp = +0.0000; I12_input1_noise = +0.0000;
  I12_Npop = +1.0000; 
  E13_ina_gNa = +120.0000; E13_ik_gK = +36.0000;
  E13_input1_Iapp = +5.0000; E13_input1_noise = +0.0000;
  E13_Npop = +1.0000;
  I14_ina_gNa = +120.0000; I14_ik_gK = +36.0000;
  I14_input1_Iapp = +0.0000; I14_input1_noise = +0.0000;
  I14_Npop = +1.0000;
  E15_ina_gNa = +120.0000; E15_ik_gK = +36.0000;
  E15_input1_Iapp = +5.0000; E15_input1_noise = +0.0000;
  E15_Npop = +1.0000;
  I16_ina_gNa = +120.0000; I16_ik_gK = +36.0000;
  I16_input1_Iapp = +0.0000; I16_input1_noise = +0.0000;
  I16_Npop = +1.0000;
  E17_ina_gNa = +120.0000; E17_ik_gK = +36.0000;
  E17_input1_Iapp = +5.0000; E17_input1_noise = +0.0000;
  E17_Npop = +1.0000;
  I18_ina_gNa = +120.0000; I18_ik_gK = +36.0000;
  I18_input1_Iapp = +0.0000; I18_input1_noise = +0.0000;
  I18_Npop = +1.0000;
  E19_ina_gNa = +120.0000; E19_ik_gK = +36.0000;
  E19_input1_Iapp = +5.0000; E19_input1_noise = +0.0000;
  E19_Npop = +1.0000;
  I20_ina_gNa = +120.0000; I20_ik_gK = +36.0000;
  I20_input1_Iapp = +0.0000; I20_input1_noise = +0.0000;
  I20_Npop = +1.0000;
% Synaptic connection:(GDL-A27h-GDL) (from 1 to 20)
  E_I_igaba_gSYN = +0.2500; E_I_igaba_ESYN = -80.0000;
  E_I_igaba_tauD = +10.0000; E_I_igaba_tauR = +0.4000;
  I4_E_iampa_gSYN = +0.1000; I4_E_iampa_ESYN = +0.0000;
  I4_E_iampa_tauD = +2.0000; I4_E_iampa_tauR = +0.4000;
  E3_I4_igaba_gSYN = +0.2500; E3_I4_igaba_ESYN = -80.0000;
  E3_I4_igaba_tauD = +10.0000; E3_I4_igaba_tauR = +0.4000;
  I6_E3_iampa_gSYN = +0.1000; I6_E3_iampa_ESYN = +0.0000;
  I6_E3_iampa_tauD = +2.0000; I6_E3_iampa_tauR = +0.4000;  
  E5_I6_igaba_gSYN = +0.2500; E5_I6_igaba_ESYN = -80.0000;
  E5_I6_igaba_tauD = +10.0000; E5_I6_igaba_tauR = +0.4000;
  I8_E5_iampa_gSYN = +0.1000; I8_E5_iampa_ESYN = +0.0000;
  I8_E5_iampa_tauD = +2.0000; I8_E5_iampa_tauR = +0.4000;
  E7_I8_igaba_gSYN = +0.2500; E7_I8_igaba_ESYN = -80.0000;
  E7_I8_igaba_tauD = +10.0000; E7_I8_igaba_tauR = +0.4000;
  I10_E7_iampa_gSYN = +0.1000; I10_E7_iampa_ESYN = +0.0000;
  I10_E7_iampa_tauD = +2.0000; I10_E7_iampa_tauR = +0.4000;  
  E9_I10_igaba_gSYN = +0.2500; E9_I10_igaba_ESYN = -80.0000;
  E9_I10_igaba_tauD = +10.0000; E9_I10_igaba_tauR = +0.4000;
  I_E9_iampa_gSYN = +0.1000; I_E9_iampa_ESYN = +0.0000;
  I_E9_iampa_tauD = +2.0000; I_E9_iampa_tauR = +0.4000;
  E11_I12_igaba_gSYN = +0.2500; E11_I12_igaba_ESYN = -80.0000;
  E11_I12_igaba_tauD = +10.0000; E11_I12_igaba_tauR = +0.4000;
  I14_E11_iampa_gSYN = +0.1000; I14_E11_iampa_ESYN = +0.0000;
  I14_E11_iampa_tauD = +2.0000; I14_E11_iampa_tauR = +0.4000;
  E13_I14_igaba_gSYN = +0.2500; E13_I14_igaba_ESYN = -80.0000;
  E13_I14_igaba_tauD = +10.0000; E13_I14_igaba_tauR = +0.4000;
  I16_E13_iampa_gSYN = +0.1000; I16_E13_iampa_ESYN = +0.0000;
  I16_E13_iampa_tauD = +2.0000; I16_E13_iampa_tauR = +0.4000;  
  E15_I16_igaba_gSYN = +0.2500; E15_I16_igaba_ESYN = -80.0000;
  E15_I16_igaba_tauD = +10.0000; E15_I16_igaba_tauR = +0.4000;
  I18_E15_iampa_gSYN = +0.1000; I18_E15_iampa_ESYN = +0.0000;
  I18_E15_iampa_tauD = +2.0000; I18_E15_iampa_tauR = +0.4000;
  E17_I18_igaba_gSYN = +0.2500; E17_I18_igaba_ESYN = -80.0000;
  E17_I18_igaba_tauD = +10.0000; E17_I18_igaba_tauR = +0.4000;
  I20_E17_iampa_gSYN = +0.1000; I20_E17_iampa_ESYN = +0.0000;
  I20_E17_iampa_tauD = +2.0000; I20_E17_iampa_tauR = +0.4000;  
  E19_I20_igaba_gSYN = +0.2500; E19_I20_igaba_ESYN = -80.0000;
  E19_I20_igaba_tauD = +10.0000; E19_I20_igaba_tauR = +0.4000;
  I12_E19_iampa_gSYN = +0.1000;  I12_E19_iampa_ESYN = +0.0000;
  I12_E19_iampa_tauD = +2.0000;  I12_E19_iampa_tauR = +0.4000;
  % with E-I intra connection (from 20 to 30)
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
  I12_E11_iampa_gSYN = +0.1000; I12_E11_iampa_ESYN = +0.0000;
  I12_E11_iampa_tauD = +2.0000; I12_E11_iampa_tauR = +0.4000;
  I14_E13_iampa_gSYN = +0.1000; I14_E13_iampa_ESYN = +0.0000;
  I14_E13_iampa_tauD = +2.0000; I14_E13_iampa_tauR = +0.4000;
  I16_E15_iampa_gSYN = +0.1000; I16_E15_iampa_ESYN = +0.0000;
  I16_E15_iampa_tauD = +2.0000; I16_E15_iampa_tauR = +0.4000;
  I18_E17_iampa_gSYN = +0.1000; I18_E17_iampa_ESYN = +0.0000;
  I18_E17_iampa_tauD = +2.0000; I18_E17_iampa_tauR = +0.4000;
  I20_E19_iampa_gSYN = +0.1000; I20_E19_iampa_ESYN = +0.0000;
  I20_E19_iampa_tauD = +2.0000; I20_E19_iampa_tauR = +0.4000; 
% withi contralateral inhibition (from 30 to 40)
  I12_I_igaba_gSYN = +0.2500; I12_I_igaba_ESYN = -80.0000;
  I12_I_igaba_tauD = +10.0000; I12_I_igaba_tauR = +0.4000;
  I_I12_igaba_gSYN = +0.2500; I_I12_igaba_ESYN = -80.0000;
  I_I12_igaba_tauD = +10.0000; I_I12_igaba_tauR = +0.4000;
  I14_I4_igaba_gSYN = +0.2500; I14_I4_igaba_ESYN = -80.0000;
  I14_I4_igaba_tauD = +10.0000; I14_I4_igaba_tauR = +0.4000;
  I4_I14_igaba_gSYN = +0.2500; I4_I14_igaba_ESYN = -80.0000;
  I4_I14_igaba_tauD = +10.0000; I4_I14_igaba_tauR = +0.4000;
  I16_I6_igaba_gSYN = +0.2500; I16_I6_igaba_ESYN = -80.0000;
  I16_I6_igaba_tauD = +10.0000; I16_I6_igaba_tauR = +0.4000;
  I6_I16_igaba_gSYN = +0.2500; I6_I16_igaba_ESYN = -80.0000;
  I6_I16_igaba_tauD = +10.0000; I6_I16_igaba_tauR = +0.4000;
  I18_I8_igaba_gSYN = +0.2500; I18_I8_igaba_ESYN = -80.0000;
  I18_I8_igaba_tauD = +10.0000; I18_I8_igaba_tauR = +0.4000;
  I8_I18_igaba_gSYN = +0.2500; I8_I18_igaba_ESYN = -80.0000;
  I8_I18_igaba_tauD = +10.0000; I8_I18_igaba_tauR = +0.4000;
  I20_I10_igaba_gSYN = +0.2500; I20_I10_igaba_ESYN = -80.0000;
  I20_I10_igaba_tauD = +10.0000; I20_I10_igaba_tauR = +0.4000;
  I10_I20_igaba_gSYN = +0.2500; I10_I20_igaba_ESYN = -80.0000;
  I10_I20_igaba_tauD = +10.0000; I10_I20_igaba_tauR = +0.4000;

%% Neuron population setting:
% follow the sequence: GDL-A27h-GDL
  E_I_igaba_netcon = ones(I_Npop,E_Npop);
  I4_E_iampa_netcon = ones(E_Npop,I4_Npop);
  E3_I4_igaba_netcon = ones(I4_Npop,E3_Npop);
  I6_E3_iampa_netcon = ones(E3_Npop,I6_Npop);
  E5_I6_igaba_netcon = ones(I6_Npop,E5_Npop);
  I8_E5_iampa_netcon = ones(E5_Npop,I8_Npop);
  E7_I8_igaba_netcon = ones(I8_Npop,E7_Npop);
  I10_E7_iampa_netcon = ones(E7_Npop,I10_Npop);
  E9_I10_igaba_netcon = ones(I10_Npop,E9_Npop);
  I_E9_iampa_netcon = ones(E9_Npop,I_Npop);
  E11_I12_igaba_netcon = ones(I12_Npop,E11_Npop);
  I14_E11_iampa_netcon = ones(E11_Npop,I14_Npop);
  E13_I14_igaba_netcon = ones(I14_Npop,E13_Npop);
  I16_E13_iampa_netcon = ones(E13_Npop,I16_Npop);
  E15_I16_igaba_netcon = ones(I16_Npop,E15_Npop);
  I18_E15_iampa_netcon = ones(E15_Npop,I18_Npop);
  E17_I18_igaba_netcon = ones(I18_Npop,E17_Npop);
  I20_E17_iampa_netcon = ones(E17_Npop,I20_Npop);
  E19_I20_igaba_netcon = ones(I20_Npop,E19_Npop);
  I12_E19_iampa_netcon = ones(E19_Npop,I12_Npop);
  % with E-I intra connection
  I_E_iampa_netcon = ones(E_Npop,I_Npop);
  I4_E3_iampa_netcon = ones(E3_Npop,I4_Npop);
  I6_E5_iampa_netcon = ones(E5_Npop,I6_Npop);
  I8_E7_iampa_netcon = ones(E7_Npop,I8_Npop);
  I10_E9_iampa_netcon = ones(E9_Npop,I10_Npop);
  I12_E11_iampa_netcon = ones(E11_Npop,I12_Npop);
  I14_E13_iampa_netcon = ones(E13_Npop,I14_Npop);
  I16_E15_iampa_netcon = ones(E15_Npop,I16_Npop);
  I18_E17_iampa_netcon = ones(E17_Npop,I18_Npop);
  I20_E19_iampa_netcon = ones(E19_Npop,I20_Npop);
  % with contralateral inhibition
  I12_I_igaba_netcon = ones(I_Npop,I12_Npop);
  I_I12_igaba_netcon = ones(I12_Npop,I_Npop);
  I14_I4_igaba_netcon = ones(I4_Npop,I14_Npop);
  I4_I14_igaba_netcon = ones(I14_Npop,I4_Npop);
  I16_I6_igaba_netcon = ones(I6_Npop,I16_Npop);
  I6_I16_igaba_netcon = ones(I16_Npop,I6_Npop);
  I18_I8_igaba_netcon = ones(I8_Npop,I18_Npop);
  I8_I18_igaba_netcon = ones(I18_Npop,I8_Npop);
  I20_I10_igaba_netcon = ones(I10_Npop,I20_Npop);
  I10_I20_igaba_netcon = ones(I20_Npop,I10_Npop);
  
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
  E11_ina_INa = @(E11_v,E11_ina_m,E11_ina_h) -E11_ina_gNa.*E11_ina_m.^3.*E11_ina_h.*(E11_v-50);
  E11_ina_aM = @(E11_v) (2.5-.1*(E11_v+65))./(exp(2.5-.1*(E11_v+65))-1);
  E11_ina_bM = @(E11_v) 4*exp(-(E11_v+65)/18);
  E11_ina_aH = @(E11_v) .07*exp(-(E11_v+65)/20);
  E11_ina_bH = @(E11_v) 1./(exp(3-.1*(E11_v+65))+1);
  E11_ik_IK = @(E11_v,E11_ik_n) -E11_ik_gK.*E11_ik_n.^4.*(E11_v+77);
  E11_ik_aN = @(E11_v) (.1-.01*(E11_v+65))./(exp(1-.1*(E11_v+65))-1);
  E11_ik_bN = @(E11_v) .125*exp(-(E11_v+65)/80);
  I12_ina_INa = @(I12_v,I12_ina_m,I12_ina_h) -I12_ina_gNa.*I12_ina_m.^3.*I12_ina_h.*(I12_v-50);
  I12_ina_aM = @(I12_v) (2.5-.1*(I12_v+65))./(exp(2.5-.1*(I12_v+65))-1);
  I12_ina_bM = @(I12_v) 4*exp(-(I12_v+65)/18);
  I12_ina_aH = @(I12_v) .07*exp(-(I12_v+65)/20);
  I12_ina_bH = @(I12_v) 1./(exp(3-.1*(I12_v+65))+1);
  I12_ik_IK = @(I12_v,I12_ik_n) -I12_ik_gK.*I12_ik_n.^4.*(I12_v+77);
  I12_ik_aN = @(I12_v) (.1-.01*(I12_v+65))./(exp(1-.1*(I12_v+65))-1);
  I12_ik_bN = @(I12_v) .125*exp(-(I12_v+65)/80);
  E13_ina_INa = @(E13_v,E13_ina_m,E13_ina_h) -E13_ina_gNa.*E13_ina_m.^3.*E13_ina_h.*(E13_v-50);
  E13_ina_aM = @(E13_v) (2.5-.1*(E13_v+65))./(exp(2.5-.1*(E13_v+65))-1);
  E13_ina_bM = @(E13_v) 4*exp(-(E13_v+65)/18);
  E13_ina_aH = @(E13_v) .07*exp(-(E13_v+65)/20);
  E13_ina_bH = @(E13_v) 1./(exp(3-.1*(E13_v+65))+1);
  E13_ik_IK = @(E13_v,E13_ik_n) -E13_ik_gK.*E13_ik_n.^4.*(E13_v+77);
  E13_ik_aN = @(E13_v) (.1-.01*(E13_v+65))./(exp(1-.1*(E13_v+65))-1);
  E13_ik_bN = @(E13_v) .125*exp(-(E13_v+65)/80);
  I14_ina_INa = @(I14_v,I14_ina_m,I14_ina_h) -I14_ina_gNa.*I14_ina_m.^3.*I14_ina_h.*(I14_v-50);
  I14_ina_aM = @(I14_v) (2.5-.1*(I14_v+65))./(exp(2.5-.1*(I14_v+65))-1);
  I14_ina_bM = @(I14_v) 4*exp(-(I14_v+65)/18);
  I14_ina_aH = @(I14_v) .07*exp(-(I14_v+65)/20);
  I14_ina_bH = @(I14_v) 1./(exp(3-.1*(I14_v+65))+1);
  I14_ik_IK = @(I14_v,I14_ik_n) -I14_ik_gK.*I14_ik_n.^4.*(I14_v+77);
  I14_ik_aN = @(I14_v) (.1-.01*(I14_v+65))./(exp(1-.1*(I14_v+65))-1);
  I14_ik_bN = @(I14_v) .125*exp(-(I14_v+65)/80);
  E15_ina_INa = @(E15_v,E15_ina_m,E15_ina_h) -E15_ina_gNa.*E15_ina_m.^3.*E15_ina_h.*(E15_v-50);
  E15_ina_aM = @(E15_v) (2.5-.1*(E15_v+65))./(exp(2.5-.1*(E15_v+65))-1);
  E15_ina_bM = @(E15_v) 4*exp(-(E15_v+65)/18);
  E15_ina_aH = @(E15_v) .07*exp(-(E15_v+65)/20);
  E15_ina_bH = @(E15_v) 1./(exp(3-.1*(E15_v+65))+1);
  E15_ik_IK = @(E15_v,E15_ik_n) -E15_ik_gK.*E15_ik_n.^4.*(E15_v+77);
  E15_ik_aN = @(E15_v) (.1-.01*(E15_v+65))./(exp(1-.1*(E15_v+65))-1);
  E15_ik_bN = @(E15_v) .125*exp(-(E15_v+65)/80);
  I16_ina_INa = @(I16_v,I16_ina_m,I16_ina_h) -I16_ina_gNa.*I16_ina_m.^3.*I16_ina_h.*(I16_v-50);
  I16_ina_aM = @(I16_v) (2.5-.1*(I16_v+65))./(exp(2.5-.1*(I16_v+65))-1);
  I16_ina_bM = @(I16_v) 4*exp(-(I16_v+65)/18);
  I16_ina_aH = @(I16_v) .07*exp(-(I16_v+65)/20);
  I16_ina_bH = @(I16_v) 1./(exp(3-.1*(I16_v+65))+1);
  I16_ik_IK = @(I16_v,I16_ik_n) -I16_ik_gK.*I16_ik_n.^4.*(I16_v+77);
  I16_ik_aN = @(I16_v) (.1-.01*(I16_v+65))./(exp(1-.1*(I16_v+65))-1);
  I16_ik_bN = @(I16_v) .125*exp(-(I16_v+65)/80);
  E17_ina_INa = @(E17_v,E17_ina_m,E17_ina_h) -E17_ina_gNa.*E17_ina_m.^3.*E17_ina_h.*(E17_v-50);
  E17_ina_aM = @(E17_v) (2.5-.1*(E17_v+65))./(exp(2.5-.1*(E17_v+65))-1);
  E17_ina_bM = @(E17_v) 4*exp(-(E17_v+65)/18);
  E17_ina_aH = @(E17_v) .07*exp(-(E17_v+65)/20);
  E17_ina_bH = @(E17_v) 1./(exp(3-.1*(E17_v+65))+1);
  E17_ik_IK = @(E17_v,E17_ik_n) -E17_ik_gK.*E17_ik_n.^4.*(E17_v+77);
  E17_ik_aN = @(E17_v) (.1-.01*(E17_v+65))./(exp(1-.1*(E17_v+65))-1);
  E17_ik_bN = @(E17_v) .125*exp(-(E17_v+65)/80);
  I18_ina_INa = @(I18_v,I18_ina_m,I18_ina_h) -I18_ina_gNa.*I18_ina_m.^3.*I18_ina_h.*(I18_v-50);
  I18_ina_aM = @(I18_v) (2.5-.1*(I18_v+65))./(exp(2.5-.1*(I18_v+65))-1);
  I18_ina_bM = @(I18_v) 4*exp(-(I18_v+65)/18);
  I18_ina_aH = @(I18_v) .07*exp(-(I18_v+65)/20);
  I18_ina_bH = @(I18_v) 1./(exp(3-.1*(I18_v+65))+1);
  I18_ik_IK = @(I18_v,I18_ik_n) -I18_ik_gK.*I18_ik_n.^4.*(I18_v+77);
  I18_ik_aN = @(I18_v) (.1-.01*(I18_v+65))./(exp(1-.1*(I18_v+65))-1);
  I18_ik_bN = @(I18_v) .125*exp(-(I18_v+65)/80);
  E19_ina_INa = @(E19_v,E19_ina_m,E19_ina_h) -E19_ina_gNa.*E19_ina_m.^3.*E19_ina_h.*(E19_v-50);
  E19_ina_aM = @(E19_v) (2.5-.1*(E19_v+65))./(exp(2.5-.1*(E19_v+65))-1);
  E19_ina_bM = @(E19_v) 4*exp(-(E19_v+65)/18);
  E19_ina_aH = @(E19_v) .07*exp(-(E19_v+65)/20);
  E19_ina_bH = @(E19_v) 1./(exp(3-.1*(E19_v+65))+1);
  E19_ik_IK = @(E19_v,E19_ik_n) -E19_ik_gK.*E19_ik_n.^4.*(E19_v+77);
  E19_ik_aN = @(E19_v) (.1-.01*(E19_v+65))./(exp(1-.1*(E19_v+65))-1);
  E19_ik_bN = @(E19_v) .125*exp(-(E19_v+65)/80);
  I20_ina_INa = @(I20_v,I20_ina_m,I20_ina_h) -I20_ina_gNa.*I20_ina_m.^3.*I20_ina_h.*(I20_v-50);
  I20_ina_aM = @(I20_v) (2.5-.1*(I20_v+65))./(exp(2.5-.1*(I20_v+65))-1);
  I20_ina_bM = @(I20_v) 4*exp(-(I20_v+65)/18);
  I20_ina_aH = @(I20_v) .07*exp(-(I20_v+65)/20);
  I20_ina_bH = @(I20_v) 1./(exp(3-.1*(I20_v+65))+1);
  I20_ik_IK = @(I20_v,I20_ik_n) -I20_ik_gK.*I20_ik_n.^4.*(I20_v+77);
  I20_ik_aN = @(I20_v) (.1-.01*(I20_v+65))./(exp(1-.1*(I20_v+65))-1);
  I20_ik_bN = @(I20_v) .125*exp(-(I20_v+65)/80);
  % with GDL-A27h sequence
  E_I_igaba_ISYN = @(E_v,E_I_igaba_s)(E_I_igaba_gSYN.*(E_I_igaba_s*E_I_igaba_netcon).*(E_v-E_I_igaba_ESYN));
  I4_E_iampa_ISYN = @(I4_v,I4_E_iampa_s)(I4_E_iampa_gSYN.*(I4_E_iampa_s*I4_E_iampa_netcon).*(I4_v-I4_E_iampa_ESYN));
  E3_I4_igaba_ISYN = @(E3_v,E3_I4_igaba_s)(E3_I4_igaba_gSYN.*(E3_I4_igaba_s*E3_I4_igaba_netcon).*(E3_v-E3_I4_igaba_ESYN)); 
  I6_E3_iampa_ISYN = @(I6_v,I6_E3_iampa_s)(I6_E3_iampa_gSYN.*(I6_E3_iampa_s*I6_E3_iampa_netcon).*(I6_v-I6_E3_iampa_ESYN));  
  E5_I6_igaba_ISYN = @(E5_v,E5_I6_igaba_s)(E5_I6_igaba_gSYN.*(E5_I6_igaba_s*E5_I6_igaba_netcon).*(E5_v-E5_I6_igaba_ESYN));
  I8_E5_iampa_ISYN = @(I8_v,I8_E5_iampa_s)(I8_E5_iampa_gSYN.*(I8_E5_iampa_s*I8_E5_iampa_netcon).*(I8_v-I8_E5_iampa_ESYN));
  E7_I8_igaba_ISYN = @(E7_v,E7_I8_igaba_s)(E7_I8_igaba_gSYN.*(E7_I8_igaba_s*E7_I8_igaba_netcon).*(E7_v-E7_I8_igaba_ESYN));
  I10_E7_iampa_ISYN = @(I10_v,I10_E7_iampa_s)(I10_E7_iampa_gSYN.*(I10_E7_iampa_s*I10_E7_iampa_netcon).*(I10_v-I10_E7_iampa_ESYN)); 
  E9_I10_igaba_ISYN = @(E9_v,E9_I10_igaba_s)(E9_I10_igaba_gSYN.*(E9_I10_igaba_s*E9_I10_igaba_netcon).*(E9_v-E9_I10_igaba_ESYN));
  I_E9_iampa_ISYN = @(I_v,I_E9_iampa_s)(I_E9_iampa_gSYN.*(I_E9_iampa_s*I_E9_iampa_netcon).*(I_v-I_E9_iampa_ESYN));
  E11_I12_igaba_ISYN = @(E11_v,E11_I12_igaba_s)(E11_I12_igaba_gSYN.*(E11_I12_igaba_s*E11_I12_igaba_netcon).*(E11_v-E11_I12_igaba_ESYN));
  I14_E11_iampa_ISYN = @(I14_v,I14_E11_iampa_s)(I14_E11_iampa_gSYN.*(I14_E11_iampa_s*I14_E11_iampa_netcon).*(I14_v-I14_E11_iampa_ESYN));
  E13_I14_igaba_ISYN = @(E13_v,E13_I14_igaba_s)(E13_I14_igaba_gSYN.*(E13_I14_igaba_s*E13_I14_igaba_netcon).*(E13_v-E13_I14_igaba_ESYN)); 
  I16_E13_iampa_ISYN = @(I16_v,I16_E13_iampa_s)(I16_E13_iampa_gSYN.*(I16_E13_iampa_s*I16_E13_iampa_netcon).*(I16_v-I16_E13_iampa_ESYN));  
  E15_I16_igaba_ISYN = @(E15_v,E15_I16_igaba_s)(E15_I16_igaba_gSYN.*(E15_I16_igaba_s*E15_I16_igaba_netcon).*(E15_v-E15_I16_igaba_ESYN));
  I18_E15_iampa_ISYN = @(I18_v,I18_E15_iampa_s)(I18_E15_iampa_gSYN.*(I18_E15_iampa_s*I18_E15_iampa_netcon).*(I18_v-I18_E15_iampa_ESYN));
  E17_I18_igaba_ISYN = @(E17_v,E17_I18_igaba_s)(E17_I18_igaba_gSYN.*(E17_I18_igaba_s*E17_I18_igaba_netcon).*(E17_v-E17_I18_igaba_ESYN));
  I20_E17_iampa_ISYN = @(I20_v,I20_E17_iampa_s)(I20_E17_iampa_gSYN.*(I20_E17_iampa_s*I20_E17_iampa_netcon).*(I20_v-I20_E17_iampa_ESYN)); 
  E19_I20_igaba_ISYN = @(E19_v,E19_I20_igaba_s)(E19_I20_igaba_gSYN.*(E19_I20_igaba_s*E19_I20_igaba_netcon).*(E19_v-E19_I20_igaba_ESYN));
  I12_E19_iampa_ISYN = @(I12_v,I12_E19_iampa_s)(I12_E19_iampa_gSYN.*(I12_E19_iampa_s*I12_E19_iampa_netcon).*(I12_v-I12_E19_iampa_ESYN));
  % with E-I intra connection
  I_E_iampa_ISYN = @(I_v,I_E_iampa_s)(I_E_iampa_gSYN.*(I_E_iampa_s*I_E_iampa_netcon).*(I_v-I_E_iampa_ESYN));
  I4_E3_iampa_ISYN = @(I4_v,I4_E3_iampa_s)(I4_E3_iampa_gSYN.*(I4_E3_iampa_s*I4_E3_iampa_netcon).*(I4_v-I4_E3_iampa_ESYN));
  I6_E5_iampa_ISYN = @(I6_v,I6_E5_iampa_s)(I6_E5_iampa_gSYN.*(I6_E5_iampa_s*I6_E5_iampa_netcon).*(I6_v-I6_E5_iampa_ESYN));
  I8_E7_iampa_ISYN = @(I8_v,I8_E7_iampa_s)(I8_E7_iampa_gSYN.*(I8_E7_iampa_s*I8_E7_iampa_netcon).*(I8_v-I8_E7_iampa_ESYN));
  I10_E9_iampa_ISYN = @(I10_v,I10_E9_iampa_s)(I10_E9_iampa_gSYN.*(I10_E9_iampa_s*I10_E9_iampa_netcon).*(I10_v-I10_E9_iampa_ESYN));
  I12_E11_iampa_ISYN = @(I12_v,I12_E11_iampa_s)(I12_E11_iampa_gSYN.*(I12_E11_iampa_s*I12_E11_iampa_netcon).*(I12_v-I12_E11_iampa_ESYN));
  I14_E13_iampa_ISYN = @(I14_v,I14_E13_iampa_s)(I14_E13_iampa_gSYN.*(I14_E13_iampa_s*I14_E13_iampa_netcon).*(I14_v-I14_E13_iampa_ESYN));
  I16_E15_iampa_ISYN = @(I16_v,I16_E15_iampa_s)(I16_E15_iampa_gSYN.*(I16_E15_iampa_s*I16_E15_iampa_netcon).*(I16_v-I16_E15_iampa_ESYN));
  I18_E17_iampa_ISYN = @(I18_v,I18_E17_iampa_s)(I18_E17_iampa_gSYN.*(I18_E17_iampa_s*I18_E17_iampa_netcon).*(I18_v-I18_E17_iampa_ESYN));
  I20_E19_iampa_ISYN = @(I20_v,I20_E19_iampa_s)(I20_E19_iampa_gSYN.*(I20_E19_iampa_s*I20_E19_iampa_netcon).*(I20_v-I20_E19_iampa_ESYN));
  % with contralateral connection
  I12_I_igaba_ISYN = @(I12_v,I12_I_igaba_s)(I12_I_igaba_gSYN.*(I12_I_igaba_s*I12_I_igaba_netcon).*(I12_v-I12_I_igaba_ESYN));
  I_I12_igaba_ISYN = @(I_v,I_I12_igaba_s)(I_I12_igaba_gSYN.*(I_I12_igaba_s*E_I_igaba_netcon).*(I_v-I_I12_igaba_ESYN));
  I14_I4_igaba_ISYN = @(I14_v,I14_I4_igaba_s)(I14_I4_igaba_gSYN.*(I14_I4_igaba_s*I14_I4_igaba_netcon).*(I14_v-I14_I4_igaba_ESYN));
  I4_I14_igaba_ISYN = @(I4_v,I4_I14_igaba_s)(I4_I14_igaba_gSYN.*(I4_I14_igaba_s*I4_I14_igaba_netcon).*(I4_v-I4_I14_igaba_ESYN));
  I16_I6_igaba_ISYN = @(I16_v,I16_I6_igaba_s)(I16_I6_igaba_gSYN.*(I16_I6_igaba_s*I16_I6_igaba_netcon).*(I16_v-I16_I6_igaba_ESYN));
  I6_I16_igaba_ISYN = @(I6_v,I6_I16_igaba_s)(I6_I16_igaba_gSYN.*(I6_I16_igaba_s*I6_I16_igaba_netcon).*(I6_v-I6_I16_igaba_ESYN));
  I18_I8_igaba_ISYN = @(I18_v,I18_I8_igaba_s)(I18_I8_igaba_gSYN.*(I18_I8_igaba_s*I18_I8_igaba_netcon).*(I18_v-I18_I8_igaba_ESYN));
  I8_I18_igaba_ISYN = @(I8_v,I8_I18_igaba_s)(I8_I18_igaba_gSYN.*(I8_I18_igaba_s*I8_I18_igaba_netcon).*(I8_v-I8_I18_igaba_ESYN));
  I20_I10_igaba_ISYN = @(I20_v,I20_I10_igaba_s)(I20_I10_igaba_gSYN.*(I20_I10_igaba_s*I20_I10_igaba_netcon).*(I20_v-I20_I10_igaba_ESYN));
  I10_I20_igaba_ISYN = @(I10_v,I10_I20_igaba_s)(I10_I20_igaba_gSYN.*(I10_I20_igaba_s*I10_I20_igaba_netcon).*(I10_v-I10_I20_igaba_ESYN));

% Prepare ODEFUN for use with built-in Matlab solvers:
ODEFUN = @(t,X)[((5+0*randn(1,1)))+((E_ina_INa(X(1:1)',X(2:2)',X(3:3)'))+((E_ik_IK(X(1:1)',X(4:4)'))))+(-E_I_igaba_ISYN(X(1:1)',X(81:81)')),...
    E_ina_aM(X(1:1)').*(1-X(2:2)')-E_ina_bM(X(1:1)').*X(2:2)',...
    E_ina_aH(X(1:1)').*(1-X(3:3)')-E_ina_bH(X(1:1)').*X(3:3)',...
    E_ik_aN(X(1:1)').*(1-X(4:4)')-E_ik_bN(X(1:1)').*X(4:4)',...
    ((0+0*randn(1,1)))+((I_ina_INa(X(5:5)',X(6:6)',X(7:7)'))+((I_ik_IK(X(5:5)',X(8:8)'))))+(-I_E_iampa_ISYN(X(5:5)',X(101:101)'))+(-I_E9_iampa_ISYN(X(5:5)',X(90:90)'))+(-I_I12_igaba_ISYN(X(5:5)',X(112:112)')),...
    I_ina_aM(X(5:5)').*(1-X(6:6)')-I_ina_bM(X(5:5)').*X(6:6)',...
    I_ina_aH(X(5:5)').*(1-X(7:7)')-I_ina_bH(X(5:5)').*X(7:7)',...
    I_ik_aN(X(5:5)').*(1-X(8:8)')-I_ik_bN(X(5:5)').*X(8:8)',...
    (((5+0*randn(1,1))))+((((E3_ina_INa(X(9:9)',X(10:10)',X(11:11)'))+((E3_ik_IK(X(9:9)',X(12:12)'))))))+((-E3_I4_igaba_ISYN(X(9:9)',X(83:83)'))),...
    E3_ina_aM(X(9:9)').*(1-X(10:10)')-E3_ina_bM(X(9:9)').*X(10:10)',...
    E3_ina_aH(X(9:9)').*(1-X(11:11)')-E3_ina_bH(X(9:9)').*X(11:11)',...
    E3_ik_aN(X(9:9)').*(1-X(12:12)')-E3_ik_bN(X(9:9)').*X(12:12)',...
    (((0+0*randn(1,1))))+((((I4_ina_INa(X(13:13)',X(14:14)',X(15:15)'))+((I4_ik_IK(X(13:13)',X(16:16)'))))))+(-I4_E3_iampa_ISYN(X(13:13)',X(102:102)'))+(-I4_E_iampa_ISYN(X(13:13)',X(82:82)'))+(-I4_I14_igaba_ISYN(X(13:13)',X(114:114)')),...
    I4_ina_aM(X(13:13)').*(1-X(14:14)')-I4_ina_bM(X(13:13)').*X(14:14)',...
    I4_ina_aH(X(13:13)').*(1-X(15:15)')-I4_ina_bH(X(13:13)').*X(15:15)',...
    I4_ik_aN(X(13:13)').*(1-X(16:16)')-I4_ik_bN(X(13:13)').*X(16:16)',...
    (((5+0*randn(1,1))))+((((E5_ina_INa(X(17:17)',X(18:18)',X(19:19)'))+((E5_ik_IK(X(17:17)',X(20:20)'))))))+((-E5_I6_igaba_ISYN(X(17:17)',X(85:85)'))),...
    E5_ina_aM(X(17:17)').*(1-X(18:18)')-E5_ina_bM(X(17:17)').*X(18:18)',...
    E5_ina_aH(X(17:17)').*(1-X(19:19)')-E5_ina_bH(X(17:17)').*X(19:19)',...
    E5_ik_aN(X(17:17)').*(1-X(20:20)')-E5_ik_bN(X(17:17)').*X(20:20)',...
    (((0+0*randn(1,1))))+((((I6_ina_INa(X(21:21)',X(22:22)',X(23:23)'))+((I6_ik_IK(X(21:21)',X(24:24)'))))))+(-I6_E5_iampa_ISYN(X(21:21)',X(103:103)'))+(-I6_E3_iampa_ISYN(X(21:21)',X(84:84)'))+(-I6_I16_igaba_ISYN(X(21:21)',X(116:116)')),...
    I6_ina_aM(X(21:21)').*(1-X(22:22)')-I6_ina_bM(X(21:21)').*X(22:22)',...
    I6_ina_aH(X(21:21)').*(1-X(23:23)')-I6_ina_bH(X(21:21)').*X(23:23)',...
    I6_ik_aN(X(21:21)').*(1-X(24:24)')-I6_ik_bN(X(21:21)').*X(24:24)',...
    (((5+0*randn(1,1))))+((((E7_ina_INa(X(25:25)',X(26:26)',X(27:27)'))+((E7_ik_IK(X(25:25)',X(28:28)'))))))+((-E7_I8_igaba_ISYN(X(25:25)',X(87:87)'))),...
    E7_ina_aM(X(25:25)').*(1-X(26:26)')-E7_ina_bM(X(25:25)').*X(26:26)',...
    E7_ina_aH(X(25:25)').*(1-X(27:27)')-E7_ina_bH(X(25:25)').*X(27:27)',...
    E7_ik_aN(X(25:25)').*(1-X(28:28)')-E7_ik_bN(X(25:25)').*X(28:28)',...
    (((0+0*randn(1,1))))+((((I8_ina_INa(X(29:29)',X(30:30)',X(31:31)'))+((I8_ik_IK(X(29:29)',X(32:32)'))))))+(-I8_E7_iampa_ISYN(X(29:29)',X(104:104)'))+(-I8_E5_iampa_ISYN(X(29:29)',X(86:86)'))+(-I8_I18_igaba_ISYN(X(29:29)',X(118:118)')),...
    I8_ina_aM(X(29:29)').*(1-X(30:30)')-I8_ina_bM(X(29:29)').*X(30:30)',...
    I8_ina_aH(X(29:29)').*(1-X(31:31)')-I8_ina_bH(X(29:29)').*X(31:31)',...
    I8_ik_aN(X(29:29)').*(1-X(32:32)')-I8_ik_bN(X(29:29)').*X(32:32)',...
    (((5+0*randn(1,1))))+((((E9_ina_INa(X(33:33)',X(34:34)',X(35:35)'))+((E9_ik_IK(X(33:33)',X(36:36)'))))))+((-E9_I10_igaba_ISYN(X(33:33)',X(89:89)'))),...
    E9_ina_aM(X(33:33)').*(1-X(34:34)')-E9_ina_bM(X(33:33)').*X(34:34)',...
    E9_ina_aH(X(33:33)').*(1-X(35:35)')-E9_ina_bH(X(33:33)').*X(35:35)',...
    E9_ik_aN(X(33:33)').*(1-X(36:36)')-E9_ik_bN(X(33:33)').*X(36:36)',...
    (((0+0*randn(1,1))))+((((I10_ina_INa(X(37:37)',X(38:38)',X(39:39)'))+((I10_ik_IK(X(37:37)',X(40:40)'))))))+(-I10_E9_iampa_ISYN(X(37:37)',X(105:105)'))+(-I10_E7_iampa_ISYN(X(37:37)',X(88:88)'))+(-I10_I20_igaba_ISYN(X(37:37)',X(120:120)')),...
    I10_ina_aM(X(37:37)').*(1-X(38:38)')-I10_ina_bM(X(37:37)').*X(38:38)',...
    I10_ina_aH(X(37:37)').*(1-X(39:39)')-I10_ina_bH(X(37:37)').*X(39:39)',...
    I10_ik_aN(X(37:37)').*(1-X(40:40)')-I10_ik_bN(X(37:37)').*X(40:40)',...
    (((5+0*randn(1,1))))+((((E11_ina_INa(X(41:41)',X(42:42)',X(43:43)'))+((E11_ik_IK(X(41:41)',X(44:44)'))))))+((-E11_I12_igaba_ISYN(X(41:41)',X(91:91)'))),...
    E11_ina_aM(X(41:41)').*(1-X(42:42)')-E11_ina_bM(X(41:41)').*X(42:42)',...
    E11_ina_aH(X(41:41)').*(1-X(43:43)')-E11_ina_bH(X(41:41)').*X(43:43)',...
    E11_ik_aN(X(41:41)').*(1-X(44:44)')-E11_ik_bN(X(41:41)').*X(44:44)',...
    (((0+0*randn(1,1))))+((((I12_ina_INa(X(45:45)',X(46:46)',X(47:47)'))+((I12_ik_IK(X(45:45)',X(48:48)'))))))+(-I12_E11_iampa_ISYN(X(45:45)',X(106:106)'))+(-I12_E19_iampa_ISYN(X(45:45)',X(100:100)'))+(-I12_I_igaba_ISYN(X(45:45)',X(111:111)')),...
    I12_ina_aM(X(45:45)').*(1-X(46:46)')-I12_ina_bM(X(45:45)').*X(46:46)',...
    I12_ina_aH(X(45:45)').*(1-X(47:47)')-I12_ina_bH(X(45:45)').*X(47:47)',...
    I12_ik_aN(X(45:45)').*(1-X(48:48)')-I12_ik_bN(X(45:45)').*X(48:48)',...
    (((5+0*randn(1,1))))+((((E13_ina_INa(X(49:49)',X(50:50)',X(51:51)'))+((E13_ik_IK(X(49:49)',X(52:52)'))))))+((-E13_I14_igaba_ISYN(X(49:49)',X(93:93)'))),...
    E13_ina_aM(X(49:49)').*(1-X(50:50)')-E13_ina_bM(X(49:49)').*X(50:50)',...
    E13_ina_aH(X(49:49)').*(1-X(51:51)')-E13_ina_bH(X(49:49)').*X(51:51)',...
    E13_ik_aN(X(49:49)').*(1-X(52:52)')-E13_ik_bN(X(49:49)').*X(52:52)',...
    (((0+0*randn(1,1))))+((((I14_ina_INa(X(53:53)',X(54:54)',X(55:55)'))+((I14_ik_IK(X(53:53)',X(56:56)'))))))+(-I14_E13_iampa_ISYN(X(53:53)',X(107:107)'))+(-I14_E11_iampa_ISYN(X(53:53)',X(92:92)'))+(-I14_I4_igaba_ISYN(X(53:53)',X(113:113)')),...
    I14_ina_aM(X(53:53)').*(1-X(54:54)')-I14_ina_bM(X(53:53)').*X(54:54)',...
    I14_ina_aH(X(53:53)').*(1-X(55:55)')-I14_ina_bH(X(53:53)').*X(55:55)',...
    I14_ik_aN(X(53:53)').*(1-X(56:56)')-I14_ik_bN(X(53:53)').*X(56:56)',...
    (((5+0*randn(1,1))))+((((E15_ina_INa(X(57:57)',X(58:58)',X(59:59)'))+((E15_ik_IK(X(57:57)',X(60:60)'))))))+((-E15_I16_igaba_ISYN(X(57:57)',X(95:95)'))),...
    E15_ina_aM(X(57:57)').*(1-X(58:58)')-E15_ina_bM(X(57:57)').*X(58:58)',...
    E15_ina_aH(X(57:57)').*(1-X(59:59)')-E15_ina_bH(X(57:57)').*X(59:59)',...
    E15_ik_aN(X(57:57)').*(1-X(60:60)')-E15_ik_bN(X(57:57)').*X(60:60)',...
    (((0+0*randn(1,1))))+((((I16_ina_INa(X(61:61)',X(62:62)',X(63:63)'))+((I16_ik_IK(X(61:61)',X(64:64)'))))))+(-I16_E15_iampa_ISYN(X(61:61)',X(108:108)'))+(-I16_E13_iampa_ISYN(X(61:61)',X(94:94)'))+(-I16_I6_igaba_ISYN(X(61:61)',X(115:115)')),...
    I16_ina_aM(X(61:61)').*(1-X(62:62)')-I16_ina_bM(X(61:61)').*X(62:62)',...
    I16_ina_aH(X(61:61)').*(1-X(63:63)')-I16_ina_bH(X(61:61)').*X(63:63)',...
    I16_ik_aN(X(61:61)').*(1-X(64:64)')-I16_ik_bN(X(61:61)').*X(64:64)',...
    (((5+0*randn(1,1))))+((((E17_ina_INa(X(65:65)',X(66:66)',X(67:67)'))+((E17_ik_IK(X(65:65)',X(68:68)'))))))+((-E17_I18_igaba_ISYN(X(65:65)',X(97:97)'))),...
    E17_ina_aM(X(65:65)').*(1-X(66:66)')-E17_ina_bM(X(65:65)').*X(66:66)',...
    E17_ina_aH(X(65:65)').*(1-X(67:67)')-E17_ina_bH(X(65:65)').*X(67:67)',...
    E17_ik_aN(X(65:65)').*(1-X(68:68)')-E17_ik_bN(X(65:65)').*X(68:68)',...
    (((0+0*randn(1,1))))+((((I18_ina_INa(X(69:69)',X(70:70)',X(71:71)'))+((I18_ik_IK(X(69:69)',X(72:72)'))))))+(-I18_E17_iampa_ISYN(X(69:69)',X(109:109)'))+(-I18_E15_iampa_ISYN(X(69:69)',X(96:96)'))+(-I18_I8_igaba_ISYN(X(69:69)',X(117:117)')),...
    I18_ina_aM(X(69:69)').*(1-X(70:70)')-I18_ina_bM(X(69:69)').*X(70:70)',...
    I18_ina_aH(X(69:69)').*(1-X(71:71)')-I18_ina_bH(X(69:69)').*X(71:71)',...
    I18_ik_aN(X(69:69)').*(1-X(72:72)')-I18_ik_bN(X(69:69)').*X(72:72)',...
    (((5+0*randn(1,1))))+((((E19_ina_INa(X(73:73)',X(74:74)',X(75:75)'))+((E19_ik_IK(X(73:73)',X(76:76)'))))))+((-E19_I20_igaba_ISYN(X(73:73)',X(99:99)'))),...
    E19_ina_aM(X(73:73)').*(1-X(74:74)')-E19_ina_bM(X(73:73)').*X(74:74)',...
    E19_ina_aH(X(73:73)').*(1-X(75:75)')-E19_ina_bH(X(73:73)').*X(75:75)',...
    E19_ik_aN(X(73:73)').*(1-X(76:76)')-E19_ik_bN(X(73:73)').*X(76:76)',...
    (((0+0*randn(1,1))))+((((I20_ina_INa(X(77:77)',X(78:78)',X(79:79)'))+((I20_ik_IK(X(77:77)',X(80:80)'))))))+(-I20_E19_iampa_ISYN(X(77:77)',X(110:110)'))+(-I20_E17_iampa_ISYN(X(77:77)',X(98:98)'))+(-I20_I10_igaba_ISYN(X(77:77)',X(119:119)')),...
    I20_ina_aM(X(77:77)').*(1-X(78:78)')-I20_ina_bM(X(77:77)').*X(78:78)',...
    I20_ina_aH(X(77:77)').*(1-X(79:79)')-I20_ina_bH(X(77:77)').*X(79:79)',...
    I20_ik_aN(X(77:77)').*(1-X(80:80)')-I20_ik_bN(X(77:77)').*X(80:80)',...
    -X(81:81)'./10+((1-X(81:81)')/0.4).*(1+tanh(X(5:5)'/10)),... % from GDL-A27h-GDL
    -X(82:82)'./2+((1-X(82:82)')/0.4).*(1+tanh(X(1:1)'/10)),...
    -X(83:83)'./10+((1-X(83:83)')/0.4).*(1+tanh(X(13:13)'/10)),...
    -X(84:84)'./2+((1-X(84:84)')/0.4).*(1+tanh(X(9:9)'/10)),...
    -X(85:85)'./10+((1-X(85:85)')/0.4).*(1+tanh(X(21:21)'/10)),...
    -X(86:86)'./2+((1-X(86:86)')/0.4).*(1+tanh(X(17:17)'/10)),...
    -X(87:87)'./10+((1-X(87:87)')/0.4).*(1+tanh(X(29:29)'/10)),...
    -X(88:88)'./2+((1-X(88:88)')/0.4).*(1+tanh(X(25:25)'/10)),...
    -X(89:89)'./10+((1-X(89:89)')/0.4).*(1+tanh(X(37:37)'/10)),...
    -X(90:90)'./2+((1-X(90:90)')/0.4).*(1+tanh(X(33:33)'/10)),...    
    -X(91:91)'./10+((1-X(91:91)')/0.4).*(1+tanh(X(45:45)'/10)),...
    -X(92:92)'./2+((1-X(92:92)')/0.4).*(1+tanh(X(41:41)'/10)),...
    -X(93:93)'./10+((1-X(93:93)')/0.4).*(1+tanh(X(53:53)'/10)),...
    -X(94:94)'./2+((1-X(94:94)')/0.4).*(1+tanh(X(49:49)'/10)),...
    -X(95:95)'./10+((1-X(95:95)')/0.4).*(1+tanh(X(61:61)'/10)),...
    -X(96:96)'./2+((1-X(96:96)')/0.4).*(1+tanh(X(57:57)'/10)),...
    -X(97:97)'./10+((1-X(97:97)')/0.4).*(1+tanh(X(69:69)'/10)),...
    -X(98:98)'./2+((1-X(98:98)')/0.4).*(1+tanh(X(65:65)'/10)),...
    -X(99:99)'./10+((1-X(99:99)')/0.4).*(1+tanh(X(77:77)'/10)),...
    -X(100:100)'./2+((1-X(100:100)')/0.4).*(1+tanh(X(73:73)'/10)),...    
    -X(101:101)'./2+((1-X(101:101)')/0.4).*(1+tanh(X(1:1)'/10)),... % inter excitatory connection
    -X(102:102)'./2+((1-X(102:102)')/0.4).*(1+tanh(X(9:9)'/10)),...
    -X(103:103)'./2+((1-X(103:103)')/0.4).*(1+tanh(X(17:17)'/10)),...
    -X(104:104)'./2+((1-X(104:104)')/0.4).*(1+tanh(X(25:25)'/10)),...
    -X(105:105)'./2+((1-X(105:105)')/0.4).*(1+tanh(X(33:33)'/10)),...
    -X(106:106)'./2+((1-X(106:106)')/0.4).*(1+tanh(X(41:41)'/10)),...
    -X(107:107)'./2+((1-X(107:107)')/0.4).*(1+tanh(X(49:49)'/10)),...
    -X(108:108)'./2+((1-X(108:108)')/0.4).*(1+tanh(X(57:57)'/10)),...
    -X(109:109)'./2+((1-X(109:109)')/0.4).*(1+tanh(X(65:65)'/10)),...
    -X(110:110)'./2+((1-X(110:110)')/0.4).*(1+tanh(X(73:73)'/10)),...
    -X(111:111)'./10+((1-X(111:111)')/0.4).*(1+tanh(X(5:5)'/10)),... % for contralateral connection
    -X(112:112)'./10+((1-X(112:112)')/0.4).*(1+tanh(X(45:45)'/10)),...
    -X(113:113)'./10+((1-X(113:113)')/0.4).*(1+tanh(X(13:13)'/10)),...
    -X(114:114)'./10+((1-X(114:114)')/0.4).*(1+tanh(X(53:53)'/10)),...
    -X(115:115)'./10+((1-X(115:115)')/0.4).*(1+tanh(X(21:21)'/10)),...
    -X(116:116)'./10+((1-X(116:116)')/0.4).*(1+tanh(X(61:61)'/10)),...
    -X(117:117)'./10+((1-X(117:117)')/0.4).*(1+tanh(X(29:29)'/10)),...
    -X(118:118)'./10+((1-X(118:118)')/0.4).*(1+tanh(X(69:69)'/10)),...
    -X(119:119)'./10+((1-X(119:119)')/0.4).*(1+tanh(X(37:37)'/10)),...
    -X(120:120)'./10+((1-X(120:120)')/0.4).*(1+tanh(X(77:77)'/10))]';
IC = [-65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          -65          0.1          0.1            0          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1          0.1];

%% Solve system using built-in Matlab solver:
options=odeset('RelTol',1e-2,'AbsTol',1e-4,'InitialStep',.01);
[t,y]=ode23(ODEFUN,[0 100],IC,options);

%% Plot result
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

% the middle segment response is chosen for phase plane analysis
figure(2)
plot(y(:,17),y(:,21));
title('Phase plane E3-I3');
ylabel('Membrane potential of I3 (mV)');
xlabel('Membrane potential of E3 (mV)');