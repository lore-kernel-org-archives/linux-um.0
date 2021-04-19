Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYU3Z-00BPIy-47
 for linux-um@lists.infradead.org; Mon, 19 Apr 2021 13:35:21 +0000
Message-ID: <2a59bd34565615ff0b4dcdd9cdcd2e0d40ed429c.camel@sipsolutions.net>
Subject: Re: [PATCH] uml/helper: Fix stack alignment
From: Benjamin Berg <benjamin@sipsolutions.net>
Date: Mon, 19 Apr 2021 15:34:58 +0200
In-Reply-To: <CABqSeATiUxfev8O4ZRdi_jvLEXC2MMuomE_nKv=mG2b_3eP-qA@mail.gmail.com>
References: <20210417163949.530921-1-zhuyifei1999@gmail.com>
 <9722b8ce233ad4d7020588f9dd60a3037455754d.camel@sipsolutions.net>
 <CABqSeATg2558BgMWMBs3O3vuR9wWS30d=x2iug3S-M1eMFi+qQ@mail.gmail.com>
 <CABqSeATiUxfev8O4ZRdi_jvLEXC2MMuomE_nKv=mG2b_3eP-qA@mail.gmail.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8300247654646070727=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: YiFei Zhu <zhuyifei1999@gmail.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>


--===============8300247654646070727==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-2ZsDClXrrniedAFDq7sc"


--=-2ZsDClXrrniedAFDq7sc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2021-04-18 at 01:56 -0500, YiFei Zhu wrote:
> On Sat, Apr 17, 2021 at 11:56 PM YiFei Zhu <zhuyifei1999@gmail.com>
> wrote:
> > =C2=A0 * um on um x86_64: I'm having trouble testing um within um, gett=
ing
> > a weird error ("start_userspace : expected SIGSTOP, got status =3D
> > 2943"
> > when starting init, might try to debug later), but the code in
> > handle_signal also aligns the stack.
>=20
> Figured this one out. The inner um, in userspace_tramp, is trying to
> mmap the syscall stub to the same syscall stub at the same location as
> the outer um, and that fails with ENOMEM. In theory, this would cause
> the printk of "mapping mmap stub at ... failed, errno =3D ..." to occur,
> but because:
> * call stack: vprintk_store -> printk_caller_id -> in_task -> in_nmi
> -> nmi_count -> preempt_count -> current_thread_info
> * um's current_thread_info is at the current stack pointer & mask,
> hence it is often not valid when on small temporary stacks.
> Therefore, userspace_tramp can't printk.
>=20
> I'm wondering, is this issue of printk being broken in userspace_tramp
> an issue worth fixing? Has there been prior discussions on it?

Yeah, printk is only usable from kernel threads. So in other cases
logging should happen directly. But do note that os_info with its
current glibc printf implementation seems to also create issues
sometimes as it may require more stack than available.

In my seccomp patchset, I added a few patches to fix related issues,
see
 https://patchwork.ozlabs.org/project/linux-um/list/?series=3D231980
specifically
 * [06/27] um: Don't use vfprintf() for os_info()
 * [07/27] um: Do not use printk in SIGWINCH helper thread
 * [09/27] um: Do not use printk in userspace trampoline

Benjamin


--=-2ZsDClXrrniedAFDq7sc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAmB9hwIACgkQq6ZWhpmF
Y3AMRxAAoINrkfD54X6GLb2IiWWJkat88yOOq9HQ9sVU0+2N278Q1qP6loABYZ8u
jrSfmng7G9R9VfIofjj4TWOcrSoaQxLX/n2/SedeqZ2mQoc5IgrJy27Jk5GWa60/
6YpV8n9grKk9fEs7JPeS2+7jr1luQQFhJuNVruzClQKJmxO1AQxy6ATLvvs8Jb01
vFEuFWd4oP7jyg1LfAzRcsVd5IgPsn86RTKx5XNF1qIP0zKCX5tUtMX6d5L0aPkP
GNArPubvcAEnjUeHRj4x+8/0AvYKiIsiGsosjpqsLHKI4vin+tRxONVbs6lzq4dA
W820cwQi60nJi0qFSnlpaGd8YPJQU/qo5IeUvCc+v4LNgaCr68sVerPPmASYWkx0
2DOgbOpwlN6gSSH7UP7KrFWPfFLjLQnQJIGj+lLe8b+1HIiOPGVIaEx7KV260KI5
x1xnCdsejSIMqVwDHwxFDyijrp8nYtwjFR1b94uIBP2paf5exQrDYIljsadXKeGV
KInP4nAyKEZbgKnyH4iYp1wqXm+t+ZCdDf9kULOjDILf1ALqW//dtNhzQN3Tns+d
4k5OngnDwlA2lUwcPjAT7OlAoVvDpZ6121qm/J2WU/pgNIW8kAdh0E0m3GrgHHgD
XlFlykspyxorQQMFWc43dVXDkm8bMa51MTEkH9LctjmdtgB9J/Y=
=Audm
-----END PGP SIGNATURE-----

--=-2ZsDClXrrniedAFDq7sc--



--===============8300247654646070727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============8300247654646070727==--



