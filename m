Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIUWk-002oyX-Kp
 for linux-um@lists.infradead.org; Sat, 06 Mar 2021 10:51:20 +0000
Received: by mail-pf1-x429.google.com with SMTP id 18so3954214pfo.6
 for <linux-um@lists.infradead.org>; Sat, 06 Mar 2021 02:51:17 -0800 (PST)
Message-ID: <ca04eca09e65939f1b828b7572c91e9cb2046b4b.camel@debian.org>
Subject: Re: [PATCH] um: mark all kernel symbols as local
From: Ritesh Raj Sarraf <rrs@debian.org>
Date: Sat, 06 Mar 2021 16:21:04 +0530
In-Reply-To: <5d04179e-5ba5-a0cc-e514-c90feea5eb00@cambridgegreys.com>
References: <3448a70e7a39b9c3202aeefa7858ace265b8a978.camel@debian.org>
 <20210305214315.75ea78f93d79.I410acf4509c4ff51aac4a03df61d19abfa0454cb@changeid>
 <5d04179e-5ba5-a0cc-e514-c90feea5eb00@cambridgegreys.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: rrs@debian.org
Content-Type: multipart/mixed; boundary="===============1378355854071653655=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: 983379@bugs.debian.org, Christopher Obbard <chris.obbard@collabora.com>, Johannes Berg <johannes.berg@intel.com>


--===============1378355854071653655==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-MZq650KY2d7bpyiV+dyV"


