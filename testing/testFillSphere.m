%currently just testing FillSphere, but need to figure out suite testing

%%
%FillSphere
classdef testFillSphere < matlab.unittest.TestCase
    
    %{
    properties
        iAmFillSphere
    end
    %}
    
    methods(TestMethodSetup)
        %sets up test method - do i need this?
    end
    
    methods(TestMethodTeardown)
        %test method "destructor" - do i need this?
    end
    
    methods(Test)
        %test constructors
        function testConstructorEmpty(testCase)
            %testCase.iAmSphere = Sphere();
            %testCase.verifyClass(testCase.iAmSphere, ?Sphere);
            iAmFillSphere = FillSphere();
            testCase.verifyClass(iAmFillSphere, ?FillSphere);
        end
        function testConstructor1(testCase)
            iAmFillSphere = FillSphere(2);
            testCase.verifyClass(iAmFillSphere, ?FillSphere);
            %testCase.iAmSphere = Sphere(2);
            %testCase.verifyClass(testCase.iAmSphere, ?Sphere);
        end
        function testConstructorArray(testCase)
            iAmFillSphere = FillSphere(ones(3,1)*2);
            for i = 1:length(iAmFillSphere)
                testCase.verifyClass(iAmFillSphere(i), ?FillSphere);
            end
        end
    end
end