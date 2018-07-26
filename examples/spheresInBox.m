%script that handles random placement of spheres into a rectangular box

%define box dimensions

%define shape dimensions
%   monosized spheres for now
%   different sizes later
%   different shapes later

%define random center locations

%make a FillableBox object to represent the canister
%   call to constructor with intended number of FillShapes

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
