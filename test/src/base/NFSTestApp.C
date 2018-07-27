#include "NFSTestApp.h"
#include "NFSApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "MooseSyntax.h"
#include "ModulesApp.h"

template <>
InputParameters
validParams<NFSTestApp>()
{
  InputParameters params = validParams<NFSApp>();
  return params;
}

NFSTestApp::NFSTestApp(InputParameters parameters) : MooseApp(parameters)
{
  Moose::registerObjects(_factory);
  ModulesApp::registerObjects(_factory);
  NFSApp::registerObjectDepends(_factory);
  NFSApp::registerObjects(_factory);

  Moose::associateSyntax(_syntax, _action_factory);
  ModulesApp::associateSyntax(_syntax, _action_factory);
  NFSApp::associateSyntaxDepends(_syntax, _action_factory);
  NFSApp::associateSyntax(_syntax, _action_factory);

  bool use_test_objs = getParam<bool>("allow_test_objects");
  if (use_test_objs)
  {
    NFSTestApp::registerObjects(_factory);
    NFSTestApp::associateSyntax(_syntax, _action_factory);
  }
}

NFSTestApp::~NFSTestApp() {}

void
NFSTestApp::registerApps()
{
  registerApp(NFSApp);
  registerApp(NFSTestApp);
}

void
NFSTestApp::registerObjects(Factory & /*factory*/)
{
  /* Uncomment Factory parameter and register your new test objects here! */
}

void
NFSTestApp::associateSyntax(Syntax & /*syntax*/, ActionFactory & /*action_factory*/)
{
  /* Uncomment Syntax and ActionFactory parameters and register your new test objects here! */
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
// External entry point for dynamic application loading
extern "C" void
NFSTestApp__registerApps()
{
  NFSTestApp::registerApps();
}

// External entry point for dynamic object registration
extern "C" void
NFSTestApp__registerObjects(Factory & factory)
{
  NFSTestApp::registerObjects(factory);
}

// External entry point for dynamic syntax association
extern "C" void
NFSTestApp__associateSyntax(Syntax & syntax, ActionFactory & action_factory)
{
  NFSTestApp::associateSyntax(syntax, action_factory);
}
