#####################
# NAME: Tensor Mechanics with hole in the middle
#
# Description:
# Tensor mechanics without holes in the middle and approx evolution of fractures
# in steels type elastic using generated mesh
#
#####################

# allocate global parameters
[GlobalParams]
  displacements = 'disp_x disp_y'
  order = FIRST
  family = LAGRANGE
[]

# using a predetermined mesh
[Mesh]
  type = GeneratedMesh
  dim = 2
  xmin = 0
  xmax = 10.0
  ymin = 0
  ymax = 10.0
  displacements = 'disp_x disp_y'
  boundary_id = '0 1 2 3'
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
    strain = SMALL # SMALL FINITE
    add_variables = true
    generate_output = 'stress_xx stress_yy stress_zz vonmises_stress'
    #use_displaced_mesh = true
  [../]
[]

# Define boundary conditions
[BCs]
  [./bottom]
    type = DirichletBC
    variable = disp_y
    boundary = Bottom
    value = -2.0
  [../]
  [./top]
    type = DirichletBC
    variable = disp_y
    boundary = Top
    value = 2.0
  [../]
  [./right]
    type = DirichletBC
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
    type = ComputeLinearElasticStress #ComputeFiniteStrainElasticStress ComputeLinearElasticStress
    #block = 0
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
  dt = 0.1
  #end_time = 1.5e4
  num_steps = 20

  #dtmin = 1.0e2
  # Max xfem updated, not needed.
  #max_xfem_update = 1
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
  #file_base = xfem_fracture
  interval = 1
  exodus = true
  #csv = true
  #[./console]
    #type = Console
    #perf_log = true
    #output_file = true
  #[../]
[]
