Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaWmg-00103a-60
	for linux-um@lists.infradead.org; Tue, 20 Sep 2022 06:31:09 +0000
Received: by mail-pf1-x436.google.com with SMTP id u132so1820782pfc.6
        for <linux-um@lists.infradead.org>; Mon, 19 Sep 2022 23:31:00 -0700 (PDT)
From: cgel.zte@gmail.com
Subject: [PATCH linux-next] um: Remove the unneeded result variable
Date: Tue, 20 Sep 2022 06:30:53 +0000
Message-Id: <20220920063053.215033-1-ye.xingchen@zte.com.cn>
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
To: richard@nod.at
Cc: anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value epoll_ctl() directly instead of storing it in another
redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 arch/um/os-Linux/irq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/um/os-Linux/irq.c b/arch/um/os-Linux/irq.c
index 98ea910ef87c..cf7e49c08b21 100644
--- a/arch/um/os-Linux/irq.c
+++ b/arch/um/os-Linux/irq.c
@@ -127,12 +127,10 @@ int os_mod_epoll_fd(int events, int fd, void *data)
 int os_del_epoll_fd(int fd)
 {
 	struct epoll_event event;
-	int result;
 	/* This is quiet as we use this as IO ON/OFF - so it is often
 	 * invoked on a non-existent fd
 	 */
-	result = epoll_ctl(epollfd, EPOLL_CTL_DEL, fd, &event);
-	return result;
+	return epoll_ctl(epollfd, EPOLL_CTL_DEL, fd, &event);
 }
 
 void os_set_ioignore(void)
-- 
2.25.1

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

