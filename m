Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C3fLB-0006Av-1T for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Sep 2004 11:32:45 -0700
Received: from mta11.adelphia.net ([68.168.78.205])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C3fL8-0005WC-4W for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Sep 2004 11:32:43 -0700
Received: from mizar.alcor.net ([69.167.148.207]) by mta11.adelphia.net
	(InterMail vM.6.01.03.02 201-2131-111-104-20040324) with ESMTP
	id <20040904183234.NDUL404.mta11.adelphia.net@mizar.alcor.net>
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 4 Sep 2004 14:32:34 -0400
Received: from mdz by mizar.alcor.net with local (Exim 4.34)
	id 1C3fL0-000550-4l for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 04 Sep 2004 11:32:34 -0700
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] Problems compiling any 2.6.x UML
Message-ID: <20040904183234.GJ4879@alcor.net>
References: <20040903180244.42898.qmail@web54004.mail.yahoo.com>
	<1094299889.7716.36.camel@localhost>
	<200409041737.29495.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <200409041737.29495.blaisorblade_spam@yahoo.it>
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
Date: Sat, 4 Sep 2004 11:32:34 -0700
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

On Sat, Sep 04, 2004 at 05:37:29PM +0200, BlaisorBlade wrote:

> Alle 14:11, sabato 4 settembre 2004, Dominik J=FCrgens ha scritto:
> > Thank you very very much, that really fixed the problem!
> >
> > But why does anyone use the /bin/sh in any script, when he wants to use
> > the bash? That is in my opinion a very bad fault!!
> >
> > My /bin/sh was linked to the /bin/dash, not because I linked it, but
> > anything else! It does not seem to be very failure tolerant to suppose
> > that /bin/sh is the bash...
>=20
> 1) Someone else got a similar problem, because he used a Debian, too, and=
 he=20
> had /bin/sh -> /bin/dash. Why and when does Debian do this?

Debian doesn't do this, but Debian users are permitted to do so if they
desire, in order to have a more lightweight /bin/sh.  The only requirement
is that /bin/sh be POSIX compliant, so scripts which specify #!/bin/sh must
be written with only POSIX syntax.

--=20
 - mdz


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=3D5047&alloc_id=3D10808&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
