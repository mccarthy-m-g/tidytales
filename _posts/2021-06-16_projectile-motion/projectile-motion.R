velocity_x <- function(velocity, angle) {
  # Degrees need to be converted to radians in cos() since that is what the
  # function uses
  velocity * cos(angle * (pi/180))
}

velocity_y <- function(velocity, angle) {
  # Degrees need to be converted to radians in sin() since that is what the
  # function uses
  velocity * sin(angle * (pi/180))
}

flight_time <- function(velocity_y, height, gravity = 9.80665) {
  ( velocity_y + sqrt(velocity_y^2 + 2 * gravity * height) ) / gravity
}

distance <- function(velocity_x, velocity_y, height, gravity = 9.80665) {
  velocity_x * ( velocity_y + sqrt(velocity_y^2 + 2 * gravity * height) ) / gravity
}

height_max <- function(velocity_y, height, gravity = 9.80665) {
  height + velocity_y^2 / (2 * gravity)
}

projectile_motion <- function(velocity, angle, height, gravity = 9.80665, nframes = 30) {

  # Velocity components
  vx <- velocity_x(velocity, angle)
  vy <- velocity_y(velocity, angle)
  # Flight components
  t  <- flight_time(vy, height, gravity)
  d  <- distance(vx, vy, height, gravity)
  # Max height components
  hm <- height_max(vy, height, gravity)
  th <- vy / gravity
  hd <- vx * th

  # Calculate the position of the projectile in 2D space at a given point in
  # time to approximate its trajectory over time
  x_pos <- map_dbl(seq(0, t, length = nframes), ~ {
    vx * .x
  })

  y_pos <- map_dbl(seq(0, t, length = nframes), ~ {
    height + ( vy * .x + 0.5 * -gravity * .x^2 )
  })

  # Calculate the vertical velocity of the projectile at a given point in time
  vy_t  <- map_dbl(seq(0, t, length = nframes), ~ {
    vy - gravity * .x
  })

  trajectory <- data.frame(
    x = x_pos,
    y = y_pos,
    vx = vx,
    vy = vy_t,
    second = seq(0, t, length = nframes)
  )

  # Return a list with all calculated values
  list(
    velocity_x = vx,
    velocity_y = vy,
    flight_time = t,
    distance = d,
    max_height = hm,
    max_height_time = th,
    max_height_dist = hd,
    trajectory = trajectory,
    nframes = nframes,
    fps = nframes/t
  )

}
