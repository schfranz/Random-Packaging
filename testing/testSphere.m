%currently just testing Sphere, but need to figure out suite testing
%unit test set for classes ShapeInterface, CanisterInterface, and derived
%classes Sphere, Cylinder, and cylCanister

%%
%Sphere
classdef testSphere < matlab.unittest.TestCase
    
    methods (Test)
        %constructors
        function testConstructorEmpty(testCase)
            iAmSphere = Sphere();
            testCase.verifyClass(iAmSphere, ?Sphere);
        end
        function testConstructor1(testCase)
            iAmSphere = Sphere(2);
            testCase.verifyClass(iAmSphere, ?Sphere);

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