Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CbPB8-0004ri-0M for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Dec 2004 12:09:50 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CbPB6-000372-NQ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Dec 2004 12:09:49 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: 2.6.9-bb4 released
References: <005301c4d95b$4bdbe4d0$0201a8c0@hawk> <41B240F4.2010108@upb.de>
In-Reply-To: <41B240F4.2010108@upb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200412062113.25753.blaisorblade_spam@yahoo.it>
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
Date: Mon, 6 Dec 2004 21:13:25 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Sven =?iso-8859-1?q?K=F6hler?= <skoehler@upb.de>, user-mode-linux-user@lists.sourceforge.net

On Saturday 04 December 2004 23:57, Sven K=F6hler wrote:
> > http://www.user-mode-linux.org/~blaisorblade/patches/guest/uml-2.6.9-bb=
4/

> runs stable now for about 24 hours, longer than any version before ;-)
Any -bb version you mean, I hope.

Including security fixes (which I had left to Bodo and Jeff at the beginnin=
g)=20
required destabilizing the -bb tree, which would otherwise have been a real=
ly=20
stabler version.

One *big* and basical problem was fixed exactly in -bb4, which explains why=
=20
it's stabler for you.

The bug was in uml-signal-delivery.patch IIRC. It's very big, and when I wa=
s=20
compelled to merge it to include further security fixes depending on it, I =

was very worried about it giving problems.

But since the first reports I got were just about trivial issues which were=
=20
easily fixed (I got *real* bug-reports much later), I just thought it was o=
k=20
(and I wasn't able to reproduce at all the problem).

> > Most notable patches are:
> > - uml-hang-on-2.6.9-host
> > - uml-fix-reboot-skas

> well, does this "fix-reboot" mean, that it doesn't reboot anymore?

That is not the intention. Just unapply it for now, and help diagnosing the=
=20
problem. Also, make sure *that* patch is at fault... start reverting end=20
patches away (with patch-scripts, please, don't go doing it by hand, it's a=
=20
bit of a massacre) and report when it works again. I would expect the probl=
em=20
to be a bit earlier (except if you also tested -bb3 or something such).

> because it doesn't when i tell it to

> sometimes it even segfaults, when halting or rebooting.

Ok, let's say it this way: UML happens to reboot depending on how much luck=
y=20
you / your box are.

On my system, with *any* UML version, out of three reboots, I get on averag=
e=20
two correct reboots and one segfault. I only can get it to reliably *crash*=
=20
on reboot by applying an obviously correct patch (Jeff Dike is still=20
astonished that it can hurt anything).

For Bodo, it only works with the patches at the end, not otherwise. For me =

it's no difference without those.

Hearing that for you rebooting *worked* makes me just wonder a bit more.

The fact it halts when halting is something new, however.
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.=20
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
