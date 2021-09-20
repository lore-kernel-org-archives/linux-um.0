Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from zeniv-ca.linux.org.uk ([2607:5300:60:148a::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSQuM-003BNK-Hm
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:33:05 +0000
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mSQuL-005yeO-ON
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:33:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 05/15] uml/i386: missing include in barrier.h
Date: Mon, 20 Sep 2021 21:32:51 +0000
Message-Id: <20210920213301.1424730-5-viro@zeniv.linux.org.uk>
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

we need cpufeatures.h there

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/um/asm/barrier.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/um/asm/barrier.h b/arch/x86/um/asm/barrier.h
index 165be7f9a9644..4da3369656987 100644
--- a/arch/x86/um/asm/barrier.h
+++ b/arch/x86/um/asm/barrier.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_UM_BARRIER_H_
 #define _ASM_UM_BARRIER_H_
 
+#include <asm/cpufeatures.h>
 #include <asm/alternative.h>
 
 /*
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

