Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AszZb-0002yi-Sh
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 23:23:15 -0800
Received: from 101.24.177.216.inaddr.g4.net ([216.177.24.101] helo=sparrow.stearns.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AszPe-0004ss-8M
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 23:12:58 -0800
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Subject: Re: [uml-devel] Re: Diagnosed and repeatable kernel mode panic in
 schedule() for 2.6! 
In-Reply-To: <200402170446.i1H4kUsq026113@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.44.0402170216570.2428-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Tue, 17 Feb 2004 02:18:31 -0500 (EST)
To: Jeff Dike <jdike@addtoit.com>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>

Good morning, Jeff,

On Mon, 16 Feb 2004, Jeff Dike wrote:

> blaisorblade_spam@yahoo.it said:
> > while /bin/true ; do /bin/true ; done 
> 
> This turned out to be slightly subtle.  It was exposed by the 
> longjmp -> siglongjmp change.  New processes were created with signals 
> enabled, so siglongjmp to a new process context re-enabled signals in the
> middle of the context switch.
> 
> Try the patch below - it seems to fix things for me.
> 
> --- 1.9/arch/um/kernel/skas/process_kern.c      Thu Jan  8 07:43:01 2004
> +++ edited/arch/um/kernel/skas/process_kern.c   Sun Feb 15 10:42:31 2004
> @@ -76,6 +76,7 @@
>  
>  void new_thread_proc(void *stack, void (*handler)(int sig))
>  {
> +       local_irq_disable();
>         init_new_thread_stack(stack, handler);
>         os_usr1_process(os_getpid());
>  }

	I've put this up for the whoopis and cache vm's on Zaphod.  We'll 
see how things look in the morning.
	Thanks again for the help, Jeff.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"Nynex.  Iroquois for Moron"
	-- A well-known Linux kernel hacker.
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
