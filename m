Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jry9e-0006FR-9v for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2008 09:30:38 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jry9b-0007H1-Nw
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2008 09:30:38 -0700
Date: Fri, 2 May 2008 12:30:20 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080502163020.GB7843@c2.user-mode-linux.org>
References: <877iel7ljp.fsf@hades.wkstn.nix> <87ve256146.fsf@hades.wkstn.nix>
	<871w4sqxgv.fsf@hades.wkstn.nix>
	<20080428164443.GB9628@c2.user-mode-linux.org>
	<871w4n9fo8.fsf@hades.wkstn.nix>
	<20080501151351.GA6303@c2.user-mode-linux.org>
	<87prs57g4h.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87prs57g4h.fsf@hades.wkstn.nix>
Subject: Re: [uml-devel] actually useful backtrace from a CPU-chewing hang
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
To: Nix <nix@esperi.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, May 02, 2008 at 12:34:54AM +0100, Nix wrote:
> loki:/tmp# /usr/bin/ntpdate -bv hades
> 30 Apr 22:45:52 ntpdate[8833]: ntpdate 4.2.4p4@1.1520-o Fri Feb 22 18:37:11 UTC 2008 (1)
> 30 Apr 22:45:52 ntpdate[8833]: step time server 192.168.14.18 offset -5.728539 sec
> 
> so in effect yes :)
> 
> Hm. A five-second skip forwards via date --set works fine. A five-second
> skip *backwards*, and instant boom.

I tried both directions for the hell of it.

With your config, I'm seeing a hang until the system time catches up
to what UML thought it should have been in the first place.  But it's
only a few seconds, not forever.

However, stracing it did reveal a bogus interval trying to be set,
which the patch below fixes.  It doesn't cause any behavior change
here, so YMMV.

This includes the previous patch, which I think is a good idea anyway,
so back that out and drop this in its place.

			Jeff

Index: linux-2.6.22/arch/um/os-Linux/time.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/time.c	2008-04-24 13:21:28.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/time.c	2008-05-02 12:21:01.000000000 -0400
@@ -107,6 +107,10 @@ static void deliver_alarm(void)
 	unsigned long long this_tick = os_nsecs();
 	int one_tick = UM_NSEC_PER_SEC / UM_HZ;
 
+	/* Protection against the host's time going backwards */
+	if ((last_tick != 0) && (this_tick < last_tick))
+		this_tick = last_tick;
+
 	if (last_tick == 0)
 		last_tick = this_tick - one_tick;
 
@@ -149,6 +153,9 @@ static int after_sleep_interval(struct t
 		start_usecs = usec;
 
 	start_usecs -= skew / UM_NSEC_PER_USEC;
+	if (start_usecs < 0)
+		start_usecs = 0;
+
 	tv = ((struct timeval) { .tv_sec  = start_usecs / UM_USEC_PER_SEC,
 				 .tv_usec = start_usecs % UM_USEC_PER_SEC });
 	interval = ((struct itimerval) { { 0, usec }, tv });

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
