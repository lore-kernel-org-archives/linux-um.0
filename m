Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lH8pI-00HY3M-ME
 for linux-um@lists.infradead.org; Tue, 02 Mar 2021 17:28:55 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d11so12411794plo.8
 for <linux-um@lists.infradead.org>; Tue, 02 Mar 2021 09:28:49 -0800 (PST)
Message-ID: <5e068447e2067fff8b21c0689f14d080b984f6e0.camel@debian.org>
Subject: Re: linux uml segfault
From: Ritesh Raj Sarraf <rrs@debian.org>
Date: Tue, 02 Mar 2021 22:57:40 +0530
In-Reply-To: <5ee28b97-6111-e12c-d0e9-83a13f2151ce@kot-begemot.co.uk>
References: <3448a70e7a39b9c3202aeefa7858ace265b8a978.camel@debian.org>
 <6d37b5aa-36f2-1fce-b70b-8faa0ff882e0@kot-begemot.co.uk>
 <c8bb257c-1542-12f5-89f1-5c1f14b8a70a@collabora.com>
 <db40449e-6916-56bf-377c-01b042b9c890@kot-begemot.co.uk>
 <529cd4e2f39efffb18125dffab3058aeec3351ce.camel@debian.org>
 <573e256a-990b-ddf6-7965-367bb8b21229@kot-begemot.co.uk>
 <1bdedf3c60058e1ae242a2a7f16eee256b0be3e0.camel@debian.org>
 <6370b92a-84fa-aa21-4270-fcaf1bf42407@kot-begemot.co.uk>
 <02e348bbb13f0fac92f2147309fb1c006b4583b2.camel@debian.org>
 <5ee28b97-6111-e12c-d0e9-83a13f2151ce@kot-begemot.co.uk>
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
Content-Type: multipart/mixed; boundary="===============8889690047814147273=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, Christopher Obbard <chris.obbard@collabora.com>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Cc: 983379@bugs.debian.org


--===============8889690047814147273==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-xeOVGX8nVhEzFtQOM7OF"


--=-xeOVGX8nVhEzFtQOM7OF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-03-02 at 17:05 +0000, Anton Ivanov wrote:
> > So the best I can extract for you is to compile the kernel with as
> > much
> > information as possible.
>=20
> Can you try using one of the older kernels so we can verify if this
> is indeed a 5.10 thing.
>=20

That was the first thing I tried. I tested it with 5.10, 5.9 and 5.4.
All 3 crashed. That's when I knew this one was going to be painful one
to conclude.

The only other input I have is that I have one more user who's reported
to be able to reproduce the issue.

OTOH, I have one more user (other than you) who's not been able to
reproduce the issue.

> I will do a dissect the moment I figure out how to reproduce it. I
> will try to do some more experiments on that tomorrow.


Meanwhile, I enabled some debug info in the kernel. Here's what I have
got so far:

