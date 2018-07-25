# Random-Packaging
Under construction: MATLAB class that allows for random packaging of 3-D objects into other objects

So far, nothing works, so don't try to use it.^^

## File Description

### Interfaces
- ShapeInterface.m: Abstract interface that defines basic variables and functions each shape should have. Is derived from handle class to allow implementing class' constructors to add listeners.
- CanisterInterface.m: Abstract interface that defines basic variables and functions each canister should have. Is derived from handle class to allow implementing class' constructors to add listeners. Will become obsolete soon because functionality will be moved to more general FilledShapeInterface class.
- FilledShapeInterface.m: Abstract interface that defines properties of fillable shapes. Is derived from ShapeInterface class because it is a Shape with extra functionality. Will have features from CanisterInterface class added to it soon.

### Object Classes
- Sphere.m: Implements ShapeInterface as a sphere.
- Cylinder.m: Implements ShapeInterface as a cylinder.
- cylCanister.m: Inherits from Cylinder and implements CanisterInterface as a cylindrical canister. Will be obsolete soon because functionality will be moved to more general FilledCanister class. 
- FilledCylinder.m: Implements FilledShapeInterface as fillable cylinder and inherits from cylinder. Will have features from cylCanister class added to it soon.

### Testing
- testSphere.m: Simple testing script for Sphere class. Will be expanded to testing function.
Will eventually add a full testing suite for all object classes.
