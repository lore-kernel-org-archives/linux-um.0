Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx2.uni-rostock.de ([139.30.22.72])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nvztE-00AMNe-Kd
	for linux-um@lists.infradead.org; Tue, 31 May 2022 11:18:23 +0000
From: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
Subject: [PATCH] um: remove straying parenthesis
Date: Tue, 31 May 2022 11:17:39 +0000
Message-ID: <20220531111740.899162-1-benjamin.beichler@uni-rostock.de>
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
To: jdike@addtoit.com, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Benjamin Beichler <benjamin.beichler@uni-rostock.de>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

Fixes: e3a33af812c6 ("um: fix and optimize xor select template for CONFIG64 and timetravel mode")
Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
---
 arch/um/include/asm/xor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/include/asm/xor.h b/arch/um/include/asm/xor.h
index 22b39de73c24..647fae200c5d 100644
--- a/arch/um/include/asm/xor.h
+++ b/arch/um/include/asm/xor.h
@@ -18,7 +18,7 @@
 #undef XOR_SELECT_TEMPLATE
 /* pick an arbitrary one - measuring isn't possible with inf-cpu */
 #define XOR_SELECT_TEMPLATE(x)	\
-	(time_travel_mode == TT_MODE_INFCPU ? TT_CPU_INF_XOR_DEFAULT : x))
+	(time_travel_mode == TT_MODE_INFCPU ? TT_CPU_INF_XOR_DEFAULT : x)
 #endif
 
 #endif
-- 
2.25.1

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

