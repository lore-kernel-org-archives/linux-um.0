Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <201105201910.13095.toralf.foerster@gmx.de>
References: <201105191526.31904.toralf.foerster@gmx.de>
	 <1305907458.1465.23.camel@gandalf.stny.rr.com>
	 <1305907896.1465.27.camel@gandalf.stny.rr.com>
	 <201105201910.13095.toralf.foerster@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 20 May 2011 13:46:09 -0400
Message-ID: <1305913569.1465.34.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: kernel 2.6.39 (user mode linux) crashes (2.6.38 works fine)
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: Darren Hart <dvhart@linux.intel.com>, richard -rw- weinberger <richard.weinberger@gmail.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, 2011-05-20 at 19:10 +0200, Toralf F=F6rster wrote:
> Steven Rostedt wrote at 18:11:36
> > > Wait! This is where we need the WARN_ON_SMP(), do we have that pa=
tch in?
> > >=20
> > > I think UML is UP, and that spin_is_locked() will always return f=
alse.
> >=20
> > Could you apply these patches:
> >=20
> > 2092e6be WARN_ON_SMP(): Allow use in if() statements on UP
> > 29096202 futex: Fix WARN_ON() test for UP
> >=20
> > On top of this commit, and see if the problem goes away. What could=
 have
> > happened, is that you have two bugs, with one of them fixed. If the=
 git
> > bisect stumbled on this bug, it will show this one, even though lat=
er
> > on, this code was fixed. If you apply the above two patches and it =
works
> > again, then this isn't the bug you are looking for.
> >=20
> > -- Steve
> Right - applying those 2 commits on top of v2.6.38-rc8-1-g2e12978 wor=
ks - now=20
> the issue is away.
>=20
> And yes - now I've to look for the other of two bugs, which was intro=
duced=20
> between the tags v2.6.38 and v2.6.39, I think.

Another thing you could do is checkout 29096202 and see if it works. If
it does, you can base that as your "git bisect good" and you should not
be affected by this bug again.

-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

