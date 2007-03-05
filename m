Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOHsC-00088c-7Y for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 10:25:24 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HOHsA-0004Hu-51
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 10:25:24 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Mon, 5 Mar 2007 19:24:53 +0100
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1BG7Fbz3Y5WiV8z"
Message-Id: <200703051924.53821.blaisorblade@yahoo.it>
Subject: [uml-devel] 2.6.21-rc CONFIG_DEBUG_SHIRQ breaks UML
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

--Boundary-00=_1BG7Fbz3Y5WiV8z
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've seen UML 2.6.21-rc crashing at boot due to CONFIG_DEBUG_SHIRQ. Below I've 
written the diagnosis, without a resolution.

The problem is in mconsole_init() with CONFIG_DEBUG_SHIRQ - it registers the 
mconsole IRQ. CONFIG_DEBUG_SHIRQ triggers a fake IRQ at registration time, to 
catch device drivers not yet ready to handle the IRQ - but our 
mconsole_interrupt() handler calls recvfrom which never returns, after 
creating the socket.

This was introduced (as debug stuff) in commit 
a304e1b82808904c561b7b149b467e338c53fcce.

I thought that it was correct for UML to do this - but I just realized that 
SHIRQ means exactly that another device may register together with us, so 
spurious IRQs may happen coming from the other device. The fix is to remove 
IRQF_SHARED from registration, since it's not needed.

However, this cannot be done for other IRQs which may actually be shared, like 
the console IRQ (which is shared among multiple consoles). I noted this on an 
UML where only one getty is started, which is strange, however this message 
convinced me (just at a glance) that multiple IRQ were being registered.

IRQ handler type mismatch for IRQ 2
current handler: console
Call Trace:
60fd3b78:  [<6004ce5a>] setup_irq+0x1b2/0x1cf
60fd3ba8:  [<600133c4>] line_interrupt+0x0/0x26
60fd3bb8:  [<6004d06b>] request_irq+0xdc/0xfd
60fd3bf8:  [<6000d049>] um_request_irq+0x25/0x47
60fd3c28:  [<600139c8>] line_setup_irq+0x47/0x93
60fd3c78:  [<6001262c>] enable_chan+0x4b/0x59
60fd3c98:  [<60013a7a>] line_open+0x66/0xeb
60fd3cc8:  [<600120aa>] con_open+0x11/0x13
60fd3cd8:  [<60108cf6>] tty_open+0x14f/0x2ba

The proper fix there may be to avoid blocking on read (i.e. using 
O_NONBLOCK) - and in that case I'd suggest deferring it since it does not 
seem me a bug which can be actually hit.

However, I'm not sure about this. What do you think, Jeff?

Mconsole backtrace:
(gdb) where
#0  0x000000006017d165 in __recvfrom_nocancel () at swab.h:134
#1  0x00000000600186d7 in mconsole_get_request (fd=7, req=0x602e3ac0) 
at /home/paolo/Admin/kernel/6/VCS/linux-2.6.git/arch/um/drivers/mconsole_user.c:90
#2  0x00000000600175aa in mconsole_interrupt (irq=7, dev_id=0x602e3b50) at 
list.h:50
#3  0x000000006004d04d in request_irq (irq=9, handler=0x60017501 
<mconsole_interrupt>, irqflags=1, devname=0x60218252 "mconsole", dev_id=0x7)
    at /home/paolo/Admin/kernel/6/VCS/linux-2.6.git/kernel/irq/manage.c:550
#4  0x000000006000d049 in um_request_irq (irq=9, fd=7, type=0, 
handler=0x602e3b50 <req.1+144>, irqflags=524, devname=0xffffffffffffffff 
<Address 0xffffffffffffffff out of bounds>,
    dev_id=0x7) 
at /home/paolo/Admin/kernel/6/VCS/linux-2.6.git/arch/um/kernel/irq.c:374
#5  0x00000000600183c7 in mconsole_init () 
at /home/paolo/Admin/kernel/6/VCS/linux-2.6.git/arch/um/drivers/mconsole_kern.c:817
#6  0x00000000600007fb in do_initcalls () 
at /home/paolo/Admin/kernel/6/VCS/linux-2.6.git/init/main.c:672
#7  0x00000000600008d4 in do_basic_setup () 
at /home/paolo/Admin/kernel/6/VCS/linux-2.6.git/init/main.c:712
#8  0x000000006000094d in init (unused=0x7) 
at /home/paolo/Admin/kernel/6/VCS/linux-2.6.git/init/main.c:803
#9  0x000000006001e77b in run_kernel_thread (fn=0x600008e6 <init>, arg=0x0, 
jmp_ptr=0x20c) 
at /home/paolo/Admin/kernel/6/VCS/linux-2.6.git/arch/um/os-Linux/process.c:292
#10 0x0000000060011343 in new_thread_handler () at thread_info.h:46

