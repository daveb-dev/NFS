#ifndef GAP_CONDUCTION_H
#define GAP_CONDUCTION_H

#include "Kernel.h"

class gap_conduction;

template<>
InputParameters validParams<gap_conduction>();

/**
 *
 */
class gap_conduction : public Kernel
{
public:
  gap_conduction(const InputParameters & parameters);

protected:
  virtual Real computeQpResidual() override;
  virtual Real computeQpJacobian() override;

};

#endif // GAP_CONDUCTION_H
