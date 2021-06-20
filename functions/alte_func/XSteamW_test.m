% XSteamW_test.m
%
% A simple test script for testing XSteamW

clc;

XSteamW ('h_pt', 100, 500:10:530)
XSteamW ('h_pt', 100:50:200, 530)

XSteamW ('h_pt', [100, 150, 200], [500, 510, 520, 530])
XSteamW ('h_pt', [100; 150; 200], [500, 510, 520, 530])
XSteamW ('h_pt', [100, 150, 200], [500; 510; 520; 530])
XSteamW ('h_pt', [100; 150; 200], [500; 510; 520; 530])
XSteamW ('h_pt', 100:50:200, 500:10:530)

XSteam ('h_pt', 100, 500)
XSteam ('h_pt', 200, 530)
