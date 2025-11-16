% -----------------------------------------
% Gate driver calculations-
%    Gate Driver Chip - DRV8300
%    Half Bridge Trasistors - GSFP0876
%
% Equations come from gate driver datasheet
%   <https://www_.ti.com/lit/ds/symlink/drv8300.pdf?HQS=dis-dk-null-digikeymode-dsf-pf-null-wwe&ts=1763304640726>
% -----------------------------------------

clc; clear; close all;

%% Calculating bootstrap capacitors 

% Givens
V_gvdd    = 12;    % Gate voltage
V_bootd   = .85;   % Integrated bootstrap diode forward voltage drop
V_bstuv   = 4.8;   % Threshold of boostrap undervoltage lockout
Q_g       = 45e-9; % Gate charge of transistor
IL_bstran = 7e-6;  % Bootstrap pin leakage current
f_sw      = 24e3;  % PWM switching frequency (24-48 kHz)

% Calculations
V_bstx_del = V_gvdd - V_bootd - V_bstuv; % Maximum allowible voltage ripple across bootstrap cap
Q_tot      = Q_g + IL_bstran/f_sw;       % Total charge (where ?)

V_bstx_del = 1; % finding the cap to get a 1V ripple
C_bst = Q_tot/V_bstx_del; % Minimum bootstrap cap
