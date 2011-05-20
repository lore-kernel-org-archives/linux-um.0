Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <BANLkTikfaKJfnDwQoFi9WLX6q+2HHe90HQ@mail.gmail.com>
References: <201105191526.31904.toralf.foerster@gmx.de>
	 <201105200937.15322.toralf.foerster@gmx.de>
	 <BANLkTik0oz6ppJvRpufaaiBL1pqcAxNHuA@mail.gmail.com>
	 <201105201042.15410.toralf.foerster@gmx.de>
	 <BANLkTikfaKJfnDwQoFi9WLX6q+2HHe90HQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 20 May 2011 13:19:13 -0400
Message-ID: <1305911953.1465.29.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: kernel 2.6.39 (user mode linux) crashes (2.6.38 works fine)
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, 2011-05-20 at 18:24 +0200, richard -rw- weinberger wrote:
> 2011/5/20 Toralf F=F6rster <toralf.foerster@gmx.de>:
> >

> Here in futex_wake() happens a NULL pointer dereference.
> Steve, any ideas?
>=20

Yes, if this is from the bisect, and does not contain the two commits
that I've posted in another email. Without those fixes, the futex code
will error and return without doing the proper work and cause all sorts
of bugs.

-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

