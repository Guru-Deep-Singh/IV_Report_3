function output = runSimulation(input)

inputStr = processInput(input, '', '');

system(['java -jar OTS.jar' inputStr], '-echo');

function inputStr = processInput(input, inputStr, location)
fieldNames = fields(input);
for i = 1:length(fieldNames)
    value = input.(fieldNames{i});
    if isempty(location)
        fullField = fieldNames{i};
    else
        fullField = [location '.' fieldNames{i}];
    end
    if isstruct(value)
        inputStr = processInput(value, inputStr, fullField);
    else
        inputStr = [inputStr ' ' fullField ' ' num2str(value)];
    end
end