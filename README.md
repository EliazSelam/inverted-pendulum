# Inverted Pendulum — Real-Time Control Lab

**`MATLAB`** &nbsp;|&nbsp; **`Simulink`** &nbsp;|REPLACE|&nbsp; **`State Feedback`** &nbsp;|&nbsp; **`Quanser IP02`**

Hardware-in-the-loop control experiments on the Quanser IP02 single inverted pendulum (SIP) cart system. All experiments use the linearised state-space model around the upright equilibrium.

**States:** x = [θ, θ̇, x_c, ẋ_c]ᵀ &nbsp;|&nbsp; **Input:** u = motor voltage [V]

## Experiments

| # | Topic | File | Key Result |
|---|-------|------|-----------|
| 1 | Cart TF: inductance vs no inductance | `experiment1_cart_tf/` | Error = 2.41×10⁻⁷ → inductance negligible |
| 2 | PV vs PD controller design | `experiment2_controllers/` | Kp = 5408, Kv = 237.86 |
| 3 | LQR — R and Q parameter sweep | `experiment3_lqr_design/` | Optimal: R=0.02, Q=diag([10 10 0 0.1]) |
| 4 | Hardware LQR validation | `experiment4_hardware_validation/` | Best: Q=diag([35 35 0.1 0.1]) |

## System

Quanser IP02 SIP | Cart mass Mc=0.57 kg | Motor Kg=3.71 | Rm=2.6 Ω | kt=7.68 mN·m/A

*Supervisor: Vladimir Sirnev · Ariel University*
