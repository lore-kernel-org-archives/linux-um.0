Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Toralf =?utf-8?q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Date: Sun, 29 May 2011 11:22:01 +0200
MIME-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Message-Id: <201105291122.01602.toralf.foerster@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
Subject: 2 small kernel config issues related to UML + RTC
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hello,

with the current git kernel I run=20
$>make ARCH=3Dum menuconfig

and searched for the string "RTC" b/c during boot of my UML image I rea=
lized nowadays the message:

"Kernel not built with RTC support, ALARM timers will not wake from sus=
pend"

Although the menuconfig gives me the answer :

  =E2=94=82 Symbol: STMMAC_RTC_TIMER [=3Dn]                            =
                                                       =E2=94=82  =20
  =E2=94=82 Type  : boolean                                            =
                                                     =E2=94=82  =20
  =E2=94=82 Prompt: Real time clock                                    =
                                                     =E2=94=82  =20
  =E2=94=82   Defined at drivers/net/stmmac/Kconfig:50                 =
                                                     =E2=94=82  =20
  =E2=94=82   Depends on: <choice> && RTC_CLASS                        =
                                                     =E2=94=82  =20
  =E2=94=82   Location:                                                =
                                                     =E2=94=82  =20
  =E2=94=82     -> Network device support (NETDEVICES [=3Dy])          =
                                                       =E2=94=82  =20
  =E2=94=82       -> Ethernet (1000 Mbit) (NETDEV_1000 [=3Dn])         =
                                                       =E2=94=82  =20
  =E2=94=82         -> STMicroelectronics 10/100/1000 Ethernet driver (=
STMMAC_ETH [=3Dn])                                     =E2=94=82  =20
  =E2=94=82           -> STMMAC Timer optimisation (STMMAC_TIMER [=3Dn]=
)                                                      =E2=94=82  =20
  =E2=94=82             -> Select Timer device (<choice> [=3Dn])       =
                                                       =E2=94=82  =20


I cannot found the menu item.

To sum it up IMO the kernel mesage doesn't makes sense for UML
and furthermore searching for "RTC" shouldn't give non-existent menu it=
ems, isn't it ?


--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

