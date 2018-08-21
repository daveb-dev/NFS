[GlobalParams]
  order = FIRST
  family = LAGRANGE
[]

[Mesh]
  file = 2d_2pi_2_fix2.e
[]

[XFEM]
  geometric_cut_userobjects = 'line_seg_cut_uo line_seg_cut_uo1 line_seg_cut_uo2
                               line_seg_cut_uo3 line_seg_cut_uo4'
  qrule = moment_fitting # moment_fitting scheme
  output_cut_plane = true
  use_crack_growth_increment = true
  crack_growth_increment = 0.1
[]

[UserObjects]
  [./line_seg_cut_uo]
    type = LineSegmentCutUserObject
    cut_data = '0.002 0.001 0.0039 0.0039'
    time_start_cut = 0.0
    time_end_cut = 2.0
  [../]
  [./line_seg_cut_uo4]
    type = LineSegmentCutUserObject
    cut_data = '0.0012 0.00055 0.002 0.001'
    time_start_cut = 0.0
    time_end_cut = 2.0
  [../]
  [./line_seg_cut_uo1]
    type = LineSegmentCutUserObject
    cut_data = '-0.002 -0.001 -0.0039 -0.0039'
    time_start_cut = 0.0
    time_end_cut = 2.0
  [../]
  [./line_seg_cut_uo2]
    type = LineSegmentCutUserObject
    cut_data = '-0.002 0.001 -0.0039 0.0039'
    time_start_cut = 0.0
    time_end_cut = 2.0
  [../]
  [./line_seg_cut_uo3]
    type = LineSegmentCutUserObject
    cut_data = '0.002 -0.001 0.0039 -0.0039'
    time_start_cut = 0.0
    time_end_cut = 2.0
  [../]
  [./xfem_marker_uo]
  type = XFEMMaterialTensorMarkerUserObject
  execute_on = timestep_end
  tensor = stress
  quantity = MaxPrincipal
  threshold = 5e+1
  average = true
[../]
[]

[Variables]
  [./disp_x]
  [../]
  [./disp_y]
  [../]
  [./T]
   order = FIRST
   family = LAGRANGE
   initial_condition= 300
  [../]
[]

[AuxVariables]
  [./th_cond]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./cp]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[AuxKernels]
  [./th_cond]
    type = MaterialRealAux
    variable = th_cond
    property = thermal_conductivity
    block = 1
    execute_on = 'initial linear'
  [../]

  [./cp]
    type = MaterialRealAux
    variable = cp
    property = specific_heat
    block = 1
    execute_on = 'initial linear'
  [../]
[]


[SolidMechanics]
  [./solid]
    disp_x = disp_x
    disp_y = disp_y
    use_displaced_mesh = false
  [../]
[]

[Kernels]
  [./heat]
    type = HeatConduction
    variable = T
  [../]
  [./heat_ie]
    type = HeatConductionTimeDerivative
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
  [./linelast]
    type = LinearIsotropicMaterial
    block = 1
    disp_x = disp_x
    disp_y = disp_y
    poissons_ratio = 0.3
    youngs_modulus = 1e6
  [../]
  [./fuel_thermalU3Si]
    type = ThermalSilicideFuel
    block = 1
    temp = T
    silicon_mole_fraction = 0.25
    specific_heat_model = WHITE   # This is the default
    thermal_conductivity_model = ZHANG
  [../]
  [./density]
    type = Density
    block = 1
    density = 1200.0
  [../]
  [./RandomizedGrain]
    type = XFEMWeibullMaterial
    specimen_material_property = 200
    specimen_volume = 1.28e-5 #m^3
    weibull_modulus = 15
  [../]
[]

[Executioner]
  type = Transient

  solve_type = 'PJFNK'
  petsc_options_iname = '-ksp_gmres_restart -pc_type -pc_hypre_type -pc_hypre_boomeramg_max_iter'
  petsc_options_value = '201                hypre    boomeramg      8'

  line_search = 'none'

  [./Quadrature]
  order = FOURTH
  type = MONOMIAL
  [../]

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
  max_xfem_update = 5000
[]

[Outputs]
  exodus = true
  file_base= Mf_multicrack
  [./console]
    type = Console
    perf_log = true
    output_linear = true
  [../]
[]
