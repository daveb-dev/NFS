#####################
# NAME: Solid Mechanics with hole in the middle
#
#
#
#####################

# Global Params
[GlobalParams]
  disp_x = disp_x
  disp_y = disp_y
  order = FIRST
  family = LAGRANGE
[]

# FE problems
# [Problem]
#   type = FEProblem
# []

# Input Mesh
[Mesh]
  file = circle_with_hole_model1.e
  displacements = 'disp_x disp_y'
  boundary_id = '1 2 3 4'
  boundary_name = 'Bottom Right Top Left'
  #uniform_refine = 1
[]

# [XFEM]
#   qrule = volfrac
#   output_cut_plane = true
#   use_crack_growth_increment = true
#   crack_growth_increment = 0.0005
# []

#[UserObjects]
  # [./xfem_marker_uo]
  #   type = XFEMMaterialTensorMarkerUserObject
  #   execute_on = timestep_end
  #   tensor = stress
  #   #quantity = MaxPrincipal
  #   quantity = hoop
  #   point1 = '0, 0, 0'
  #   point2 = '0, 0, 1'
  #   #average = false
  #   average = true
  #   threshold = 1.5e8  #1.5e8 #1.3e8
  #   initiate_on_boundary = 1
  #   random_range = 0.1
  #   #weibull = xfem_weibull
  #   #use_weibull = true
  # [../]
#  [./xfem_mean_stress]
#    type = XFEMMeanStress
#    tensor = stress
#    quantity = MaxPrincipal
#    execute_on = timestep_end
#    critical_stress = 1.0 #1.3e8
#    use_weibull = true
#    radius = 0.0002
#    weibull_radius = 0.0002
#    average_h = h
#  [../]
  # [./xfem_energy_release_rate]
  #   type = XFEMEnergyReleaseRate
  #   execute_on = timestep_end
  #   block = pellet_type_1
  #   use_weibull = true
  #   average_h = h
  #   radius_inner = 2e-4
  #   radius_outer = 4e-4
  #   critical_energy_release_rate = 200
  # [../]
 #  [./xfem_max_hoop_stress]
 #    type = XFEMMaxHoopStress
 #    execute_on = timestep_end
 #    block = 1
 #    disp_x = disp_x
 #    disp_y = disp_y
 #    temp = temp
 #    youngs_modulus = 2.e11
 #    poissons_ratio = .345
 #    thermal_expansion = 10e-6
 #    radius_inner = 2e-4
 #    radius_outer = 4e-4
 #    average_h = h
 #    intersecting_boundary = 8
 #    critical_k = 8e6
 # [../]
 # [./pair_qps]
 #   type = XFEMElementPairQPProvider
 # [../]
 # [./manager]
 #   type = XFEMElemPairMaterialManager
 #   material_names = 'material1'
 #   element_pair_qps = pair_qps
 # [../]
#[]

[Variables]
  [./disp_x]
  [../]

  [./disp_y]
  [../]
[]

[AuxVariables]

  [./xfem_volfrac]
    order = CONSTANT
    family = MONOMIAL
  [../]

  [./xfem_marker]
    order = CONSTANT
    family = MONOMIAL
  [../]

  [./xfem_cut_origin_x]
    order = CONSTANT
    family = MONOMIAL
  [../]

  [./xfem_cut_origin_y]
    order = CONSTANT
    family = MONOMIAL
  [../]

  [./xfem_cut_origin_z]
    order = CONSTANT
    family = MONOMIAL
  [../]

  [./xfem_cut_normal_x]
    order = CONSTANT
    family = MONOMIAL
  [../]

  [./xfem_cut_normal_y]
    order = CONSTANT
    family = MONOMIAL
  [../]

  [./xfem_cut_normal_z]
    order = CONSTANT
    family = MONOMIAL
  [../]

  [./xfem_threshold]
    order = CONSTANT
    family = MONOMIAL
  [../]

  [./stress_xx]      # stress aux variables are defined for output; this is a way to get integration point variables to the output file
    order = CONSTANT
    family = MONOMIAL
  [../]

  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]

  [./stress_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]

  # [./hoop]
  #   order = CONSTANT
  #   family = MONOMIAL
  # [../]

  # [./radial]
  #   order = CONSTANT
  #   family = MONOMIAL
  # [../]
  #
  # [./axial]
  #   order = CONSTANT
  #   family = MONOMIAL
  # [../]
  #
  # [./vonmises]
  #   order = CONSTANT
  #   family = MONOMIAL
  # [../]
  #
  # [./weibull]
  #   order = CONSTANT
  #   family = MONOMIAL
  # [../]
  #
  # [./burnup]
  #   order = CONSTANT
  #   family = MONOMIAL
  # [../]
[]


[SolidMechanics]
  [./solid]
    volumetric_locking_correction = false
  [../]
