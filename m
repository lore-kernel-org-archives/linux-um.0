Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bb1hf-0000x2-3t for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jun 2004 11:33:35 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Bb1he-0002FT-G3 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jun 2004 11:33:34 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [uml-user] skas not found
References: <BAY18-F18AMdGwGMFdX000701d9@hotmail.com>
	<200406061859.39809.blaisorblade_spam@yahoo.it>
	<200406081717.i58HHKis002962@ccure.user-mode-linux.org>
In-Reply-To: <200406081717.i58HHKis002962@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200406172043.25474.blaisorblade_spam@yahoo.it>
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
Date: Thu, 17 Jun 2004 20:43:25 +0200
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 19:17, marted=EC 8 giugno 2004, Jeff Dike ha scritto:
> blaisorblade_spam@yahoo.it said:
> > - There should be a stable branch, just updating to new releases, and
> > development patches, adding experimental features. It works so all
> > over the  world. Sadly not here. I would also think that stable trunk
> > is 2.4.26-1,  -2... while for development we have a list of
> > independent patches  (HUMFS-2.4.26-1-v1.patch to apply onto 2.4.26-1,
> > and which is version 1).

> I don't disagree.  A stable tree would be a fine idea.  The only problem =
is
> that no one has volunteered to manage it, and I don't have time to open
> up and maintain a new tree.

Well, let's discuss this on the ML. I could be maybe able to maintain it, i=
f=20
we intend it as "porting to new vanilla kernels, merging patches when they =

are ready and building the patch". Not very timely maybe, but I could. This=
=20
is not a good moment for this, since I should be busy... however I'm going =
to=20
post a test-patch for 2.6.7... it will maybe include some trivial changes I=
=20
posted recently.

> > This could be done in 2.6 mainline if UML updates get merged: Jeff,
> > you could  update UML to kernel changes in mainline, while putting
> > experimental patches  on the site until they are tested enough to be
> > merged.

> Who's going to test individual patches unless they are part of a widely
> used tree?

>  I think a stable tree is a fine idea, but I don't particularly
> like the idea of having an "official" set of patches floating around.  If
> they're official, then they can be part of a development tree, and everyo=
ne
> who uses that tree tests all of the patches in it.
>
> 				Jeff

Ok, I could translate and correct my idea to:

- the "stable" tree will be, at the end, the vanilla tree (so no release wo=
rk=20
for you).

- you keep mantaining a development tree, but if possible in the form of a =

patchset (like -mm); each new (non-trivial) patch is posted to the ML (well=
,=20
obviously you don't need to wait for comments), so that it can be tested=20
before the new release (especially if it's development work).

The "patchset" form is especially important to be able to commit patches in=
=20
little bits (well, not so little: splitting one big change in 7 depending=20
changes as on LKML is a lot of work, but separating HUMFS and other fixes i=
s=20
not).

To manage well the patchset, with little effort, there are the patch-script=
s=20
from Randy Dunlap, used for -mm (at=20
http://developer.osdl.org/rddunlap/patch-scripts/). I'm going to study them=
,=20
probably.
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
