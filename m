Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4DE31A2E.70705@st.com>
Date: Mon, 30 May 2011 06:16:46 +0200
From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
MIME-Version: 1.0
References: <201105291122.01602.toralf.foerster@gmx.de> <103895.1306689477@turing-police.cc.vt.edu>
In-Reply-To: <103895.1306689477@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: 2 small kernel config issues related to UML + RTC
To: Valdis.Kletnieks@vt.edu
Cc: =?windows-1252?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi Valdis

On 5/29/2011 7:17 PM, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 29 May 2011 11:22:01 +0200, Toralf F=F6rster said:
>>   =E2=94=82 Symbol: STMMAC_RTC_TIMER [=3Dn]                       =20
>>   =E2=94=82 Type  : boolean
>>   =E2=94=82 Prompt: Real time clock
>>   =E2=94=82   Defined at drivers/net/stmmac/Kconfig:50
>>   =E2=94=82   Depends on: <choice> && RTC_CLASS
>>   =E2=94=82   Location:
>>   =E2=94=82     -> Network device support (NETDEVICES [=3Dy])
>>   =E2=94=82       -> Ethernet (1000 Mbit) (NETDEV_1000 [=3Dn])
>>   =E2=94=82         -> STMicroelectronics 10/100/1000 Ethernet drive=
r (STMMAC_ETH [=3Dn])
>>   =E2=94=82           -> STMMAC Timer optimisation (STMMAC_TIMER [=3D=
n])
>>   =E2=94=82             -> Select Timer device (<choice> [=3Dn])
>=20
> Ouch. That has to be the strangest place one could *possibly* put an =
RTC driver. ;)
>=20
> Giuseppe - is that RTC driver *really* an integral part of the chipse=
t and
> won't work without the Ethernet parts, or should the driver code for =
the RTC
> live elsewhere in the tree?

No the external RTC (or the SH-4 TMU) HW can be used by the driver to
handle the rx/tx process mitigating the DMA interrupts. This is not the
best approach but it actually helped many people to space the CPU
especially on old chips w/o dedicate timer.

It's likely I will remove all this code as soon as I work on a chip wit=
h
the embedded watchdog.

Regards
Giuseppe
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

