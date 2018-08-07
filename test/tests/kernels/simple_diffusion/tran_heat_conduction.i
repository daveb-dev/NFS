[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 10
  ny = 10
  boundary_id = '1 3'
  boundary_name = 'right left'
[]

[Kernels]
  [./diff]
    type = Diffusion
    variable= T
  [../]
[]

[Variables]
  [./T]
   order = FIRST
   family = LAGRANGE
   initial_condition= 300 # inital temp conditions
  [../]
[]

[BCs]
  [./outside]
    type = PresetBC
    boundary = 1
    variable = T
    value = 300 # Outside temperature set at 300K
  [../]
  [./Inside]
    type = PresetBC
    boundary = 3
    variable = T
    value = 1400 # Inside temperature set at 300K
  [../]
[]

[Executioner]
  type = Transient

  solve_type = 'PJFNK'
  petsc_options_iname = '-ksp_gmres_restart -pc_type -pc_hypre_type -pc_hypre_boomeramg_max_iter'
  petsc_options_value = '201                hypre    boomeramg      8'

  line_search = 'none'

  [./Predictor]
    type = SimplePredictor
    scale = 1.0
  [../]

# controls for linear iterations
  l_max_its = 100
  l_tol = 1e-2

# controls for nonlinear iterations
  nl_max_its = 15
  nl_rel_tol = 1e-14
  nl_abs_tol = 1e-9

# time control
  start_time = 0.0
  dt = 0.2
  end_time = 2.0
  num_steps= 5000
[]

[Outputs]
  exodus = true
[]
