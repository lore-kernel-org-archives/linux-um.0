Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AxBIp-0004a5-GR for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Feb 2004 12:43:15 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AxB84-0000Qk-Vu for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 Feb 2004 12:32:09 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <200402281541.05497.blaisorblade_spam@yahoo.it>
	<20040228171309.GA7043@ccure.user-mode-linux.org>
In-Reply-To: <20040228171309.GA7043@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402282136.31552.blaisorblade_spam@yahoo.it>
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
Date: Sat, 28 Feb 2004 21:36:31 +0100
To: Jeff Dike <jdike@addtoit.com>, Ingo Molnar <mingo@elte.hu>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 18:13, sabato 28 febbraio 2004, Jeff Dike ha scritto:
> On Sat, Feb 28, 2004 at 03:41:05PM +0100, BlaisorBlade wrote:
> > "Sorry, are you sure? The child process is not running when ptrace() is
> > called,
> > and this holds even for PTRACE_SWITCH_MM (check ptrace_check_attach()).
> >
> > So, the child process is not running and activate_mm cannot be called
> > (maybe I do not understand activate_mm, but it's simply switch_mm, that
> > is called by schedule, so I think I guessed right)."
>
> Suppose it's an SMP box, and the UP UML is the only thing active on it. 
> The child process will indeed go to sleep as you say.  However, a kernel
> thread (the idle thread if nothing else) will run on that processor in the
> meantime.

> The thing about switching to a kernel thread is that it doesn't
> do a memory switch.  It uses leaves old process's address space in place. 
> That way, if that process wakes up and is the next thing to run, you've
> just saved two memory switches.

Yes, you speak about enter_lazy_tlb (I've read something from .

> So, in this case, the child will go to sleep, it will have its address
> space changed, and when it wakes back up, that address space will have not
> been properly activated because there was never a real memory switch.

Ok, good diagnosys. So *in this* case activate_mm must be called somewhere. 
But not in sys_ptrace, because that runs in process context, and would 
activate the mm for "current", which cannot be the child.

Also, if the temporary HIGHMEM mappings created by kmap are stored in 
current->active_mm, then we cannot even change the kernel thread active_mm 
(it would also be difficult anyway, since you need to suspend it).

So someone (not me, even if I'll try) must change the code for switching from 
a kernel thread to a userspace thread. It seems that "not properly activated" 
means that in switch_mm, at the BUG line, prev has been changed but 
cpu_tlbstate[cpu].active_mm has not. Also, it must not be changed (for the 
HIGHMEM problem above).

Normally, we have prev == cpu_tlbstate[cpu].active_mm; here prev instead has 
the wrong value, while cpu_tlbstate[cpu].active_mm is correct and the 
cpu_vm_mask (the only thing the code changes on prev) was changed on it and 
not on prev.

So, since I guess that CONFIG_SMP=n means the cpu_tlbstate does not exist, I 
would propose this change in include/asm-i386/mmu_context.h:switch_mm() (and 
removing the BUG_ON line since that could not any more be triggered):

         int cpu = smp_processor_id();
+#ifdef CONFIG_SMP
+       prev = cpu_tlbstate[cpu].active_mm;
+#endif
         if (likely(prev != next)) {

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
