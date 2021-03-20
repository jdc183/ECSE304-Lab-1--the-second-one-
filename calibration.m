valveVoltages = [0 10 20 30 40 50 60 70 80 90 100];
actualLevel =  [ 0.0     0.25  1.0    2.25  4.0  6.25  9.0  12.25 15.99  20.23  24.95];
digitalLevel = [-0.02456 1.234 4.975 11.26 20.0 31.26 45.01 61.23 79.96 101.1  124.7];

scatter(digitalLevel,actualLevel);
levelCalibration = polyfit(digitalLevel,actualLevel,1)
hold on
plot(digitalLevel,polyval(levelCalibration,digitalLevel));
title('Actual Level vs Uncalibrated Digital Value')
xlabel('Uncalibrated Digital Value')
ylabel('Actual Level (meters)');%I think it's meters, but idk for sure


heaterPower = [0 10 20 30 40 50 60 70 80 90 100];
actualTemp =  [1.35   9.0   16.65  24.3  31.95 39.6  47.25 54.9  62.55 70.2  77.85];
digitalTemp = [0.6662 4.515  8.321 12.15 15.97 19.8  23.62 27.45 31.26 35.09 38.91];

figure
scatter(digitalTemp,actualTemp);
tempCalibration = polyfit(digitalTemp,actualTemp,1)
hold on
plot(digitalTemp,polyval(tempCalibration,digitalTemp));
title('Actual Temperature vs Uncalibrated Digital Temperature Value')
xlabel('Uncalibrated Digital Temperature Value')
ylabel('Actual Temperature (Degrees Celsius)');

inflow =  [0.0 1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0   9.0   10.0  ];
outflow = [0.0 1.0 2.0 3.0 4.0 5.0 6.0 7.0 7.999 8.996  9.991];

heat = (polyval(tempCalibration,digitalTemp) - 1.326)*2.22;

figure
plot(actualLevel,outflow,'o--')
title('Outflow vs Level')
xlabel('Water Level (meters)')
ylabel('Outflow (cubic meters/second)')
figure
rootLevel = sqrt(actualLevel);
scatter(rootLevel,outflow);
hold on
fit = polyfit(rootLevel,outflow,1);
plot(rootLevel,polyval(f,rootLevel))
title('Outflow vs Sqare-root Level')
xlabel('Square-Root Level (sqrt(meters))')
ylabel('Outflow (cubic meters/second)')
k = fit(1)

figure
scatter(heaterPower,heat)
hold on
fit = polyfit(heaterPower,heat,1);
plot(heaterPower,polyval(fit,heaterPower))
title('Heat vs Heater Power')
xlabel('Heater Power (percent)')
ylabel('Heat (k-cal)')

figure
ppm = 1e6 * (polyval(tempCalibration,digitalTemp)-actualTemp)./77.85;
plot(actualTemp,ppm);
title('Temperature Sensor Calibration Error in PPM of Full Scale (FS = 77.85 C)')
ylabel('Error in PPM of FS')
xlabel('Measured Value (C)')

figure
ppm = 1e6 * (polyval(levelCalibration,digitalLevel)-actualLevel)./24.95;
plot(actualLevel,ppm);
title('Level Sensor Calibration Error in PPM of Full Scale (FS = 24.95 m)')
ylabel('Error in PPM of FS')
xlabel('Measured Level (m)')
