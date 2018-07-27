#ifndef NFSAPP_H
#define NFSAPP_H

#include "MooseApp.h"

class NFSApp;

template <>
InputParameters validParams<NFSApp>();

class NFSApp : public MooseApp
{
public:
  NFSApp(InputParameters parameters);
  virtual ~NFSApp();

  static void registerApps();
  static void registerObjects(Factory & factory);
  static void registerObjectDepends(Factory & factory);
  static void associateSyntax(Syntax & syntax, ActionFactory & action_factory);
  static void associateSyntaxDepends(Syntax & syntax, ActionFactory & action_factory);
};

#endif /* NFSAPP_H */
