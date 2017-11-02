Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] um/time: use timespec64 for persistent clock
Date: Thu,  2 Nov 2017 13:07:02 +0100
Message-Id: <20171102120716.442649-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Nicolai Stange <nicstange@gmail.com>, John Stultz <john.stultz@linaro.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This read_persistent_clock() implementation is the only remaining
caller of set_normalized_timespec(). Using read_persistent_clock64()
and set_normalized_timespec64() instead lets us remove the deprecated
interface in the future and helps make 32-bit arch/um get closer to
working beyond 2038.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/um/kernel/time.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 7f69d17de354..052de4c8acb2 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -121,12 +121,12 @@ static void __init um_timer_setup(void)
 	clockevents_register_device(&timer_clockevent);
 }
 
-void read_persistent_clock(struct timespec *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
 	long long nsecs = os_persistent_clock_emulation();
 
-	set_normalized_timespec(ts, nsecs / NSEC_PER_SEC,
-				nsecs % NSEC_PER_SEC);
+	set_normalized_timespec64(ts, nsecs / NSEC_PER_SEC,
+				  nsecs % NSEC_PER_SEC);
 }
 
 void __init time_init(void)
-- 
2.9.0


