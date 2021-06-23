% Notes:
%  - For acc and cacc, fractions are given as fraction of all cars or 
%    trucks (not all traffic).
%  - Parameters are defined in a nested manner. Parameter 'input.truck.a'
%    also applies to 'input.truck.acc.a', unless that is itself specified.
%  - Parameter descriptions are only given the first time they occur.

% Batch running:
%  - Make a separate script.
%  - Create loops to run over scenario's, and seeds within a scenario.
%  - For each run, create an input structure. Note: you only need to define
%    non-default input. Below all default input is given.
%  - Set 'input.autorun' to 'true' so no GUI and manual input is required.
%  - Use the input structure to run a simulation (runSimulation).
%  - Use the input structure to process the output (processOutput).
%  - Perform analysis on each run using the output.
%  - Gather data over the runs per scenario.
%  - Tip: change the output files for each run so you can keep all data on
%    disk. Then in a separate loop-structure, perform the output. In this
%    way you can change the output processing code without having to re-run
%    all the simulation.

% Scenario settings
input.autorun = 'false'; % set 'true' to hide the GUI
input.seed = 1; % change between runs in a single scenario
input.demandMain = 0.7; % demand factor on mainline demand
input.demandRamp = 0.7; % demand factor on ramp demand
input.upstreamDetector = 100.0; % location of upstream dectectors (1 & 2), upstream of ramp [m]
input.downstreamDetector = 100.0; % location of downstream detector (3 & 4), downstream of ramp [m]
input.outputFileDetectors = 'dets.txt'; % output file detectors
input.outputFileTravelTime = 'time.txt'; % output file travel time

% Vehicle class fractions
input.truck.p = 1.0;
input.car.acc.p = 0.25;
input.car.cacc.p = 0.25;
input.truck.acc.p = 0.5;
input.truck.cacc.p = 0.5;

% Longitudinal model: 'linear', or 'ploeg'
input.car.acc.model = 'linear';
input.truck.acc.model = 'linear';
input.car.cacc.model = 'linear';
input.truck.cacc.model = 'linear';

% Car parameters
input.car.a = 1.25; % maximum acceleration [m/s/s]
input.car.b = 2.09; % maximum comfortable deceleration [m/s/s]
input.car.Tr = 0.4; % reaction time [s]
input.car.n = 2; % number of leading vehicles considered in car-following

% Truck parameters
input.truck.a = 0.8;
input.truck.b = 2.09;
input.truck.Tr = 0.4;
input.truck.n = 3;

% ACC car parameters
input.car.acc.range = 150; % range of on-board sensors [m]
input.car.acc.delay = 0.2; % delay of on-board sensors [s]
input.car.acc.kf = 0.075; % desired speed error gain
input.car.acc.Tacc = 1.2; % ACC headway [s]
input.car.acc.x0 = 3.0; % stopping distance [m]
input.car.acc.ks = 0.2; % gap error gain
input.car.acc.kv = 0.4; % speed error gain (Linear)
input.car.acc.kd = 0.7; % gap error derivative gain (Ploeg)
input.car.acc.vol = 1.0; % factor on lane change desire for voluntary incentives
input.car.acc.coop = 1.0; % sensitivity to cooperate for lane changes

% ACC truck parameters
input.truck.acc.a = 0.8;
input.truck.acc.range = 150;
input.truck.acc.delay = 0.2;
input.truck.acc.kf = 0.075;
input.truck.acc.Tacc = 1.2;
input.truck.acc.x0 = 3.0;
input.truck.acc.ks = 0.2;
input.truck.acc.kv = 0.4;
input.truck.acc.kd = 0.7;
input.truck.acc.vol = 1.0;
input.truck.acc.coop = 1.0;

% CACC car parameters
input.car.cacc.range = 300;
input.car.cacc.delay = 0.2;
input.car.cacc.kf = 0.075;
input.car.cacc.Tacc = 1.2;
input.car.cacc.Tcacc = 0.5; % CACC headway
input.car.cacc.x0 = 3.0;
input.car.cacc.ks = 0.2;
input.car.cacc.ka = 1.0; % acceleration error gain [m/s/s]
input.car.cacc.kv = 0.4;
input.car.cacc.kd = 0.7;
input.car.cacc.vol = 1.0;
input.car.cacc.coop = 1.0;

% CACC truck parameters
input.truck.cacc.a = 0.8;
input.truck.cacc.range = 300;
input.truck.cacc.delay = 0.2;
input.truck.cacc.kf = 0.075;
input.truck.cacc.Tacc = 1.2;
input.truck.cacc.Tcacc = 0.5;
input.truck.cacc.x0 = 3.0;
input.truck.cacc.ks = 0.2;
input.truck.cacc.ka = 1.0;
input.truck.cacc.kv = 0.4;
input.truck.cacc.kd = 0.7;
input.truck.cacc.vol = 1.0;
input.truck.cacc.coop = 1.0;

% Run simulation
runSimulation(input);

% Process output
output = processOutput(input);

% Plot
for i = 1:4
    subplot(2,2,i);
    plot(output.detector(i).t, output.detector(i).q);
    xlabel('Time [min]');
    ylabel('Flow [veh/h]');
    title(['Detector ' num2str(i)]);
end
fieldNames = fields(output.travelTime);
for i = 1:length(fieldNames)
    disp(['Mean travel time for ' fieldNames{i} ': ' num2str(mean(output.travelTime.(fieldNames{i})))]);
end