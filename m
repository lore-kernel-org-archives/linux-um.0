Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1541FC7EE30
	for <linux-um@archiver.kernel.org>; Thu, 26 Jun 2025 16:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8WWyylL/OQDZN+BQlllp9O148iIrISnZhKRdMW4Il1I=; b=BErhEmYhuhqVutFvENbX6bxyTc
	/KeacA8I4cJNJxNe/2ymvOzvbYNrPiiKn/FRc1OCywkOwzu5kjh0Sz51p1cGnwVGV5q6y+v3ygzjR
	YVDsd1zKFxWyLR8F0HPNbn6kSpy8BrEMYFNOn7fgpwYuLj3NcFJxRKe7U0YLT6/Ue7w1iDrHJDMiY
	3d7MH/LKffyFjTG+QN3rPsdQER9I93bCn6E1teyYhodGN3RIp5CM9+uW9U4qmLTGHiPQ8591ee9/o
	phzk3R1bFcIOWHnGCOZAKk0G9/TmcWds0zVHdW3HR7lvCdQAWXaTtXuuz5SH5ylp+yCM5BXsYZOgr
	bBOqjykQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUpKZ-0000000CFFn-3Ce5;
	Thu, 26 Jun 2025 16:20:07 +0000
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUoaC-0000000C7p1-3wCy;
	Thu, 26 Jun 2025 15:32:15 +0000
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-32b5226e6beso9837611fa.2;
        Thu, 26 Jun 2025 08:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750951931; x=1751556731; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WWyylL/OQDZN+BQlllp9O148iIrISnZhKRdMW4Il1I=;
        b=R1blt6rwpdLmNSMEiKRtIPzl67s/lqIk89s2iXfTEi1xW7CkAC+57Ij7vnuu6Mahhc
         ZS0btAxPU4+LXCx5UhFMr3imVvXoeLDwzhVOdtZ8Sn7Er8NTGjIfY5n1cTvdXlbSOpbR
         JhBNL33wtjUxrLyyCzObjSCvoLa61B1tWMx/zytUtv9aaTO5Ynuql5VFgHnlfBrmRG37
         u5p2VZzeEXiVraLh829FfeKvAnqyRd1QsaJjRbm142EX/LVmyzIRVh6+DOGJQJnI8lVh
         buF7A0mfpeypNN+zUVBnOk8Ee2aw7FwAipbemgep8rpdtWHzlQuZyVe9WjocemvOGqrp
         DQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951931; x=1751556731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WWyylL/OQDZN+BQlllp9O148iIrISnZhKRdMW4Il1I=;
        b=uzT6hQlpQNwGo1hD+I2dc2XsJqUU8ZBuHvuY5+3uyZQONzZc9Fno8of24u3tKIjyeg
         t0gyDfFnAbfqaNZRoVY5jAXH5peVtfQDBv5tkB11uVHgdaw5jW5+diy46A3Qz1mLfnMv
         kT059aynrMHiqXy97SWkfV39vF3+Ue095rBN8z3+FH+35r1gng0Lrf51XPblplbvZ6MW
         fN7gguRz5rTW0g9fE5SlqAlAlVGelqx6i1UvoDDOQ5+13hzYLPZaoLOg/Yd3fb3m0rGZ
         pkEB34K+cCsPKF0+VSzuQ4/VIXUdVlTdX5iWmJFxd6jxFxpAopf8DlVVPDoC4m7nhA0+
         NyQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2iD65hBxn/d6LMHnBUEzYgAl1+xHiKACh3Yz7HOIr6T0UAE3hhChCi7AbJXIwWJuTpyLkvhI57ue1F3Y=@lists.infradead.org, AJvYcCVhwzJfhoDDmGFco2oLP6lSEXbeExnx+C49IANbvRnB9a6ffOshp5lOBzY1ieaqYhCiLAB8Deo92hChyXwt4wYT@lists.infradead.org, AJvYcCW5k4BaBPihaz/652XcUHV3romn5tEvuXzOcSVFlfxDxb37oK0bt3eHTRegDX6XV3A8kD4g5pfhVR0=@lists.infradead.org
X-Gm-Message-State: AOJu0YxsvJMreCPldaWK+SdbpPW0jAx1Oe8kI/iBes0mB8Z8VQEs/8EU
	ZX3BxNQHrHEIy5aTrk1zIGoS46PrxF+C8krCqLJJ6UnVB2uwvtcMCl2h
X-Gm-Gg: ASbGnct10ir+Q2KzqnIIKBUxcZUTK9mESIf3n483UAZ/LIK4pd0FfaTUfdSd+RuIya/
	uvfqpT8jW+3Nw2KVLu+0PGJfQtZvT3sTGE+dghI/ElxsrJJYkv2wgJl+vbTXdBb0oFPFXzzh732
	1U8cf3gwIVGDzNaGFxcZg9LRG17PG6tOh9PfLuwpu24THTwrTgxepIOs4U7P5cwe1W21AiECfJR
	Q94pYfCeTO7VXFd4gdUbYTORk+/I/y0DILEHyTap/xpxaAq0qMsux7USIxbHMoh41gTtT3KRc3H
	G7tktLXfrg3yr45GY/r17F6ZOKIzJ5BZOUx1vFaUTnbVO2Z7DLWzzm7mLdJbHQHaPjNZubtZ2cK
	DPkruWOFj8INIs/KmJKiZy2b11fGpkQSstOnfWnc3
X-Google-Smtp-Source: AGHT+IE9GYxLiOYhxIA5Ev3WJWnszBqvgVmZmVZpoI4KzTn4pH5uj6GPwII6Blv/6T015vTzfPK1pQ==
X-Received: by 2002:a05:6512:b91:b0:553:adf7:e740 with SMTP id 2adb3069b0e04-554fdd1d728mr2765576e87.28.1750951930696;
        Thu, 26 Jun 2025 08:32:10 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ce1fasm42792e87.174.2025.06.26.08.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:32:10 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	akpm@linux-foundation.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com
