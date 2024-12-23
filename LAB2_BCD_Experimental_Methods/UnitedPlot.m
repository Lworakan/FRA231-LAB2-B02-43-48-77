% Updated Parameters
maxSpeed = 241.91;           % Max Speed in rad/s
I_No_load = 0.378154;           % No-load Current in A
I_Stall = 3.586;              % Stall Current in A
stallTorque = 0.24;         % Stall Torque in Nm
Vin = 12.6;                   % Input Voltage in V

% Efficiency Curve
Torque1 = linspace(0, stallTorque, 1000);  % Torque from 0 to Stall Torque
n = ((-(maxSpeed/stallTorque)*((Torque1).^2) + maxSpeed*Torque1) ./ ...
    (((I_Stall - I_No_load)/stallTorque)*Torque1*Vin + I_No_load*Vin)) * 100;

% Find the maximum efficiency and its corresponding torque (Rated Point)
[maxEfficiency, idx] = max(n);  % maxEfficiency is the highest value, idx is its index
ratedTorque = Torque1(idx);     % Find the corresponding torque

% Power Curve
Torque2 = linspace(0, stallTorque, 1000);  % Torque from 0 to Stall Torque
P = -(maxSpeed/stallTorque)*((Torque2).^2) + maxSpeed*Torque2;

% Find the Rated Power (Power at rated torque)
ratedPower = -(maxSpeed/stallTorque)*(ratedTorque^2) + maxSpeed*ratedTorque;

% Torque-Current Curve
xTorqueCurrent = [0, stallTorque];  % Torque range
yCurrent = [I_No_load, I_Stall];    % Current range
ratedCurrent = interp1(xTorqueCurrent, yCurrent, ratedTorque, 'linear');  % Current at rated torque

% Torque-Speed Curve
xTorqueSpeed = [0, stallTorque];    % Torque range
ySpeed = [maxSpeed, 0];             % Speed range
ratedSpeed = interp1(xTorqueSpeed, ySpeed, ratedTorque, 'linear');  % Speed at rated torque

% Combined Plot in Subplots
figure;

% Subplot 1: Efficiency Curve
subplot(2, 2, 1);  % 2x2 grid, first subplot
plot(Torque1, n, '-black', 'LineWidth', 1.5, 'DisplayName', 'Efficiency (%)');
hold on;
plot(ratedTorque, maxEfficiency, 'bo', 'MarkerFaceColor', 'b', 'DisplayName', 'Rated Point (Efficiency)');
xlabel('Torque (Nm)');
ylabel('Efficiency (%)');
title('Efficiency Curve');
grid on;
legend('Location', 'Best');

% Subplot 2: Power Curve
subplot(2, 2, 2);  % 2x2 grid, second subplot
plot(Torque2, P, '-g', 'LineWidth', 1.5, 'DisplayName', 'Power (W)');
hold on;
plot(ratedTorque, ratedPower, 'ro', 'MarkerFaceColor', 'r', 'DisplayName', 'Rated Point (Power)');
xlabel('Torque (Nm)');
ylabel('Power (W)');
title('Power Curve');
grid on;
legend('Location', 'Best');

% Subplot 3: Torque-Current Curve
subplot(2, 2, 3);  % 2x2 grid, third subplot
plot(xTorqueCurrent, yCurrent, '-b', 'LineWidth', 1.5, 'DisplayName', 'Torque/Current (A)');
hold on;
plot(ratedTorque, ratedCurrent, 'mo', 'MarkerFaceColor', 'm', 'DisplayName', 'Rated Point (Current)');
xlabel('Torque (Nm)');
ylabel('Current (A)');
title('Torque-Current Curve');
grid on;
legend('Location', 'Best');

% Subplot 4: Torque-Speed Curve
subplot(2, 2, 4);  % 2x2 grid, fourth subplot
plot(xTorqueSpeed, ySpeed, '-r', 'LineWidth', 1.5, 'DisplayName', 'Torque/Speed (Rad/s)');
hold on;
plot(ratedTorque, ratedSpeed, 'co', 'MarkerFaceColor', 'c', 'DisplayName', 'Rated Point (Speed)');
xlabel('Torque (Nm)');
ylabel('Speed (Rad/s)');
title('Torque-Speed Curve');
grid on;
legend('Location', 'Best');

% Adjust layout for better spacing
sgtitle('DC Motor Characteristics');