Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lH124-0008SH-Up
 for linux-um@lists.infradead.org; Tue, 02 Mar 2021 09:09:33 +0000
Received: by mail-pf1-x42e.google.com with SMTP id w18so13415286pfu.9
 for <linux-um@lists.infradead.org>; Tue, 02 Mar 2021 01:09:30 -0800 (PST)
Message-ID: <1bdedf3c60058e1ae242a2a7f16eee256b0be3e0.camel@debian.org>
Subject: Re: linux uml segfault
From: Ritesh Raj Sarraf <rrs@debian.org>
Date: Tue, 02 Mar 2021 14:39:22 +0530
In-Reply-To: <573e256a-990b-ddf6-7965-367bb8b21229@kot-begemot.co.uk>
References: <3448a70e7a39b9c3202aeefa7858ace265b8a978.camel@debian.org>
 <6d37b5aa-36f2-1fce-b70b-8faa0ff882e0@kot-begemot.co.uk>
 <c8bb257c-1542-12f5-89f1-5c1f14b8a70a@collabora.com>
 <db40449e-6916-56bf-377c-01b042b9c890@kot-begemot.co.uk>
 <529cd4e2f39efffb18125dffab3058aeec3351ce.camel@debian.org>
 <573e256a-990b-ddf6-7965-367bb8b21229@kot-begemot.co.uk>
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
Content-Type: multipart/mixed; boundary="===============2615394976070681269=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, Christopher Obbard <chris.obbard@collabora.com>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Cc: 983379@bugs.debian.org


--===============2615394976070681269==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-sQ+YYcfd5YMW7CEe8w0S"


--=-sQ+YYcfd5YMW7CEe8w0S
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-02-24 at 11:44 +0000, Anton Ivanov wrote:
> In all cases it boots cleanly and there are no segfaults.
>=20
> So, frankly, no idea what is causing it to crash - I have run most
> combinations of 5.10 on a 5.10, all work fine here.

Is there any other way I can help you with this issue ?
I do have the core dump available on my local machine.


--=20
Ritesh Raj Sarraf | http://people.debian.org/~rrs
Debian - The Universal Operating System

--=-sQ+YYcfd5YMW7CEe8w0S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAmA+AMIACgkQpjpYo/Lh
dWkgoQ/8Drbr5D8q4wRiI2ksHztbvTzNoIxxKhW2nG+ydzZGuebGVCdp9iyxOH5e
VJSp3gLNLgJqaBY552nTuqoGUSvMhXyW40vC/2qqAW7WV/1b8q9Knyv/G3n2dTCB
xK0X0X2hJ1lvw/IK/D5T0phKiY4cBr54xt+lYKSr0jK218NOrZu6E2KzY0ZVGsMc
gE9RnEmhn1jJ3tVJq8riy7ygGoT4Ie0zflgPjjMcE9KqUZ2anVoYNIryjlW9msxc
g6b05AD353A9EV+dV0RHNomvvY2uEqzxTD09fWf9L3rbAp34E+BpR4OWhlOf4++B
XTy4IWf8NYkROB1Hb6KufKlCik8b+kkV0t5sbjYSHat3BjCzoTzOy/CzLzqrxcqJ
OUSfIRg0FHIWswNKhHcmpztGVDCvwiZgbJDqJItUP5gShvbz4vVb6fT617fL4JrY
/kLulVa6WKcl6J6umqUhCg6nE9Mj+zP7t95+lTYKp/vE61b1qEAYGrDiwqDgKH7y
YjC2Dbyn3QfoAOpOY5VDyRwKJwli5qsJ92sbPW30q8xyPnopc/ANl85w5LfjS+sI
/rETLFykzOdHJkzEbFnusrdIfsFn6iRkccVnHmgB6p87AAeTkQ9cpbJRblbnbSuS
ecq+kPktRvpg83UkjBjaAwZu3gMS8DSzyTszvocHY7XlPs1x9AQ=
=Jfk0
-----END PGP SIGNATURE-----

--=-sQ+YYcfd5YMW7CEe8w0S--



--===============2615394976070681269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============2615394976070681269==--