--=-MZq650KY2d7bpyiV+dyV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-03-05 at 20:54 +0000, Anton Ivanov wrote:
> On 05/03/2021 20:43, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > Ritesh reported a bug [1] against UML, noting that it crashed on
> > startup. The backtrace shows the following (heavily redacted):
> >=20
> > (gdb) bt
> > ...
> > =C2=A0 #26 0x0000000060015b5d in sem_init () at ipc/sem.c:268
> > =C2=A0 #27 0x00007f89906d92f7 in ?? () from /lib/x86_64-linux-
> > gnu/libcom_err.so.2
> > =C2=A0 #28 0x00007f8990ab8fb2 in call_init (...) at dl-init.c:72
> > ...
> > =C2=A0 #40 0x00007f89909bf3a6 in nss_load_library (...) at
> > nsswitch.c:359
> > ...
> > =C2=A0 #44 0x00007f8990895e35 in _nss_compat_getgrnam_r (...) at
> > nss_compat/compat-grp.c:486
> > =C2=A0 #45 0x00007f8990968b85 in __getgrnam_r [...]
> > =C2=A0 #46 0x00007f89909d6b77 in grantpt [...]
> > =C2=A0 #47 0x00007f8990a9394e in __GI_openpty [...]
> > =C2=A0 #48 0x00000000604a1f65 in openpty_cb (...) at arch/um/os-
> > Linux/sigio.c:407
> > =C2=A0 #49 0x00000000604a58d0 in start_idle_thread (...) at arch/um/os-
> > Linux/skas/process.c:598
> > =C2=A0 #50 0x0000000060004a3d in start_uml () at
> > arch/um/kernel/skas/process.c:45
> > =C2=A0 #51 0x00000000600047b2 in linux_main (...) at
> > arch/um/kernel/um_arch.c:334
> > =C2=A0 #52 0x000000006000574f in main (...) at arch/um/os-
> > Linux/main.c:144
> >=20
> > indicating that the UML function openpty_cb() calls openpty(),
> > which internally calls __getgrnam_r(), which causes the nsswitch
> > machinery to get started.
> >=20
> > This loads, through lots of indirection that I snipped, the
> > libcom_err.so.2 library, which (in an unknown function, "??")
> > calls sem_init().
> >=20
> > Now, of course it wants to get libpthread's sem_init(), since
> > it's linked against libpthread. However, the dynamic linker
> > looks up that symbol against the binary first, and gets the
> > kernel's sem_init().
> >=20
> > Hajime Tazaki noted that "objcopy -L" can localize a symbol,
> > so the dynamic linker wouldn't do the lookup this way. I tried,
> > but for some reason that didn't seem to work.
> >=20
> > Doing the same thing in the linker script instead does seem to
> > work, though I cannot entirely explain - it *also* works if I
> > just add "VERSION { { global: *; }; }" instead, indicating that
> > something else is happening that I don't really understand. It
> > may be that explicitly doing that marks them with some kind of
> > empty version, and that's different from the default.
> >=20
> > Explicitly marking them with a version breaks kallsyms, so that
> > doesn't seem to be possible.
> >=20
> > Marking all the symbols as local seems correct, and does seem
> > to address the issue, so do that. Also do it for static link,
> > nsswitch libraries could still be loaded there.
> >=20
> > [1] https://bugs.debian.org/983379
> >=20
> > Reported-by: Ritesh Raj Sarraf <rrs@debian.org>
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > ---
> > =C2=A0 arch/um/kernel/dyn.lds.S | 6 ++++++
> > =C2=A0 arch/um/kernel/uml.lds.S | 6 ++++++
> > =C2=A0 2 files changed, 12 insertions(+)
> >=20
> > diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
> > index dacbfabf66d8..2f2a8ce92f1e 100644
> > --- a/arch/um/kernel/dyn.lds.S
> > +++ b/arch/um/kernel/dyn.lds.S
> > @@ -6,6 +6,12 @@ OUTPUT_ARCH(ELF_ARCH)
> > =C2=A0 ENTRY(_start)
> > =C2=A0 jiffies =3D jiffies_64;
> > =C2=A0=20
> > +VERSION {
> > +=C2=A0 {
> > +=C2=A0=C2=A0=C2=A0 local: *;
> > +=C2=A0 };
> > +}
> > +
> > =C2=A0 SECTIONS
> > =C2=A0 {
> > =C2=A0=C2=A0=C2=A0 PROVIDE (__executable_start =3D START);
> > diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
> > index 45d957d7004c..7a8e2b123e29 100644
> > --- a/arch/um/kernel/uml.lds.S
> > +++ b/arch/um/kernel/uml.lds.S
> > @@ -7,6 +7,12 @@ OUTPUT_ARCH(ELF_ARCH)
> > =C2=A0 ENTRY(_start)
> > =C2=A0 jiffies =3D jiffies_64;
> > =C2=A0=20
> > +VERSION {
> > +=C2=A0 {
> > +=C2=A0=C2=A0=C2=A0 local: *;
> > +=C2=A0 };
> > +}
> > +
> > =C2=A0 SECTIONS
> > =C2=A0 {
> > =C2=A0=C2=A0=C2=A0 /* This must contain the right address - not quite t=
he default
> > ELF one.*/
> >=20

Tested on all 3 machines where the issue was seen before.


>=20
> Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Tested-By: Ritesh Raj Sarraf <rrs@debian.org>

--=20
Ritesh Raj Sarraf | http://people.debian.org/~rrs
Debian - The Universal Operating System

--=-MZq650KY2d7bpyiV+dyV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAmBDXpgACgkQpjpYo/Lh
dWnqVxAAnlB/F4EKrRFslY4cXzMYg64XpJRz2BVJfCSFTNE7uPbzI9pIO4ebBdT/
mAbVMHm82TqO2i1bpRyLebhG6cUUy/AhtK0eAElvAc01s+nznYZo88o4LbZfAxwQ
6HRA3FK882C5cqIf7LpOUePpqpxUDdHQjWZqMNKsuRLjCgc+Ab2szaVr5v8hVtlA
7lUTDNL++vyPk2bKoHXiB/d5Nv2jCQW5CfuXFfrcmnSdagHRzT2LYdPADOWJHZEe
TNRbagq2+u3Ub5szRx3wVnOd6AWHDfJ+3mErJnXIUvUIfyaX081n33Y8YsxRVxHd
2BF/35F0+9Ghjnri61ae6HJVIYhOSdbT2gb3cRN4zeCitjjKlzRiRcPhFO97cc2b
OTmn2amnYRE+kbkBArXX01e/tEe7sNN7H6J2j+swU9PxcfbB4mln5AYW5x4qw9mJ
wUVVNZKNN6TSDQcJHKktMyj4ejIb9clyjubW7l04YPRaqpdcmHJmgaLoqQ8XUXj5
NL/Gq8+s+bSK3pu3GJRNraEad5xZaFSjZg3P6i8FvPeJJKXa5KqDRl5d0Q5u7RBn
2kmBMPQ/WQhHtYCD4v9nz2R/axoopO5xZ4Fr3lG9UWky88J5ZLbK6QzTO/+yFy57
4C66LMh+CEdqJ9GhDOmd5s/r5oMGfDYV9+nqmE0OO3tsX8nZemw=
=prVm
-----END PGP SIGNATURE-----

--=-MZq650KY2d7bpyiV+dyV--



--===============1378355854071653655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============1378355854071653655==--



