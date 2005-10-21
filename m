Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ET1Lu-0003x5-Os	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Oct 2005 11:10:50 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1ET1Lp-0006gl-0z
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Oct 2005 11:10:50 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] hostfs link count bug?
References: <Pine.GSO.4.63.0510211919010.18944@kempelen.iit.bme.hu>
In-Reply-To: <Pine.GSO.4.63.0510211919010.18944@kempelen.iit.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200510212011.13792.blaisorblade@yahoo.it>
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
Date: Fri, 21 Oct 2005 20:11:13 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Szabo Peter <pts@inf.bme.hu>

On Friday 21 October 2005 19:22, Szabo Peter wrote:
> Hi!

> I think I have found a bug in UML.
Sure!
> Inside my guest Linux, I get=20
[...]
> I use this version of UML:

> # dpkg -l user-mode-linux
> Desired=3DUnknown/Install/Remove/Purge/Hold

> | Status=3DNot/Installed/Config-files/Unpacked/Failed-config/Half-install=
ed
> |/ Err?=3D(none)/Hold/Reinst-required/X=3Dboth-problems (Status,Err:

> uppercase=3Dbad)

> ||/ Name           Version        Description
>
> +++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=3D=3D=3D ii  user-mode-linu 2.4.26-3um-1   User-mode Linux (kernel)
>
> Best regards,
>
> P=E9ter
The hostfs code in that release is very experimental, and was never finishe=
d=20
for 2.4, so try 2.4.28-bs2, which is an updated version from me, and includ=
es=20
the old working hostfs code from 2.4.24-1um (with some additional fixes=20
included).

Btw, you could also test 2.4.24-1um, except it doesn't plain work on 2.6=20
hosts, and has various bugs.

If, btw, you can file a bug upstream to Debian, to add 2.4.28-bs2 UML, it'd=
 be=20
nice.
--=20
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	=09
___________________________________=20
Yahoo! Messenger: chiamate gratuite in tutto il mondo=20
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
