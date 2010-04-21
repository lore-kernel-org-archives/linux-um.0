Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 21 Apr 2010 14:12:05 +0800
From: Amerigo Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 4/5] uml: i386: Avoid redefinition of NR_syscalls
Message-ID: <20100421061205.GC4467@cr0.nay.redhat.com>
References: <cover.1271713955.git.jan.kiszka@web.de>
 <3e07ad1a38e88a22d7298deb88a8f3962b101998.1271713955.git.jan.kiszka@web.de>
 <20100420101056.GC5317@cr0.nay.redhat.com>
 <4BCDE103.7080709@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BCDE103.7080709@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Amerigo Wang <xiyou.wangcong@gmail.com>, trivial@kernel.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Apr 20, 2010 at 07:14:43PM +0200, Jan Kiszka wrote:
>Amerigo Wang wrote:
>> On Mon, Apr 19, 2010 at 11:53:07PM +0200, Jan Kiszka wrote:
>>> The i386 subarch happens to pull in original NR_syscalls. Maybe we can
>>> make that work for all host arch, but for now just avoid the clash by
>>> using an all-upper-case name.
>>>
>> 
>> Where?
>
>Not sure if this answers your question:
>
>  CC      arch/um/kernel/skas/syscall.o
>/data/linux-2.6/arch/um/kernel/skas/syscall.c:13:1: warning:
>"NR_syscalls" redefined
>In file included from /data/linux-2.6/arch/x86/include/asm/unistd.h:3,
>                 from
>/data/linux-2.6/arch/um/sys-i386/shared/sysdep/syscalls.h:6,
>                 from /data/linux-2.6/arch/um/kernel/skas/syscall.c:10:
>/data/linux-2.6/arch/x86/include/asm/unistd_32.h:349:1: warning: this is
>the location of the previous definition
>

Ah, sure. I misunderstood your purpose, please do include the warning
messages you are trying to fix in your patch description.


Thanks!