Cc: arnd@arndb.de,
	rppt@kernel.org,
	geert@linux-m68k.org,
	mcgrof@kernel.org,
	guoweikang.kernel@gmail.com,
	tiwei.btw@antgroup.com,
	kevin.brodsky@arm.com,
	benjamin.berg@intel.com,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	snovitoll@gmail.com
Subject: [PATCH v2 01/11] kasan: unify static kasan_flag_enabled across modes
Date: Thu, 26 Jun 2025 20:31:37 +0500
Message-Id: <20250626153147.145312-2-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626153147.145312-1-snovitoll@gmail.com>
References: <20250626153147.145312-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_083212_974309_7A5F5AC8 
X-CRM114-Status: GOOD (  15.33  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Historically, the runtime static key kasan_flag_enabled existed only for
CONFIG_KASAN_HW_TAGS mode. Generic and SW_TAGS modes either relied on
architecture-specific kasan_arch_is_ready() implementations or evaluated
KASAN checks unconditionally, leading to code duplication.

This patch unifies the approach by:

1. Moving kasan_flag_enabled declaration under CONFIG_KASAN (all modes)
   instead of only CONFIG_KASAN_HW_TAGS
2. Moving the static key definition to common.c for shared usage
3. Adding kasan_init_generic() function that enables the static key and
   handles initialization for Generic mode
4. Updating SW_TAGS mode to enable the unified static key
5. Removing the duplicate static key definition from HW_TAGS

After this change, all KASAN modes use the same underlying static key
infrastructure. The kasan_enabled() function now provides consistent
runtime enable behavior across Generic, SW_TAGS, and HW_TAGS modes.

This maintains a backward compatibility - existing architecture code
continues to work unchanged, but now benefits from the unified runtime
control mechanism. The architecture-specific kasan_arch_is_ready()
implementations can be gradually replaced with calls to the new
kasan_init_generic() function.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 include/linux/kasan-enabled.h | 10 ++++++++--
 include/linux/kasan.h         |  6 ++++++
 mm/kasan/common.c             |  7 +++++++
 mm/kasan/generic.c            | 11 +++++++++++
 mm/kasan/hw_tags.c            |  7 -------
 mm/kasan/sw_tags.c            |  2 ++
 6 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
index 6f612d69ea0..2b1351c30c6 100644
--- a/include/linux/kasan-enabled.h
+++ b/include/linux/kasan-enabled.h
@@ -4,9 +4,15 @@
 
 #include <linux/static_key.h>
 
-#ifdef CONFIG_KASAN_HW_TAGS
-
+#ifdef CONFIG_KASAN
+/*
+ * Global runtime flag. Starts ‘false’; switched to ‘true’ by
+ * the appropriate kasan_init_*() once KASAN is fully initialized.
+ */
 DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
+#endif
+
+#ifdef CONFIG_KASAN_HW_TAGS
 
 static __always_inline bool kasan_enabled(void)
 {
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 890011071f2..51a8293d1af 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -543,6 +543,12 @@ void kasan_report_async(void);
 
 #endif /* CONFIG_KASAN_HW_TAGS */
 
+#ifdef CONFIG_KASAN_GENERIC
+void __init kasan_init_generic(void);
+#else
+static inline void kasan_init_generic(void) { }
+#endif
+
 #ifdef CONFIG_KASAN_SW_TAGS
 void __init kasan_init_sw_tags(void);
 #else
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index ed4873e18c7..525194da25f 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -32,6 +32,13 @@
 #include "kasan.h"
 #include "../slab.h"
 
+/*
+ * Definition of the unified static key declared in kasan-enabled.h.
+ * This provides consistent runtime enable/disable across all KASAN modes.
+ */
+DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
+EXPORT_SYMBOL(kasan_flag_enabled);
+
 struct slab *kasan_addr_to_slab(const void *addr)
 {
 	if (virt_addr_valid(addr))
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index d54e89f8c3e..32c432df24a 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -36,6 +36,17 @@
 #include "kasan.h"
 #include "../slab.h"
 
+/*
+ * Initialize Generic KASAN and enable runtime checks.
+ * This should be called from arch kasan_init() once shadow memory is ready.
+ */
+void __init kasan_init_generic(void)
+{
+	static_branch_enable(&kasan_flag_enabled);
+
+	pr_info("KernelAddressSanitizer initialized (generic)\n");
+}
+
 /*
  * All functions below always inlined so compiler could
  * perform better optimizations in each of __asan_loadX/__assn_storeX
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 9a6927394b5..8e819fc4a26 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -45,13 +45,6 @@ static enum kasan_arg kasan_arg __ro_after_init;
 static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
 static enum kasan_arg_vmalloc kasan_arg_vmalloc __initdata;
 
-/*
- * Whether KASAN is enabled at all.
- * The value remains false until KASAN is initialized by kasan_init_hw_tags().
- */
-DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
-EXPORT_SYMBOL(kasan_flag_enabled);
-
 /*
  * Whether the selected mode is synchronous, asynchronous, or asymmetric.
  * Defaults to KASAN_MODE_SYNC.
diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
index b9382b5b6a3..525bc91e2fc 100644
--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -45,6 +45,8 @@ void __init kasan_init_sw_tags(void)
 
 	kasan_init_tags();
 
+	static_branch_enable(&kasan_flag_enabled);
+
 	pr_info("KernelAddressSanitizer initialized (sw-tags, stacktrace=%s)\n",
 		str_on_off(kasan_stack_collection_enabled()));
 }
-- 
2.34.1


