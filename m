Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AxCel-0002Xo-MJ for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Feb 2004 14:09:59 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AxCTy-0001s6-Tn
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Feb 2004 13:58:51 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20040228222842.GA7716@ccure.user-mode-linux.org>
References: <200402281541.05497.blaisorblade_spam@yahoo.it>
	<20040228171309.GA7043@ccure.user-mode-linux.org>
	<200402282136.31552.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402282136.31552.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: And the BUG of skas-2.6 with SMP active?
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
Date: Sat, 28 Feb 2004 17:28:42 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: Ingo Molnar <mingo@elte.hu>, user-mode-linux-devel@lists.sourceforge.net

On Sat, Feb 28, 2004 at 09:36:31PM +0100, BlaisorBlade wrote:
> Ok, good diagnosys. So *in this* case activate_mm must be called somewhere. 
> But not in sys_ptrace, because that runs in process context, and would 
> activate the mm for "current", which cannot be the child.

Yup, right.

> Also, if the temporary HIGHMEM mappings created by kmap are stored in 
> current->active_mm, then we cannot even change the kernel thread active_mm 
> (it would also be difficult anyway, since you need to suspend it).

No one is proposing that.

> So, since I guess that CONFIG_SMP=n means the cpu_tlbstate does not exist, I 
> would propose this change in include/asm-i386/mmu_context.h:switch_mm() (and 
> removing the BUG_ON line since that could not any more be triggered):
> 
>          int cpu = smp_processor_id();
> +#ifdef CONFIG_SMP
> +       prev = cpu_tlbstate[cpu].active_mm;
> +#endif
>          if (likely(prev != next)) {

That looks reasonable with a quick look at the code.  You're forcing it into
the address-space-changed case, which is right.

				Jeff


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
