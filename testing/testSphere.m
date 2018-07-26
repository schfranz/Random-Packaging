%currently just testing Sphere, but need to figure out suite testing
%unit test set for classes ShapeInterface, CanisterInterface, and derived
%classes Sphere, Cylinder, and cylCanister

%%
%Sphere
classdef testSphere < matlab.unittest.TestCase
    
    %{
    properties
        iAmSphere
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
            iAmSphere = Sphere();
            testCase.verifyClass(iAmSphere, ?Sphere);
        end
        function testConstructor1(testCase)
            iAmSphere = Sphere(2);
            testCase.verifyClass(iAmSphere, ?Sphere);
            %testCase.iAmSphere = Sphere(2);
            %testCase.verifyClass(testCase.iAmSphere, ?Sphere);
        end
        function testConstructorArray(testCase)
            iAmSphere = Sphere(ones(3,1)*2);
            for i = 1:length(iAmSphere)
                testCase.verifyClass(iAmSphere(i), ?Sphere);
            end
        end
    end
    %{
    hm = Sphere(2);
    hm = Sphere(2, [1,2,3]);
    hm = Sphere(2, [1,2]);
    hm = Sphere(2, 1);
    hm = Sphere(2, [1;2;3]);
    hm = Sphere(2, []);
    hm = Sphere(2, [1,2,3,4]);
    %}
end