qt5_add_resources(qunox_SRCS resources.qrc)
add_executable(qunox main.cpp ${qunox_SRCS})
target_link_libraries(qunox Qt5::Qml Qt5::Gui)

