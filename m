Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BZcrd-0007Ii-N1 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Jun 2004 14:50:05 -0700
Received: from smtp3.wanadoo.fr ([193.252.22.28] helo=mwinf0304.wanadoo.fr)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BZcra-00031C-TO for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Jun 2004 14:50:03 -0700
From: Laurent Vivier <LaurentVivier@wanadoo.fr>
In-Reply-To: <200406121616.26839.blaisorblade_spam@yahoo.it>
References: <200406121616.26839.blaisorblade_spam@yahoo.it>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-yE3+U4P6+Y0k8ji/W99w"
Message-Id: <1087163413.1260.111.camel@chartreuse>
Mime-Version: 1.0
Subject: [uml-devel] Re: [SYSEMU] New benchmarks results
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 13 Jun 2004 23:50:14 +0200
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, roland <for_spam@gmx.de>



--=-yE3+U4P6+Y0k8ji/W99w
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Le sam 12/06/2004 =E0 16:16, BlaisorBlade a =E9crit :
> I've decided to do benchmarks to check how much SYSEMU saves in benchmark=
=20
> which also access memory (memLoop.c) and how much could save the 0 contex=
t=20
> switch idea (provided that segmentation has low cost).
>=20
> First, about the benchmark on the Laurent Vivier page: I think that the "=
60 %"=20
> number is meaningless - I guess it is that calculated with "real time", w=
hich=20
> is not very meaningful IMHO - that is the time from when the process star=
t to=20
> when it ends, and counts even time spent by executing other processes. A =
more=20
> meaningful difference is done with the sum of user+system time:
>=20
> average time (user+system):
> - without SYSEMU=20
> 64.910
> - with SYSEMU
> 51.321
>=20
> SYSEMU saves (64.910 - 51.321) / 64.910 * 100 % =3D 20,9 % of the time wi=
thout=20
> SYSEMU, in this benchmark.

Hello Paolo,

thank you for your comments.

the real question is: how accurate is the command "time" under UML ?

I choose "real" time for several reasons:

- what user feels is the most important (how many time he waits ?)
- I don't really know how is computed "sys" time under UML: is it host +
guest "sys" time ? How "time" takes into account the time of the process
"ptracing" the user process and, thus, the sys time of the guest kernel
?

I made my measurements on a 8 cpus Xeon server with several gigabytes of
memory, with no load and only one user: me.

Host:

real               0m7.920s
user+sys           0m7.930s
real - (user+sys) -0m0.010s=20
(mmhhh, a negative value, there is really no load ;-) )

So I didn't really explain the measurements I had :

w/o SYSEMU:

real     6m16.956s 6m17.126s 6m16.461s
user+sys 1m03.712s 1m06.577s 1m04.442s

w/ SYSEMU:

real     3m55.052s 3m56.964s 3m54.179s
user+sys 0m52.347s 0m48.481s 0m53.135s

Could you explain where we lost :

w/o SYSEMU

real - (user+sys) 5m13.144s 5m10.549s 5m12.002s=20

w/ SYSEMU

real - (user+sys) 3m02.705s 3m08.483s 3m01.044s

In the TLB flushes ? in the "ptracing" process ? in other processes ?

IMHO, I thought it's in guest kernel, so "real" is more significant than "u=
ser+sys".
BUT I think you're the real specialist of UML and I'm not...

> I've re-benchmarked UML with SYSEMU using memLoop.c which tries to measur=
e the=20
> effects of accessing memory: it access one byte per page, thus causing th=
e=20
> CPU to reload in the TLB the page table entry (PTE) for that page. IMHO, =
this=20
> benchmark shows that most of the gap vs the host is in the 2 remaining CS=
 per=20
