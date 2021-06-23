% This example script runs a base scenario and 6 CACC truck scenarios. The
% scenarios are given by 3 penetration rates (20%, 50% and 100%), which are
% tested for both the 'linear' and 'ploeg' CACC. Output is the capacity
% estimated as the highest 1-minute flow (i.e. this is bad estimate!). This
% output is printed to the Command Window.

% number of seeds
seeds = 3;

% when false, we can redo the evaluation without re-running
% note that this can only be done if all runs are performed once first
run = true; 

% non-default input, fixed across scenarios
input.autorun = 'true';
input.truck.p = 0.1;
%input.car.acc.p = 0.0;
%input.car.cacc.p = 0.0;
input.truck.acc.p = 0.5;
input.truck.cacc.p = 0.5;

input.demandMain = 0.5; % demand factor on mainline demand
input.demandRamp = 0.5; % demand factor on ramp demand

input.car.acc.model = 'linear';
input.truck.acc.model = 'linear';
input.car.cacc.model = 'linear';
input.truck.cacc.model = 'linear';

acc = [0.0 0.25 0.5];
cacc = [0.5 0.25 0.0];

for b = [1 2]
    input.car.b = b;
    %number of repeats for each b value scenario
    
    for r = 1:seeds
        input.seed = r;
        
        %number of combinations of acc and cacc
        for i = 1:3
            input.car.acc.p = acc(i);
            input.car.cacc.p = cacc(i);
            if run
                runSimulation(input);
                output = processOutput(input);
                % store data so we can redo the evaluation without re-running
                save(['b_' num2str(b) '_seed_' num2str(r) '_acc_' num2str(acc(i)) '_cacc_' num2str(cacc(i)) '.mat'], 'output');
            else
                load(['b_' num2str(b) '_seed_' num2str(r) '_acc_' num2str(acc(i)) '_cacc_' num2str(cacc(i)) '.mat']);
        
            end
        end
        
        %Displaying the capacity
        cap = max(output.detector(3).q + output.detector(4).q);
        disp(['Capacity b ' num2str(b) ' seed '  num2str(r) ' acc ' num2str(acc(i)) ' cacc ' num2str(cacc(i)) ': ' num2str(cap) 'veh/h']);
        %Displaying the mean time 
        fieldNames = fields(output.travelTime);
        for i = 1:length(fieldNames)
            disp(['Mean travel time for ' fieldNames{i} ': ' num2str(mean(output.travelTime.(fieldNames{i})))]);
        end
    end
end
           
     
    
%{
% base scenario
input.truck.cacc.p = 0.0;

for r = 1:seeds
    input.seed = r;
    if run
        runSimulation(input);
        output = processOutput(input);
        % store data so we can redo the evaluation without re-running
        save(['base_' num2str(r) '.mat'], 'output');
    else
        load(['base_' num2str(r) '.mat']);
    end
    cap = max(output.detector(3).q + output.detector(4).q);
    disp(['Capacity base seed ' num2str(r) ': ' num2str(cap) 'veh/h']);
end

% CACC scenarios
systems = {'linear', 'ploeg'};
for p = [0.2 0.5 1.0]
    input.truck.cacc.p = p;
    for s = 1:2
        input.truck.cacc.model = systems{s};
        for r = 1:seeds
            input.seed = r;
            if run
                runSimulation(input);
                output = processOutput(input);
                save([systems{s} '_' num2str(p) '_' num2str(r) '.mat'], 'output');
            else
                load([systems{s} '_' num2str(p) '_' num2str(r) '.mat']);
            end
            cap = max(output.detector(3).q + output.detector(4).q);
            disp(['Capacity ' systems{s} ' at ' num2str(p*100) '% seed ' num2str(r) ': ' num2str(cap) 'veh/h']);
        end
    end
end

%}