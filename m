Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iL45r-0006tM-Pm
 for linux-um@lists.infradead.org; Thu, 17 Oct 2019 11:37:25 +0000
Received: by mail-pf1-x431.google.com with SMTP id q12so1474506pff.9
 for <linux-um@lists.infradead.org>; Thu, 17 Oct 2019 04:37:23 -0700 (PDT)
Message-ID: <a1307b17bd3f51d84d9195760492d1ef284b6382.camel@researchut.com>
Subject: uml segfault during I/O
From: Ritesh Raj Sarraf <rrs@researchut.com>
Date: Thu, 17 Oct 2019 17:07:35 +0530
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: rrs@researchut.com
Content-Type: multipart/mixed; boundary="===============1257918328470018330=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>


--===============1257918328470018330==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ylP8deJz/E12fhKOGN+a"


--=-ylP8deJz/E12fhKOGN+a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This happens on the 5.2 Linux kernel with Debian patches on top.
The configs details are:

Linux Host: 5.2 (Debian)
Linux UML: 5.2 (Debian)

This tends to happen very easily when doing good amount of I/O, in this
case, doing an `apt upgrade`


[  OK  ] Started Update UTMP about System Runlevel Changes.
NET: Registered protocol family 10
Segment Routing with IPv6
random: crng init done

Modules linked in: ipv6 crc_ccitt
Pid: 870, comm: kworker/0:1H Not tainted 5.2.17
RIP: 0033:[<00000000607e9c03>]
RSP: 000000009d40fde0  EFLAGS: 00010297
RAX: 0000000000000000 RBX: 0000000000004801 RCX: 000000009d40fe30
RDX: 0000000000000001 RSI: 000000009dbc35c0 RDI: 0000000000000000
RBP: 000000009d40fe30 R08: 0000000c00000204 R09: 8080808080808080
R10: fefefefefefefeff R11: 0000000000000246 R12: 0000000000000000
R13: 000000009dbc35c0 R14: 000000009dbc3608 R15: 000000009dbb9800
Kernel panic - not syncing: Segfault with no mm
CPU: 0 PID: 870 Comm: kworker/0:1H Not tainted 5.2.17 #2
Workqueue: kblockd blk_mq_requeue_work
Stack:
 00000000 100000000000001 607d4425 00000001
 9dbc35c0 00000000 00000000 00000000
 9dbb9800 607d44e9 9d40fe30 9d40fe30
Call Trace:
 [<607d4425>] ? blk_mq_sched_insert_request+0x0/0xff
 [<607d44e9>] ? blk_mq_sched_insert_request+0xc4/0xff
 [<607d4425>] ? blk_mq_sched_insert_request+0x0/0xff
 [<607d07c6>] ? blk_mq_requeue_work+0xd0/0x133
 [<60434285>] ? process_one_work+0x1e4/0x34c
 [<60431fd0>] ? move_linked_works+0x0/0x4f
 [<609791f0>] ? __schedule+0x0/0x41d
 [<6043569f>] ? wq_worker_running+0xd/0x2f
 [<60431fd0>] ? move_linked_works+0x0/0x4f
 [<60435362>] ? worker_thread+0x324/0x45e
 [<6043215f>] ? set_pf_worker+0x0/0x5e
 [<604167c7>] ? get_signals+0x0/0xa
 [<60439485>] ? __kthread_parkme+0x4a/0x94
 [<60421a53>] ? do_exit+0x0/0x948
 [<6043503e>] ? worker_thread+0x0/0x45e
 [<604399aa>] ? kthread+0x198/0x1a0
 [<603fea08>] ? new_thread_handler+0x82/0xb8

/home/rrs/bin/uml-debian: line 8: 16743 Aborted                 (core dumpe=
d) linux ubd0=3D~/rrs-home/Libvirt-Images/uml.img eth0=3Ddaemon mem=3D1024M=
 rw
 16:58 =E2=99=92 =E0=A5=90   =E2=98=B9 =F0=9F=98=9F=3D> 134 =20


And the linux process remains stray on the host machine.

rrs      18159  0.0  0.0 1057692 11496 ?       Ss   16:57   0:00 linux ubd0=
=3D/home/rrs/rrs-home/Libvirt-Images/uml.img eth0=3Ddaemon mem=3D1024M rw
rrs      18187  0.0  0.0 1057704 11496 ?       Ss   16:57   0:00 linux ubd0=
=3D/home/rrs/rrs-home/Libvirt-Images/uml.img eth0=3Ddaemon mem=3D1024M rw

--=20
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."

--=-ylP8deJz/E12fhKOGN+a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAl2oUn8ACgkQpjpYo/Lh
dWmADA/9FzkMz7T8P4ZoSnDAD+YN6Uh2mDlUEVdISMidWhneOerg3Ib612Y7kjN+
ZyFh7QxssAf2ZIkMIPgvjxK3/KhR4nwz7Z94S+2zZEOsL0eXUBD6E5Z6OSR3SrEu
cngIACdb0Q7C8TQ84XUiaxGNwhn67Unn9GLRJpi5+RK5h75J6C8T15cVeGedEM53
7c1Qt56Yytz+v5AAOzLdpJyBwKvurXuOnWoLAfFUMiXtwD0MxXkG45Rgivl0AsTk
9Om8kOq04A+D2OYXYG0QzRimWNy1HHMXzm/gcum53DpLqLrkFni6afPy+6SzZwxk
rzViZngKiobiWJpJtKS1/g+cer6v+Nuxpn8hCcM87gdGG1jQxu9Wy6BWJTsVS1O8
L50huPj0OzR+8FH7LfYQfV/a3wJc0+FGRUJ3sp1wYl+nl/FI05ryz0EGoZ1BRni1
SXhZIfH3q1GxC1/jDcnR1QT25yDCpoMg/QsYDehENVTpR6lfgjk+4bWBWM6aHupy
6aaR3HEOEK8x+RVoRTMyoLREWdUmnXeme1N7H5ZTPg3S7QRIeu9LLtD1WsKCdzNk
eMuXkhGjCpV5Rzg8PlddKFG4LC8pJQjTTtXhXbAPaYKsPVhXR/9RGAWOh9gn/VIG
Msr7ZsE+tv3IVGj8UrACF46iekWPr+akAzT9wuLFGiRS+6MKu7A=
=0DWO
-----END PGP SIGNATURE-----

--=-ylP8deJz/E12fhKOGN+a--



--===============1257918328470018330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============1257918328470018330==--



