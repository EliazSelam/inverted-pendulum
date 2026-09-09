% lqr_R_sweep.m
% LQR design for IP02 SIP — effect of R on closed-loop response
% Experiment 3, Part A — Real-Time Control Lab (מעבדת בקרה בזמן אמת)
% Author: Eliaz Selam
%
% Requires: setup_ip02_sip  (Quanser QUARC script)
%           s_sip_lqr       (Simulink model)
% setup_ip02_sip defines: A, B, C, D (4-state linearised IP02)
% States: x = [theta; theta_dot; x_cart; x_cart_dot]

setup_ip02_sip;

% --- Setup figures ---
figure; hax1 = axes; % VM (motor voltage)
figure; hax2 = axes; % XC (cart position)
figure; hax3 = axes; % Alpha (pendulum angle)

% --- Sweep parameters ---
R_arr = [0.01 0.02 0.04 0.06 0.08];
q1 = 10; q2 = 10; q3 = 0; q4 = 0.1;

vm_max_values    = [];
alpha_max_values = [];

hold(hax1); title(hax1, 'VM Step Response for different R values'); grid(hax1);
hold(hax2); title(hax2, 'XC Step Response for different R values');  grid(hax2);
hold(hax3); title(hax3, 'Alpha Step Response for different R values'); grid(hax3);

% --- Simulation loop ---
for idx = 1:length(R_arr)
    R = R_arr(idx);
    Q = diag([q1 q2 q3 q4]);

    % Compute LQR gain
    [K, S, EIG_CL] = lqr(A, B, Q, R);

    % Run Simulink model
    sim('s_sip_lqr');

    % --- VM ---
    t_vm = data_vm(:,1);  y_vm = data_vm(:,2);
    plot(hax1, t_vm, y_vm, 'DisplayName', ['R = ' num2str(R)]);
    vm_max_values(idx) = max(y_vm);

    % --- XC ---
    t_xc = data_xc(:,1);  y_xc = data_xc(:,2);  yr_xc = data_xc(:,3);
    plot(hax2, t_xc, y_xc, 'DisplayName', ['R = ' num2str(R)]);
    hold on;
    plot(hax2, t_xc, yr_xc, 'DisplayName', ['R = ' num2str(R)]);

    % --- Alpha ---
    t_alpha = data_alpha(:,1);  y_alpha = data_alpha(:,2);
    plot(hax3, t_alpha, y_alpha, 'DisplayName', ['R = ' num2str(R)]);
    alpha_max_values(idx) = max(y_alpha);
end

legend(hax1, 'show'); legend(hax2, 'show'); legend(hax3, 'show');

% --- Max VM vs R ---
figure;
plot(R_arr, vm_max_values, '-o');
xlabel('R values'); ylabel('Max VM');
title('Max VM vs R'); grid on;
saveas(gcf, 'Max_VM_vs_R.png');

% --- Max Alpha vs R ---
figure;
plot(R_arr, alpha_max_values, '-o');
xlabel('R values'); ylabel('Max Alpha');
title('Max Alpha vs R'); grid on;
saveas(gcf, 'Max_Alpha_vs_R.png');

% --- Print results ---
disp('--- Max VM values ---');
disp(array2table([R_arr' vm_max_values'], 'VariableNames', {'R', 'Max_VM'}));
disp('--- Max Alpha values ---');
disp(array2table([R_arr' alpha_max_values'], 'VariableNames', {'R', 'Max_Alpha'}));
%
% Results:
%  R=0.01: Max_VM=1.9014  Max_Alpha=1.2429
%  R=0.02: Max_VM=1.3491  Max_Alpha=1.0916
%  R=0.04: Max_VM=0.9630  Max_Alpha=0.9165
%  R=0.06: Max_VM=0.7954  Max_Alpha=0.8131
%  R=0.08: Max_VM=0.6973  Max_Alpha=0.7420
