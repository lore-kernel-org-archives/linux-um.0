Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IyBnH-0005i8-UR for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Nov 2007 11:45:00 -0800
Received: from fxip-0047f.externet.hu ([88.209.222.127]
	helo=dorka.pomaz.szeredi.hu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IyBnG-00040C-At
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Nov 2007 11:44:59 -0800
In-reply-to: <20071129170205.GA7415@c2.user-mode-linux.org> (message from Jeff
	Dike on Thu, 29 Nov 2007 12:02:05 -0500)
References: <E1IxMK0-0006ae-2s@dorka.pomaz.szeredi.hu>
	<20071128150637.GA5518@c2.user-mode-linux.org>
	<E1IxOwS-000752-HF@dorka.pomaz.szeredi.hu>
	<20071128182935.GA8048@c2.user-mode-linux.org>
	<E1IxRv7-0007e8-Dq@dorka.pomaz.szeredi.hu>
	<E1IxgUe-00011b-Sl@dorka.pomaz.szeredi.hu>
	<20071129170205.GA7415@c2.user-mode-linux.org>
Message-Id: <E1IyBmq-0005t7-Re@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 30 Nov 2007 20:44:32 +0100
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
To: jdike@addtoit.com
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Found some interesting things, the delays are caused by

 1) throttle_vm_writeout()

     I removed it, Andrew worries about that, but hopefully there's a
     better solution to his worries

 2) atime updates

     my uml image did not have them turned off

 3) UML timer tick does not seem very reliable, here's what the below
    patch outputs during writing.  It shows the delay between ticks in
    milliseconds:

[42949415.110000] zzz - 267
[42949415.120000] zzz - 862
[42949415.130000] zzz - 71
[42949415.140000] zzz - 599
[42949415.170000] zzz - 3746
[42949415.190000] zzz - 2961
[42949415.200000] zzz - 3272
[42949415.210000] zzz - 253
[42949415.220000] zzz - 1692
[42949415.230000] zzz - 823
[42949415.280000] zzz - 344
[42949415.310000] zzz - 224

I guess, the ubd interrupts confuse the timekeeping somehow, but the
details are unclear.

Miklos


Index: linux/arch/um/kernel/time.c
===================================================================
--- linux.orig/arch/um/kernel/time.c	2007-11-30 20:19:17.000000000 +0100
+++ linux/arch/um/kernel/time.c	2007-11-30 20:21:24.000000000 +0100
@@ -23,6 +23,12 @@ unsigned long long sched_clock(void)
 void timer_handler(int sig, struct uml_pt_regs *regs)
 {
 	unsigned long flags;
+	static long long last;
+	long long now = os_nsecs() / 1000000;
+
+	if (now - last > 50)
+		printk("zzz - %lli\n", now-last);
+	last = now;
 
 	local_irq_save(flags);
 	do_IRQ(TIMER_IRQ, regs);

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
