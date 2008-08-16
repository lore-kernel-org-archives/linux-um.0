Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KUUNn-0005DP-Sp for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 16 Aug 2008 15:36:28 -0700
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KUUNm-00022r-6S
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 16 Aug 2008 15:36:27 -0700
From: <gregkh@suse.de>
Date: Sat, 16 Aug 2008 15:32:39 -0700
In-Reply-To: <20080805201403.GA11734@c2.user-mode-linux.org>
Message-Id: <20080816223620.C1EC91454450@imap.suse.de>
Subject: [uml-devel] patch uml-fix-bad-ntp-interaction-with-clock.patch
	added to 2.6.25-stable tree
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
To: jdike@addtoit.com, akpm@linux-foundation.org, gregkh@suse.de, jdike@linux.intel.com, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, user-mode-linux-devel@lists.sourceforge.net, xiyou.wangcong@gmail.com
Cc: stable@kernel.org, stable-commits@vger.kernel.org


This is a note to let you know that we have just queued up the patch titled

    Subject: uml: fix bad NTP interaction with clock

to the 2.6.25-stable tree.  Its filename is

    uml-fix-bad-ntp-interaction-with-clock.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


From stable-bounces@linux.kernel.org Tue Aug  5 13:14:46 2008
From: Jeff Dike <jdike@addtoit.com>
Date: Tue, 5 Aug 2008 16:14:03 -0400
Subject: uml: fix bad NTP interaction with clock
To: stable@kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Message-ID: <20080805201403.GA11734@c2.user-mode-linux.org>
Content-Disposition: inline

From: Jeff Dike <jdike@addtoit.com>

commit cfd28f6695d0fc047478480791a21bdd4967f98e upstream

UML's supposed nanosecond clock interacts badly with NTP when NTP
decides that the clock has drifted ahead and needs to be slowed down.
Slowing down the clock is done by decrementing the cycle-to-nanosecond
multiplier, which is 1.  Decrementing that gives you 0 and time is
stopped.

This is fixed by switching to a microsecond clock, with a multiplier
of 1000.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
Cc: WANG Cong <xiyou.wangcong@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/um/kernel/time.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -74,7 +74,7 @@ static irqreturn_t um_timer(int irq, voi
 
 static cycle_t itimer_read(void)
 {
-	return os_nsecs();
+	return os_nsecs() / 1000;
 }
 
 static struct clocksource itimer_clocksource = {
@@ -82,7 +82,7 @@ static struct clocksource itimer_clockso
 	.rating		= 300,
 	.read		= itimer_read,
 	.mask		= CLOCKSOURCE_MASK(64),
-	.mult		= 1,
+	.mult		= 1000,
 	.shift		= 0,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };


Patches currently in stable-queue which might be from jdike@addtoit.com are

queue-2.6.25/uml-fix-build-when-slob-is-enabled.patch
queue-2.6.25/uml-fix-bad-ntp-interaction-with-clock.patch
queue-2.6.25/uml-physical-memory-shouldn-t-include-initial-stack.patch
queue-2.6.25/uml-track-and-make-up-lost-ticks.patch
queue-2.6.25/uml-missed-kmalloc-in-pcap_user.c.patch
queue-2.6.25/uml-deal-with-host-time-going-backwards.patch
queue-2.6.25/uml-deal-with-inaccessible-address-space-start.patch
queue-2.6.25/uml-missing-export-of-csum_partial-on-uml-amd64.patch
queue-2.6.25/uml-memcpy-export-needs-to-follow-host-declaration.patch
queue-2.6.25/uml-stub-needs-to-tolerate-sigwinch.patch
queue-2.6.25/uml-work-around-broken-host-ptrace_sysemu.patch
queue-2.6.25/uml-fix-gcc-ices-and-unresolved-externs.patch
queue-2.6.25/uml-fix-boot-crash.patch

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
