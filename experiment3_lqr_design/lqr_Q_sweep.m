% lqr_Q_sweep.m
% LQR design for IP02 SIP — effect of Q weights on closed-loop response
% Experiment 3, Part B — Real-Time Control Lab (מעבדת בקרה בזמן אמת)
% Author: Eliaz Selam
%
% Requires: setup_ip02_sip, s_sip_lqr

setup_ip02_sip;

figure; hax1 = axes; hold(hax1, 'on');

R = 0.02;
q1_arr = [1 10 20 30 35 40];
q2 = 1; q3 = 1; q4 = 1;

for idx = 1:length(q1_arr)
    Q = diag([q1_arr(idx), q2, q3, q4]);
    K = lqr(A, B, Q, R);
    sys = ss(A - B*K, B, C, D);
    w = tf(minreal(sys));
    w1 = w(1, :);
    step(hax1, w1);
end

lines = flipud(findall(hax1, 'Type', 'line'));
legend(hax1, lines, "Q1 = " + string(q1_arr), 'Location', 'bestoutside');

title(hax1, 'Step Response for Different Q1 Values');
xlabel(hax1, 'Time (s)');
ylabel(hax1, 'Output');
grid(hax1, 'on');
