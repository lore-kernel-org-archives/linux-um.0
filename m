Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C3buP-0001Uf-Fj for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Sep 2004 07:52:53 -0700
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C3buO-0008MA-Qy for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Sep 2004 07:52:53 -0700
Subject: Re: [uml-devel] Problems compiling any 2.6.x UML
From: Dominik =?ISO-8859-1?Q?J=FCrgens?= <dcdom@gmx.de>
In-Reply-To: <Pine.LNX.4.61.0409041625430.16231@filer.marasystems.com>
References: <20040903180244.42898.qmail@web54004.mail.yahoo.com>
	<1094299889.7716.36.camel@localhost>
	<Pine.LNX.4.61.0409041625430.16231@filer.marasystems.com>
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <1094309562.14679.12.camel@localhost>
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
Date: Sat, 04 Sep 2004 16:52:43 +0200
Content-Transfer-Encoding: quoted-printable
To: Henrik Nordstrom <uml@hno.marasystems.com>

Am Sa, den 04.09.2004 schrieb Henrik Nordstrom um 16:29:
> On Sat, 4 Sep 2004, Dominik J=FCrgens wrote:
>=20
> > But why does anyone use the /bin/sh in any script, when he wants to use
> > the bash? That is in my opinion a very bad fault!!
>=20
> /bin/sh is by UNIX standard a "UNIX compatible shell". It does not need t=
o=20
> be bash, but it needs to implement the UNIX standard shell syntax.
O.K!
>=20
> So any shell script using the UNIX shell syntax should be using /bin/sh
>=20
> Any shell script explicitly written for bash only shold be using /bin/bash

>=20
> Assuming /bin/sh understands bash specific extensions to the UNIX shell=20
> syntax is wrong.
I thought that any script in the build process uses such an extention,
so I wanted to report this. If not, I agree to you!

> Regards
> Henrik
>=20

Dominik Juergens



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=3D5047&alloc_id=3D10808&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
