Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZDbK-0007I5-HY for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 11:23:50 -0800
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CZDbJ-00009j-C7 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 11:23:50 -0800
Message-ID: <41ACC8BC.6050507@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: 2.6.9-bb3 creates zombie threads in SKAS
References: <000901c4d0e1$e7f998d0$0201a8c0@hawk>
	<200411222346.36960.blaisorblade_spam@yahoo.it>
	<001001c4d184$ca00b9f0$0201a8c0@hawk>
	<241401c4d70e$38b53450$0201a8c0@hawk>
In-Reply-To: <241401c4d70e$38b53450$0201a8c0@hawk>
Content-Type: multipart/mixed; boundary="------------090406060009000104090208"
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
Date: Tue, 30 Nov 2004 20:23:40 +0100
To: "Christopher S. Aker" <caker@theshore.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade_spam@yahoo.it>, dopez <lists@dopez.xs4all.nl>

This is a multi-part message in MIME format.
--------------090406060009000104090208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Christopher S. Aker wrote:
> I've been able to narrow this down to the "signal-delivery" patch.  2.6.10-rc2-mm3
> without the patch is fine, whereas adding the signal-delivery patch and you'll get
> mysql zombies inside the UML.  This happens on a variety of hosts, including
> 2.6.10-rc2-bk7 + skas-v7.
> 
> I just noticed 2.6.10-rc2-mm4 is out, and the patch there is named
> "uml-redo-the-signal-delivery-mechanism.patch".
> 
> -Chris
> 
Have found a bug in the signal-delivery patch a few days ago.
Could you please try the appended patch? (It's relevant for usage of RTSIGs
only, don't know, whether this could help you)

Bodo

--------------090406060009000104090208
Content-Type: text/x-diff;
 name="extramask.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="extramask.patch"


From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Restoring of current->blocked in sys_sigreturn is wrong.
The first (long ) of the mask correctly is fetched from sc->oldmask.
The further longs again come from there, but correctly should be
taken from frame->extramask.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---


diff -puN arch/um/sys-i386/signal.c~extramask arch/um/sys-i386/signal.c
--- linux-2.6.10-rc2/arch/um/sys-i386/signal.c~extramask	2004-11-26 14:03:10.770096974 +0100
+++ linux-2.6.10-rc2-root/arch/um/sys-i386/signal.c	2004-11-26 14:11:03.264403385 +0100
@@ -307,11 +307,12 @@ long sys_sigreturn(struct pt_regs regs)
 	struct sigframe __user *frame = (struct sigframe *)(sp - 8);
 	sigset_t set;
 	struct sigcontext __user *sc = &frame->sc;
-	unsigned long __user *mask = &sc->oldmask;
+	unsigned long __user *oldmask = &sc->oldmask;
+	unsigned long __user *extramask = &frame->extramask;
 	int sig_size = (_NSIG_WORDS - 1) * sizeof(unsigned long);
 
-	if(copy_from_user(&set.sig[0], mask, sizeof(&set.sig[0])) ||
-	   copy_from_user(&set.sig[1], mask, sig_size))
+	if(copy_from_user(&set.sig[0], oldmask, sizeof(&set.sig[0])) ||
+	   copy_from_user(&set.sig[1], extramask, sig_size))
 		goto segfault;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
_

--------------090406060009000104090208--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
