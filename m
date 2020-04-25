Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jSG1c-0007HP-GU
 for linux-um@lists.infradead.org; Sat, 25 Apr 2020 08:19:02 +0000
Received: by mail-wr1-x443.google.com with SMTP id d17so14252596wrg.11
 for <linux-um@lists.infradead.org>; Sat, 25 Apr 2020 01:18:58 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH] um: Fix typo in vector driver transport option definition
Date: Sat, 25 Apr 2020 09:18:42 +0100
Message-Id: <20200425081842.4365-1-ignat@cloudflare.com>
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
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: trivial@kernel.org, Ignat Korchagin <ignat@cloudflare.com>

No big problem as "raw" and "gre" have the same length, but could go wrong if
they don't in the future.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 arch/um/drivers/vector_user.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/vector_user.h b/arch/um/drivers/vector_user.h
index 91f35b266aba..d29d5fdd98fa 100644
--- a/arch/um/drivers/vector_user.h
+++ b/arch/um/drivers/vector_user.h
@@ -17,7 +17,7 @@
 #define TRANS_TAP_LEN strlen(TRANS_TAP)
 
 #define TRANS_GRE "gre"
-#define TRANS_GRE_LEN strlen(TRANS_RAW)
+#define TRANS_GRE_LEN strlen(TRANS_GRE)
 
 #define TRANS_L2TPV3 "l2tpv3"
 #define TRANS_L2TPV3_LEN strlen(TRANS_L2TPV3)
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

