
clc; clear all; close all;

% step 1 : load parameters
parameters;

% step 2 : load data , create matrix
load("data_nr1.mat");

% step 3 : fourier x-azis , y-axis 
data=fftshift(fft(data,[],1),1); 
data=fftshift(fft(data,[],2),2);

% step 4: create phase factor matrix (?matched filter?) and multiply data by it
phase_factor;


% step 5: Slotz interpolation (assuming - Stolt)
s_B = data;

% stolt_migartion - for legacy there is a snippet inside for taking only
% strong reflections into account
stolt;

% step 6: 3D inverse fourier 


% step 7: visualising data