> syscall: the 2 we save with SYSEMU account for about 25% of the getpid=20
> execution, most of the gap is still there.
>=20
> In the attached files NPAGES =3D 64 (see source), but I also posted resul=
ts with=20
> NPAGES =3D 512. Also, please, don't look at the "elapsed" time: it's=20
> meaningless.
>=20
> In fact getpidLoop measures only the cost of TLB flushes, while memLoop a=
lso=20
> measures the cost of TLB misses after the TLB flush, which can be compare=
d=20
> against memLoopPure, which runs no syscall and thus never flushes the TLB=
s.
>=20
> To see this, I must be sure that memLoopPure has no TLB fault, i.e. that =
the=20
> PTEs for all pages fit in the TLB; this happen when NPAGES =3D 64, not wh=
en=20
> NPAGES=3D512. In the two cases, we have working sets of 64 * PAGE_SIZE =
=3D 128k=20
> and of 512 * PAGE_SIZE =3D 2 M.
>=20
> On the host, memLoop and memLoopPure have similar user time, since there =
is=20
> never a TLB flush. When NPAGES =3D 512, each page access causes a TLB mis=
s, so=20
> the user time is always similar, both on the host and the guest, and both=
=20
> with and without syscalls.
>=20
> But when NPAGES =3D 64, on the host the TLB is never flushed (except when=
=20
> another process is executing): it is filled only once and then used.
>=20
> On the guest, instead, with NPAGES =3D 64 the user time of memLoop is dou=
ble=20
> than the memLoopPure one. And since 0.40 s are for the getpid() calls,=20
> touch_mem() uses 0.40 s in memLoopPure and 1.20 s in memLoop: 3 times the=
 old=20
