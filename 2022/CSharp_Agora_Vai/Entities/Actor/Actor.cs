using Godot;
using System;

public class Actor : KinematicBody2D
{
  [Export] public int speed = 200;
  [Export] public int jumpForce = 300;
  [Export] public int gravity = 500;
  [Export] public float friction = 0.1f;
  [Export] public float airFriction = 0.05f;
  [Export] public float acceleration = 0.25f;

  public Vector2 velocity = new Vector2();

  public override void _PhysicsProcess(float delta)
  {
    base._PhysicsProcess(delta);

    ApplyHorizontalMovement();
    ApplyGravity(delta);
    ApplyMotion();
    ApplyJump();
  }

  public virtual void ApplyHorizontalMovement() { }

  public virtual void ApplyGravity(float delta)
  {
    velocity.y += gravity * delta;
  }

  public virtual void ApplyMotion()
  {
    velocity = MoveAndSlide(velocity, Vector2.Up);
  }

  public virtual void ApplyJump() { }
}
