Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1450299596-10780-1-git-send-email-vegard.nossum@oracle.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <5671E30A.8030207@nod.at>
Date: Wed, 16 Dec 2015 23:17:46 +0100
MIME-Version: 1.0
In-Reply-To: <1450299596-10780-1-git-send-email-vegard.nossum@oracle.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] uml: fix hostfs mknod()
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 16.12.2015 um 21:59 schrieb Vegard Nossum:
> An inverted return value check in hostfs_mknod() caused the function
> to return success after handling it as an error (and cleaning up).
> 
> It resulted in the following segfault when trying to bind() a named
> unix socket:
> 
>   Pid: 198, comm: a.out Not tainted 4.4.0-rc4
>   RIP: 0033:[<0000000061077df6>]
>   RSP: 00000000daae5d60  EFLAGS: 00010202
>   RAX: 0000000000000000 RBX: 000000006092a460 RCX: 00000000dfc54208
>   RDX: 0000000061073ef1 RSI: 0000000000000070 RDI: 00000000e027d600
>   RBP: 00000000daae5de0 R08: 00000000da980ac0 R09: 0000000000000000
>   R10: 0000000000000003 R11: 00007fb1ae08f72a R12: 0000000000000000
>   R13: 000000006092a460 R14: 00000000daaa97c0 R15: 00000000daaa9a88
>   Kernel panic - not syncing: Kernel mode fault at addr 0x40, ip 0x61077df6
>   CPU: 0 PID: 198 Comm: a.out Not tainted 4.4.0-rc4 #1
>   Stack:
>    e027d620 dfc54208 0000006f da981398
>    61bee000 0000c1ed daae5de0 0000006e
>    e027d620 dfcd4208 00000005 6092a460
>   Call Trace:
>    [<60dedc67>] SyS_bind+0xf7/0x110
>    [<600587be>] handle_syscall+0x7e/0x80
>    [<60066ad7>] userspace+0x3e7/0x4e0
>    [<6006321f>] ? save_registers+0x1f/0x40
>    [<6006c88e>] ? arch_prctl+0x1be/0x1f0
>    [<60054985>] fork_handler+0x85/0x90
> 
> Let's also get rid of the "cosmic ray protection" while we're at it.
> 
> Fixes: e9193059b1b3 "hostfs: fix races in dentry_name() and inode_name()"
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: stable@vger.kernel.org

Applied! :-)

BTW: How did you create this patch? I had to apply it by hand using -p0...
git am didn't like it.

Thanks,
//richard
