Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMUWl-009aYv-SN
 for linux-um@lists.infradead.org; Tue, 22 Feb 2022 12:44:26 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH v2] um: Fix uml_mconsole stop/go
Date: Tue, 22 Feb 2022 12:44:10 +0000
Message-Id: <20220222124410.1383646-1-anton.ivanov@cambridgegreys.com>
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
Cc: rrs@debian.org, 1005900@bugs.debian.org, quake2iasi@gmail.com, johannes@sipsolutions.net, richard@nod.at, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Moving to an EPOLL based IRQ controller broke uml_mconsole stop/go
commands. This fixes it and restores stop/go functionality.

Fixes: ff6a17989c08 ("Epoll based IRQ controller")
Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/mconsole_kern.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index 6ead1e240457..8ca67a692683 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -224,7 +224,7 @@ void mconsole_go(struct mc_request *req)
 
 void mconsole_stop(struct mc_request *req)
 {
-	deactivate_fd(req->originating_fd, MCONSOLE_IRQ);
+	block_signals();
 	os_set_fd_block(req->originating_fd, 1);
 	mconsole_reply(req, "stopped", 0, 0);
 	for (;;) {
@@ -247,6 +247,7 @@ void mconsole_stop(struct mc_request *req)
 	}
 	os_set_fd_block(req->originating_fd, 0);
 	mconsole_reply(req, "", 0, 0);
+	unblock_signals();
 }
 
 static DEFINE_SPINLOCK(mc_devices_lock);
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

