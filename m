Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <AANLkTi=e+tM-WTerLmkZfLTQqKCLsJHVBgQ5sj+TMjc4@mail.gmail.com>
References: <AANLkTi=e+tM-WTerLmkZfLTQqKCLsJHVBgQ5sj+TMjc4@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Thu, 17 Mar 2011 10:08:56 -0400
Message-ID: <1300370936.16880.96.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: um: WARNING: at kernel/futex.c:786 __unqueue_futex
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: laijs@cn.fujitsu.com, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, dvhart@linux.intel.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, 2011-03-17 at 13:25 +0100, richard -rw- weinberger wrote:
> Lai,
> 
> Your commit 2e12978a
> (futex,plist: Pass the real head of the priority list to plist_del())
> triggers gazillions warnings on User Mode Linux (x86, Linus' tree as of today):
> 
> ------------[ cut here ]------------
> WARNING: at kernel/futex.c:786 __unqueue_futex+0x12/0x16()
> Modules linked in:
> 27d4cce8:  [<081c13fe>] dump_stack+0x1c/0x20
> 27d4cd00:  [<08071aa0>] warn_slowpath_common+0x49/0x5f
> 27d4cd18:  [<08071acb>] warn_slowpath_null+0x15/0x19
> 27d4cd28:  [<0808fdb8>] __unqueue_futex+0x12/0x16
> 27d4cd38:  [<0808fef3>] futex_wait+0x137/0x1ed
> 27d4cdd0:  [<080910c3>] do_futex+0x78/0x7c4
> 27d4cedc:  [<080918e6>] sys_futex+0xd7/0xed
> 27d4cf28:  [<0805abf6>] handle_syscall+0x7a/0x98
> 27d4cf78:  [<080685d9>] userspace+0x2c9/0x370
> 27d4cfe0:  [<08058be5>] fork_handler+0x53/0x5b
> 27d4cffc:  [<00000000>] 0x0
> 
> ---[ end trace ed7709f235f82328 ]---
> 
> !spin_is_locked(q->lock_ptr) in the WARN_ON() at line 786
> triggers the warnings.

Crap, I bet you are running CONFIG_SMP=n. I'll test this. We may need to
make that a WARN_ON_SMP().

-- Steve

> 
> I'm not sure whether this shows a bug within UML
> or the WARN_ON() is wrong.
> 
> What do you think?
> 


