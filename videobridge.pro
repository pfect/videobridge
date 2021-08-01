QT += quick qml
QT += quickcontrols2
QT += network
QT += multimedia

DEFINES += MOBILE_BUILD

CONFIG += c++11

SOURCES += main.cpp \
    bridge.cpp

TARGET = videobridge
TEMPLATE = app

RESOURCES += qml.qrc



# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS


HEADERS += \
    bridge.h
