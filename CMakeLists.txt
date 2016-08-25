# Copyright: (C) 2016 INRIA
# Authors: Serena Ivaldi
# CopyPolicy: Released under the terms of the GNU GPL v2.0.

cmake_minimum_required(VERSION 2.8)
project(icub-assembly-collaborative)
set(BUILD_BUNDLE ON)

option(BUILD_TUNINGINTERACTION "Build Force Imitation Demo" ON)

find_package(ICUBcontrib REQUIRED)
list(APPEND CMAKE_MODULE_PATH ${ICUBCONTRIB_MODULE_PATH})
include(ICUBcontribOptions)
include(ICUBcontribHelpers)
icubcontrib_set_default_prefix()

if (BUILD_TUNINGINTERACTION)
    add_subdirectory(tuning-interaction)
endif()

icubcontrib_add_uninstall_target()
