Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from zeniv-ca.linux.org.uk ([2607:5300:60:148a::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSQuN-003BO6-08
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:33:06 +0000
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mSQuM-005yee-5t
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:33:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 10/15] um: common-offsets.h debriding...
Date: Mon, 20 Sep 2021 21:32:56 +0000
Message-Id: <20210920213301.1424730-10-viro@zeniv.linux.org.uk>
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
 arch/um/include/shared/common-offsets.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/um/include/shared/common-offsets.h b/arch/um/include/shared/common-offsets.h
index b2483104e27f0..96195483fbd0f 100644
--- a/arch/um/include/shared/common-offsets.h
+++ b/arch/um/include/shared/common-offsets.h
@@ -9,29 +9,17 @@ DEFINE(UM_KERN_PAGE_MASK, PAGE_MASK);
 DEFINE(UM_KERN_PAGE_SHIFT, PAGE_SHIFT);
 DEFINE(UM_NSEC_PER_SEC, NSEC_PER_SEC);
 
-DEFINE(UM_ELF_CLASS, ELF_CLASS);
-DEFINE(UM_ELFCLASS32, ELFCLASS32);
-DEFINE(UM_ELFCLASS64, ELFCLASS64);
-
-DEFINE(UM_NR_CPUS, NR_CPUS);
-
 DEFINE(UM_GFP_KERNEL, GFP_KERNEL);
 DEFINE(UM_GFP_ATOMIC, GFP_ATOMIC);
 
 DEFINE(UM_THREAD_SIZE, THREAD_SIZE);
 
-DEFINE(UM_HZ, HZ);
-
-DEFINE(UM_USEC_PER_SEC, USEC_PER_SEC);
 DEFINE(UM_NSEC_PER_SEC, NSEC_PER_SEC);
 DEFINE(UM_NSEC_PER_USEC, NSEC_PER_USEC);
 
 #ifdef CONFIG_PRINTK
 DEFINE(UML_CONFIG_PRINTK, CONFIG_PRINTK);
 #endif
-#ifdef CONFIG_NO_HZ_COMMON
-DEFINE(UML_CONFIG_NO_HZ_COMMON, CONFIG_NO_HZ_COMMON);
-#endif
 #ifdef CONFIG_UML_X86
 DEFINE(UML_CONFIG_UML_X86, CONFIG_UML_X86);
 #endif
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

