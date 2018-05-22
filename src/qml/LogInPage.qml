/*
 *  QunoX - A Qt-based UNO card game clone using XMPP as back-end
 *
 *  Copyright (C) 2018 QunoX developers and contributors
 *  (see the LICENSE file for a full list of copyright authors)
 *
 *  QunoX is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  In addition, as a special exception, the author of QunoX gives
 *  permission to link the code of its release with the OpenSSL
 *  project's "OpenSSL" library (or with modified versions of it that
 *  use the same license as the "OpenSSL" library), and distribute the
 *  linked executables. You must obey the GNU General Public License in
 *  all respects for all of the code used other than "OpenSSL". If you
 *  modify this file, you may extend this exception to your version of
 *  the file, but you are not obligated to do so.  If you do not wish to
 *  do so, delete this exception statement from your version.
 *
 *  QunoX is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with QunoX.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import org.kde.kirigami 2.3 as Kirigami

Kirigami.Page {
    title: qsTr("Log in")

    ColumnLayout {
        anchors.fill: parent

        Kirigami.Heading {
            text: qsTr("Log in to your XMPP account")
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
            horizontalAlignment: Qt.AlignHCenter
        }

        ColumnLayout {
            width: parent.width
            Layout.fillWidth: true

            // For desktop or tablet devices
            Layout.alignment: Qt.AlignCenter
            Layout.maximumWidth: Kirigami.Units.gridUnit * 25

            Label {
                text: qsTr("QunoX can be played over XMPP, that means that you " +
                           "can log in to your instant messaging account and " +
                           "play UNO with your contacts. There is no special " +
                           "server required.")
                Layout.fillWidth: true
                Layout.maximumWidth: Kirigami.Units.gridUnit * 25
                wrapMode: Text.Wrap
                textFormat: Text.PlainText
                horizontalAlignment: Text.AlignHCenter
                bottomPadding: Kirigami.Units.gridUnit * 2
            }

            // JID field
            Label {
                id: jidLabel
                text: qsTr("Your Jabber-ID:")
                textFormat: Text.PlainText
            }
            TextField {
                id: jidField
                text: qunox.jid
                placeholderText: qsTr("user@example.org")
                Layout.fillWidth: true
                selectByMouse: true
            }

            // Password field
            Label {
                text: qsTr("Your Password:")
                textFormat: Text.PlainText
            }
            TextField {
                id: passField
                text: qunox.password
                echoMode: TextInput.Password
                selectByMouse: true
                Layout.fillWidth: true
            }

            // Connect button
            Button {
                id: connectButton
                Layout.fillWidth: true
                highlighted: true

                states: [
                    State {
                        name: "connecting"
                        PropertyChanges {
                                target: connectButton
                                enabled: false
                        }
                        PropertyChanges {
                                target: connectLabel
                                text: "<i>" + qsTr("Connecting…") + "</i>"
                        }
                    }
                ]

                onClicked: {
                        // connect to given account data
                        connectButton.state = "connecting"
                        qunox.connectToServer(jidField.text, passField.text)
                }

                Label {
                    id: connectLabel
                    anchors.centerIn: connectButton
                    text: qsTr("Connect")
                    color: Kirigami.Theme.highlightedTextColor
                    textFormat: Text.StyledText
                }
            }

            // connect when return was pressed
            Keys.onPressed: {
                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter)
                    connectButton.clicked()
            }
        }
    }
    
    function handleConnected() {
        print("CONNECTED!")
        qunox.jid = jidField.text
        qunox.password = passField.text
    }
    
    function handleDisconnected() {
        connectButton.state = ""
    }
    
    Component.onCompleted: {
        qunox.connected.connect(handleConnected)
        qunox.disconnected.connect(handleDisconnected)
    }
    
    Component.onDestruction: {
        qunox.connected.disconnect(handleConnected)
        qunox.disconnected.disconnect(handleDisconnected)
    }
}
