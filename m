Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l33EQ-0007DF-62
 for linux-um@lists.infradead.org; Fri, 22 Jan 2021 20:40:35 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] um: fix os_idle_sleep() to not hang
Date: Fri, 22 Jan 2021 21:40:23 +0100
Message-Id: <20210122214023.c2219f43d6c1.I1382fc1a4ce633c65cf2fdb9693462e76722937b@changeid>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

Changing os_idle_sleep() to use pause() (I accidentally described
it as an empty select() in the commit log because I had changed it
from that to pause() in a later revision) exposed a race condition
in the idle code. The following can happen:

 timer_settime(0, 0, {it_interval={tv_sec=0, tv_nsec=0}, it_value={tv_sec=0, tv_nsec=624017}}, NULL) = 0
 ...
 <SIGALRM is delivered but we're already on the way to idle>
 pause()

and we now hang forever. This was previously possible as well, but
it could never cause UML to hang for more than a second since we
could only sleep for that much, so at most you'd notice a "hiccup"
in the UML. Obviously, any sort of external interrupt also "saves"
it and interrupts pause().

Fix this by properly handling the race, rather than papering over
it again:

 - first, block SIGALRM, and obtain the old signal set
 - check the timer
 - suspend, waiting for any signal out of the old set, if, and only
   if, the timer will fire in the future
 - restore the old signal mask

This ensures race-free operation: as it's blocked, the signal won't
be delivered while we're looking at the timer even if it were to be
triggered right _after_ we've returned from timer_gettime() with a
non-zero value (telling us the timer will trigger). Thus, despite
getting to sigsuspend() because timer_gettime() told us we're still
waiting, we'll not hang because sigsuspend() will return immediately
due to the pending signal.

Fixes: 49da38a3ef33 ("um: Simplify os_idle_sleep() and sleep longer")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/os-Linux/time.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index a61cbf73a179..6c5041c5560b 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -104,5 +104,18 @@ long long os_nsecs(void)
  */
 void os_idle_sleep(void)
 {
-	pause();
+	struct itimerspec its;
+	sigset_t set, old;
+
+	/* block SIGALRM while we analyze the timer state */
+	sigemptyset(&set);
+	sigaddset(&set, SIGALRM);
+	sigprocmask(SIG_BLOCK, &set, &old);
+
+	/* check the timer, and if it'll fire then wait for it */
+	timer_gettime(event_high_res_timer, &its);
+	if (its.it_value.tv_sec || its.it_value.tv_nsec)
+		sigsuspend(&old);
+	/* either way, restore the signal mask */
+	sigprocmask(SIG_UNBLOCK, &set, NULL);
 }
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

