#####################
# NAME: Tensor Mechanics with hole in the middle
#
# Description:
# Tensor mechanics without holes in the middle and approx evolution of fractures
# in steels type elastic using generated mesh
#
#####################

# Allocate global parameters
[GlobalParams]
  displacements = 'disp_x disp_y'
  # order = FIRST
  # family = LAGRANGE
[]

# XFEM qrule
[XFEM]
  qrule = volfrac
  output_cut_plane = true
  use_crack_growth_increment = true
  crack_growth_increment = 0.2
  geometric_cut_userobjects = 'line_seg_cut_u0'
[]

[UserObjects]
  [./line_seg_cut_u0]
    type = LineSegmentCutUserObject
    # x y cut data
    cut_data = '0 5.0 5.0 5.0'
    time_start_cut = 0.0
    time_end_cut = 0.0
  [../]
[]

# using a predetermined mesh
[Mesh]
  type = GeneratedMesh
  dim = 2
  xmin = 0
  xmax = 10.0
  nx = 20
  ymin = 0
  ymax = 10.0
  ny = 20
  displacements = 'disp_x disp_y'
  boundary_id = '0 1 2 3'
  boundary_name = 'Bottom Right Top Left'
  #second_order = true
  #uniform_refine = 1
[]

# variables for x and y displacements
[Variables]
  [./disp_x]
  [../]
  [./disp_y]
  [../]
[]

# Master action for TM, where strain is small compare to the stress, and
# automatically adding variables.
[Modules/TensorMechanics/Master]
  [./block1]
    strain = FINITE# SMALL FINITE
    add_variables = true
    generate_output = 'stress_xx stress_yy stress_zz vonmises_stress'
    use_displaced_mesh = true
  [../]
[]

# Define boundary conditions
[BCs]
  [./bottom]
    type = PresetBC
    variable = disp_y
    boundary = Bottom
    value = -0.1
  [../]
  [./top]
    type = PresetBC
    variable = disp_y
    boundary = Top
    value = 0.1
  [../]
  [./right]
    type = PresetBC
    variable = disp_x
    boundary = Right
    value = 0.0
  [../]
[]

# Material vectors for elasticity and stress
# tensors, which it supples the elasticity tensors and
# linear stress using stress recovery
[Materials]
  [./elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2.1e5
    poissons_ratio = 0.3
  [../]
  [./stress]
    type =  ComputeFiniteStrainElasticStress #ComputeFiniteStrainElasticStress ComputeLinearElasticStress
    block = 0
  [../]
[]

# Executioner PJFNK
[Executioner]
  type = Transient
  solve_type = 'PJFNK'

  # petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  # petsc_options_value = 'lu superlu_dist'
  # line_search = 'none'

 # [./Quadrature]
 #   order = FOURTH
 #   type = MONOMIAL
 # [../]

  l_max_its = 100
  l_tol = 8e-3

  nl_max_its = 30
  nl_rel_tol = 1e-6
  nl_abs_tol = 1e-10

  start_time = 0.0
  dt = 1.0
  #end_time = 1.5e4
  num_steps = 2

  #dtmin = 1.0e2
  # Max xfem updated, not needed.
  max_xfem_update = 0
[]

[Postprocessors]
  [./_dt]                     # time step
    type = TimestepSize
  [../]
  [./nonlinear_its]           # number of nonlinear iterations at each timestep
    type = NumNonlinearIterations
  [../]
  [./Stress_xx]
    type = ElementAverageValue
    variable = stress_xx
  [../]
  [./Stress_yy]
    type = ElementAverageValue
    variable = stress_yy
  [../]
  [./Stress_zz]
    type = ElementAverageValue
    variable = stress_zz
  [../]
  [./Von_mises]
    type = ElementAverageValue
    variable = vonmises_stress
  [../]
[]

[Outputs]
  # Define output file
  file_base = xfem_fracture
  #interval = 1
  exodus = true
  #csv = true
  print_linear_residuals = true
  #[./console]
  #  type = Console
  #  perf_log = true
  #output_file = true
  #[../]
[]
