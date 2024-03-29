[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 15
  ny = 15
  xmin = 0
  xmax = 600
  ymin = 0
  ymax = 600
  elem_type = QUAD4
[]


[Variables]
  [./T]
   order = FIRST
   family = LAGRANGE
   initial_condition= 300
  [../]
[]

[AuxVariables]
  [./weistrength]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]


[AuxKernels]
  [./Wei_Aux]
    type = MaterialRealAux
    property = weibull
    variable = weistrength
    execute_on = 'initial linear'
  [../]
[]

[Kernels]
  [./diff]
  type = Diffusion
  variable = T
  [../]
[]


[BCs]
  [./outside]
    type = PresetBC
    boundary = 2
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

[Materials]
  [./weiproperty]
    type = XFEMWeibullMaterial
    weibull_modulus = 5
    specimen_material_property = 100e6
    specimen_volume = 0.1
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
  max_xfem_update = 11
[]

[Outputs]
  exodus = true
  file_base= randomized_properties
  [./console]
    type = Console
    perf_log = true
    output_linear = true
  [../]
[]
