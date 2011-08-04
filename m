Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Date: Thu, 4 Aug 2011 13:04:40 +0200
References: <201108011541.59640.richard@nod.at> <08cf4697685ecd9bcb7e4eefe516f2ee@localhost> <20110801172452.GA26190@albatros>
In-Reply-To: <20110801172452.GA26190@albatros>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Message-Id: <201108041304.41135.toralf.foerster@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: shm updates broke UML
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Richard Weinberger <richard@nod.at>, serge.hallyn@canonical.com, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

issue solved for the UML, tested linux-v3.0-7347-g288d5ab whcih works f=
ine.

BTW is there a special commit id dealing with this bug or was it solved=
 as a=20
side effect of another commit ?

Vasiliy Kulikov wrote at 19:24:52
> On Mon, Aug 01, 2011 at 19:19 +0200, Marc Zyngier wrote:
> > Here you go (sorry about the line wrapping, damned webmail...):
> Thank you!  Now I see that the problem is rw_mutex is not initialized=
:
>=20
> 	down_write(&shm_ids(ns).rw_mutex);
>=20
> void __sched __down_write_nested(struct rw_semaphore *sem, int subcla=
ss)
> {
>     ...
> 	if (sem->activity =3D=3D 0 && list_empty(&sem->wait_list)) {
>                                          ^^^^^^^^^^^^^^^ is NULL
>=20
> Wtf - ipc namespace should be fully initialized for the moment of
> threads run...
>=20
> > Calibrating local timer... 104.99MHz.
> > CPU1: Booted secondary processor
> > CPU1: Unknown IPI message 0x1
> > CPU2: Booted secondary processor
> > CPU2: Unknown IPI message 0x1
> > CPU3: Booted secondary processor
> > CPU3: Unknown IPI message 0x1
> > Brought up 4 CPUs
> > SMP: Total of 4 processors activated (333.41 BogoMIPS).
> > ns =3D c0447474, ids =3D c04474d0
> > ns =3D c0447474, ids =3D c04474d0
> > wait_list =3D c04474e0
> > next =3D   (null)
>=20
>            ^^^^^^


--=20
MfG/Sincerely
Toralf F=F6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

