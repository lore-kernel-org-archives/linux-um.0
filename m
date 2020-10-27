Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXCYn-00021t-4V
 for linux-um@lists.infradead.org; Tue, 27 Oct 2020 00:10:29 +0000
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 06/46] um: change sigio_spinlock to a mutex
Date: Mon, 26 Oct 2020 20:09:05 -0400
Message-Id: <20201027000946.1026923-6-sashal@kernel.org>
In-Reply-To: <20201027000946.1026923-1-sashal@kernel.org>
References: <20201027000946.1026923-1-sashal@kernel.org>
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
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit f2d05059e15af3f70502074f4e3a504530af504a ]

Lockdep complains at boot:

=============================
[ BUG: Invalid wait context ]
5.7.0-05093-g46d91ecd597b #98 Not tainted
-----------------------------
swapper/1 is trying to lock:
0000000060931b98 (&desc[i].request_mutex){+.+.}-{3:3}, at: __setup_irq+0x11d/0x623
other info that might help us debug this:
context-{4:4}
1 lock held by swapper/1:
 #0: 000000006074fed8 (sigio_spinlock){+.+.}-{2:2}, at: sigio_lock+0x1a/0x1c
stack backtrace:
CPU: 0 PID: 1 Comm: swapper Not tainted 5.7.0-05093-g46d91ecd597b #98
Stack:
 7fa4fab0 6028dfd1 0000002a 6008bea5
 7fa50700 7fa50040 7fa4fac0 6028e016
 7fa4fb50 6007f6da 60959c18 00000000
Call Trace:
 [<60023a0e>] show_stack+0x13b/0x155
 [<6028e016>] dump_stack+0x2a/0x2c
 [<6007f6da>] __lock_acquire+0x515/0x15f2
 [<6007eb50>] lock_acquire+0x245/0x273
 [<6050d9f1>] __mutex_lock+0xbd/0x325
 [<6050dc76>] mutex_lock_nested+0x1d/0x1f
 [<6008e27e>] __setup_irq+0x11d/0x623
 [<6008e8ed>] request_threaded_irq+0x169/0x1a6
 [<60021eb0>] um_request_irq+0x1ee/0x24b
 [<600234ee>] write_sigio_irq+0x3b/0x76
 [<600383ca>] sigio_broken+0x146/0x2e4
 [<60020bd8>] do_one_initcall+0xde/0x281

Because we hold sigio_spinlock and then get into requesting
an interrupt with a mutex.

Change the spinlock to a mutex to avoid that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/kernel/sigio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/kernel/sigio.c b/arch/um/kernel/sigio.c
index b5e0cbb343828..476ded92affac 100644
--- a/arch/um/kernel/sigio.c
+++ b/arch/um/kernel/sigio.c
@@ -36,14 +36,14 @@ int write_sigio_irq(int fd)
 }
 
 /* These are called from os-Linux/sigio.c to protect its pollfds arrays. */
-static DEFINE_SPINLOCK(sigio_spinlock);
+static DEFINE_MUTEX(sigio_mutex);
 
 void sigio_lock(void)
 {
-	spin_lock(&sigio_spinlock);
+	mutex_lock(&sigio_mutex);
 }
 
 void sigio_unlock(void)
 {
-	spin_unlock(&sigio_spinlock);
+	mutex_unlock(&sigio_mutex);
 }
-- 
2.25.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

