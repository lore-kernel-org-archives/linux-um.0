Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aswl2-0007Av-8T
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 20:22:52 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AswhA-0006aZ-BL
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 20:18:52 -0800
Message-Id: <200402170446.i1H4kUsq026113@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: Diagnosed and repeatable kernel mode panic in schedule() for 2.6! 
In-Reply-To: Your message of "Mon, 16 Feb 2004 20:25:24 +0100."
             <200402162025.24853.blaisorblade_spam@yahoo.it> 
References: <200402151911.11890.blaisorblade_spam@yahoo.it> <20040216095335.GA27377@elte.hu>  <200402162025.24853.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 16 Feb 2004 23:46:30 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>

blaisorblade_spam@yahoo.it said:
> while /bin/true ; do /bin/true ; done 

This turned out to be slightly subtle.  It was exposed by the 
longjmp -> siglongjmp change.  New processes were created with signals 
enabled, so siglongjmp to a new process context re-enabled signals in the
middle of the context switch.

Try the patch below - it seems to fix things for me.

				Jeff


--- 1.9/arch/um/kernel/skas/process_kern.c      Thu Jan  8 07:43:01 2004
+++ edited/arch/um/kernel/skas/process_kern.c   Sun Feb 15 10:42:31 2004
@@ -76,6 +76,7 @@
 
 void new_thread_proc(void *stack, void (*handler)(int sig))
 {
+       local_irq_disable();
        init_new_thread_stack(stack, handler);
        os_usr1_process(os_getpid());
 }



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
