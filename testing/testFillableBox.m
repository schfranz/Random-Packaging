%script that runs simple tests on FillableBox class

classdef testFillableBox < matlab.unittest.TestCase
    
    %{
    properties
        interactTestCase = matlab.unittest.TestCase.forInteractiveUse;
    end
    %}
    
    methods (Test)
        %check that legal constructors work
        function testConstructorEmpty(testCase)
            iAmFillableBox = FillableBox();
            testCase.verifyClass(iAmFillableBox, ?FillableBox);
        end
        %check that illegal constructors fail
        %check that constructor with 1 argument fails
        function testConstructor1(testCase)
            [~] = testCase.verifyError(@() FillableBox(2), 'MATLAB:minrhs');            
        end
        %check that calls asking for too many output arguments fail
    end
end