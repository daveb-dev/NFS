#include "gap_conduction.h"



template<>
InputParameters validParams<gap_conduction>()
{
  InputParameters params = validParams<Kernel>();
  params.addClassDescription("calculating the gap conduction");
  return params;
}

gap_conduction::gap_conduction(const InputParameters & parameters)
  : Kernel(parameters)
{}

Real
gap_conduction::computeQpResidual()
{
  return _grad_u[_qp] * _grad_test[_i][_qp];
}

Real
gap_conduction::computeQpJacobian()
{
  return _grad_phi[_j][_qp] * _grad_test[_i][_qp];
}
