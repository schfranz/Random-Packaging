%script that handles random placement of spheres into a rectangular box

%define box dimensions: tall box with square base
height = 2*173.275;
width = 2*11.59;
depth = width;

%make a FillableBox object
myBox = FillableBox(height, width, depth);

%define shape dimensions (monosized spheres for now; different sizes/shapes later
nSpheres = 400; %number of spheres
totSphereVol = 0.525*(myBox.volume); %total volume we expect to fill
radius = (totSphereVol*3/4/pi() / nSpheres)^(1/3); %radius of each sphere
%create array of FillSphere objects with diameter and default center
sphereArray = FillSphere(ones(nSpheres,1) * 2 * radius);

%update intended number of FillShapes in myBox
myBox.nFillShapesExp = nSpheres; %maybe move to constructor

%generate random center locations
myBox.placeFillShapesRand(sphereArray)

%start a loop to 
    %make FillSphere objects according to random center ...
    %   location and size 
    %       call to Sphere constructor with diameter and center
    %       add FillSphere variables (movable, transpShape, transpWall)
        
    %add them to the FillableBox object (call to addShape with FillSphere
    %   object)
    %       adding will update the list of neighbors (go through X, Y, Z
    %       list of FillableBox, take 6 from each list (3 down, 3 up),
    %       clean list to take out duplicate IDs; make sure there is a
    %       failsafe for 
    %       adding will determine if FillShape can be placed
    
    %stop when all shapes are added or when shapes can't be added anymore
    
%check overlap (make function in FillableShapeInterface that checks overlap ...
%   between all shapes that can't have any and all other shapes present as ...
%   well as walls)

%yayyyyy, we've placed a bunch of spheres! write MCNP input
