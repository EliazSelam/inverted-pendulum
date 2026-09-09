% cart_transfer_function.m
% IP02 Cart: Transfer function derivation with and without motor inductance
% Experiment 1 — Real-Time Control Lab (מעבדת בקרה בזמן אמת)
% Author: Eliaz Selam

s = tf('s');

% Time parameters
dt = 1e-5; tf = 10;

% IP02 System parameters
Mc = 0.57;      % Cart mass          [kg]
Bc = 4.3;       % Cart damping       [N·s/m]
Kg = 3.71;      % Gear ratio
Eta_g = 1;      % Gear efficiency
Eta_m = 1;      % Motor efficiency
rmp = 6.35e-3;  % Motor pinion radius [m]
Rm = 2.6;       % Motor resistance   [Ohm]
Lm = 1.8e-4;    % Motor inductance   [H]
Lm1 = 0;
kt = 7.68e-3;   % Motor torque const [N·m/A]
km = 7.68e-3;   % Back-EMF constant  [V·s/rad]

% Transfer function with inductance
W = Eta_g * Kg * kt * Eta_m * rmp / ...
    ((s^2 * Mc * Lm + s * (Mc * Rm + Bc * Lm) + Bc * Rm) * rmp^2 ...
    + Eta_g * Eta_m * Kg^2 * kt);

% Transfer function without inductance
W1 = Eta_g * Kg * kt * Eta_m * rmp / ...
    ((s * (Mc * Rm) + Bc * Rm) * rmp^2 ...
    + Eta_g * Eta_m * Kg^2 * kt);

% Step response comparison
figure;
step(W, W1);
legend('W(s) - with inductance', 'W1(s) - without inductance');
title('Step Response Comparison');
xlabel('Time (s)');
ylabel('Output');
grid on;

% Run Simulink model
sim('LCTR_11');

% Compute error between models
Error = norm(WithLm - WithoutLm) / 10 * sqrt(dt);
fprintf('Error = %.4e\n\n', Error);
disp('W(s) ='); W
disp('W1(s) ='); W1
% Result: Error = 2.411e-07  →  inductance is negligible for control design
