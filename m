Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13E0CD37B0
	for <linux-um@archiver.kernel.org>; Mon, 18 Sep 2023 10:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:CC:To:Message-ID:MIME-Version:Subject:
	Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+Kec7uH+AnLLlovsLQAV+rnEmczEed7nG02szao0drs=; b=yjmoa6Gsf9JRgS
	xfBC+XCmMe9cIMZMJ8UxGMSTibAHNDWfopmnr2lNK2nHXA8PVWDfMJdft2yPkU92MKlvqFaR03Kah
	CkuhiGLnlcQN4k/ZsaqUwLS/GLc9d0YQSEhNt0DAqd/YqJKo8f4eY2wD/cvsJg0YgyyuLku6VqjcB
	aG/T0uv5V+xNP1Gvdc8qo+UwpeUmq956p3q/UaDbiDuSzEXg56rvqyC9UW/Y0NwJNjwrFdF/Wn4g2
	kccJPo6WR3nesVoG7yx0iiLUTEvCLunATM2vowT3NbRM/u4Aj3LfgYTOKGgISKWJoBg32FOBzTV26
	LDwzoPZ6gmybLZcRCezQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiBs0-00FGaJ-1b;
	Mon, 18 Sep 2023 10:52:48 +0000
Received: from smtp2.axis.com ([195.60.68.18])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiBrw-00FGYF-2n
	for linux-um@lists.infradead.org;
	Mon, 18 Sep 2023 10:52:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1695034365;
  x=1726570365;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=bOsEzjVQKBPn7rGdrNw3l2iC/L1VtxB+euAZfU+U4zs=;
  b=hggS6tRep+WSkPpQFEO+ihQAUN7wj0fNwi/6EavLizvVd41Ry1bxYOpt
   9e1YGneRLuhpwPV0kHNuG8ZA79MGJUfd8rKdyQA6Rf3qTlDUroTaS7n8D
   juW746YLKiOl3w5uxkco8lSG2EW7PCSw9vZDw5GEMQsOl0RCFpg2o3cP+
   DhF3IP3UCMTlb6ChUqRRy3gRH/De4rb68rlBNJl7OmLQbxy3BRRS+sUUK
   IwtrcrUz3mO9WCjsCIhNxPYuxwN5PmYdCOiFfMckS6OAemRFVX4GOFVNX
   Z3fZvyiafKeePEDg9JRW0Fj5RoF9AIVHvGqJOuQ4y9e0pq0Ljp7NepUXV
   Q==;
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Date: Mon, 18 Sep 2023 12:52:34 +0200
Subject: [PATCH v3] x86: Fix build of UML with KASAN
MIME-Version: 1.0
Message-ID: <20230918-uml-kasan-v3-1-7ad6db477df6@axis.com>
X-B4-Tracking: v=1; b=H4sIAPErCGUC/22Nyw7CIBBFf6VhLYZXTXHlfxgXFAZLtNCAkpqm/
 y50YxdmVudmzr0LShAdJHRuFhQhu+SCL8APDdKD8nfAzhRGjDBOTkTi9/jED5WUx4xLZozQvGs
 7VP57lQD3UXk9VMOGwGo8RbBu3iaut8KDS68QP9tipjX9V54ppri1SndGEGmEvajZpaMOI6olm
 f1ESdu9yIoIlpezwlIhduK6rl9voZLC8QAAAA==
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Frederic Weisbecker
	<frederic@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Peter Zijlstra <peterz@infradead.org>
CC: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>,
	<linux-um@lists.infradead.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>, Andrey Konovalov
	<andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino
	<vincenzo.frascino@arm.com>, <kasan-dev@googlegroups.com>,
	<linux-kernel@vger.kernel.org>, <kernel@axis.com>, Vincent Whitchurch
	<vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_035245_390961_A1863EAE 
