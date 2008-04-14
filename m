Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JlPvV-0006sP-0T for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Apr 2008 07:44:57 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JlPvQ-0004oK-OC
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Apr 2008 07:44:56 -0700
Date: Mon, 14 Apr 2008 10:40:52 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080414144052.GA7186@c2.user-mode-linux.org>
References: <87k5jcqmh8.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87k5jcqmh8.fsf@hades.wkstn.nix>
Subject: Re: [uml-devel] Lockups with the fixed timer code :/
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
Cc: Thomas Gleixner <tglx@timesys.com>, user-mode-linux-devel@lists.sourceforge.net

On Sat, Apr 05, 2008 at 05:45:39PM +0100, Nix wrote:
> The fixed timer patch you posted a few weeks back has indeed fixed my
> select()-based timeout woes.
> 
> Unfortunately, both with the old kludgy approach and with the new
> remain-versus-max estimator code, I see intermittent tight lockups of
> the UML kernel-space ptrace thread, with that thread chewing all
> available CPU time and the virtual machine, unsurprisingly, going
> unresponsive. 

Below is another patch for you to try.  I spent most of last week
chasing this one.  The symptoms are somewhat similar to yours -
intermittent UML hangs, although not with UML spinning, and it still
pings.

The problem is NTP adjusting the multiplier part of the clock-provided
cycles-to-ns conversion function.  UML pretended to have a ns clock,
with a multiplier of 1.  When NTP adjusted that down in order to slow
down the clock, that became 0, and time stopped.

The fix below is to switch to a usec clock, with a multiplier of 1000,
which can be adjusted with much more granualarity.

      	     	      Jeff

-- 
Work email - jdike at linux dot intel dot com

Index: linux-2.6.22/arch/um/kernel/time.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/time.c	2008-04-10 12:53:32.000000000 -0400
+++ linux-2.6.22/arch/um/kernel/time.c	2008-04-14 10:30:00.000000000 -0400
@@ -75,7 +75,7 @@ static irqreturn_t um_timer(int irq, voi
 
 static cycle_t itimer_read(void)
 {
-	return os_nsecs();
+	return os_nsecs() / 1000;
 }
 
 static struct clocksource itimer_clocksource = {
@@ -83,7 +83,7 @@ static struct clocksource itimer_clockso
 	.rating		= 300,
 	.read		= itimer_read,
 	.mask		= CLOCKSOURCE_MASK(64),
-	.mult		= 1,
+	.mult		= 1000,
 	.shift		= 0,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
