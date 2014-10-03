Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1Xa0Pq-000350-4O
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Oct 2014 10:48:50 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xa0Pm-0001uo-N6
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Oct 2014 10:48:50 +0000
Message-ID: <1412333319.14180.22.camel@localhost.localdomain>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Fri, 03 Oct 2014 12:48:39 +0200
In-Reply-To: <CAFLxGvzAru4dCcAkxMeUVyWYfK8x1dYA4X5dO3g7q8D-iZqBNg@mail.gmail.com>
References: <1412292073.14180.16.camel@localhost.localdomain>
	<CAFLxGvzAru4dCcAkxMeUVyWYfK8x1dYA4X5dO3g7q8D-iZqBNg@mail.gmail.com>
Mime-Version: 1.0
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] panic() call from non-kernel stack in uml_postsetup
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Am Freitag, den 03.10.2014, 10:17 +0200 schrieb Richard Weinberger:
> On Fri, Oct 3, 2014 at 1:21 AM, Thomas Meyer <thomas@m3y3r.de> wrote:
> > Hi,
> >
> > When you pass an initrd to UML and the size of the initrd is too big for
> > the current kernel memory, a panic() call is done with the message("Out
> > of memory").
> >
> > But this message never hits the stdout as the following stack trace
> > dumps because there is no current_thread_info() in the UML stack, which
> > is still active at this time:
> 
> Do you see the message if you boot UML with the earlyprintk parameter?

No it doesn't. The UML kernel crashes will trying to print the stack
trace.

I tried this drop in arch/um/kernel/dump_stack.c:

#include <linux/kernel.h>
#include <linux/export.h>
#include <linux/sched.h>
#include <linux/smp.h>
#include <linux/atomic.h>
#include <kern_util.h>

void dump_stack(void)
{
    struct thread_info* ti = current_thread_info();
    if(is_kernel_addr(ti)) {
	    dump_stack_print_info(KERN_DEFAULT);
	    show_stack(NULL, NULL);
	} else {
	    printk(KERN_CRIT "Dump_stack from non-kernel stack!\n");
	}
}

EXPORT_SYMBOL(dump_stack);


But this doesn't help as UML will crash then in kernel/panic.c while
trying to call atomic_notifier_call_chain(&panic_notifier_list, 0, buf);

I think the root cause is that current_thread_info() returns an invalid
thread_info. The proper fix would be to also have the UML stack an valid
thread_info at the begin of the stack, pointing to init_thread_info.

but don't know how to do this.

what do you think about this?

with kind regards
thomas


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

