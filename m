Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <201105200937.15322.toralf.foerster@gmx.de>
References: <201105191526.31904.toralf.foerster@gmx.de>
	<201105192218.18261.toralf.foerster@gmx.de>
	<20110519204342.GA10792@home.goodmis.org>
	<201105200937.15322.toralf.foerster@gmx.de>
Date: Fri, 20 May 2011 09:56:02 +0200
Message-ID: <BANLkTik0oz6ppJvRpufaaiBL1pqcAxNHuA@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: kernel 2.6.39 (user mode linux) crashes (2.6.38 works fine)
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

2011/5/20 Toralf F=F6rster <toralf.foerster@gmx.de>:
> ...
> Kernel panic - not syncing: Kernel mode fault at addr 0x0, ip 0x80a9f=
6b

Looks like a NULL-pointer bug.
What code is at address 80a9f6b?
Use "objdump -d -S | less" to find it.
Please note, kernel binary and log message have to match!

> The file /var/log/messages of the UML says :
>
> 2011-05-20T09:33:03.455+02:00 n22_uml kernel: ------------[ cut here =
]------------
> 2011-05-20T09:33:03.455+02:00 n22_uml kernel: WARNING: at kernel/fute=
x.c:789 wake_futex+0x28/0x60()

Is this really 2.6.39?
Line 789 contains no WARN*().
http://lxr.linux.no/#linux+v2.6.39/kernel/futex.c#L789

--=20
Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

