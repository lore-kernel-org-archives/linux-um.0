Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <BANLkTinvtfpPr3GxKA49MN4y1q66HETorQ@mail.gmail.com>
References: <201105191526.31904.toralf.foerster@gmx.de>
	 <1305907458.1465.23.camel@gandalf.stny.rr.com>
	 <1305907896.1465.27.camel@gandalf.stny.rr.com>
	 <201105210053.51314.toralf.foerster@gmx.de>
	 <BANLkTinvtfpPr3GxKA49MN4y1q66HETorQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Date: Sun, 22 May 2011 00:37:36 +0200
Message-ID: <1306017456.18455.1.camel@twins>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: kernel 2.6.39 (user mode linux) crashes (2.6.38 works fine)
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>, Steven Rostedt <rostedt@goodmis.org>, Darren Hart <dvhart@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sat, 2011-05-21 at 12:12 +0200, richard -rw- weinberger wrote:
> 2011/5/21 Toralf F=C3=B6rster <toralf.foerster@gmx.de>:
> > Bisecting gave :
> >
> >
> > git bisect badd123375425d7df4b6081a631fc1203fceafa59b2 is the first=
 bad commit
> > commit d123375425d7df4b6081a631fc1203fceafa59b2
> > Author: Thomas Gleixner <tglx@linutronix.de>
> > Date:   Wed Jan 26 21:32:01 2011 +0100
> >
> >    rwsem: Remove redundant asmregparm annotation
> >
> >    Peter Zijlstra pointed out, that the only user of asmregparm (x8=
6) is
> >    compiling the kernel already with -mregparm=3D3. So the annotati=
on of
> >    the rwsem functions is redundant. Remove it.
>=20
> Ok, this bisect makes much more sense.
>=20
> Thomas, Peter, please revert d123375425d7df4b6081a631fc1203fceafa59b2=
=2E
> We cannot compile UML with -mregparm=3D3 it would cause a lot of trou=
ble.
> It would break 32bit UML on 64bit and also on older 32bit systems lik=
e RHEL5.

But why?=20

Also, having to carry that asmregparm notation just for uml doesn't see=
m
worth the trouble.
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

