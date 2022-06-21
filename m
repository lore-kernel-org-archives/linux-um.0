Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from sym.noone.org ([178.63.92.236] helo=sym2.noone.org)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3b0k-004qBN-LF
	for linux-um@lists.infradead.org; Tue, 21 Jun 2022 10:21:31 +0000
From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] um: remove unused mm_copy_segments
Date: Tue, 21 Jun 2022 12:21:18 +0200
Message-Id: <20220621102118.15803-1-tklauser@distanz.ch>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

It was already removed by commit c17c02040bf0 ("arch: remove unused
*_segments() macros/functions") but seems to have been accidentally
reintroduced by commit 0500871f21b2 ("Construct init thread stack in the
linker script rather than by union"). Remove it for good.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/um/include/asm/processor-generic.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index 6a4fe8b4e686..d0fc1862da95 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -59,11 +59,6 @@ static inline void release_thread(struct task_struct *task)
 {
 }
 
-static inline void mm_copy_segments(struct mm_struct *from_mm,
-				    struct mm_struct *new_mm)
-{
-}
-
 /*
  * User space process size: 3GB (default).
  */
-- 
2.36.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

