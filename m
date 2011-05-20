Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <201105191834.56577.toralf.foerster@gmx.de>
References: <201105191526.31904.toralf.foerster@gmx.de>
	<201105191834.56577.toralf.foerster@gmx.de>
Date: Fri, 20 May 2011 08:44:39 +0200
Message-ID: <BANLkTi=8NW9Q+8Q=kuUJY1L=FcQGapqDLA@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: kernel 2.6.39 (user mode linux) crashes (2.6.38 works fine)
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi,

a few more questions/ideas. :)

2011/5/19 Toralf F=F6rster <toralf.foerster@gmx.de>:
> FWIW I got :
>
> * Starting local

What is this "Starting local",
was UML crashing while starting your distro?

> Kernel panic - not syncing: Segfault with no mm
> 08335ed4: =A0[<082b0b3b>] dump_stack+0x22/0x24
> 08335eec: =A0[<082b0ba0>] panic+0x63/0x167
> 08335f14: =A0[<080614af>] segv+0x27f/0x2f0
> 08335fcc: =A0[<08061561>] segv_handler+0x41/0x60
> 08335fec: =A0[<08071da4>] sig_handler_common+0x44/0xb0
>
>
> EIP: 0000:[<00000000>] CPU: 0 Not tainted EFLAGS: 00000000
> =A0 =A0Not tainted
> EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
> ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 0000 ES: 0000
> 08335e88: =A0[<0807935d>] show_regs+0xed/0x120
> 08335ea4: =A0[<0806179c>] panic_exit+0x2c/0x50
> 08335eb4: =A0[<080a2b9c>] notifier_call_chain+0x4c/0x70
> 08335edc: =A0[<080a2c13>] atomic_notifier_call_chain+0x23/0x30
> 08335eec: =A0[<082b0bc8>] panic+0x8b/0x167
> 08335f14: =A0[<080614af>] segv+0x27f/0x2f0
> 08335fcc: =A0[<08061561>] segv_handler+0x41/0x60
> 08335fec: =A0[<08071da4>] sig_handler_common+0x44/0xb0
>
>
> and gdb gives in another session to reproduce the bug this:
>
> (gdb) c
> Continuing.

GDB stopped here and UML got SIGSEGV after you continued?
GDB has to ignore SIGSEGV. UML uses this signal to handle page faults.
type: handle SIGSEGV noprint nostop pass

I fear the backtrace is garbage.

Can you reproduce the issue using the default config?
Are you using hostfs?
What exactly is the output when it crashes? (Without GDB)

Your host's kernel ring buffer should contain a line like this one
after the crash:
linux[123]: segfault at 0 ip xxx sp xxx error 4 in linux[xxx+yyy]
Please share this line with me.

--=20
Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