[]
#
# [Kernels]
#   [./heat]         # gradient term in heat conduction equation
#     type = HeatConduction
#     variable = temp
#   [../]
#
#  [./heat_ie]       # time term in heat conduction equation
#    type = HeatConductionTimeDerivative
#    variable = temp
#  [../]
#
#
#   [./heat_source]  # source term in heat conduction equation
#      type = HeatSource
#      variable = temp
#      block = 1
#      function = power_history
#   [../]
# []

[AuxKernels]
 # [./weibull_output]
 #   type = MaterialRealAux
 #   variable = weibull
 #   property = weibull
 # [../]
  # [./xfem_marker]
  #   type = XFEMMarkerAux
  #   variable = xfem_marker
  #   execute_on = linear
  # [../]
 # [./xfem_threshold]
 #    type = MaterialTensorAux
 #    variable = xfem_threshold
 #    tensor = stress
 #    quantity = MaxPrincipal
 #    #quantity = hoop
 #    #point1 = '0, 0, 0'
 #    #point2 = '0, 0, 1'
 #    execute_on = timestep_end
 #  [../]
  [./stress_xx]               # computes stress components for output
    type = MaterialTensorAux
    tensor = stress
    variable = stress_xx
    index = 0
    execute_on = timestep_end     # for efficiency, only compute at the end of a timestep
  [../]
  [./stress_yy]
    type = MaterialTensorAux
    tensor = stress
    variable = stress_yy
    index = 1
    execute_on = timestep_end
  [../]
  [./stress_zz]
    type = MaterialTensorAux
    tensor = stress
    variable = stress_zz
    index = 2
    execute_on = timestep_end
  [../]
  # [./hoop]
  #   type = MaterialTensorAux
  #   tensor = stress
  #   variable = hoop
  #   quantity = hoop
  #   point1 = '0, 0, 0'
  #   point2 = '0, 0, 1'
  #   execute_on = linear
  # [../]
  # [./radial]
  #   type = MaterialTensorAux
  #   tensor = stress
  #   variable = radial
  #   quantity = radial
  #   point1 = '0, 0, 0'
  #   point2 = '0, 0, 1'
  #   execute_on = timestep_end
  # [../]
  # [./axial]
  #   type = MaterialTensorAux
  #   tensor = stress
  #   variable = axial
  #   quantity = axial
  #   point1 = '0, 0, 0'
  #   point2 = '0, 0, 1'
  #   execute_on = timestep_end
  # [../]
  # [./vonmises]
  #   type = MaterialTensorAux
  #   tensor = stress
  #   variable = vonmises
  #   quantity = vonmises
  #   execute_on = timestep_end
  # [../]
[]

[BCs]
# Define boundary conditions
  [./bottom]
    type = DirichletBC
    variable = disp_x
    boundary = Bottom
    value = 0.1
  [../]
  [./top]
    type = DirichletBC
    variable = disp_x
    boundary = Top
    value = 0.1
  [../]


[]

[Materials]
  [./elastic]
    type = Elastic
    block = 1
    #temp = temp
    youngs_modulus = 2.e11
    poissons_ratio = .345
    thermal_expansion = 10e-6
    compute_JIntegral = true
    #stress_free_temperature = 300
  [../]

  [./density]
    type = Density
    block = 1
    density = 10.0 #kg/m3
  [../]

  # [./fuel_oxide]
  #       type = ThermalFuel
  #       block = 1
  #       temp = temp
  #       burnup = burnup
  #       model = 5
  # [../]
  # [./fuel_thermalU3Si]
  #       type = ThermalSilicideFuel
  #       block = 1
  #       temp = temp
  #       silicon_mole_fraction = 0.25
  #       specific_heat_model = WHITE
  #       thermal_conductivity_model = ZHANG
  # [../]

  # [./weilbull]
  #   type = XFEMWeibullMaterial
  #   weibull_modulus = 15
  #   specimen_volume = 5.281e-5 #5.281e-5 # 7.6977e-05
  #   specimen_material_property = 1.0
  #   block = 1
  # [../]
[]

[Executioner]

  type = Transient

  solve_type = 'PJFNK'

  petsc_options = '-snes_ksp_ew'
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package -mat_superlu_dist_fact'
  petsc_options_value = 'lu       superlu_dist    SamePattern'

  # petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  # petsc_options_value = 'lu superlu_dist'

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
  dt = 1.0e2
  #end_time = 1.5e4
  num_steps = 10

  dtmin = 1.0e2

  max_xfem_update = 1
[]

[Postprocessors]
  [./_dt]                     # time step
    type = TimestepSize
  [../]
  [./nonlinear_its]           # number of nonlinear iterations at each timestep
    type = NumNonlinearIterations
  [../]
  # [./hoop_stress]
  #   type = ElementAverageValue
  #   variable = hoop
  # [../]
  [./vonmises]
    type = ElementAverageValue
    variable = vonmises
  [../]
[]

[Outputs]
  # Define output file(s)
  #file_base = solid_with_hole
  interval = 1
  exodus = true
  csv = true
  [./console]
    type = Console
    perf_log = true
    output_file = true
  [../]
[]
