Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKymY-00DLYS-Oa
 for linux-um@lists.infradead.org; Fri, 18 Feb 2022 08:38:28 +0000
Received: by mail-pf1-x42c.google.com with SMTP id z16so1806617pfh.3
 for <linux-um@lists.infradead.org>; Fri, 18 Feb 2022 00:38:25 -0800 (PST)
Message-ID: <ea276eed0eab8f6452b4d7098f8bef5c0001b34e.camel@debian.org>
Subject: Re: Bug#1005900: linux.uml: uml_mconsole client becomes blocked on
 read after issuing commands stop and go
From: Ritesh Raj Sarraf <rrs@debian.org>
Date: Fri, 18 Feb 2022 14:08:23 +0530
In-Reply-To: <CALv6pCZ1r_j=2K4vPReVjkegUeaOJS_wYyte+pWfnMxwrhWiMw@mail.gmail.com>
References: <CALv6pCZ1r_j=2K4vPReVjkegUeaOJS_wYyte+pWfnMxwrhWiMw@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============4378809991343514500=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Mihai Hanor <quake2iasi@gmail.com>, 1005900@bugs.debian.org, linux-um@lists.infradead.org


--===============4378809991343514500==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Djviw3JvnWk+GoLZLkPx"


--=-Djviw3JvnWk+GoLZLkPx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Mihai,

In this case, it is good to have the User Mode Linux upstream in the
loop.

Thanks,
Ritesh

--- linux-source-5.16/arch/um/drivers/mconsole_kern.c	2022-02-05 20:22:06.0=
00000000 +0200
+++ linux-source-5.16.fix/arch/um/drivers/mconsole_kern.c	2022-02-16 23:35:=
39.562668086 +0200
@@ -224,6 +224,7 @@
=20
 void mconsole_stop(struct mc_request *req)
 {
+	int err;
 	deactivate_fd(req->originating_fd, MCONSOLE_IRQ);
 	os_set_fd_block(req->originating_fd, 1);
 	mconsole_reply(req, "stopped", 0, 0);
@@ -247,6 +248,11 @@
 	}
 	os_set_fd_block(req->originating_fd, 0);
 	mconsole_reply(req, "", 0, 0);
+	err=3Dactivate_fd(MCONSOLE_IRQ, req->originating_fd, IRQ_READ,
+		(void*)(req->originating_fd), NULL);
+	if (err)
+	  mconsole_reply(req, "Failed to reactivate MCONSOLE_IRQ, \
+			this will block the read for uml_mconsole", 1, 0);
 }
=20
 static DEFINE_SPINLOCK(mc_devices_lock);
--- linux-source-5.16/arch/um/kernel/irq.c	2022-02-05 20:22:06.000000000 +0=
200
+++ linux-source-5.16.fix/arch/um/kernel/irq.c	2022-02-16 23:39:15.65027936=
7 +0200
@@ -249,7 +249,7 @@
 		free_irq_entry(entry, false);
 }
=20
-static int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_i=
d,
+int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_id,
 		       void (*timetravel_handler)(int, int, void *,
 						  struct time_travel_event *))
 {
@@ -304,6 +304,7 @@
 out:
 	return err;
 }
