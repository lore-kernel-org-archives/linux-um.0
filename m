Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IxPPZ-00036J-DX for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 08:05:17 -0800
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IxPPW-0001CP-OA
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 08:05:17 -0800
Date: Wed, 28 Nov 2007 17:05:01 +0100
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20071128160501.GA7986@elte.hu>
References: <E1IxMK0-0006ae-2s@dorka.pomaz.szeredi.hu>
	<20071128125030.GB21791@elte.hu>
	<E1IxMfh-0006fN-HQ@dorka.pomaz.szeredi.hu>
	<20071128150840.GB5518@c2.user-mode-linux.org>
	<E1IxOzn-00075w-Gq@dorka.pomaz.szeredi.hu>
	<20071128154152.GA742@elte.hu>
	<E1IxPKU-00079S-UH@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1IxPKU-00079S-UH@dorka.pomaz.szeredi.hu>
Subject: Re: [uml-devel] -rt doesn't compile for UML
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

> > it doesnt need it - turn IRQOFF_TRACING off.
> 
> # CONFIG_CRITICAL_IRQSOFF_TIMING is not set
> 
> This seems to be off.
> 
> But latency_trace.c uses irqs_disabled_flags(), which is defined in 
> <linux/irqflags.h> only if CONFIG_TRACE_IRQFLAGS_SUPPORT is set.
> 
> So perhaps latency_trace.c should be using raw_irqs_disabled_flags() 
> instead.  But UML doesn't define that either and I have no idea how to 
> do that, so this is still not solved yet.

irqs_disabled_flags() gives us a nonessential bit of the trace output:

                 _------=> CPU#
                / _-----=> irqs-off
               | / _----=> need-resched
               || / _---=> hardirq/softirq
               ||| / _--=> preempt-depth
               |||| /
               |||||     delay
   cmd     pid ||||| time  |   caller
      \   /    |||||   \   |   /
 privoxy-12926 1.Ns1    0us : ktime_get_ts (ktime_get)
 privoxy-12926 1.Ns1    0us : getnstimeofday (ktime_get_ts)
 privoxy-12926 1.Ns1    1us : set_normalized_timespec (ktime_get_ts)
 privoxy-12926 1.Ns1    1us : rb_first (htb_dequeue)

it's the 'irqs-off' flag, which is 'd', 'D' or '.'.

so you can define irqs_off_flags to always-0 and you should be able to 
get pretty good traces still. It should have no functional impact.

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
