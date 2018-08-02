#include "NFSApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "ModulesApp.h"
#include "MooseSyntax.h"

#include "XFEMWeibullMaterial.h"

template <>
InputParameters
validParams<NFSApp>()
{
  InputParameters params = validParams<MooseApp>();
  return params;
}

NFSApp::NFSApp(InputParameters parameters) : MooseApp(parameters)
{
  Moose::registerObjects(_factory);
  ModulesApp::registerObjects(_factory);
  NFSApp::registerObjects(_factory);

  Moose::associateSyntax(_syntax, _action_factory);
  ModulesApp::associateSyntax(_syntax, _action_factory);
  NFSApp::associateSyntax(_syntax, _action_factory);
}

NFSApp::~NFSApp() {}

void
NFSApp::registerApps()
{
  registerApp(NFSApp);
}

void
NFSApp::registerObjects(Factory & factory)
{
 // registerMaterial(XFEMWeibullMaterial);
  /* Uncomment Factory parameter and register your new production objects here! */
}

void
NFSApp::associateSyntax(Syntax & /*syntax*/, ActionFactory & /*action_factory*/)
{
  /* Uncomment Syntax and ActionFactory parameters and register your new production objects here! */
}

void
NFSApp::registerObjectDepends(Factory & /*factory*/)
{
}

void
NFSApp::associateSyntaxDepends(Syntax & /*syntax*/, ActionFactory & /*action_factory*/)
{
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
extern "C" void
NFSApp__registerApps()
{
  NFSApp::registerApps();
}

extern "C" void
NFSApp__registerObjects(Factory & factory)
{
  NFSApp::registerObjects(factory);
}

extern "C" void
NFSApp__associateSyntax(Syntax & syntax, ActionFactory & action_factory)
{
  NFSApp::associateSyntax(syntax, action_factory);
}