```
(gdb) bt
#0  0x00007f89908dc087 in kill () at ../sysdeps/unix/syscall-
template.S:120
#1  0x00000000604a3514 in uml_abort () at arch/um/os-Linux/util.c:94
#2  0x00000000604a3791 in os_dump_core () at arch/um/os-
Linux/util.c:149
#3  0x000000006048d126 in panic_exit (self=3D0x2e66d5, unused1=3D6,
unused2=3D0x0) at arch/um/kernel/um_arch.c:217
#4  0x00000000604c725a in notifier_call_chain (nl=3D0x2e66d5, val=3D0,
v=3D0x60d82f40 <buf>, nr_to_call=3D-1, nr_calls=3D0x0) at
kernel/notifier.c:83
#5  0x00000000604c72f6 in atomic_notifier_call_chain (nh=3D0x2e66d5,
val=3D6, v=3D0x0) at kernel/notifier.c:217
#6  0x0000000060a54607 in panic (fmt=3D0x60a55225 <printk>
"UH\211\345H\201\354", <incomplete sequence \320>) at
kernel/panic.c:272
#7  0x000000006048cca3 in segv (fi=3D<incomplete type>, ip=3D1615717312,
is_user=3D0, regs=3D0x60c2ee58 <cpu0_irqstack+11864>) at
arch/um/kernel/trap.c:246
#8  0x000000006048ce64 in segv_handler (sig=3D3040981, unused_si=3D0x6,
regs=3D0x60c2ee58 <cpu0_irqstack+11864>) at arch/um/kernel/trap.c:190
#9  0x00000000604a2556 in sig_handler_common (sig=3D11, si=3D0x60c2fbf0
<cpu0_irqstack+15344>, mc=3D0x60c2fae8 <cpu0_irqstack+15080>) at
arch/um/os-Linux/signal.c:48
#10 0x00000000604a2aa2 in sig_handler (sig=3D3040981, si=3D0x6, mc=3D0x0) a=
t
arch/um/os-Linux/signal.c:81
#11 0x00000000604a265f in hard_handler (sig=3D3040981, si=3D0x60c2fbf0
<cpu0_irqstack+15344>, p=3D0x0) at arch/um/os-Linux/signal.c:180
#12 <signal handler called>
#13 0x00000000604de3c0 in printk_caller_id () at
kernel/printk/printk.c:1924
#14 log_output (text_len=3D<optimized out>, text=3D<optimized out>,
dev_info=3D<optimized out>, lflags=3D<optimized out>, level=3D<optimized
out>, facility=3D<optimized out>) at kernel/printk/printk.c:1932
#15 vprintk_store (facility=3D1624806843, level=3D5, dev_info=3D0x0, fmt=3D=
0x35
<error: Cannot access memory at address 0x35>, args=3D0x1) at
kernel/printk/printk.c:2004
#16 0x00000000604de8b7 in vprintk_emit (facility=3D1624806843,
level=3D1622768673, dev_info=3D0x35, fmt=3D0x1 <error: Cannot access memory
at address 0x1>, args=3D0x60b97c22) at kernel/printk/printk.c:2029
#17 0x00000000604debad in vprintk_deferred (fmt=3D0x1 <error: Cannot
access memory at address 0x1>, args=3D0x60b97c21) at
kernel/printk/printk.c:3079
#18 0x0000000060a554de in printk_deferred (fmt=3D0x60d895bb <textbuf+91>
"\n") at kernel/printk/printk.c:3091
#19 0x000000006092680f in _warn_unseeded_randomness
(previous=3D<optimized out>, caller=3D<optimized out>, func_name=3D<optimiz=
ed
out>) at drivers/char/random.c:1534
#20 _warn_unseeded_randomness (func_name=3D0x60abf380 <__func__.38>
"get_random_u32", caller=3D0x608b5f25 <bucket_table_alloc+287>,
previous=3D0x35) at drivers/char/random.c:1516
#21 0x0000000060927d47 in get_random_u32 () at
drivers/char/random.c:2221
#22 0x00000000608b5f25 in bucket_table_alloc (nbuckets=3D64, gfp=3D3264,
ht=3D<optimized out>) at lib/rhashtable.c:203
#23 0x00000000608b6733 in rhashtable_init (ht=3D0x60c60e30
<init_ipc_ns+80>, params=3D0x608b5e06 <bucket_table_alloc>) at
lib/rhashtable.c:1061
#24 0x000000006080f234 in ipc_init_ids (ids=3D0x60c60de8 <init_ipc_ns+8>)
at ipc/util.c:119
#25 0x0000000060813c6d in sem_init_ns (ns=3D0x60d895bb <textbuf+91>) at
ipc/sem.c:254
#26 0x0000000060015b5d in sem_init () at ipc/sem.c:268
#27 0x00007f89906d92f7 in ?? () from /lib/x86_64-linux-
gnu/libcom_err.so.2
#28 0x00007f8990ab8fb2 in call_init (l=3D<optimized out>,
argc=3Dargc@entry=3D5, argv=3Dargv@entry=3D0x7ffe3e7a4c98,
env=3Denv@entry=3D0x7ffe3e7a4cc8) at dl-init.c:72
#29 0x00007f8990ab90b9 in call_init (env=3D0x7ffe3e7a4cc8,
argv=3D0x7ffe3e7a4c98, argc=3D5, l=3D<optimized out>) at dl-init.c:30
#30 _dl_init (main_map=3D0x61497ea0, argc=3D5, argv=3D0x7ffe3e7a4c98,
env=3D0x7ffe3e7a4cc8) at dl-init.c:119
#31 0x00007f89909d82bd in __GI__dl_catch_exception
(exception=3Dexception@entry=3D0x0, operate=3Doperate@entry=3D0x7f8990abc5a=
0
<call_dl_init>, args=3Dargs@entry=3D0x7ffe3e7a1e80) at dl-error-
skeleton.c:182
#32 0x00007f8990abd028 in dl_open_worker (a=3Da@entry=3D0x7ffe3e7a2020) at
dl-open.c:758
#33 0x00007f89909d8260 in __GI__dl_catch_exception
(exception=3Dexception@entry=3D0x7ffe3e7a2000,
operate=3Doperate@entry=3D0x7f8990abcc70 <dl_open_worker>,
args=3Dargs@entry=3D0x7ffe3e7a2020) at dl-error-skeleton.c:208
#34 0x00007f8990abc8ca in _dl_open (file=3D0x7ffe3e7a22a0
"libnss_nis.so.2", mode=3D-2147483646, caller_dlopen=3D0x7f89909bf3a6
<nss_load_library+294>, nsid=3D-2, argc=3D5, argv=3D0x7ffe3e7a2000,
env=3D0x7ffe3e7a4cc8)
    at dl-open.c:837
#35 0x00007f89909d76dd in do_dlopen (ptr=3Dptr@entry=3D0x7ffe3e7a2260) at
dl-libc.c:96
#36 0x00007f89909d8260 in __GI__dl_catch_exception
(exception=3Dexception@entry=3D0x7ffe3e7a21e0,
operate=3Doperate@entry=3D0x7f89909d76a0 <do_dlopen>,
args=3Dargs@entry=3D0x7ffe3e7a2260) at dl-error-skeleton.c:208
#37 0x00007f89909d831f in __GI__dl_catch_error
(objname=3Dobjname@entry=3D0x7ffe3e7a2238,
errstring=3Derrstring@entry=3D0x7ffe3e7a2240,
mallocedp=3Dmallocedp@entry=3D0x7ffe3e7a2237,=20
    operate=3Doperate@entry=3D0x7f89909d76a0 <do_dlopen>,
args=3Dargs@entry=3D0x7ffe3e7a2260) at dl-error-skeleton.c:227
#38 0x00007f89909d77b7 in dlerror_run
(operate=3Doperate@entry=3D0x7f89909d76a0 <do_dlopen>,
args=3Dargs@entry=3D0x7ffe3e7a2260) at dl-libc.c:46
#39 0x00007f89909d7846 in __GI___libc_dlopen_mode
(name=3Dname@entry=3D0x7ffe3e7a22a0 "libnss_nis.so.2", mode=3Dmode@entry=3D=
-
2147483646) at dl-libc.c:195
#40 0x00007f89909bf3a6 in nss_load_library (ni=3Dni@entry=3D0x61497db0) at
nsswitch.c:359
#41 0x00007f89909bfc39 in __GI___nss_lookup_function (ni=3D0x61497db0,
fct_name=3D<optimized out>, fct_name@entry=3D0x7f899089b020 "setgrent") at
nsswitch.c:467
#42 0x00007f899089554b in init_nss_interface () at nss_compat/compat-
grp.c:83
#43 init_nss_interface () at nss_compat/compat-grp.c:79
#44 0x00007f8990895e35 in _nss_compat_getgrnam_r (name=3D0x7f8990a2a1e0
"tty", grp=3D0x7ffe3e7a2910, buffer=3D0x7ffe3e7a24e0 "", buflen=3D1024,
errnop=3D0x7f899089eb00) at nss_compat/compat-grp.c:486
#45 0x00007f8990968b85 in __getgrnam_r (name=3Dname@entry=3D0x7f8990a2a1e0
"tty", resbuf=3Dresbuf@entry=3D0x7ffe3e7a2910,
buffer=3Dbuffer@entry=3D0x7ffe3e7a24e0 "", buflen=3D1024,
result=3Dresult@entry=3D0x7ffe3e7a2908)
    at ../nss/getXXbyYY_r.c:315
#46 0x00007f89909d6b77 in grantpt (fd=3Dfd@entry=3D5) at
../sysdeps/unix/grantpt.c:152
#47 0x00007f8990a9394e in __GI_openpty (amaster=3D0x60c2bd94,
aslave=3D0x60c2bd98, name=3D0x0, termp=3D0x0, winp=3D0x0) at openpty.c:103
#48 0x00000000604a1f65 in openpty_cb (arg=3D0x60c2bd94) at arch/um/os-
Linux/sigio.c:407
#49 0x00000000604a58d0 in start_idle_thread (stack=3D0x60c28000
<init_thread_info>, switch_buf=3D0x60c31e08 <init_task+4936>) at
arch/um/os-Linux/skas/process.c:598
#50 0x0000000060004a3d in start_uml () at
arch/um/kernel/skas/process.c:45
#51 0x00000000600047b2 in linux_main (argc=3D1624806843, argv=3D0x40709000)
at arch/um/kernel/um_arch.c:334
#52 0x000000006000574f in main (argc=3D5, argv=3D0x7ffe3e7a4c98, envp=3D0x3=
5)
at arch/um/os-Linux/main.c:144
(gdb)=20

```


