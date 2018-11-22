Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gPeE1-0006tH-Lp
 for linux-um@lists.infradead.org; Thu, 22 Nov 2018 01:56:14 +0000
Received: by mail-pl1-x642.google.com with SMTP id 101so1750431pld.6
 for <linux-um@lists.infradead.org>; Wed, 21 Nov 2018 17:56:02 -0800 (PST)
From: Wei Li <liwei@anbutu.com>
Subject: [PATCH] um/timer: fix tv_sec value setup in os_timer_one_shot
Date: Thu, 22 Nov 2018 09:55:35 +0800
Message-Id: <20181122015535.3943-1-liwei@anbutu.com>
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
Cc: Wei Li <liwei@anbutu.com>, richard@nod.at, jdike@addtoit.com

Signed-off-by: Wei Li <liwei@anbutu.com>
---
 arch/um/os-Linux/time.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index 0e39b9978729..c0c6bcb51241 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -119,11 +119,11 @@ int os_timer_one_shot(int ticks)
 	unsigned long long nsec;
 	unsigned long sec;
 
-    nsec = (ticks + 1);
-    sec = nsec / UM_NSEC_PER_SEC;
+	nsec = (ticks + 1);
+	sec = nsec / UM_NSEC_PER_SEC;
 	nsec = nsec % UM_NSEC_PER_SEC;
 
-	its.it_value.tv_sec = nsec / UM_NSEC_PER_SEC;
+	its.it_value.tv_sec = sec;
 	its.it_value.tv_nsec = nsec;
 
 	its.it_interval.tv_sec = 0;
-- 
2.19.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

