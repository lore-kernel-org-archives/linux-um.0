Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <renzo@cs.unibo.it>) id 1LhUwh-0005qX-IS
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Mar 2009 20:22:31 +0000
Received: from leb.cs.unibo.it ([130.136.1.102])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LhUwa-0007nC-Kf
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Mar 2009 20:22:31 +0000
Date: Wed, 11 Mar 2009 21:22:22 +0100
From: Renzo Davoli <renzo@cs.unibo.it>
Message-ID: <20090311202221.GB5419@cs.unibo.it>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] 2.6.29: IRQF_DISABLED is not guaranteed on shared IRQs
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
To: user-mode-linux-devel@lists.sourceforge.net

User-Mode Linux 2.6.29-rc* gives a lot of warnings during the boot:

IRQ 2/console: IRQF_DISABLED is not guaranteed on shared IRQs
IRQ 3/console-write: IRQF_DISABLED is not guaranteed on shared IRQs
IRQ 5/eth0: IRQF_DISABLED is not guaranteed on shared IRQs
IRQ 6/ssl: IRQF_DISABLED is not guaranteed on shared IRQs
IRQ 7/ssl-write: IRQF_DISABLED is not guaranteed on shared IRQs
IRQ 10/winch: IRQF_DISABLED is not guaranteed on shared IRQs
...

In fact there is a warning in kernel/irq/manage.c:682.
  if ((irqflags & (IRQF_SHARED|IRQF_DISABLED))
      == (IRQF_SHARED|IRQF_DISABLED))
    pr_warning("IRQ %d/%s: IRQF_DISABLED is not "
        "guaranteed on shared IRQs\n",
        irq, devname);

Jeff,
It is necessary to have IRQF_DISABLED for shared IRQs?
Can IRQF_DISABLED be switched off for all shared IRQ?
Given that the masking policy is not guaranteed already, nothing
should change, if it works it should continue to work.

VDE networking does not work on 2.6.29-rc*.
The patch here attached seems to fix the problem.
Is it correct to switch off the IRQF_DISABLED flag for networking IRQ?

	renzo
-----
--- arch/um/drivers/net_kern.c.orig     2009-03-11 21:16:36.000000000 +0100
+++ arch/um/drivers/net_kern.c  2009-03-11 21:16:46.000000000 +0100
@@ -165,7 +165,7 @@
        }
 
        err = um_request_irq(dev->irq, lp->fd, IRQ_READ, uml_net_interrupt,
-                            IRQF_DISABLED | IRQF_SHARED, dev->name, dev);
+                            IRQF_SHARED, dev->name, dev);
        if (err != 0) {
                printk(KERN_ERR "uml_net_open: failed to get irq(%d)\n", err);
                err = -ENETUNREACH;



------------------------------------------------------------------------------
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

