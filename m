Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUnRS-00024c-SL for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2004 06:39:22 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CUnRR-0007Do-RD for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2004 06:39:22 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Patchset to implement PTRACE_SYSEMU_SINGLESTEP
References: <419517A4.7020700@fujitsu-siemens.com>
	<200411180647.iAI6lSQ3008451@ccure.user-mode-linux.org>
	<419CAF81.9010408@fujitsu-siemens.com>
In-Reply-To: <419CAF81.9010408@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200411181541.13171.blaisorblade_spam@yahoo.it>
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
Date: Thu, 18 Nov 2004 15:41:12 +0100
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>

On Thursday 18 November 2004 15:19, Bodo Stroesser wrote:
> Jeff Dike wrote:
> > bstroesser@fujitsu-siemens.com said:
> >>What happens on my system shows some other symptoms. After "Restarting
> >>system." UML exits without further message. I could track this down to
> >>a SIGIO being unblocked immediately before the execvp(). It is handled
> >>by sig_handler() that calls sig_handler_common_skas(). Why this exits,
> >>I don't know.

> > Try this patch.  It adds the missing closes that you found today, plus it
> > makes sure that netdevices get closed down correctly.

> >     Jeff

> Yes. I've tested and mostly it works fine. Only one litte change is needed
> to have the daemon-network working after "network stop" and "network
> start". I commented it in the patch.
You mean restarting network support in the guest, right?

>          Bodo

> > Index: 2.6.9/arch/um/drivers/net_kern.c
> > ===================================================================
> > --- 2.6.9.orig/arch/um/drivers/net_kern.c 2004-11-17 22:25:19.000000000
> > -0500 +++ 2.6.9/arch/um/drivers/net_kern.c 2004-11-17 23:18:21.000000000
> > -0500 @@ -126,10 +126,6 @@
> >   lp->tl.data = (unsigned long) &lp->user;
> >   netif_start_queue(dev);
> >
> > - spin_lock(&opened_lock);
> > - list_add(&lp->list, &opened);
> > - spin_unlock(&opened_lock);
> > -
> >   /* clear buffer - it can happen that the host side of the interface
> >    * is full when we get here.  In this case, new data is never queued,
> >    * SIGIOs never arrive, and the net never works.
> > @@ -150,11 +146,10 @@
> >
> >   free_irq_by_irq_and_dev(dev->irq, dev);

> A little question: what about the "free_irq_by_irq_and_dev"? In my sources
> they are missing, and I couldn't find a patch relating this. My daemon
> works without it.

Use the 2.6.10-rc2 tree and you should find that - it's an update for IRQ 
handling changes in 2.6.10, i.e. the creation of generic IRQ support, in 
kernel/irq/*, merged by Ingo Molnar.

From arch/i386/kernel/irq.c:

/*
 * (mostly architecture independent, will move to kernel/irq.c in 2.5.)
 */
Well, Ingo Molnar did this. Other archs are not forced to upgrade to the new 
code, but UML was borrowing the i386 headers, which got converted, so we had 
no choice.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
