Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Toralf =?iso-8859-15?q?F=F6rster?= <toralf.foerster@gmx.de>
Date: Fri, 20 May 2011 19:10:12 +0200
References: <201105191526.31904.toralf.foerster@gmx.de> <1305907458.1465.23.camel@gandalf.stny.rr.com> <1305907896.1465.27.camel@gandalf.stny.rr.com>
In-Reply-To: <1305907896.1465.27.camel@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Message-Id: <201105201910.13095.toralf.foerster@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: kernel 2.6.39 (user mode linux) crashes (2.6.38 works fine)
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Darren Hart <dvhart@linux.intel.com>, richard -rw- weinberger <richard.weinberger@gmail.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


Steven Rostedt wrote at 18:11:36
> > Wait! This is where we need the WARN_ON_SMP(), do we have that patc=
h in?
> >=20
> > I think UML is UP, and that spin_is_locked() will always return fal=
se.
>=20
> Could you apply these patches:
>=20
> 2092e6be WARN_ON_SMP(): Allow use in if() statements on UP
> 29096202 futex: Fix WARN_ON() test for UP
>=20
> On top of this commit, and see if the problem goes away. What could h=
ave
> happened, is that you have two bugs, with one of them fixed. If the g=
it
> bisect stumbled on this bug, it will show this one, even though later
> on, this code was fixed. If you apply the above two patches and it wo=
rks
> again, then this isn't the bug you are looking for.
>=20
> -- Steve
Right - applying those 2 commits on top of v2.6.38-rc8-1-g2e12978 works=
 - now=20
the issue is away.

And yes - now I've to look for the other of two bugs, which was introdu=
ced=20
between the tags v2.6.38 and v2.6.39, I think.

Is there's an easy way to check, whether a given checked out git tree c=
ontains=20
a specific commit id ?

--=20
MfG/Sincerely
Toralf F=F6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

