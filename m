Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZzkRB-0008J8-M6
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 12:05:09 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZzkRA-0001It-G1
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 12:05:09 +0000
Received: from tun252.maui-covenant.sigsegv.cx ([192.168.17.6]
	helo=smaug.kot-begemot.co.uk) by ivanoab4.miniserver.com with esmtps
	(TLS1.2:RSA_AES_128_CBC_SHA1:128) (Exim 4.80)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZzkR3-0008Jt-Tc
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 12:05:01 +0000
Received: from monstrousnightmare.kot-begemot.co.uk ([192.168.3.80])
	by smaug.kot-begemot.co.uk with esmtp (Exim 4.84)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1ZzkR3-0000MB-Nl
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 12:05:01 +0000
Message-ID: <564F0C6D.8000806@kot-begemot.co.uk>
Date: Fri, 20 Nov 2015 12:05:01 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
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
Subject: [uml-devel] IRQ handler reentrancy
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

I have gotten to the bottom of this.

1. The IRQ handler re-entrancy issue predates the timer patch. Adding a 
simple guard with a WARN_ON_ONCE around the device loop in the 
sig_io_handler catches it in plain 4.3

diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 23cb935..ac0bbce 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -30,12 +30,17 @@ static struct irq_fd **last_irq_ptr = &active_fds;

  extern void free_irqs(void);

+static int in_poll_handler = 0;
+
  void sigio_handler(int sig, struct siginfo *unused_si, struct 
uml_pt_regs *regs)
  {
         struct irq_fd *irq_fd;
         int n;

+    WARN_ON_ONCE(in_poll_handler == 1);
+
         while (1) {
+        in_poll_handler = 1;
                 n = os_waiting_for_events(active_fds);
                 if (n <= 0) {
                         if (n == -EINTR)
@@ -51,6 +56,7 @@ void sigio_handler(int sig, struct siginfo *unused_si, 
struct uml_pt_regs *regs)
                         }
                 }
         }
+    in_poll_handler = 0;

         free_irqs();
  }

This is dangerously broken - you can under heavy IO exhaust the stack, 
you can get packets out of order, etc. Most IO is reasonably atomic so 
corruption is not likely, but not impossible (especially if one or more 
drivers are optimized to use multi-read/multi-write).

2. I cannot catch what is wrong with the current code in signal.c. When 
I read it, it should not produce re-entrancy. But it does.

3. I found 2-3 minor issues with signal handling and the timer patch 
which I will submit a hot-fix for, including a proper fix for the 
hang-in-sleep issue.

4. While I can propose a brutal patch for signal.c which sets guards 
against reentrancy which works fine, I suggest we actually get to the 
bottom of this. Why the code in unblock_signals() does not guard 
correctly against that?

A.

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

