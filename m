Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C44fQ-0001V7-V8 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 05 Sep 2004 14:35:20 -0700
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C44fP-0000Lr-A6 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 05 Sep 2004 14:35:20 -0700
In-Reply-To: <200409041737.29495.blaisorblade_spam@yahoo.it>
References: <20040903180244.42898.qmail@web54004.mail.yahoo.com>
	<1094299889.7716.36.camel@localhost>
	<200409041737.29495.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=pgp-sha1; boundary="Apple-Mail-10-146602369"
Message-Id: <5CAA3946-FF7E-11D8-83EF-000A95CD704C@kungfoocoder.org>
Content-Transfer-Encoding: 7bit
From: Paul Wagland <paul@kungfoocoder.org>
Subject: Re: [uml-devel] Problems compiling any 2.6.x UML
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
Date: Sun, 5 Sep 2004 22:58:39 +0200
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Matt Zimmerman <mdz@debian.org>, =?ISO-8859-1?Q?Dominik_J=FCrgens?= <dcdom@gmx.de>


--Apple-Mail-10-146602369
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1; format=flowed


On Sep 4, 2004, at 17:37, BlaisorBlade wrote:

> Alle 14:11, sabato 4 settembre 2004, Dominik J=FCrgens ha scritto:
>> Thank you very very much, that really fixed the problem!
>>
>> But why does anyone use the /bin/sh in any script, when he wants to=20=

>> use
>> the bash? That is in my opinion a very bad fault!!
>>
>> My /bin/sh was linked to the /bin/dash, not because I linked it, but
>> anything else! It does not seem to be very failure tolerant to =
suppose
>> that /bin/sh is the bash...
>
> 1) Someone else got a similar problem, because he used a Debian, too,=20=

> and he
> had /bin/sh -> /bin/dash. Why and when does Debian do this?

Someone has already answered this, but here is a more detailed answer:

When you install the dash package it will ask you if you want to use=20
this as your default shell. This should be OK, since dash is posix=20
compliant, and if you ask for /bin/sh you should only expect posix=20
compliance. Under debian, any package that specifies /bin/sh and then=20
uses bash extensions will normally get a level 3 bug raised, which is a=20=

violation of packaging policy. I.e. Only use /bin/sh if you want a=20
posix shell, otherwise use /bin/bash.

As to when, dash is the only package that I know of that will do this=20
for you, and then only if you ask it to. Why? Dash is faster than bash,=20=

and could save up to a second of boot time! ;-) Seriously, some people=20=

use it to ensure package compliance, some people do it because it seems=20=

right. I do it because it has a very low overhead, and it helps me to=20
ensure that my scripts are cross platform compatible.

> 2) Well, I'm attaching the patch to fix this.

Much appreciated :-)

Cheers,
Paul=

--Apple-Mail-10-146602369
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFBO34Dtch0EvEFvxURAkqPAJ9a/eLgJi2AS125fWlBeznYzpR0iQCggWUU
ArIpeVG6KQj4L93gXUtKsc0=
=YS9v
-----END PGP SIGNATURE-----

--Apple-Mail-10-146602369--



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
