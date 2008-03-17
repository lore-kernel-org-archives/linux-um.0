Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JbIkf-0000cN-Jw for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Mar 2008 10:03:57 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JbIkc-0008S6-Qj
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 Mar 2008 10:03:57 -0700
Date: Mon, 17 Mar 2008 13:03:28 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080317170328.GB9536@c2.user-mode-linux.org>
References: <47B34BA0.30006@club-internet.fr>
	<20080214003853.GA15952@c2.user-mode-linux.org>
	<47B4BDCD.4080605@club-internet.fr>
	<20080215160205.GA6082@c2.user-mode-linux.org>
	<47B5CE40.9000005@club-internet.fr>
	<20080215184650.GA8810@c2.user-mode-linux.org>
	<87y78kx640.fsf_-_@hades.wkstn.nix>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87y78kx640.fsf_-_@hades.wkstn.nix>
Subject: Re: [uml-devel] [2.6.24.x] UML select()/poll() oversleeping
	reproducibly (was	Re: g_timeout_add)
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
Cc: Thomas Gleixner <tglx@timesys.com>, linux-kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Fri, Mar 14, 2008 at 11:01:35PM +0000, Nix wrote:
> bash-3.2# ./select-sleep 10
> Slept for 13 seconds.

See what kind of difference the patch below makes - it reduces the 30%
oversleeping down to 10% for me.  That's still way too much, but it's
better.

The problem being fixed here is that setitimer consistently returns a
remaining time greater than what was originally requested, by ~20%:

1205773032.413780 setitimer(ITIMER_VIRTUAL, {it_interval={0, 10000}, it_value={0, 10000}}, NULL) = 0
1205773032.413814 setitimer(ITIMER_VIRTUAL, {it_interval={0, 0},
it_value={0, 0}}, {it_interval={0, 10998}, it_value={0, 11998}}) = 0

This is setting a 100 HZ timer, immediately followed by a cancellation
which also requests the amount left on the timer.  The interval is
rounded up by 10%, and the first tick by 20%.

	       	       	    Jeff

-- 
Work email - jdike at linux dot intel dot com

Index: linux-2.6.22/arch/um/os-Linux/time.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/time.c	2008-02-18 11:53:51.000000000 -0500
+++ linux-2.6.22/arch/um/os-Linux/time.c	2008-03-17 12:55:41.000000000 -0400
@@ -58,12 +58,17 @@ static inline long long timeval_to_ns(co
 long long disable_timer(void)
 {
 	struct itimerval time = ((struct itimerval) { { 0, 0 }, { 0, 0 } });
+	int remain, max = UM_NSEC_PER_SEC / UM_HZ;
 
 	if (setitimer(ITIMER_VIRTUAL, &time, &time) < 0)
 		printk(UM_KERN_ERR "disable_timer - setitimer failed, "
 		       "errno = %d\n", errno);
 
-	return timeval_to_ns(&time.it_value);
+	remain = timeval_to_ns(&time.it_value);
+	if (remain > max)
+		remain = max;
+
+	return remain;
 }
 
 long long os_nsecs(void)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
