Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IxlvP-0007bF-Th for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Nov 2007 08:07:40 -0800
Received: from fxip-0047f.externet.hu ([88.209.222.127]
	helo=dorka.pomaz.szeredi.hu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IxlvP-0001in-3c
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Nov 2007 08:07:39 -0800
In-reply-to: <20071129105744.GI10577@elte.hu> (message from Ingo Molnar on
	Thu, 29 Nov 2007 11:57:44 +0100)
References: <E1IxMK0-0006ae-2s@dorka.pomaz.szeredi.hu>
	<20071128150637.GA5518@c2.user-mode-linux.org>
	<E1IxOwS-000752-HF@dorka.pomaz.szeredi.hu>
	<20071128182935.GA8048@c2.user-mode-linux.org>
	<E1IxRv7-0007e8-Dq@dorka.pomaz.szeredi.hu>
	<E1IxgUe-00011b-Sl@dorka.pomaz.szeredi.hu>
	<20071129105744.GI10577@elte.hu>
Message-Id: <E1Ixlv9-0001rb-U7@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Nov 2007 17:07:23 +0100
Subject: Re: [uml-devel] scheduling anomaly on uml (was: -rt doesn't compile
	for UML)
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: mingo@elte.hu
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

> > I can't say I'm understading these traces very well, but here's a 
> > snippet that looks a bit strange.  I'm running 'while true; do date; 
> > done' in parallel with the dd.
> > 
> > For some time it is doing 100% CPU as expected, then it goes into a 
> > second or so of mosty idle (afaics), and then returns to the normal 
> > pattern again.
> 
> try:
> 
>   echo 1 > /proc/sys/kernel/stackframe_tracing
> 
> to get symbolic stack backdumps for the wakeup points, and add 
> trace_special_sym() calls to generate extra stackdump entries at 
> arbitrary places. schedule() does not have it right now - it might make 
> sense to add it.

OK, this helped.

It looks like the delays are caused by the page allocator, and not
UML.  Which is good news, because I'm supposed to understand memory
management better than scheduling.

Thanks,
Miklos



    bash-504   0.... 6312803us!: schedule <kswapd0-33> (-5 0)
    bash-504   0.... 6313820us : userspace()<-fork_handler()<-<2f0a3670>()<-(    0)()
    bash-504   0.... 6313821us+: (    0)()<-(    0)()<-(    0)()<-(    0)()
    date-5726  0.... 6315334us+: pipe_read()<-do_sync_read()<-vfs_read()<-sys_read()
    date-5726  0.... 6315336us : handle_syscall()<-handle_trap()<-userspace()<-fork_handler()
    bash-504   0.... 6315340us!: schedule <date-5726> (0 0)
    bash-504   0.... 6315731us+: io_schedule_timeout()<-congestion_wait()<-throttle_vm_writeout()<-shrink_zone()
    bash-504   0.... 6315733us : shrink_zones()<-try_to_free_pages()<-__alloc_pages()<-do_wp_page()
  <idle>-0     0.... 6315738us!: schedule <bash-504> (0 20)
  <idle>-0     0.Nh. 6476223us+: __trace_start_sched_wakeup <bash-504> (120 -1)
  <idle>-0     0.Nh. 6476228us+: __trace_start_sched_wakeup <kswapd0-33> (115 -1)
  <idle>-0     0.Nh. 6476232us+: __trace_start_sched_wakeup <dd-5155> (120 -1)
  <idle>-0     0.... 6476256us+: cpu_idle()<-rest_init()<-start_kernel()<-start_kernel_proc()

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
