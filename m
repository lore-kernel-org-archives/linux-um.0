Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuH5X-0002ar-6y for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Feb 2004 12:17:31 -0800
Received: from externalmx.valinux.com ([198.186.202.147]
	helo=externalmx.vasoftware.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AuFCs-00031c-Gk for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Feb 2004 10:16:58 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:36577)
	by externalmx.vasoftware.com with smtp (Exim 4.24 #1 (Debian))
	id 1AuEpD-0007i6-78
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 20 Feb 2004 09:52:31 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [discuss] UML and AMD-64
References: <E1AgMua-00075F-00@hermes.virtue>
	<20040113175635.GE2673@jaa.iki.fi>
	<1077235841.8412.37.camel@wopr.tektonic.net>
In-Reply-To: <1077235841.8412.37.camel@wopr.tektonic.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Message-Id: <200402201854.30464.blaisorblade_spam@yahoo.it>
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
Date: Fri, 20 Feb 2004 18:54:30 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 01:10, venerd=EC 20 febbraio 2004, Matt Ayres ha scritto:
> Did you use the skas3 patch?  My understand from looking at it is that
> skas3 is written for i386 only, hence you would only be able to run a
> 32-bit kernel.

Not exactly: it is for i386 only, so when you compile the host kernel for=20
amd64, you cannot use it. However, I think that the porting probably is not=
=20
too hard, having a test box at hand.

Bye
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