> time.
> --------
> HOST:
>=20
> host $ time ./getpidLoop 1000000
>=20
> 0.27user 0.21system 0:00.55elapsed 87%CPU (0avgtext+0avgdata 0maxresident=
)k
> 0inputs+0outputs (70major+11minor)pagefaults 0swaps
> --------
> With NPAGES =3D 64:
>=20
> host $ time ./memLoop 1000000
>=20
> 1.11user 0.23system 0:01.46elapsed 91%CPU (0avgtext+0avgdata 0maxresident=
)k
> 0inputs+0outputs (79major+75minor)pagefaults 0swaps
> ----
> host $ time ./memLoopPure 1000000
> 0.88user 0.00system 0:00.97elapsed 90%CPU (0avgtext+0avgdata 0maxresident=
)k
> 0inputs+0outputs (78major+75minor)pagefaults 0swaps
> --------
> With NPAGES =3D 512
>=20
> host $ time ./memLoop 1000000
>=20
> 8.93user 0.24system 0:09.84elapsed 93%CPU (0avgtext+0avgdata 0maxresident=
)k
> 0inputs+0outputs (79major+523minor)pagefaults 0swaps
> ----
> host $ time ./memLoopPure 1000000
>=20
> 8.71user 0.01system 0:09.43elapsed 92%CPU (0avgtext+0avgdata 0maxresident=
)k
> 0inputs+0outputs (78major+523minor)pagefaults 0swaps
>=20
> ------------
> On the guest, with SYSEMU:
>=20
> guest # /usr/bin/time=20
> /mnt/host/home/paolo/Dati/Sorgenti/Varie/C-C++/getpidLoop 1000000
>=20
> 0.42user 3.87system 0:16.09elapsed 26%CPU (0avgtext+0avgdata 0maxresident=
)k
> 0inputs+0outputs (0major+76minor)pagefaults 0swaps
> --------
> With NPAGES =3D 64:
> ----
> guest # /usr/bin/time /mnt/host/home/paolo/Dati/Sorgenti/Varie/C-C++/memL=
oop=20
> 1000000
>=20
> 1.60user 4.00system 0:18.02elapsed 31%CPU (0avgtext+0avgdata 0maxresident=
)k
> 0inputs+0outputs (0major+146minor)pagefaults 0swaps
> ----
> guest # /usr/bin/time=20
> /mnt/host/home/paolo/Dati/Sorgenti/Varie/C-C++/memLoopPure 1000000
>=20
> 0.85user 0.05system 0:01.01elapsed 88%CPU (0avgtext+0avgdata 0maxresident=
)k
> 0inputs+0outputs (0major+146minor)pagefaults 0swaps
> --------
> With NPAGES =3D 512:
>=20
> guest # /usr/bin/time /mnt/host/home/paolo/Dati/Sorgenti/Varie/C-C++/memL=
oop=20
> 1000000
>=20
> 9.09user 4.18system 0:28.37elapsed 46%CPU (0avgtext+0avgdata 0maxresident=
)k
> 0inputs+0outputs (0major+594minor)pagefaults 0swaps
> ----
> guest # /usr/bin/time=20
> /mnt/host/home/paolo/Dati/Sorgenti/Varie/C-C++/memLoopPure 1000000
>=20
> 8.76user 0.07system 0:11.57elapsed 76%CPU (0avgtext+0avgdata 0maxresident=
)k
> 0inputs+0outputs (0major+594minor)pagefaults 0swaps
>=20
> ----------------
> On the guest, without SYSEMU:
> (we always about 25% increase for system time vs SYSEMU, except for=20
> memLoopPure, but equal user time: we don't save the TLB misses)
>=20
> # /usr/bin/time /mnt/host/home/paolo/Dati/Sorgenti/Varie/C-C++/getpidLoop=
=20
> 1000000
> 0.42user 5.01system 0:21.08elapsed 25%CPU (0avgtext+0avgdata 0maxresident=
)k
> 0inputs+0outputs (0major+76minor)pagefaults 0swaps
> ----
> With NPAGES =3D 64:
>=20
> guest # /usr/bin/time=20
> /mnt/host/home/paolo/Dati/Sorgenti/Varie/C-C++/memLoopPure 1000000
> (about the same, as expected)
>=20
> 0.86user 0.02system 0:00.94elapsed 92%CPU (0avgtext+0avgdata 0maxresident=
)k
> 0inputs+0outputs (0major+146minor)pagefaults 0swaps
> ----
> guest # /usr/bin/time /mnt/host/home/paolo/Dati/Sorgenti/Varie/C-C++/memL=
oop=20
> 1000000
> (about 25% increase for system time, equal user time: we don't save the T=
LB=20
> misses)
> 1.62user 5.00system 0:26.73elapsed 24%CPU (0avgtext+0avgdata 0maxresident=
)k
> 0inputs+0outputs (0major+146minor)pagefaults 0swaps
>=20
> --------
>=20
> With NPAGES =3D 512
>=20
> guest # /usr/bin/time=20
> /mnt/host/home/paolo/Dati/Sorgenti/Varie/C-C++/memLoopPure 1000000
>=20
> 8.84user 0.02system 0:10.86elapsed 81%CPU (0avgtext+0avgdata 0maxresident=
)k
> 0inputs+0outputs (0major+594minor)pagefaults 0swaps
>=20
> ----
>=20
> guest # /usr/bin/time /mnt/host/home/paolo/Dati/Sorgenti/Varie/C-C++/memL=
oop=20
> 1000000
> 9.15user 5.06system 0:36.66elapsed 38%CPU (0avgtext+0avgdata 0maxresident=
)k
> 0inputs+0outputs (0major+594minor)pagefaults 0swaps
--=20
                   Laurent Vivier
+------------------------------------------------+
     "Any sufficiently advanced technology is=20
indistinguishable from magic." -- Arthur C. Clarke
   "Aller les Bleus" - France 2 - 1 Angleterre

--=-yE3+U4P6+Y0k8ji/W99w
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAzMwVbmJwdIv5dzMRAilfAJ47C6U3+1OwU51UD0l57oq9+9WqugCfQqaP
EbIV8yXcR0B5tmnwP5BJnq0=
=EV9t
-----END PGP SIGNATURE-----

--=-yE3+U4P6+Y0k8ji/W99w--



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
