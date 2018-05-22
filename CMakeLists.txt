cmake_minimum_required(VERSION 3.0)

find_package(PkgConfig REQUIRED)
find_package(Qt5 "5.7.0" REQUIRED COMPONENTS Gui Qml)
find_package(KF5Kirigami2 REQUIRED)
pkg_check_modules(qxmpp REQUIRED qxmpp)

set(CMAKE_AUTOMOC ON)

add_subdirectory(src)
