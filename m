Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ARLLN-0003MB-8f
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 16:58:17 -0800
Received: from pacific.moreton.com.au ([203.143.235.130] helo=dorfl.internal.moreton.com.au)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1ARLLM-00071o-At
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Dec 2003 16:58:16 -0800
Received: from snapgear.com (steveb1.sw.moreton.com.au [10.1.9.1])
	by dorfl.internal.moreton.com.au (8.12.8/8.12.9) with ESMTP id hB30w3dN084287
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 3 Dec 2003 10:58:03 +1000 (EST)
	(envelope-from steveb@snapgear.com)
Message-ID: <3FCD351B.4090104@snapgear.com>
From: Steve Bennett <steveb@snapgear.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030603060102060703050102"
Subject: [uml-devel] [PATCH] fix for reboot panic
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
Date: Wed, 03 Dec 2003 10:58:03 +1000
To: user-mode-linux-devel@lists.sourceforge.net


This is a multi-part message in MIME format.
--------------030603060102060703050102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

With a certain configuration, when I run con=xterm
rebooting a UML instance causes a panic.
This is against 2.4.22-6

I traced this to the following problem.

During reboot, close_chan() is called to close all the vty channels.
When a channel is connected to an xterm, this involves killing the
xterm process, which generates a SIGINT on the channel.
This causes chan_interrupt() to close the channel itself, calling close_chan()
and then free_chan().
When the original close_chan() is resumed, the channel memory is now invalid.

The attached patch ensures that no access is required to the channel after
calling the channel close handler.

(gdb) where
#0  close_chan (chans=0xa0230088) at chan_kern.c:178
#1  0xa00bda49 in chan_interrupt (chans=0xa0230088, task=0xa02300bc,
     tty=0xa09b9000, irq=2, dev=0xa0230080) at chan_kern.c:495
#2  0xa00be298 in line_interrupt (irq=2, data=0xa0230080, unused=0xa3a98274)
     at line.c:28
#3  0xa007aa0e in handle_IRQ_event (irq=2, regs=0xa3a98274, action=0xa033efe0)
     at irq.c:160
#4  0xa007ac1f in do_IRQ (irq=2, regs=0xa3a98274) at irq.c:323
#5  0xa007b47c in sigio_handler (sig=29, regs=0xa3a98274) at irq_user.c:73
#6  0xa0086b4a in sig_handler_common_tt (sig=29, sc_ptr=0xa3a9b748)
     at trap_user.c:37
#7  0xa0083023 in sig_handler (sig=29, sc=
       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh 
= 0, edi = 2745809964, esi = 33, ebp = 2745809468, esp = 2745809440,
#8  <signal handler called>
#9  0xa018de51 in kill ()
#10 0xa008ac72 in os_kill_process (pid=16800, reap_child=1) at process.c:87
#11 0xa00bba8c in xterm_close (fd=33, d=0xa037ce40) at xterm.c:159
#12 0xa00bccb6 in close_chan (chans=0xa0230088) at chan_kern.c:182
#13 0xa00be9bc in close_lines (lines=0xa0230080, nlines=8) at line.c:311
#14 0xa00bc74d in console_exit () at stdio_console.c:244
#15 0xa007d882 in do_uml_exitcalls () at process_kern.c:327
#16 0xa007e7ca in machine_restart (__unused=0x0) at reboot.c:47
#17 0xa00211df in sys_reboot (magic1=-18751827, magic2=672274793,
     cmd=19088743, arg=0xf) at sys.c:308
#18 0xa00857be in execute_syscall_tt (r=0xa3a98274) at syscall_kern.c:120
#19 0xa00857fe in syscall_handler_tt (sig=12, regs=0xa3a98274)
     at syscall_user.c:37
#20 0xa0086b4a in sig_handler_common_tt (sig=12, sc_ptr=0xa3a9bd28)
     at trap_user.c:37
#21 0xa0083023 in sig_handler (sig=12, sc=
       {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh 
= 0, edi = 4276215469, esi = 15, ebp = 2684354108, esp = 2684354028,
     at trap_user.c:101
(gdb)

-- 
Steve Bennett                 http://www.SnapGear.com/
steveb@snapgear.com           Custom Embedded Solutions + Security

--------------030603060102060703050102
Content-Type: text/plain;
 name="uml-reboot-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uml-reboot-fix.patch"

diff  -u linux-2.4.x/arch/um/drivers/chan_kern.c
--- linux-2.4.x/arch/um/drivers/chan_kern.c.orig
+++ linux-2.4.x/arch/um/drivers/chan_kern.c	2003-12-03 10:49:11.000000000 +1000
@@ -175,13 +175,21 @@
 	 * state.  Then, the first one opened will have the original state,
 	 * so it must be the last closed.
 	 */
-        for(ele = chans->prev; ele != chans; ele = ele->prev){
-                chan = list_entry(ele, struct chan, list);
-		if(!chan->opened) continue;
-		if(chan->ops->close != NULL)
-			(*chan->ops->close)(chan->fd, chan->data);
+	for(ele = chans->prev; ele != chans; ele = prev){
+		/* Note that the close function can trigger a signal
+		 * which will close this channel from under us, so
+		 * we need to do everything for the channel
+		 * before we call close */
+		int fd;
+		prev = ele->prev;
+
+		chan = list_entry(ele, struct chan, list);
+		if (!chan->opened) continue;
+		fd = chan->fd;
 		chan->opened = 0;
 		chan->fd = -1;
+		if(chan->ops->close != NULL)
+			(*chan->ops->close)(fd, chan->data);
 	}
 }
 

--------------030603060102060703050102--



-------------------------------------------------------
This SF.net email is sponsored by OSDN's Audience Survey.
Help shape OSDN's sites and tell us what you think. Take this
five minute survey and you could win a $250 Gift Certificate.
http://www.wrgsurveys.com/2003/osdntech03.php?site=8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
