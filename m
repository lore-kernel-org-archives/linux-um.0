Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bg4ko-0008EH-67 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 09:49:42 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1Bg4kn-0006CG-IS for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jul 2004 09:49:42 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [mgedmin@b4net.lt: Bug#256873: user-mode-linux: fails
	to start (kernel panic)]
References: <20040629182711.GM5243@alcor.net> <40E20187.1050803@nks.net>
	<02F391BE-CA6B-11D8-A5A1-000A95CD704C@wagland.net>
In-Reply-To: <02F391BE-CA6B-11D8-A5A1-000A95CD704C@wagland.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200406302038.41475.blaisorblade_spam@yahoo.it>
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
Date: Wed, 30 Jun 2004 20:38:41 +0200
Content-Transfer-Encoding: quoted-printable
To: Paul Wagland <paul@wagland.net>, James Neal <jneal@nks.net>
Cc: Matt Zimmerman <mdz@debian.org>, user-mode-linux-devel@lists.sourceforge.net, 256873-forwarded@bugs.debian.org, Marius Gedminas <mgedmin@b4net.lt>

Alle 09:56, mercoled=EC 30 giugno 2004, Paul Wagland ha scritto:
> On Jun 30, 2004, at 1:55, James Neal wrote:

> I normally hate doing this... but me too!

> Even worse, it would appear that UML and reiserfs don't play nice...
> when the UML does crash I tend to end up with some pretty massive
> filesystem corruptions, to the point where my UML will not boot
> anymore, and I spent over an hour just now trying to coax it back to
> life by copying in and replacing all of the corrupted binaries.
If you didn't enable the synchronous UBD access (near to the UBD options in=
=20
the kernel configuration), that's almost expected, as the help explains=20
(IIRC), for journaled filesystems (although some people claim ext3 does not=
=20
need it, and this could be true, even because reiserfs works like ext3=20
"data=3Dwriteback" mode, which is less safe than the default ext3=20
"data=3Dordered").

In either case, give more info, so we know if this is a "no-bug" or if we=20
should investigate it.
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 -=20
digital self defense, top technical experts, no vendor pitches,=20
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
