Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ALCTk-0005q8-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 15 Nov 2003 18:17:32 -0800
Received: from blabluga.hell.pl ([62.121.102.27])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1ALCSl-0006Ba-TT
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 15 Nov 2003 18:16:32 -0800
From: "Artur R. Czechowski" <arturcz@hell.pl>
Message-ID: <20031116021613.GW22490@blabluga.hell.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/7+LvQqw8N5lf/3J"
Content-Disposition: inline
Subject: [uml-devel] Re: arch/um/sys-i386/bugs.c compile error
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 16 Nov 2003 03:16:13 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: ljlane@debian.org



--/7+LvQqw8N5lf/3J
Content-Type: multipart/mixed; boundary="H88uUF932U8Oj0a6"
Content-Disposition: inline



--H88uUF932U8Oj0a6
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,
Look at http://bugs.debian.org/220724

OTOH, uml 6 has yet another silly error which results in failed
compilation when built with modules. Patch for arch/um/drivers/hostaudio_ke=
rn.c=20
attached.

Cheers
	Artur

PS. Sorry for breaking the thread. Webarchives do not provide msgid. Well,
    one more day with trying to run u-m-l on 2.6 host and I will subscribe
    here :)
--=20
Serwer odpowiedzia=B3:
- Mam trzy i p=F3=B3 macha [...]
                      http://fun.from.hell.pl/00-ROCZNIK-2001/stare/outlook=
=2Ejpg

--H88uUF932U8Oj0a6
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: attachment; filename="hostaudio_kern.diff"
Content-Transfer-Encoding: quoted-printable

22a23,30
> #define DSP_HELP \
> "    This is used to specify the host dsp device to the hostaudio driver.=
\n" \
> "    The default is \"" HOSTAUDIO_DEV_DSP "\".\n\n"
>=20
> #define MIXER_HELP \
> "    This is used to specify the host mixer device to the hostaudio drive=
r.\n" \
> "    The default is \"" HOSTAUDIO_DEV_MIXER "\".\n\n"
>=20
30,33d37
< #define DSP_HELP \
< "    This is used to specify the host dsp device to the hostaudio driver.=
\n" \
< "    The default is \"" HOSTAUDIO_DEV_DSP "\".\n\n"
<=20
42,45d45
< #define MIXER_HELP \
< "    This is used to specify the host mixer device to the hostaudio drive=
r.\n" \
< "    The default is \"" HOSTAUDIO_DEV_MIXER "\".\n\n"
<=20

--H88uUF932U8Oj0a6--

--/7+LvQqw8N5lf/3J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/tt3tlk0AXAynaGwRAqSKAJ4hnRHnEZ1h676eqITJxEQ4RIxuYACfRxMK
eyTk12I5Wu3J3TJN4ZgV2aA=
=XTOl
-----END PGP SIGNATURE-----

--/7+LvQqw8N5lf/3J--


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
