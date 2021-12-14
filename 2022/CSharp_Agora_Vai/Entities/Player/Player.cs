using Godot;
using System;

public class Player : Actor
{
  public override void ApplyHorizontalMovement()
  {
    int dir = 0;

    if (Input.IsActionPressed("ui_right")) { dir += 1; }
    if (Input.IsActionPressed("ui_left")) { dir -= 1; }

    if (dir != 0)
    {
      velocity.x = Mathf.Lerp(velocity.x, (float)dir * (float)speed, acceleration);
    }
    else
    {
      if (IsOnFloor())
      {
        velocity.x = Mathf.Lerp(velocity.x, 0.0f, friction);
      }
      else
      {
        velocity.x = Mathf.Lerp(velocity.x, 0.0f, airFriction);
      }
    }
  }

  public override void ApplyJump()
  {
    if (Input.IsActionJustPressed("ui_up"))
    {
      if (IsOnFloor())
      {
        velocity.y = -jumpForce;
      }
    }
  }
}