+EXPORT_SYMBOL(activate_fd);
=20
 /*
  * Remove the entry or entries for a specific FD, if you
--- linux-source-5.16/arch/um/include/shared/irq_user.h	2022-02-05 20:22:06=
.000000000 +0200
+++ linux-source-5.16.fix/arch/um/include/shared/irq_user.h	2022-02-16 23:3=
9:09.642292312 +0200
@@ -19,6 +19,7 @@
 void sigio_run_timetravel_handlers(void);
 extern void free_irq_by_fd(int fd);
 extern void deactivate_fd(int fd, int irqnum);
+extern int activate_fd(int irq, int fd, enum um_irq_type type, void *dev_i=
d, void (*timetravel_handler)(int, int, void *, struct time_travel_event *)=
);
 extern int deactivate_all_fds(void);
 extern int activate_ipi(int fd, int pid);

On Thu, 2022-02-17 at 01:06 +0200, Mihai Hanor wrote:
> Package: user-mode-linux
> Version: 5.16um1
> Severity: normal
> File: /usr/bin/linux.uml
> X-Debbugs-Cc: quake2iasi@gmail.com
>=20
> Dear Maintainer,
>=20
> * What is the problem:
> Issuing the commands stop followed by go, at the input of the
> uml_mconsole
> client, results in the client becoming blocked on read socket. This
> is because
> of logic in arch/um/drivers/mconsole_kern.c, where mconsole_stop()
> doesn't
> reactivate the MCONSOLE_IRQ before the function has exited.
>=20
> I've managed to find a fix which seems to be working, but I don't
> know if it's
> a proper fix. Please see the attached file.
>=20
>=20
> -- System Information:
> Debian Release: bookworm/sid
> =C2=A0 APT prefers testing
> =C2=A0 APT policy: (900, 'testing'), (500, 'unstable-debug'), (500,
> 'testing-debug'), (1, 'unstable')
> Architecture: amd64 (x86_64)
> Foreign Architectures: i386
>=20
> Kernel: Linux 5.16.0-1-amd64 (SMP w/4 CPU threads; PREEMPT)
> Kernel taint flags: TAINT_WARN
> Locale: LANG=3Den_US.UTF-8, LC_CTYPE=3Den_US.UTF-8 (charmap=3DUTF-8),
> LANGUAGE=3Den_US:en
> Shell: /bin/sh linked to /bin/dash
> Init: systemd (via /run/systemd/system)
> LSM: AppArmor: enabled
>=20
> Versions of packages user-mode-linux depends on:
> ii =C2=A0libc6 =C2=A02.33-5
>=20
> Versions of packages user-mode-linux recommends:
> ii =C2=A0uml-utilities =C2=A020070815.4-1
>=20
> Versions of packages user-mode-linux suggests:
> ii =C2=A0mate-terminal [x-terminal-emulator] =C2=A01.26.0-1
> ii =C2=A0pterm [x-terminal-emulator] =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00.=
76-2
> pn =C2=A0rootstrap =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<none>
> pn =C2=A0slirp =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<none>
> pn =C2=A0user-mode-linux-doc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0<none>
> pn =C2=A0vde2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <none>
>=20
> -- no debconf information

--=20
Ritesh Raj Sarraf | http://people.debian.org/~rrs
Debian - The Universal Operating System

--=-Djviw3JvnWk+GoLZLkPx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAmIPWv8ACgkQpjpYo/Lh
dWkO3RAAgzv24IixRFVAv5spm0SxkaMBMgCX1bXkEVzr9m8USGGrLVSXo/Uvtvl/
r/CFlmAgFZBsoLNSMK1izGsTK0kyIeTR2OSFkOwN9ZjuZrAuEAMPuklUQRldegq0
SmwmS6J8d80B8F+aNAF6gj6fySeDga4Tdg+0BZr6J+Hu3rFwG/wQBQyLn72LB94N
7TXeSpZ0huJN1qh8nTTpA0u8DwKJBK1e/0NEyBTGZbelReoF5Ouh30IQtBLKlQds
0SiivcrAuFppyD0NWBMF6GY1OF0hFC6d7HhqTvmaWrufRWUAafg0Vv7l2WXKBKSE
N2ZsycSaArIxtrGcAKjl/+G/zWVJLInotjuGXDsTdUNsNfTCK8Yzs0jtfWJlGOcs
YRkIzWHPs5kmjBUgFViFKJ6UDrrq0eH833LsjsCX6iwScP8sR6RP8WyCDCanVwjj
eFEQ0sJ0z/mxX/Cz2qKZS2FciZJFviNUgHxhyVyIwLuV/dHfKHdca/GzMmbsEW1A
VnT5sAChnHffrlo5hgB70vM21A8Kaj1VQLuV8p9ek5DNiaj0vhoUSHyYGs7t1CjN
qR48IUJzDag0nOdm46TlVrqoH3kRjCLecejqTNON+Vi/rEBp/QQ7S1xaEGT7WADh
XPNV95mgI4vy17ZQZrbv2rpI8fx7B28oZccjMa1Yj+uihIjDe5A=
=b6W7
-----END PGP SIGNATURE-----

--=-Djviw3JvnWk+GoLZLkPx--


--===============4378809991343514500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============4378809991343514500==--


