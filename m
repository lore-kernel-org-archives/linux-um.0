Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.92] (helo=sc8-sf-mx2-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DnHwp-0000oQ-Pi	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Jun 2005 08:24:27 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx2-new.sourceforge.net with esmtp (Exim 4.44)
	id 1DnHwo-0005Qo-CY	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Jun 2005 08:24:27 -0700
Message-ID: <42C16BA1.4060902@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Kernel panic in dump fpu with 2.6.11.11
References: <6028.1119969442@www81.gmx.net>
In-Reply-To: <6028.1119969442@www81.gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 28 Jun 2005 17:24:17 +0200
To: Dominik Vogt <dominik.vogt@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

Dominik Vogt wrote:
> When I run a certain mulithreaded application in a virtual
> machine, I get a UML kernel panic.  The host and the VM are both
> running Debian-3.1r0a (sarge) on i386.  The application gets a
> SIGSEGV after a couple of seconds and generates a core dump.  In
> this process, the UML kernel panics un the dump_fpu() function at
> position 0x61 with a NULL pointer reference:
> 
>   C: (ptrace.c, line 333, inline function copy_fpu_fxsave_tt)
>   struct i387_fxsave_struct *fpu = SC_FXSR_ENV(PT_REGS_SC(regs));
> 
>   assembler: (eax being 0)
>   0xa0031b4d <dump_fpu+61>:       mov    0x4(%eax),%eax
> 
> I can prevent the kernel panic by commenting out the line
> 
>   copy_fpu_fxsave(regs, (struct user_i387_struct *) fpu);
> 
> in dump_fpu(), so that copy_fpu_fxsave_tt() is never called.  The
> application always coredumps in
> 
>   /lib/tls/libc.so.6(__clone+0x5a)[0x4026118a]
> 
> which I guess is part of the threading library in libc.  This
> crash is 100% reproducable.
The kernel panic in case UML/tt tries to core dump is a known bug.

The reason is host's kernel not providing the fp-regs in sigcontext,
of the SIGSEGV, if fp-regs were not used before the SIGSEGV happens.
In sigcontext the pointer to the fp-regs is NULL in this case, which
makes UML crash, as the pointer is used without a check.

	Bodo


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
