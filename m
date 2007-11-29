Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ixh5k-0000im-SE for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Nov 2007 02:58:00 -0800
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ixh5h-0001NP-QN
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Nov 2007 02:57:59 -0800
Date: Thu, 29 Nov 2007 11:57:44 +0100
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20071129105744.GI10577@elte.hu>
References: <E1IxMK0-0006ae-2s@dorka.pomaz.szeredi.hu>
	<20071128150637.GA5518@c2.user-mode-linux.org>
	<E1IxOwS-000752-HF@dorka.pomaz.szeredi.hu>
	<20071128182935.GA8048@c2.user-mode-linux.org>
	<E1IxRv7-0007e8-Dq@dorka.pomaz.szeredi.hu>
	<E1IxgUe-00011b-Sl@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1IxgUe-00011b-Sl@dorka.pomaz.szeredi.hu>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


* Miklos Szeredi <miklos@szeredi.hu> wrote:

> I can't say I'm understading these traces very well, but here's a 
> snippet that looks a bit strange.  I'm running 'while true; do date; 
> done' in parallel with the dd.
> 
> For some time it is doing 100% CPU as expected, then it goes into a 
> second or so of mosty idle (afaics), and then returns to the normal 
> pattern again.

try:

  echo 1 > /proc/sys/kernel/stackframe_tracing

to get symbolic stack backdumps for the wakeup points, and add 
trace_special_sym() calls to generate extra stackdump entries at 
arbitrary places. schedule() does not have it right now - it might make 
sense to add it.

also, enabling mcount:

 echo 1 > /proc/sys/kernel/mcount_enabled

will give you a _lot_ more verbose trace. Likewise:

 echo 1 > /proc/sys/kernel/syscall_tracing

(but for that you'd have to add the sys_call()/sys_ret() instrumentation 
that x86 has in entry_32.S)

but even this highlevel trace shows something weird:

> events/0-4     0.... 16044512us+: schedule <<idle>-0> (20 -5)
>   <idle>-0     0.... 16044564us!: schedule <events/0-4> (-5 20)
>   <idle>-0     0.Nh. 16076072us+: __trace_start_sched_wakeup <date-7133> (120 -1)
>   <idle>-0     0.Nh. 16076075us+: __trace_start_sched_wakeup <dd-6444> (120 -1)
>   <idle>-0     0.Nh. 16076078us+: __trace_start_sched_wakeup <kswapd0-33> (115 -1)
>       dd-6444  0.... 16076104us+: schedule <<idle>-0> (20 0)

how come UML idled for 30 msecs here, while the workload was supposed to 
be CPU-bound? It's not IO bound anywhere, right? No SMP artifacts 
either, right?

	Ingo

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
