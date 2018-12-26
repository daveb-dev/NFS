#include "NFSApp.h"
#include "Moose.h"

#include "AppFactory.h"
#include "ModulesApp.h"
#include "MooseSyntax.h"
// #include "HeatConductionApp.h"
// #include "XFEMApp.h"
// #include "TensorMechanicsApp.h"
// #include "SolidMechanicsApp.h"

#include "CombinedApp.h"


//#ifdef BISON_ENABLED
#include "BisonApp.h"
#include "BisonSyntax.h"
//#endif

/* Personal Stuff */

// Kernels
#include "gap_conduction.h"

// Materials
#include "ExampleMaterial.h"


template <>
InputParameters
validParams<NFSApp>()
{
  InputParameters params = validParams<MooseApp>();
  return params;
}

//registerKnownLabel("NFSApp");


NFSApp::NFSApp(InputParameters parameters) : MooseApp(parameters)
{
  Moose::registerObjects(_factory);
  ModulesApp::registerObjects(_factory);
  NFSApp::registerObjects(_factory);

  Moose::associateSyntax(_syntax, _action_factory);
  ModulesApp::associateSyntax(_syntax, _action_factory);
  NFSApp::associateSyntax(_syntax, _action_factory);

  // BisonApp
  //BisonApp::registerObjects(_factory);
  //BisonApp::associateSyntax(_syntax, _action_factory);
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
  //registerKernel(diffusion2);
  //registerKernel(DarcyPressure);

  //Kernels
  registerKernel(gap_conduction);



  // Materials
  registerMaterial(ExampleMaterial);

  // Bison Register
//  #ifdef BISON_ENABLED
    BisonApp::registerObjects(factory);
//  #endif

  // HeatConductionApp::registerObjects(factory);
  // XFEMApp::registerObjects(factory);
  // TensorMechanicsApp::registerObjects(factory);
  // SolidMechanicsApp::registerObjects(factory);

  /* Use Combined to register all objects */
  CombinedApp::registerObjects(factory);

}

void
NFSApp::associateSyntax(Syntax & syntax, ActionFactory & action_factory)
{
  /* Uncomment Syntax and ActionFactory parameters and register your new production objects here! */
  //#ifdef BISON_ENABLED
    Bison::associateSyntax(syntax, action_factory);
  //#endif

  // HeatConductionApp::associateSyntax(syntax, action_factory);
  // XFEMApp::associateSyntax(syntax, action_factory);
  // TensorMechanicsApp::associateSyntax(syntax, action_factory);
  // SolidMechanicsApp::associateSyntax(syntax, action_factory);
  /* Used combined App to register all of the syntax */
  CombinedApp::associateSyntax(syntax, action_factory);
    //Registry::registerActionsTo(action_factory, {"NFSApp"});

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
