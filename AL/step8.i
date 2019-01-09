[Mesh]
  file = square.e
  uniform_refine = 4
[]

[Variables]

  [./diffused]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[Kernels]

  [./diffused_ie]
    type = TimeDerivative
    variable = diffused
  [../]

  [./diff]
    type = Diffusion
    variable = diffused
  [../]
[]

[BCs]

  [./left_diffused]
    type = DirichletBC
    variable = diffused
    boundary = 'left'
    value = 0
  [../]

  [./right_diffused]
    type = DirichletBC
    variable = diffused
    boundary = 'right'
    value = 1
  [../]

[]

[Materials]
  [./example_material]
    type = ExampleMaterial
    block = 1
    initial_diffusivity = 0.05
  [../]
[]

[Executioner]
  type = Transient
  solve_type = 'PJFNK'
  num_steps = 10
  dt = 1.0
[]

[Outputs]
  execute_on = 'timestep_end'
  exodus = true
[]
