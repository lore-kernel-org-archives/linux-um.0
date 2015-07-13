Return-Path: <dcb314@hotmail.com>
Message-ID: <DUB128-W717989412EB0F37DA7D4F79C9C0@phx.gbl>
From: David Binderman <dcb314@hotmail.com>
Date: Mon, 13 Jul 2015 15:25:08 +0000
In-Reply-To: <20150713151341.GA4474@parts.user-mode-linux.org>
References: 
 <DUB128-W4287C49CC298A43BB8A3409C9C0@phx.gbl>,<55A3A5E0.8030802@nod.at>,<DUB128-W657ACA17D13F07E1D42A339C9C0@phx.gbl>,<CAMuHMdUjwQF3Lhcyo0L_TNGECtKMbOdDp+fixiyj=Svw7XeuXg@mail.gmail.com>,<DUB128-W57E673D474548BF61C14F09C9C0@phx.gbl>,<20150713151341.GA4474@parts.user-mode-linux.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [uml-devel] linux-4.2-rc2/arch/um/drivers/net_user.c:258:
 possible missing call to va_end ?
To: Jeff Dike <jdike@addtoit.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger <richard@nod.at>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

=0A=
Hello there Jeff=2C=0A=
=0A=
----------------------------------------=0A=
> Just eyeballing it=2C that looks right to me. It just needs your=0A=
> original bug report above the Signed-off-by.=0A=
=0A=
Righto. Second try:=0A=
=0A=
Hello there=2C=0A=
=0A=
[linux-4.2-rc2/arch/um/drivers/net_user.c:258]: (error) va_list 'ap' was op=
ened but not closed by va_end().=0A=
=0A=
Source code is=0A=
=0A=
=A0=A0=A0 va_start(ap=2C str)=3B=0A=
=A0=A0=A0 while ((arg =3D va_arg(ap=2C char **)) !=3D NULL) {=0A=
=A0=A0=A0=A0=A0=A0=A0 if (*str =3D=3D '\0')=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return NULL=3B=0A=
=A0=A0=A0=A0=A0=A0=A0 end =3D strchr(str=2C '=2C')=3B=0A=
=A0=A0=A0=A0=A0=A0=A0 if (end !=3D str)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *arg =3D str=3B=0A=
=A0=A0=A0=A0=A0=A0=A0 if (end =3D=3D NULL)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return NULL=3B=0A=
=A0=A0=A0=A0=A0=A0=A0 *end++ =3D '\0'=3B=0A=
=A0=A0=A0=A0=A0=A0=A0 str =3D end=3B=0A=
=A0=A0=A0 }=0A=
=A0=A0=A0 va_end(ap)=3B=0A=
=A0=A0=A0 return str=3B=0A=
=0A=
If va_end needs to be called for successful return=2C it probably also=0A=
needs to be called for NULL return (twice).=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
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
-=A0=A0=A0=A0=A0=A0=A0 if (*str =3D=3D '\0')=0A=
+=A0=A0=A0=A0=A0=A0=A0 if (*str =3D=3D '\0') {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 va_end(ap)=3B=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return NULL=3B=0A=
+=A0=A0=A0=A0=A0=A0=A0 }=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 end =3D strchr(str=2C '=2C')=3B=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (end !=3D str)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *arg =3D str=3B=0A=
-=A0=A0=A0=A0=A0=A0=A0 if (end =3D=3D NULL)=0A=
+=A0=A0=A0=A0=A0=A0=A0 if (end =3D=3D NULL) {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 va_end(ap)=3B=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return NULL=3B=0A=
+=A0=A0=A0=A0=A0=A0=A0 }=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 *end++ =3D '\0'=3B=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 str =3D end=3B=0A=
=A0=A0=A0=A0 }=0A=
=0A=
 		 	   		  =