--=20
Ritesh Raj Sarraf | http://people.debian.org/~rrs
Debian - The Universal Operating System

--=-xeOVGX8nVhEzFtQOM7OF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAmA+dYwACgkQpjpYo/Lh
dWk0jA//cQtnmiSeiws29HsIe9o93RKwbXuQvMNsc0aYMOKUFiHpDqLxKdvw7Q28
U5XWxm9jejxAbnayaYGZ0PXt9RZfd10eh6OuVSREd45Gf6CZQyS1fVSAqdVOwPS/
eZ1Qgx532PeA0fmpQV2iX9JPrqgYk4y46Us48Lwqkgc32hXTwJHA6E5KYAbPCAgN
XwCcYd5km4jOZp1ofXY5MTm4qBVJV6t5G0JWNSz1FNBw73LEKz4EEeJ7dOEzYckF
gjRUxLVwKKkZSLGOn98rYVS/+NspjzkO9ViBgkilr1kdrYSilp0E+wkCaZqwaFEp
3IhB9vsYuQ5XgM37XPI4qqpMpkSDf03l5R1tXqgiUTV/qRRQclevo+v1raIxF6mJ
zQ7xKy6jcuPSIsLGlnBtY5QJDMmRZCz3O/prjaUr7VChejyXf4eF3GekDRW/qMGS
DQOzMBtFhxMgc0gxRgxedWMS3X72FhYylULPcrm7R2nXNXMDRu8YWqkrM7xr7PY8
YUrxEwwXQ4Wpx7OgruWvzsN7ZobE/S5pG4CFdCSkpfrdp5W5rFhCaeJ/dKbUZON3
nrmyymxNUAa1+qUZ6afMHTAO098Tx7OJPbcWw52PEnE95U2tENu1BzVq0jXB0Y6u
+05BZVdUa0Vpow06TiRjy3bFCLJVxXV27vIZGui40zeuIWj5VTs=
=gLGA
-----END PGP SIGNATURE-----

--=-xeOVGX8nVhEzFtQOM7OF--



--===============8889690047814147273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============8889690047814147273==--



