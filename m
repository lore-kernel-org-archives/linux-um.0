Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQmyt-0006HC-OY for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 May 2004 05:49:03 -0700
Received: from smtp8.wanadoo.fr ([193.252.22.23] helo=mwinf0801.wanadoo.fr)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BQmyt-0002FQ-5g for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 May 2004 05:49:03 -0700
Subject: Re: [uml-devel] [PATCH] host context switch reduction
From: Laurent Vivier <LaurentVivier@wanadoo.fr>
In-Reply-To: <05a001c43e12$7affe2a0$2000000a@schlepptopp>
References: <20040229043549.GA8583@ccure.user-mode-linux.org>
	<02dc01c43c4a$bb7c0490$2000000a@schlepptopp>
	<1084831251.1230.4.camel@chartreuse>
	<03ff01c43c5d$7db6e5e0$2000000a@schlepptopp>
	<20040518175904.GB29114@ccure.user-mode-linux.org>
	<1084987654.2250.4.camel@chartreuse>
	<012201c43dcb$402ca6a0$2000000a@schlepptopp>
	<1084990661.2255.28.camel@chartreuse>
	<018a01c43dd9$0173f270$2000000a@schlepptopp>
	<1084996157.2256.36.camel@chartreuse>
	<05a001c43e12$7affe2a0$2000000a@schlepptopp>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-orTJTAxy43Z1zSS6KWAW"
Message-Id: <1085057350.1197.2.camel@chartreuse>
Mime-Version: 1.0
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
Date: Thu, 20 May 2004 14:49:11 +0200
To: roland <for_spam@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, blaisorblade_spam@yahoo.it



--=-orTJTAxy43Z1zSS6KWAW
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I put all related information at this URL:

http://perso.wanadoo.fr/laurent.vivier/UML

I have modified the 2.4.24 patches to set PTRACE_SYSEMU to 31 too.
This modification allows to use 2.4.24 UML on 2.6.6 host, and 2.6.6 UML
on 2.4.24 host.

Regards,
Laurent

Le jeu 20/05/2004 =E0 04:30, roland a =E9crit :
> Hi Laurent,=20
> i wondered about:
> "Checking syscall emulation patch for ptrace...missing"
>=20
> so  - i dig into this:
>=20
> the uml-patch needs to be adjusted to the fix you gave for the host patch=
:
> in arch/um/kernel/skas/include/ptrace-skas.h
> i changed :
> #define PTRACE_SYSEMU 25
> to
> #define PTRACE_SYSEMU 31
>=20
> whoha - now sysemu patch is running with 2.6.6  :)
>=20
> same positive effect: the getpid loop runs MUCH faster.
> i have tested some other commands and if i run a "vmstat 1" on the HOST,=20
> i can see the context-swap-rate drop down significantly.
>=20
> great!
>=20
> laurent, can you post the sysemu uml and host patch again in ONE mail,=20
> containing the corrected defines?
> others will probably have it easier this way!
> (maybe some notes about how it works and what it does would be helpful, t=
oo)
>=20
> thanks a lot!
>=20
> now we need some real-world performance tests/comparisons :)
> regards
> roland
>=20
> ps:
> i will do some more tests. maybe blaisorblade already wants to mention th=
at
> patch in his 2.6 documentation at: http://www.user-mode-linux.org/~blaiso=
rblade/ ?
>=20
>=20
>=20
>=20
>=20
>=20
> >in include/linux/ptrace.h ,
> >change
> >#define PTRACE_SCEMU            25
> >by
> >#define PTRACE_SCEMU            31
>=20
>=20
>=20
>=20
>=20
> ----- Original Message -----=20
> From: "Laurent Vivier" <LaurentVivier@wanadoo.fr>
> To: "roland" <for_spam@gmx.de>
> Cc: <user-mode-linux-devel@lists.sourceforge.net>
> Sent: Wednesday, May 19, 2004 9:49 PM
> Subject: Re: [uml-devel] [PATCH] host context switch reduction
>=20
>=20

--=-orTJTAxy43Z1zSS6KWAW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBArKlGbmJwdIv5dzMRAkkZAJ9cxy/G5XmxITjZp07Gq1MwWHIApQCfZq6d
OmNioxF5itpkop48xSlVwHA=
=hK8K
-----END PGP SIGNATURE-----

--=-orTJTAxy43Z1zSS6KWAW--



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
