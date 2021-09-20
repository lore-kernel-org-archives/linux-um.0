Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from zeniv-ca.linux.org.uk ([2607:5300:60:148a::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSQuN-003BP2-CE
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:33:07 +0000
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mSQuM-005yeu-Iq
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:33:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 15/15] um: header debriding - sigio.h
Date: Mon, 20 Sep 2021 21:33:01 +0000
Message-Id: <20210920213301.1424730-15-viro@zeniv.linux.org.uk>
In-Reply-To: <20210920213301.1424730-1-viro@zeniv.linux.org.uk>
References: <YUj9S+S4Gd86mM6N@zeniv-ca.linux.org.uk>
 <20210920213301.1424730-1-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/um/include/shared/sigio.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/include/shared/sigio.h b/arch/um/include/shared/sigio.h
index 8fe8f57c05de8..e60c8b2278449 100644
--- a/arch/um/include/shared/sigio.h
+++ b/arch/um/include/shared/sigio.h
@@ -7,7 +7,6 @@
 #define __SIGIO_H__
 
 extern int write_sigio_irq(int fd);
-extern int register_sigio_fd(int fd);
 extern void sigio_lock(void);
 extern void sigio_unlock(void);
 
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

