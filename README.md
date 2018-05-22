# QunoX - A Qt-based UNO card game clone using XMPP as back-end [WIP!]

A simple project to show that XMPP can also be used for different things than
instant messaging.

Currently this can't do anything more than connecting with your JID.

## Dependencies

* [Qt5](https://qt.io/)
* [QXmpp](https://github.com/qxmpp-project/qxmpp)
* [Kirigami2](https://techbase.kde.org/Kirigami)

## Compiling

```bash
git clone https://github.com/lnj2/qunox

cd qunox
mkdir build
cd build

cmake ..
make -j$(nproc)
```

Now you can run it by `./src/qunox`. If you want, you can install it by using
`sudo make install`.
