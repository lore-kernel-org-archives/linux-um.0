Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CCha1-0000hz-N9 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Sep 2004 09:45:25 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CCha0-00018R-Id for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Sep 2004 09:45:25 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [uml-devel] Minor problems with interrupted systemcalls 
Message-ID: <8B6FF516CBA0194AB0996705076B02520F7C3D@ABGEX01E.abg.fsc.net>
From: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
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
Date: Wed, 29 Sep 2004 18:34:14 +0200
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

Jeff Dike <jdike@addtoit.com> said:
> OK, following is my breakup of your signal patch.  It all looks right
to me, and cleans up that code nicely.  Let me know if you see any
problems here.
> 
> These are also available from the incremental patches page
> 	http://user-mode-linux.sourceforge.net/patches.html
> and I would appreciate testing.
> 
> This one changes the do_signal interface to eliminate its argument.
Also, remove the calls from the system call handlers since they are
redundant.  In > all cases, pending signals are checked for in the
interrupt handler.
> Temporarily, do_signal passes the current error to kern_do_signal.
> 
> 				Jeff

Thank you.

I've tested the patches. AFAICS it works well.
A small piece of code regarding SA_ONESHOT should be removed only. In
2.6.9 this is done in get_signal_to_deliver(), and since
get_signal_to_deliver() writes a copy of the corresponding k_sigaction
into caller's ka_copy, it is a real NOOP.

Still, there is something wrong with error handling in case, that a
signal handler couldn't be started (i.E. stack limit reached or signal
stack invalid). This is a problem not only for UML, but with i386, too.
I will try to fix it for UML with separate patches.

Bodo


--- orig/arch/um/kernel/signal_kern.c	2004-09-29 18:15:46.505334183
+0200
+++ new/arch/um/kernel/signal_kern.c	2004-09-29 18:16:37.813855152
+0200
@@ -88,9 +88,6 @@
 					    (unsigned long)
ka->sa.sa_handler,
 					    restorer, regs, oldset);
 
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
-
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked, &current->blocked, 


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
