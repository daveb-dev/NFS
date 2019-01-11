#ifndef EXAMPLE_MATERIAL2_H
#define EXAMPLE_MATERIAL2_H

#include "Material.h"

class example_material2;

template<>
InputParameters validParams<example_material2>();

// Inherit Classes from Material objects
class example_material2 : public Material
{
public:
  example_material2(const InputParameters & parameters);

protected:
  virtual void computeQpProperties() override;

private:
  MaterialProperty<Real> &_diff;
  MaterialProperty<Real> &_density;
};

#endif //EXAMPLE_MATERIAL2_H
