Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <201105211054.00553.toralf.foerster@gmx.de>
References: <201105191526.31904.toralf.foerster@gmx.de>
	<1305907896.1465.27.camel@gandalf.stny.rr.com>
	<201105210053.51314.toralf.foerster@gmx.de>
	<201105211054.00553.toralf.foerster@gmx.de>
Date: Mon, 23 May 2011 21:17:31 +0200
Message-ID: <BANLkTikQozc+rr9Meihft_avOJf=iMAGdw@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: kernel 2.6.39 (user mode linux) crashes (2.6.38 works fine)
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Darren Hart <dvhart@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

2011/5/21 Toralf F=F6rster <toralf.foerster@gmx.de>:
>
> Toralf F=F6rster wrote at 00:53:50
>> Bisecting gave :
>>
>>
>> git bisect badd123375425d7df4b6081a631fc1203fceafa59b2 is the first =
bad
>> commit commit d123375425d7df4b6081a631fc1203fceafa59b2
>> Author: Thomas Gleixner <tglx@linutronix.de>
>> Date: =A0 Wed Jan 26 21:32:01 2011 +0100
>>
>> =A0 =A0 rwsem: Remove redundant asmregparm annotation
>>
>> =A0 =A0 Peter Zijlstra pointed out, that the only user of asmregparm=
 (x86) is
>> =A0 =A0 compiling the kernel already with -mregparm=3D3. So the anno=
tation of
>> =A0 =A0 the rwsem functions is redundant. Remove it.
>
> BTW I double checked that this commit is the culprit of the hang - it=
 is.
> Furthermore I added these kernel config options :

Toralf,

does this patch fix your problem?
http://userweb.kernel.org/~rw/rwsem.diff

Please do a make clean before rebuilding...

--=20
Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

