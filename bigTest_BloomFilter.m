clear, clc
%% Variables
setSize = 1e5;
stringSize = 50;
randomStringSize = 0; % False = 0 / True = else
set = generateStrings(setSize, stringSize, 1);
notSet = generateStrings(setSize, stringSize, 1);
if randomStringSize == 0
    fprintf('Length of the randomly generated strings: %d\n', stringSize);
else
    fprintf('Max length of the randomly generated strings: %d\n', stringSize);
end

falsePositiveProbability = 0.001;
obj = BloomFilter(falsePositiveProbability, setSize);
fprintf('Probability of false positive: %f\n', falsePositiveProbability);
fprintf('Length of the set to add (m): %d\n\n', setSize);

%% Add set to filter
for idx = 1:setSize
    obj.add(set{idx});  
end
fprintf('%d randomly generated strings added to the filter.\n\n', setSize);

%% Verify if the set is in the filter
numExisting = 0;
for idx = 1:setSize
    if obj.contains(set{idx}) == 1
        numExisting = numExisting + 1;
    end
end
fprintf('%d strings that were previously added are probably in the set.\n', numExisting);
fprintf('%d strings that were previously added are not in the set.\n\n', setSize - numExisting);

%% Verify if other elems that were not added may be in the set
numExisting = 0;
for idx = 1:setSize
    if obj.contains(notSet{idx}) == 1
        numExisting = numExisting + 1;
    end
end
fprintf('%d strings that were not added are probably in the set.\n', numExisting);
fprintf('%d strings that were not added are not in the set.\n', setSize - numExisting);
fprintf('Probability of false positives (observed): %f\n\n', numExisting / setSize);
