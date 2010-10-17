Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: Re: Fwd: Re: UML kernel crash of v2.6.36-rcX kernel
Date: Sun, 17 Oct 2010 15:55:39 +0200
References: <201010131328.06465.toralf.foerster@gmx.de> <201010151133.38170.toralf.foerster@gmx.de>
In-Reply-To: <201010151133.38170.toralf.foerster@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201010171555.40453.toralf.foerster@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>, Al Viro <viro@zeniv.linux.org.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

I bisected it again w/ a fixed test script, got the same bad commit script =
and
double checked, that this commit is really the culprit which crashes a user
mode linux kernel at my 32bix x86 stable Gentoo running 2.6.35.6 vanilla ke=
rnel
as host system and 2/ gcc version 4.4.3 (Gentoo 4.4.3-r2 p1.2) and
glibc-2.11.2-r1 in the tool chain.

The crash info is=20
...
* Starting local ...                                                       =
                                           [ ok ]
Kernel panic - not syncing: Kernel mode fault at addr 0x4, ip 0x80db40a
082fab50:  [<08277b7b>] dump_stack+0x22/0x24
082fab68:  [<08277bde>] panic+0x61/0xdb
082fab84:  [<0805e492>] segv+0x1e2/0x2b0
082fac3c:  [<0805e5a1>] segv_handler+0x41/0x60
082fac5c:  [<0806ec04>] sig_handler_common+0x54/0xa0
082facd8:  [<0806eda7>] sig_handler+0x27/0x50
082face8:  [<0806effc>] handle_signal+0x5c/0xa0
082fad0c:  [<08071378>] hard_handler+0x18/0x20
082fad1c:  [<b7753400>] 0xb7753400


EIP: 0073:[<40000812>] CPU: 0 Not tainted ESP: 007b:bf95171c EFLAGS: 000002=
12
    Not tainted
EAX: ffffffda EBX: 08059be8 ECX: 00000054 EDX: bf95174c
ESI: 08059bd8 EDI: 40166ff4 EBP: bf951728 DS: 007b ES: 007b
082fab04:  [<08075ffd>] show_regs+0xed/0x120
082fab20:  [<0805e7dc>] panic_exit+0x2c/0x50
082fab30:  [<0809932e>] notifier_call_chain+0x3e/0x70
082fab58:  [<080993b3>] atomic_notifier_call_chain+0x23/0x30
082fab68:  [<08277c06>] panic+0x89/0xdb
082fab84:  [<0805e492>] segv+0x1e2/0x2b0
082fac3c:  [<0805e5a1>] segv_handler+0x41/0x60
082fac5c:  [<0806ec04>] sig_handler_common+0x54/0xa0
082facd8:  [<0806eda7>] sig_handler+0x27/0x50
082face8:  [<0806effc>] handle_signal+0x5c/0xa0
082fad0c:  [<08071378>] hard_handler+0x18/0x20
082fad1c:  [<b7753400>] 0xb7753400

Terminated

Toralf F=EF=BF=BDrster wrote at 11:33:37
> Hello,
>=20
> git bisect gave :
>=20
> tfoerste@n22 ~/devel/linux-2.6 $ git bisect bad
> 365b18189789bfa1acd9939e6312b8a4b4577b28 is the first bad commit
> commit 365b18189789bfa1acd9939e6312b8a4b4577b28
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Wed Jul 7 18:53:25 2010 +0200
>=20
>     add f_flags to struct statfs(64)
>=20
>     Add a flags field to help glibc implementing statvfs(3) efficiently.
>=20
>     We copy the flag values from glibc, and add a new ST_VALID flag to
>     denote that f_flags is implemented.
>=20
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>

--=20
MfG/Kind regards
Toralf F=EF=BF=BDrster

pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3

