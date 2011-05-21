Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1306017456.18455.1.camel@twins>
References: <201105191526.31904.toralf.foerster@gmx.de>
	<1305907458.1465.23.camel@gandalf.stny.rr.com>
	<1305907896.1465.27.camel@gandalf.stny.rr.com>
	<201105210053.51314.toralf.foerster@gmx.de>
	<BANLkTinvtfpPr3GxKA49MN4y1q66HETorQ@mail.gmail.com>
	<1306017456.18455.1.camel@twins>
Date: Sun, 22 May 2011 01:06:46 +0200
Message-ID: <BANLkTinswk09M7bOup01EnrTNQycNbUMDw@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: kernel 2.6.39 (user mode linux) crashes (2.6.38 works fine)
To: Peter Zijlstra <peterz@infradead.org>
Cc: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>, Steven Rostedt <rostedt@goodmis.org>, Darren Hart <dvhart@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, May 22, 2011 at 12:37 AM, Peter Zijlstra <peterz@infradead.org>=
 wrote:
> On Sat, 2011-05-21 at 12:12 +0200, richard -rw- weinberger wrote:
>> 2011/5/21 Toralf F=F6rster <toralf.foerster@gmx.de>:
>> > Bisecting gave :
>> >
>> >
>> > git bisect badd123375425d7df4b6081a631fc1203fceafa59b2 is the firs=
t bad commit
>> > commit d123375425d7df4b6081a631fc1203fceafa59b2
>> > Author: Thomas Gleixner <tglx@linutronix.de>
>> > Date: =A0 Wed Jan 26 21:32:01 2011 +0100
>> >
>> > =A0 =A0rwsem: Remove redundant asmregparm annotation
>> >
>> > =A0 =A0Peter Zijlstra pointed out, that the only user of asmregpar=
m (x86) is
>> > =A0 =A0compiling the kernel already with -mregparm=3D3. So the ann=
otation of
>> > =A0 =A0the rwsem functions is redundant. Remove it.
>>
>> Ok, this bisect makes much more sense.
>>
>> Thomas, Peter, please revert d123375425d7df4b6081a631fc1203fceafa59b=
2.
>> We cannot compile UML with -mregparm=3D3 it would cause a lot of tro=
uble.
>> It would break 32bit UML on 64bit and also on older 32bit systems li=
ke RHEL5.
>
> But why?

Why reverting?
d123375 effectively reverts commit d50efc6c (x86: fix UML and -regparm=3D=
3).

> Also, having to carry that asmregparm notation just for uml doesn't s=
eem
> worth the trouble.
>

=46rankly, I don't know why exactly UML breaks without having asmregpar=
m.
I've seen this -regparm=3D3 thing today the very first time, I'll dig i=
nto it...

--=20
Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

