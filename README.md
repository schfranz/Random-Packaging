# Random-Packaging
Under construction: MATLAB class that allows for random packaging of 3-D objects into other objects

So far, nothing works, so don't try to use it.^^

## File Description

### Interfaces
- FillShapeInterface.m: Abstract interface that defines properties of shapes that can fill objects that implement the FillableShapeInterface class.
- FillableShapeInterface.m: Abstract interface that defines properties of fillable shapes. Is derived from ShapeInterface class because it is a Shape with extra functionality. Will have features from CanisterInterface class added to it soon.
- ShapeInterface.m: Abstract interface that defines basic variables and functions each shape should have. Is derived from handle class to allow implementing class' constructors to add listeners.

### Object Classes
- Box.m: Implements ShapeInterface as a box.
- Cylinder.m: Implements ShapeInterface as a cylinder.
- FillSphere.m: Inherits from Sphere and implements FillShapeInterface as a spherical FillShape.
- FillableBox.m: Inherits from Box and implements FillableShapeInterface as a box FillableShape.
- Sphere.m: Implements ShapeInterface as a sphere.

### Testing
Tests can be found in /testing. To run a test enter runtests('FILENAME.m').
- testSphere.m: Simple testing script for Sphere class. Will be expanded to testing function.
Will eventually add a full testing suite for all object classes.
- testFillableBox.m: Simple constructor tests for FillableBoxClass.

### Examples
Examples can be found in folder /examples.
- spheresInBox.m: shows an example of placing a bunch of monosized spheres into a box.

### Other
- .gitignore: Helps me keep my local folder clean. Will take out local files and only put .asv files MATLAB might make while running for final release.
 
