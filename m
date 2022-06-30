Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6ouI-00FpHF-7G
	for linux-um@lists.infradead.org; Thu, 30 Jun 2022 07:48:11 +0000
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-317f6128c86so148642077b3.22
        for <linux-um@lists.infradead.org>; Thu, 30 Jun 2022 00:48:07 -0700 (PDT)
Date: Thu, 30 Jun 2022 15:47:56 +0800
Message-Id: <20220630074757.2739000-1-davidgow@google.com>
Mime-Version: 1.0
Subject: [PATCH v3 1/2] mm: Add PAGE_ALIGN_DOWN macro
From: David Gow <davidgow@google.com>
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
To: Vincent Whitchurch <vincent.whitchurch@axis.com>, Johannes Berg <johannes@sipsolutions.net>, Patricia Alfonso <trishalfonso@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, anton.ivanov@cambridgegreys.com, Dmitry Vyukov <dvyukov@google.com>, Brendan Higgins <brendanhiggins@google.com>, Andrew Morton <akpm@linux-foundation.org>, Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: David Gow <davidgow@google.com>, kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Daniel Latypov <dlatypov@google.com>, linux-mm@kvack.org, kunit-dev@googlegroups.com

This is just the same as PAGE_ALIGN(), but rounds the address down, not
up.

Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: David Gow <davidgow@google.com>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
---

Please take this patch as part of the UML tree, along with patch #2,
thanks!

Changes since v2:
https://lore.kernel.org/lkml/20220527185600.1236769-1-davidgow@google.com/
- Add Andrew's Acked-by tag.

v2 was the first version of this patch (it having been introduced as
part of v2 of the UML/KASAN series).

There are almost certainly lots of places where this macro should be
used: just look for ALIGN_DOWN(..., PAGE_SIZE). I haven't gone through
to try to replace them all.

---
 include/linux/mm.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9f44254af8ce..9abe5975ad11 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -221,6 +221,9 @@ int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr) ALIGN(addr, PAGE_SIZE)
 
+/* to align the pointer to the (prev) page boundary */
+#define PAGE_ALIGN_DOWN(addr) ALIGN_DOWN(addr, PAGE_SIZE)
+
 /* test whether an address (unsigned long or pointer) is aligned to PAGE_SIZE */
 #define PAGE_ALIGNED(addr)	IS_ALIGNED((unsigned long)(addr), PAGE_SIZE)
 
-- 
2.37.0.rc0.161.g10f37bed90-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

