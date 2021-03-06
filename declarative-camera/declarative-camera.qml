/****************************************************************************
**
** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import QtMultimedia 5.4
import QtGraphicalEffects 1.0

Rectangle {
    id : cameraUI

    width: 800
    height: 480

    state: "StartState"


    gradient: Gradient{
    GradientStop { position: 0.0; color: 'black'}
    GradientStop { position: 0.3; color: 'black'}
    GradientStop { position: 0.5; color: "#003346"}
    GradientStop { position: 1.0; color: "#45240e"}
    }

    RectangularGlow{
        id: cameraGlow
        anchors.fill: viewfinder
        glowRadius: 8
        spread: 0.2
        color: "white"
        cornerRadius: 2
        visible: false
    }


    Image{
        id: automenseLogo
        source: "images/Automense_Logo.png"
        anchors.left: ravenLogo.right
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: -60
        width: 180
        height: 180
        fillMode: Image.PreserveAspectFit
    }

    Image{
        id: ravenLogo
        source: "images/raven_standard_cropped.png"
        x: 5
        y: 0
    }

    AdminPage{
        id: adminPage
        anchors.left: automenseLogo.right
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 10
        visible: false

        onNewUserClicked: {
            cameraUI.state = "NewUser";
        }

        onBackClicked: {
            cameraUI.state = "StartState";
        }
    }



    CameraButton {
        id: userButton
        width: 100
        height: 30
        text: "User"
        anchors.leftMargin: 8
        onClicked: {
            userDisp.visible = true
            cameraUI.state = "NewUser";

        }
        anchors.top: ravenLogo.bottom
        anchors.topMargin: 11
        anchors.left: ravenLogo.left
    }

    CameraButton {
        id: adminButton
        width: 100
        height: 30
        text: "Admin"
        onClicked: {
            cameraUI.state = "AdminLogin";
        }
        anchors.top: userButton.bottom
        anchors.topMargin: 10
        anchors.left: userButton.left
    }

    CameraButton {
        id: metaButton
        width: 100
        height: 30
        text: "Meta"
        onClicked: {
            cameraUI.state = "AdminLogin";
        }
        anchors.top: adminButton.bottom
        anchors.topMargin: 10
        anchors.left: userButton.left
    }

    AdminLogin{
        id: adLogin
        anchors.leftMargin: 8
        anchors.top: automenseLogo.bottom
        anchors.topMargin: 10
        anchors.left: automenseLogo.left
        visible: false
        onLoginClicked: {
            cameraUI.state = "AdminView";
        }
    }

    UserDisplay{
        id: userDisp
        anchors.left: automenseLogo.right
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 10
        visible: false

        onBackClicked: {
            cameraUI.state = "StartState";
        }
    }

    states: [
        State {
            name: "PhotoCapture"
            StateChangeScript {
                script: {
                    camera.captureMode = Camera.CaptureStillImage
                    camera.start()
                }
            }
        },
        State {
            name: "PhotoPreview"
        },
        State {
            name: "VideoCapture"
            StateChangeScript {
                script: {
                    camera.captureMode = Camera.CaptureVideo
                    camera.start()
                }
            }
        },
        State {
            name: "VideoPreview"
            StateChangeScript {
                script: {
                    camera.stop()
                }
            }
        },
        State {
            name: "StartState"
            StateChangeScript {
                script: {
                    camera.stop()
                    userButton.visible = true
                    adLogin.visible = false
                    adminPage.visible = false
                    cameraGlow.visible = false
                    userDisp.visible = false
                }
            }
        },
        State {
            name: "AdminLogin"
            StateChangeScript {
                script: {
                    camera.stop()
                    adLogin.visible = true;
                }
            }
        },
        State {
            name: "AdminView"
            StateChangeScript {
                script: {
                    camera.stop()
                    adLogin.visible = false
                    adminPage.visible = true
                }
            }
        },
        State {
            name: "NewUser"
            StateChangeScript {
                script: {
                    camera.captureMode = Camera.CaptureVideo
                    camera.start()
                    //cameraGlow.visible = true
                }
            }
        },
        State {
            name: "UserDisplay"
            StateChangeScript {
                script: {
                    camera.captureMode = Camera.CaptureVideo
                    camera.start()
                    //cameraGlow.visible = true
                }
            }
        }

    ]

    Camera {
        id: camera
        captureMode: Camera.CaptureStillImage

        imageCapture {
            onImageCaptured: {
                photoPreview.source = preview
                stillControls.previewAvailable = true
                cameraUI.state = "PhotoPreview"
            }
        }

        videoRecorder {
             resolution: "640x480"
             frameRate: 15
        }
    }

    PhotoPreview {
        id : photoPreview
        anchors.fill : parent
        onClosed: cameraUI.state = "PhotoCapture"
        visible: cameraUI.state == "PhotoPreview"
        focus: visible
    }

    VideoPreview {
        id : videoPreview
        anchors.fill : parent
        onClosed: cameraUI.state = "VideoCapture"
        visible: cameraUI.state == "VideoPreview"
        focus: visible

        //don't load recorded video if preview is invisible
        source: visible ? camera.videoRecorder.actualLocation : ""
    }

    VideoOutput {
        id: viewfinder
        visible: cameraUI.state == "PhotoCapture" || cameraUI.state == "VideoCapture" || cameraUI.state == "NewUser"

        x: 40
        y: 170
        //width: parent.width - stillControls.buttonsPanelWidth
        //height: parent.height
        width: 320
        height: 240

        source: camera
        z:20
        //autoOrientation: true
    }

    ParticleShader{
        id: particles
        x: 250
        y: 250
        visible: false
        z:10
    }

    PhotoCaptureControls {
        id: stillControls
        anchors.fill: parent
        camera: camera
        visible: cameraUI.state == "PhotoCapture"
        onPreviewSelected: cameraUI.state = "PhotoPreview"
        onVideoModeSelected: cameraUI.state = "VideoCapture"
    }

    VideoCaptureControls {
        id: videoControls
        anchors.fill: parent
        camera: camera
        visible: cameraUI.state == "VideoCapture"
        onPreviewSelected: cameraUI.state = "VideoPreview"
        onPhotoModeSelected: cameraUI.state = "PhotoCapture"
    }
}
