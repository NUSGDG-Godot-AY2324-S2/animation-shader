# animation-shader
Template project to add shaders

## Guide

### Scenes

#### Player

Basic movement of players have been implemented.

* Left, right arrows to move left and right
* Z to dash (can dash from the air)
* X to jump
* C to attack

Assets are found in `assets/BlueWizard`. Assets for bullets

#### Map

Basic map layout and collision have been defined. Enemies and obstacles are also added.

Assets are found in `assets/Mossy Tileset`.

Assets for enemy are found in `assets/SlimeOrange`.

Assets for obstacles are found in `assets/Plant Animations/Plant 8 Poison`.

### Collision

#### Layer

* Player: 1
* Bullet: none
* Map: 2
* Obstacles: none
* Enemy: 3

#### Mask

* Player: 2 & 3
* Bullet: 3
* Map: none
* Obstacles: 1
* Enemy: none

## Acknowledgement

Assets are obtained from [Mossy Cavern](https://maaot.itch.io/mossy-cavern).

Assets for bullets are obtained from [16x16 Bullet](https://bdragon1727.itch.io/free-effect-and-bullet-16x16).
