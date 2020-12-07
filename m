Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmKAy-0000iX-1j
 for linux-um@lists.infradead.org; Mon, 07 Dec 2020 17:19:53 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH 1/3] um: Monitor error events in IRQ controller
Date: Mon,  7 Dec 2020 17:19:38 +0000
Message-Id: <20201207171940.25240-1-anton.ivanov@cambridgegreys.com>
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
Cc: richard@nod.at, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Ensure that file closes, connection closes, etc are propagated
as interrupts in the interrupt controller.

Fixes: ff6a17989c08 ("Epoll based IRQ controller")
Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/os-Linux/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/irq.c b/arch/um/os-Linux/irq.c
index d508310ee5e1..f1732c308c61 100644
--- a/arch/um/os-Linux/irq.c
+++ b/arch/um/os-Linux/irq.c
@@ -48,7 +48,7 @@ int os_epoll_triggered(int index, int events)
 int os_event_mask(int irq_type)
 {
 	if (irq_type == IRQ_READ)
-		return EPOLLIN | EPOLLPRI;
+		return EPOLLIN | EPOLLPRI | EPOLLERR | EPOLLHUP | EPOLLRDHUP;
 	if (irq_type == IRQ_WRITE)
 		return EPOLLOUT;
 	return 0;
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

