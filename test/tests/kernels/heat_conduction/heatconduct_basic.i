[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 10
  ny = 10
  xmin = 0
  xmax = 10
  ymin = 0
  ymax = 10
  boundary_id = '1 3'
  boundary_name = 'right left'
[]


[Kernels]
  [./HeatDiff] # Partial T
    type = HeatConduction
    variable = T
  [../]
  [./HeatTdot]  # partial t
    type = HeatConductionTimeDerivative
    variable = T
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
  [./right]
    type = DirichletBC
    boundary = right
    variable = T
    value = 300 # Outside temperature set at 300K
  [../]
  [./left]
    type = DirichletBC
    boundary = left
    variable = T
    value = 1200 # Outside temperature set at 300K
  [../]
[]

[Materials]
  [./k]
    type = GenericConstantMaterial
    prop_names = 'thermal_conductivity'
    prop_values = '0.95' #copper in cal/(cm sec C)
  [../]
  [./cp]
    type = GenericConstantMaterial
    prop_names = 'specific_heat'
    prop_values = '0.092' #copper in cal/(g C)
  [../]
  [./rho]
    type = GenericConstantMaterial
    prop_names = 'density'
    prop_values = '8.92' #copper in g/(cm^3)
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
  dt = 1
  end_time = 10
[]

[Outputs]
  exodus = true
  [./console]
    type = Console
    perf_log = false
    output_linear = true
  [../]
[]
