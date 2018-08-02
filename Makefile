###############################################################################
################### MOOSE Application Standard Makefile #######################
###############################################################################
#
# Optional Environment variables
# MOOSE_DIR        - Root directory of the MOOSE project
MOOSE_DIR	:= $(subst $(notdir $(CURDIR)),,$(CURDIR))moose_fracture
###############################################################################
# Use the MOOSE submodule if it exists and MOOSE_DIR is not set
MOOSE_SUBMODULE    := $(CURDIR)/moose
ifneq ($(wildcard $(MOOSE_SUBMODULE)/framework/Makefile),)
  MOOSE_DIR        ?= $(MOOSE_SUBMODULE)
else
  MOOSE_DIR        ?= $(shell dirname `pwd`)/moose
endif

# framework
FRAMEWORK_DIR      := $(MOOSE_DIR)/framework
include $(FRAMEWORK_DIR)/build.mk
include $(FRAMEWORK_DIR)/moose.mk

################################## MODULES ####################################
# To use certain physics included with MOOSE, set variables below to
# yes as needed.  Or set ALL_MODULES to yes to turn on everything (overrides
# other set variables).

ALL_MODULES         := yes

CHEMICAL_REACTIONS  := no
CONTACT             := no
FLUID_PROPERTIES    := no
HEAT_CONDUCTION     := no
MISC                := no
NAVIER_STOKES       := no
PHASE_FIELD         := no
RDG                 := no
RICHARDS            := no
SOLID_MECHANICS     := no
STOCHASTIC_TOOLS    := no
TENSOR_MECHANICS    := no
WATER_STEAM_EOS     := no
XFEM                := yes
POROUS_FLOW         := no

include $(MOOSE_DIR)/modules/modules.mk
###############################################################################
# BISON
BISON_F_DIR          ?= $(shell dirname `pwd`)/bison_fracture
ifneq ($(wildcard $(BISON_F_DIR)/Makefile),)
  APPLICATION_DIR    := $(BISON_F_DIR)
  APPLICATION_NAME   := bison_fracture
  include            $(FRAMEWORK_DIR)/app.mk
endif

# dep apps
APPLICATION_DIR    := $(CURDIR)
APPLICATION_NAME   := nfs
BUILD_EXEC         := yes
DEP_APPS           := $(shell $(FRAMEWORK_DIR)/scripts/find_dep_apps.py $(APPLICATION_NAME))
include            $(FRAMEWORK_DIR)/app.mk

###############################################################################
# Additional special case targets should be added here
