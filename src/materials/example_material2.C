#include "example_material2.h"

//registerMooseObject("", example_material2);

template<>
InputParameters validParams<example_material2>()
{
  InputParameters params = validParams<Material>();
  params.addClassDescription("Example2 testing_materials");

  return params;
}

example_material2::example_material2(const InputParameters & parameters)
  : Material(parameters),
  _diff(declareProperty<Real>("Diffusivity2"))
{
}

void
example_material2::computeQpProperties()
{

}
