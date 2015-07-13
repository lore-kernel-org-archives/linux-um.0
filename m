Return-Path: <dcb314@hotmail.com>
Message-ID: <DUB128-W57E673D474548BF61C14F09C9C0@phx.gbl>
From: David Binderman <dcb314@hotmail.com>
Date: Mon, 13 Jul 2015 14:57:48 +0000
In-Reply-To: 
 <CAMuHMdUjwQF3Lhcyo0L_TNGECtKMbOdDp+fixiyj=Svw7XeuXg@mail.gmail.com>
References: 
 <DUB128-W4287C49CC298A43BB8A3409C9C0@phx.gbl>,<55A3A5E0.8030802@nod.at>,<DUB128-W657ACA17D13F07E1D42A339C9C0@phx.gbl>,<CAMuHMdUjwQF3Lhcyo0L_TNGECtKMbOdDp+fixiyj=Svw7XeuXg@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [uml-devel] linux-4.2-rc2/arch/um/drivers/net_user.c:258:
 possible missing call to va_end ?
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hello there Geert=2C=0A=
=0A=
----------------------------------------=0A=
> In that case we feel obliged to guide you to a proper patch submission.=
=0A=
>=0A=
> Please give it a try. We won't bite =3B-)=0A=
=0A=
Since you've been so nice about it=2C here is my umpteenth go at a=0A=
linux kernel patch.=0A=
=0A=
Signed-off-by: David Binderman <dcb314@hotmail.com>=0A=
=0A=
--- linux-4.2-rc2/arch/um/drivers/net_user.c.sav=A0=A0=A0 2015-07-13 15:41:=
33.2115=0A=
48852 +0100=0A=
+++ linux-4.2-rc2/arch/um/drivers/net_user.c=A0=A0=A0 2015-07-13 15:42:50.1=
91786525 +0=0A=
100=0A=
@@ -254=2C13 +254=2C17 @@ char *split_if_spec(char *str=2C ...)=0A=
=A0=0A=
=A0=A0=A0=A0 va_start(ap=2C str)=3B=0A=
=A0=A0=A0=A0 while ((arg =3D va_arg(ap=2C char **)) !=3D NULL) {=0A=
-=A0=A0=A0 =A0=A0=A0 if (*str =3D=3D '\0')=0A=
+=A0=A0=A0 =A0=A0=A0 if (*str =3D=3D '\0') {=0A=
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 va_end(ap)=3B=0A=
=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return NULL=3B=0A=
+=A0=A0=A0 =A0=A0=A0 }=0A=
=A0=A0=A0=A0 =A0=A0=A0 end =3D strchr(str=2C '=2C')=3B=0A=
=A0=A0=A0=A0 =A0=A0=A0 if (end !=3D str)=0A=
=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 *arg =3D str=3B=0A=
-=A0=A0=A0 =A0=A0=A0 if (end =3D=3D NULL)=0A=
+=A0=A0=A0 =A0=A0=A0 if (end =3D=3D NULL) {=0A=
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 va_end(ap)=3B=0A=
=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return NULL=3B=0A=
+=A0=A0=A0 =A0=A0=A0 }=0A=
=A0=A0=A0=A0 =A0=A0=A0 *end++ =3D '\0'=3B=0A=
=A0=A0=A0=A0 =A0=A0=A0 str =3D end=3B=0A=
=A0=A0=A0=A0 }=0A=
=0A=
 		 	   		  =

