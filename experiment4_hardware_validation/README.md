# Experiment 4 — Hardware LQR Validation (Verifying LQR)

Real hardware experiments on the Quanser IP02 inverted pendulum.
Controller: full-state LQR feedback (gains from Experiment 3).

## Q Matrix Sweep Results

| Q = diag([q1 q2 q3 q4]) | Observation |
|--------------------------|-------------|
| [1 1 1 1]                | Default — poor balance |
| [10 35 0.1 0.1]          | Good stability, mild overshoot |
| [40 35 0.1 0.1]          | Strong cart weight — fast but noisier |
| [100 35 0.1 0.1]         | High noise from hardware |
| [35 100 0.1 0.1]         | Cart doesn't converge to zero |
| [35 350 0.1 0.1]         | Excessive cart weight, oscillation |
| **[35 35 0.1 0.1]**      | ✅ **Optimal — best angle + position trade-off** |
| **[40 35 0.1 0.1]**      | ✅ **Runner-up — minimal simulation error** |

## Conclusion

Best Q matrix: `Q = diag([35 35 0.1 0.1])` or `Q = diag([40 35 0.1 0.1])`.

Key factors affecting hardware results:
- Cart start position sensitivity (~30 cm from rail start required)
- External disturbances (table vibration, air currents)
- Simulation vs real-hardware discrepancy increases with R

*Hardware: Quanser IP02 + Q2-USB DAQ · Supervisor: Vladimir Sirnev · Ariel University*
