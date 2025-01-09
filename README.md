This is an unpolished but otherwise functioning prototype of BREAKOUT developed in Godot 4.3, as part of the 20 games challenge.

![](assets/breakout.GIF)

Requirements
------------
- Godot 4.3

Limitations
---
- I tried initially to do it with physics, but switched back to using CharacterBody2D for the ball, as physics was a bit tricky
- Expect bugs everywhere. For example, sometimes collisions between the ball and a brick are not registered and the brick is not destroyed
- Keyboard only