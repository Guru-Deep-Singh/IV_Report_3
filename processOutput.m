function output = processOutput(input)

if isfield(input, 'outputFileDetectors')
    file = input.outputFileDetectors;
else
    file = 'dets.txt';
end
fid = fopen(file);
detDat = textscan(fid, '%d,%d,%d,%f', 'HeaderLines', 1, 'EndOfLine', '\r\n');
fclose(fid);
for det = 1:4
    these = detDat{1} == det;
    output.detector(det).t = detDat{2}(these) / 60;
    output.detector(det).q = detDat{3}(these);
    output.detector(det).v = detDat{4}(these);
end

if isfield(input, 'outputFileTravelTime')
    file = input.outputFileTravelTime;
else
    file = 'time.txt';
end
fid = fopen(file);
timeDat = textscan(fid, '%s', 'EndOfLine', '\r\n');
timeDat = timeDat{1};
fclose(fid);

GTUTypes = {'CAR', 'TRUCK', 'ACC_CAR', 'CACC_CAR', 'ACC_TRUCK', 'CACC_TRUCK'};
GTUType = '';
for i = 1:length(timeDat)
    if any(strcmp(timeDat{i}, GTUTypes))
        GTUType = timeDat{i};
        output.travelTime.(GTUType) = [];
    else
        output.travelTime.(GTUType)(end+1) = str2double(timeDat{i});
    end
end