#ifndef NFSTESTAPP_H
#define NFSTESTAPP_H

#include "MooseApp.h"

class NFSTestApp;

template <>
InputParameters validParams<NFSTestApp>();

class NFSTestApp : public MooseApp
{
public:
  NFSTestApp(InputParameters parameters);
  virtual ~NFSTestApp();

  static void registerApps();
  static void registerObjects(Factory & factory);
  static void associateSyntax(Syntax & syntax, ActionFactory & action_factory);
};

#endif /* NFSTESTAPP_H */
