% -----------------------------------------
% Gate driver calculations-
%    Gate Driver Chip - DRV8300
%    Half Bridge Trasistors - GSFP0876
%
% Equations come from gate driver datasheet
%   <https://www_.ti.com/lit/ds/symlink/drv8300.pdf?HQS=dis-dk-null-digikeymode-dsf-pf-null-wwe&ts=1763304640726>
% -----------------------------------------

clc; clear; close all;

%% Givens
% Gate Driver
V_gvdd    = 12;    % Gate voltage
V_bootd   = .85;   % Integrated bootstrap diode forward voltage drop
V_bstuv   = 4.8;   % Threshold of boostrap undervoltage lockout
IL_bstran = 7e-6;  % Bootstrap pin leakage current
f_sw      = 24e3;  % PWM switching frequency (24-48 kHz)
I_source  = .75;   % Gate driver typical source current

% Transistor
Q_g = 45e-9; % Gate charge of transistor
R_g = 1.1;   % Gate resistance

% System Parameter
t_r = 120e-9; % Rise time (system parameter chosen)

%% Calculating bootstrap capacitors 
% Calculations
V_bstx_del = V_gvdd - V_bootd - V_bstuv; % Maximum allowible voltage ripple across bootstrap cap
Q_tot      = Q_g + IL_bstran/f_sw;       % Total charge (where ?)

V_bstx_del = 1; % finding the cap to get a 1V ripple
C_bst = Q_tot/V_bstx_del; % Minimum bootstrap cap

%% Calculate R_gate
% <https://www.ti.com/lit/an/sluaap4/sluaap4.pdf?ts=1760201496590> page 4
C_eq = Q_g/V_gvdd; % Equivalent gate capacitance
I_g  = C_eq*V_gvdd/t_r; % Current required to switch transistors at t_r

R_total = V_gvdd/I_g; % Gate total resistance to get specific current
R_driver = V_gvdd/I_source; % Gate driver Rout
R_gate = R_total - R_driver - R_g; % Resistance to limit current from I_source to Ig


