#####################
# NAME: Tensor Mechanics with hole in the middle
#
#
#
#####################

# Allocate global parameters
[GlobalParams]
  displacements = 'disp_x disp_y'
  order = FIRST
  family = LAGRANGE
[]

# uses the mesh created
[Mesh]
  file = circle_with_hole_model1.e
  displacements = 'disp_x disp_y'
  boundary_id = '1 2 3 4'
  boundary_name = 'Bottom Right Top Left'
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
    strain = SMALL
    add_variables = true
    generate_output = 'stress_xx stress_yy stress_zz vonmises_stress'
  [../]
[]

# Define boundary conditions
[BCs]
  [./bottom]
    type = DirichletBC
    variable = disp_x
    boundary = Left
    value = -0.01
  [../]
  [./top]
    type = DirichletBC
    variable = disp_x
    boundary = Right
    value = 0.1
  [../]
  [./right]
    type = DirichletBC
    variable = disp_y
    boundary = Top
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
    type = ComputeLinearElasticStress
    block = 1
  [../]
[]

[Executioner]
  type = Transient
  solve_type = 'PJFNK'

  # petsc_options = '-snes_ksp_ew'
  # petsc_options_iname = '-pc_type -pc_factor_mat_solver_package -mat_superlu_dist_fact'
  # petsc_options_value = 'lu       superlu_dist    SamePattern'

  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu superlu_dist'
  line_search = 'none'

#  [./Quadrature]
#    order = FOURTH
#    type = MONOMIAL
#  [../]

  l_max_its = 100
  l_tol = 8e-3

  nl_max_its = 30
  nl_rel_tol = 1e-6
  nl_abs_tol = 1e-10

  start_time = 0.0
  #dt = 1.0e2
  #end_time = 1.5e4
  num_steps = 1

  dtmin = 1.0e2
  # Max xfem updated, not needed.
  max_xfem_update = 1
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
  # Define output file(s)
  #file_base = tm_test_mode_1
  interval = 1
  exodus = true
  #csv = true
  # [./console]
  #   type = Console
  #   perf_log = true
  #   output_file = true
  # [../]
[]
