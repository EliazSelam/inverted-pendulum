% pv_pd_comparison.m
% PV vs PD velocity/position controller for IP02 Cart
% Experiment 2 — Real-Time Control Lab (מעבדת בקרה בזמן אמת)
% Author: Eliaz Selam

s = tf('s');

% Design requirements
K   = 0.125;   % Plant gain
tau = 0.02;    % Plant time constant
xi  = 0.591;   % Desired damping ratio
wn  = 26;      % Desired natural frequency [rad/s]

% Controller gains
Kp = wn^2 / K;
Kv = (2 * xi * wn - 1) / K;
Kd = Kv;  % PD uses same derivative gain

fprintf('PV Controller:\nKp = %.2f\nKv = %.2f\n\n', Kp, Kv);
fprintf('PD Controller:\nKp = %.2f\nKd = %.2f\n\n', Kp, Kd);
% Result: Kp = 5408.00  Kv = 237.86

% Closed-loop transfer functions
WclPV = K * Kp / (tau * s^2 + (1 + Kv * K) * s + K * Kp);
WclPD = K * (Kp + Kd * s) / (tau * s^2 + (1 + K * Kd) * s + K * Kp);

% Step response comparison
figure;
step(WclPV, 'b', WclPD, 'r--', 1.5);
title('Step Response Comparison: PV vs PD');
legend('PV Controller', 'PD Controller');
xlabel('Time (s)');
ylabel('Output');
grid on;

% Bode diagram comparison
figure;
bode(WclPV, 'b', WclPD, 'r--');
title('Bode Diagram Comparison: PV vs PD');
legend('PV Controller', 'PD Controller');
grid on;
