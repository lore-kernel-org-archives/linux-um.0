Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <201105210053.51314.toralf.foerster@gmx.de>
References: <201105191526.31904.toralf.foerster@gmx.de>
	<1305907458.1465.23.camel@gandalf.stny.rr.com>
	<1305907896.1465.27.camel@gandalf.stny.rr.com>
	<201105210053.51314.toralf.foerster@gmx.de>
Date: Sat, 21 May 2011 12:12:27 +0200
Message-ID: <BANLkTinvtfpPr3GxKA49MN4y1q66HETorQ@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: kernel 2.6.39 (user mode linux) crashes (2.6.38 works fine)
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Darren Hart <dvhart@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

2011/5/21 Toralf F=F6rster <toralf.foerster@gmx.de>:
> Bisecting gave :
>
>
> git bisect badd123375425d7df4b6081a631fc1203fceafa59b2 is the first b=
ad commit
> commit d123375425d7df4b6081a631fc1203fceafa59b2
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date: =A0 Wed Jan 26 21:32:01 2011 +0100
>
> =A0 =A0rwsem: Remove redundant asmregparm annotation
>
> =A0 =A0Peter Zijlstra pointed out, that the only user of asmregparm (=
x86) is
> =A0 =A0compiling the kernel already with -mregparm=3D3. So the annota=
tion of
> =A0 =A0the rwsem functions is redundant. Remove it.

Ok, this bisect makes much more sense.

Thomas, Peter, please revert d123375425d7df4b6081a631fc1203fceafa59b2.
We cannot compile UML with -mregparm=3D3 it would cause a lot of troubl=
e.
It would break 32bit UML on 64bit and also on older 32bit systems like =
RHEL5.

--=20
Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

