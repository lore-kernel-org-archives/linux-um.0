Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KP3K0-0004mJ-Sw for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Aug 2008 15:42:05 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KP3K0-0001y3-56
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Aug 2008 15:42:04 -0700
Date: Fri, 1 Aug 2008 18:41:28 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080801224128.GA13721@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 6/14] uml: deal with host time going backwards
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
To: stable@kernel.org
Cc: Nix <nix@esperi.org.uk>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

From b547462b600e9d284f9d40ed558ca2b8904af185 Mon Sep 17 00:00:00 2001

Protection against the host's time going backwards (eg, ntp activity on
the host) by keeping track of the time at the last tick and if it's
greater than the current time, keep time stopped until the host catches
up.

Cc: Nix <nix@esperi.org.uk>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/um/os-Linux/time.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index bee98f4..dec5678 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -106,6 +106,10 @@ static void deliver_alarm(void)
 	unsigned long long this_tick = os_nsecs();
 	int one_tick = UM_NSEC_PER_SEC / UM_HZ;
 
+	/* Protection against the host's time going backwards */
+	if ((last_tick != 0) && (this_tick < last_tick))
+		this_tick = last_tick;
+
 	if (last_tick == 0)
 		last_tick = this_tick - one_tick;
 
@@ -148,6 +152,9 @@ static int after_sleep_interval(struct timespec *ts)
 		start_usecs = usec;
 
 	start_usecs -= skew / UM_NSEC_PER_USEC;
+	if (start_usecs < 0)
+		start_usecs = 0;
+
 	tv = ((struct timeval) { .tv_sec  = start_usecs / UM_USEC_PER_SEC,
 				 .tv_usec = start_usecs % UM_USEC_PER_SEC });
 	interval = ((struct itimerval) { { 0, usec }, tv });
-- 
1.5.5.1

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
