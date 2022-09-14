Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYMqw-009i8M-Ud
	for linux-um@lists.infradead.org; Wed, 14 Sep 2022 07:30:36 +0000
From: Gaosheng Cui <cuigaosheng1@huawei.com>
Subject: [PATCH] um: remove unused reactivate_chan() declaration
Date: Wed, 14 Sep 2022 15:30:27 +0800
Message-ID: <20220914073027.1340509-1-cuigaosheng1@huawei.com>
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
To: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, cuigaosheng1@huawei.com
Cc: linux-um@lists.infradead.org

All uses of reactivate_chan() were removed by
commit 940b241d9050 ("um: Remove obsolete reenable_XX
calls"), so remove the declaration, too.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 arch/um/drivers/chan.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/drivers/chan.h b/arch/um/drivers/chan.h
index c37cc4f26f91..3fec3b8406e9 100644
--- a/arch/um/drivers/chan.h
+++ b/arch/um/drivers/chan.h
@@ -36,7 +36,6 @@ extern int console_write_chan(struct chan *chan, const char *buf,
 			      int len);
 extern int console_open_chan(struct line *line, struct console *co);
 extern void deactivate_chan(struct chan *chan, int irq);
-extern void reactivate_chan(struct chan *chan, int irq);
 extern void chan_enable_winch(struct chan *chan, struct tty_port *port);
 extern int enable_chan(struct line *line);
 extern void close_chan(struct line *line);
-- 
2.25.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