Original commit:

Commit: a304e1b82808904c561b7b149b467e338c53fcce
Author: David Woodhouse <dwmw2@infradead.org> Mon, 12 Feb 2007 00:52:00 -0800

    [PATCH] Debug shared irqs

    Drivers registering IRQ handlers with SA_SHIRQ really ought to be able to
    handle an interrupt happening before request_irq() returns.  They also
    ought to be able to handle an interrupt happening during the start of 
their
    call to free_irq().  Let's test that hypothesis....

-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_1BG7Fbz3Y5WiV8z
Content-Type: text/x-diff; charset="us-ascii";
	name="bogus-fix-other-shared-irqs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="bogus-fix-other-shared-irqs.patch"

Various other bogus IRQF_SHARED removals. The console IRQ is actually shared
with itself on other consoles, the network IRQ may be shared with other network
interfaces, 

Index: linux-2.6.git/arch/um/drivers/line.c
===================================================================
--- linux-2.6.git.orig/arch/um/drivers/line.c
+++ linux-2.6.git/arch/um/drivers/line.c
@@ -404,7 +404,7 @@ static irqreturn_t line_write_interrupt(
 int line_setup_irq(int fd, int input, int output, struct line *line, void *data)
 {
 	const struct line_driver *driver = line->driver;
-	int err = 0, flags = IRQF_DISABLED | IRQF_SHARED | IRQF_SAMPLE_RANDOM;
+	int err = 0, flags = IRQF_DISABLED | IRQF_SAMPLE_RANDOM;
 
 	if (input)
 		err = um_request_irq(driver->read_irq, fd, IRQ_READ,
@@ -803,7 +803,7 @@ void register_winch_irq(int fd, int tty_
 	spin_unlock(&winch_handler_lock);
 
 	if(um_request_irq(WINCH_IRQ, fd, IRQ_READ, winch_interrupt,
-			  IRQF_DISABLED | IRQF_SHARED | IRQF_SAMPLE_RANDOM,
+			  IRQF_DISABLED | IRQF_SAMPLE_RANDOM,
 			  "winch", winch) < 0)
 		printk("register_winch_irq - failed to register IRQ\n");
 }
Index: linux-2.6.git/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.git.orig/arch/um/drivers/net_kern.c
+++ linux-2.6.git/arch/um/drivers/net_kern.c
@@ -128,7 +128,7 @@ static int uml_net_open(struct net_devic
 	}
 
 	err = um_request_irq(dev->irq, lp->fd, IRQ_READ, uml_net_interrupt,
-			     IRQF_DISABLED | IRQF_SHARED, dev->name, dev);
+			     IRQF_DISABLED, dev->name, dev);
 	if(err != 0){
 		printk(KERN_ERR "uml_net_open: failed to get irq(%d)\n", err);
 		err = -ENETUNREACH;

--Boundary-00=_1BG7Fbz3Y5WiV8z
Content-Type: text/x-diff; charset="us-ascii";
	name="fix-mconsole-wrong-shared-irq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fix-mconsole-wrong-shared-irq.patch"

uml: make various UML not shared

If another device shared the IRQ with this one we could get spurious IRQs. Since
mconsole_interrupt() calls recvfrom() and hangs when no message is received,
this is bogus.
In fact, under CONFIG_DEBUG_SHIRQ, it causes an hang at boot.

Likewise, various other IRQs cause similar hang, but those IRQ can be actually
shared.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.git.orig/arch/um/drivers/mconsole_kern.c
+++ linux-2.6.git/arch/um/drivers/mconsole_kern.c
@@ -815,7 +815,7 @@ static int mconsole_init(void)
 	register_reboot_notifier(&reboot_notifier);
 
 	err = um_request_irq(MCONSOLE_IRQ, sock, IRQ_READ, mconsole_interrupt,
-			     IRQF_DISABLED | IRQF_SHARED | IRQF_SAMPLE_RANDOM,
+			     IRQF_DISABLED | IRQF_SAMPLE_RANDOM,
 			     "mconsole", (void *)sock);
 	if (err){
 		printk("Failed to get IRQ for management console\n");

--Boundary-00=_1BG7Fbz3Y5WiV8z
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_1BG7Fbz3Y5WiV8z
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--Boundary-00=_1BG7Fbz3Y5WiV8z--
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 