X-CRM114-Status: GOOD (  10.83  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Building UML with KASAN fails since commit 69d4c0d32186 ("entry, kasan,
x86: Disallow overriding mem*() functions") with the following errors:

 $ tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=y
 ...
 ld: mm/kasan/shadow.o: in function `memset':
 shadow.c:(.text+0x40): multiple definition of `memset';
 arch/x86/lib/memset_64.o:(.noinstr.text+0x0): first defined here
 ld: mm/kasan/shadow.o: in function `memmove':
 shadow.c:(.text+0x90): multiple definition of `memmove';
 arch/x86/lib/memmove_64.o:(.noinstr.text+0x0): first defined here
 ld: mm/kasan/shadow.o: in function `memcpy':
 shadow.c:(.text+0x110): multiple definition of `memcpy';
 arch/x86/lib/memcpy_64.o:(.noinstr.text+0x0): first defined here

UML does not use GENERIC_ENTRY and is still supposed to be allowed to
override the mem*() functions, so use weak aliases in that case.

Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
Changes in v3:
- Add SYM_FUNC_ALIAS_MEMFUNC() macro to avoid ifdefs in multiple places.
- Link to v2: https://lore.kernel.org/r/20230915-uml-kasan-v2-1-ef3f3ff4f144@axis.com

Changes in v2:
- Use CONFIG_UML instead of CONFIG_GENERIC_ENTRY.
- Link to v1: https://lore.kernel.org/r/20230609-uml-kasan-v1-1-5fac8d409d4f@axis.com
---
 arch/x86/include/asm/linkage.h | 7 +++++++
 arch/x86/lib/memcpy_64.S       | 2 +-
 arch/x86/lib/memmove_64.S      | 2 +-
 arch/x86/lib/memset_64.S       | 2 +-
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 97a3de7892d3..32cdf1e92cfb 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -97,6 +97,13 @@
 	CFI_POST_PADDING					\
 	SYM_FUNC_END(__cfi_##name)
 
+/* UML needs to be able to override memcpy() and friends for KASAN. */
+#ifdef CONFIG_UML
+#define SYM_FUNC_ALIAS_MEMFUNC	SYM_FUNC_ALIAS_WEAK
+#else
+#define SYM_FUNC_ALIAS_MEMFUNC	SYM_FUNC_ALIAS
+#endif
+
 /* SYM_TYPED_FUNC_START -- use for indirectly called globals, w/ CFI type */
 #define SYM_TYPED_FUNC_START(name)				\
 	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_F_ALIGN)	\
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 8f95fb267caa..76697df8dfd5 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -40,7 +40,7 @@ SYM_TYPED_FUNC_START(__memcpy)
 SYM_FUNC_END(__memcpy)
 EXPORT_SYMBOL(__memcpy)
 
-SYM_FUNC_ALIAS(memcpy, __memcpy)
+SYM_FUNC_ALIAS_MEMFUNC(memcpy, __memcpy)
 EXPORT_SYMBOL(memcpy)
 
 SYM_FUNC_START_LOCAL(memcpy_orig)
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 0559b206fb11..ccdf3a597045 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -212,5 +212,5 @@ SYM_FUNC_START(__memmove)
 SYM_FUNC_END(__memmove)
 EXPORT_SYMBOL(__memmove)
 
-SYM_FUNC_ALIAS(memmove, __memmove)
+SYM_FUNC_ALIAS_MEMFUNC(memmove, __memmove)
 EXPORT_SYMBOL(memmove)
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 7c59a704c458..3d818b849ec6 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -40,7 +40,7 @@ SYM_FUNC_START(__memset)
 SYM_FUNC_END(__memset)
 EXPORT_SYMBOL(__memset)
 
-SYM_FUNC_ALIAS(memset, __memset)
+SYM_FUNC_ALIAS_MEMFUNC(memset, __memset)
 EXPORT_SYMBOL(memset)
 
 SYM_FUNC_START_LOCAL(memset_orig)

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230609-uml-kasan-2392dd4c3858

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
