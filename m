Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: Re: Fwd: Re: UML kernel crash of v2.6.36-rcX kernel
Date: Sat, 16 Oct 2010 13:12:49 +0200
References: <201010131328.06465.toralf.foerster@gmx.de> <201010151946.53402.richard@nod.at> <201010161055.33660.toralf.foerster@gmx.de>
In-Reply-To: <201010161055.33660.toralf.foerster@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201010161312.50106.richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Toralf =?iso-8859-15?q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi,

Am Samstag 16 Oktober 2010, 10:55:32 schrieb Toralf F=EF=BF=BDrster:
> Hello,
>=20
> I'm currently in the progress of bisecting the issue again- with a fully
> autoamted scripts which doesn't alck a "make clean" - *shame*

Please always run make clean.
Or even better mrproper.
I've had lots of *very* strange results which got all resolved by runing ma=
ke=20
mrproper.

> However I get with v2.6.35-rc3-173-g3638632 and the attached .config this=
 :
>=20

This kernel boots fine on my test bed.

> nitializing software serial port version 1
> console [mc-1] enabled
>  ubda:
> EIP: 0073:[<081bfec3>] CPU: 0 Not tainted ESP: 007b:1845aa08 EFLAGS:
> 00010297 Not tainted
> EAX: 00000000 EBX: 184da000 ECX: 00000001 EDX: 00000000
> ESI: 185fb930 EDI: 185f6900 EBP: 1845aa20 DS: 007b ES: 007b
> 082fab68:  [<08075f5d>] show_regs+0xed/0x120
> 082fab84:  [<0805e50e>] segv+0x25e/0x2b0
> 082fac3c:  [<0805e5a1>] segv_handler+0x41/0x60
> 082fac5c:  [<0806eb64>] sig_handler_common+0x54/0xa0
> 082facd8:  [<0806ed07>] sig_handler+0x27/0x50
> 082face8:  [<0806ef5c>] handle_signal+0x5c/0xa0
> 082fad0c:  [<080712d8>] hard_handler+0x18/0x20
> 082fad1c:  [<b77de400>] 0xb77de400
>=20
> Kernel panic - not syncing: Segfault with no mm
> 082fab50:  [<08277d5b>] dump_stack+0x22/0x24
> 082fab68:  [<08277dbe>] panic+0x61/0xdb
> 082fab84:  [<0805e51a>] segv+0x26a/0x2b0
> 082fac3c:  [<0805e5a1>] segv_handler+0x41/0x60
> 082fac5c:  [<0806eb64>] sig_handler_common+0x54/0xa0
> 082facd8:  [<0806ed07>] sig_handler+0x27/0x50
> 082face8:  [<0806ef5c>] handle_signal+0x5c/0xa0
> 082fad0c:  [<080712d8>] hard_handler+0x18/0x20
> 082fad1c:  [<b77de400>] 0xb77de400
>=20
>=20
> EIP: 0073:[<b77de424>] CPU: 0 Not tainted ESP: 007b:bf83a460 EFLAGS:
> 00000246 Not tainted
> EAX: 00000000 EBX: 00006c83 ECX: 00000013 EDX: 00006c83
> ESI: 00006c7f EDI: bf83a4f4 EBP: bf83a494 DS: 007b ES: 007b
> 082fab04:  [<08075f5d>] show_regs+0xed/0x120
> 082fab20:  [<0805e7dc>] panic_exit+0x2c/0x50
> 082fab30:  [<0809928e>] notifier_call_chain+0x3e/0x70
> 082fab58:  [<08099313>] atomic_notifier_call_chain+0x23/0x30
> 082fab68:  [<08277de6>] panic+0x89/0xdb
> 082fab84:  [<0805e51a>] segv+0x26a/0x2b0
> 082fac3c:  [<0805e5a1>] segv_handler+0x41/0x60
> 082fac5c:  [<0806eb64>] sig_handler_common+0x54/0xa0
> 082facd8:  [<0806ed07>] sig_handler+0x27/0x50
> 082face8:  [<0806ef5c>] handle_signal+0x5c/0xa0
> 082fad0c:  [<080712d8>] hard_handler+0x18/0x20
> 082fad1c:  [<b77de400>] 0xb77de400
>=20
> /home/tfoerste/workspace/bin/start_uml.sh: line 64: 27775 Segmentation
> fault (core dumped) $LINUX ubda=3D$ROOT_FS ubdb=3D$SWAP_FS $CD
> eth0=3Dtuntap,,,$TAP mem=3D256M umid=3D$USER $TTY $*
>=20
>=20
> Richard Weinberger wrote at 19:46:53
>=20
> > Hi!
> >=20
> > Can you please post more details.
> > What exactly causes the crash?
> > phpsysinfo does a lot of stuff.
> > On my test bed it works fine.
> >=20
> > Am Freitag 15 Oktober 2010, 11:33:37 schrieben Sie:
> > > Hello,
> > >=20
> > > git bisect gave :
> > >=20
> > > tfoerste@n22 ~/devel/linux-2.6 $ git bisect bad
> > > 365b18189789bfa1acd9939e6312b8a4b4577b28 is the first bad commit
> > > commit 365b18189789bfa1acd9939e6312b8a4b4577b28
> > > Author: Christoph Hellwig <hch@lst.de>
> > > Date:   Wed Jul 7 18:53:25 2010 +0200
> > >=20
> > >     add f_flags to struct statfs(64)
> > >    =20
> > >     Add a flags field to help glibc implementing statvfs(3)
> > >     efficiently.
> > >    =20
> > >     We copy the flag values from glibc, and add a new ST_VALID flag to
> > >     denote that f_flags is implemented.
> > >    =20
> > >     Signed-off-by: Christoph Hellwig <hch@lst.de>
> > >     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > :
> > > :040000 040000 92f04bf96f0c6bb2df3ddea83a4a27c35985bdcc
> > >=20
> > > e702d8dd95a3897e085bf3fe4919e2dd30a57b47 M      arch
> > >=20
> > > :040000 040000 5705bba0e9a2a61112281f7bb1a1030ef9eb337e
> > >=20
> > > 34fc3ea912581ae7923a15246291387bfc354e47 M      fs
> > >=20
> > > :040000 040000 578a5bb0743aa85adfec7a25f82d440b2ea4db27
> > >=20
> > > 7e96f95b6f1d6ccc9e004b560670638db66b8a93 M      include
> > >=20
> > >=20
> > > BTW is UML dead ?
> > > (I'm asking b/c there're so many different issues - compile errors or
> > > the UML kernel crashes during start or during shutdown, independent of
> > > the result of the wget issue I was investigating - there are 120
> > > skip'ed commits within the git bisect log beside 46 good and 15 bad
> > > commits and I didn't saw any chance to fully automate the bisect)
> >=20
> > Hmm, I did a lot git bisects on UML 2.6.35 to 2.6.36.
> > 2.6.36-rc1 does not always compile. You need no apply f3c072a first.
> > I've not seen any crashes during bootup nor shutdown. Can you provide
> > some more details?
> >=20
> > Thanks,
> > //richard

Thanks,
//richard
