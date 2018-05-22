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

#ifndef QUNOX_H
#define QUNOX_H

#include <qxmpp/QXmppClient.h>
#include <QString>
#include <QSettings>

/**
 * @todo write docs
 */
class QunoX : public QXmppClient
{
    Q_OBJECT
    Q_PROPERTY(QString jid READ getJid WRITE setJid NOTIFY jidChanged)
    Q_PROPERTY(QString password READ getPassword WRITE setPassword NOTIFY passwordChanged)

public:
    QunoX(QObject *parent = nullptr);

    ~QunoX();

    Q_INVOKABLE bool isConnected() const
    {
        return QXmppClient::isConnected();
    }

    void setJid(QString jid)
    {
        settings.setValue("auth/jid", jid);
    }

    QString getJid() const
    {
        return settings.value("auth/jid").toString();
    }

    void setPassword(QString password)
    {
        settings.setValue("auth/password", QString::fromUtf8(password.toUtf8().toBase64()));
    }

    QString getPassword() const
    {
        return QString(QByteArray::fromBase64(settings.value("auth/password")
                                              .toString().toUtf8()));
    }

signals:
    void jidChanged();
    void passwordChanged();

private:
    QSettings settings;
};

#endif // QUNOX_H
