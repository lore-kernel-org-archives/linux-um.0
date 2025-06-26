Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6008DC7EE31
	for <linux-um@archiver.kernel.org>; Thu, 26 Jun 2025 16:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dIODlzXqnC6bR1NnIlD5Ra9HGYOoS6BNr32H/5XQfhE=; b=OISXiaTepvX77PoD0AGAplZ5K7
	Nc8NHB6o8nxCDrVfghNJeobzznkrAqkrpMxkWxTosJYhdN8xNYAfP7QZINmvYua863quen2Awfju6
	8ZhjOK25JzYGCloXS57SrkOI8IlgJcZAOJcne8xa3w5nEVeZqvUmAACQmscQxPlDt9oup1o6AZzeH
	nVBy1Wup9ngtaDzN9A+9RrIOCB8V2QCpnb0N9D/biFq0HNieAT+mAdre1QNbsccirSFvVDGgQFhcp
	RJJoMM+TNGAxWJk63Jwik6GPirl8E5nfoNeAQCX3NMIJtFk8xbqemlhqHK3DbIaSpmLZz7f7fcNIR
	Nb+4wMLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUpKv-0000000CFT4-0coS;
	Thu, 26 Jun 2025 16:20:29 +0000
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUoac-0000000C87O-3BrB;
	Thu, 26 Jun 2025 15:32:40 +0000
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-553b16a0e38so1245549e87.1;
        Thu, 26 Jun 2025 08:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750951957; x=1751556757; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIODlzXqnC6bR1NnIlD5Ra9HGYOoS6BNr32H/5XQfhE=;
        b=mohvYyh4ZU39gAdzH9QNjl+ABxliAt/KGXLB+4g0IggURYFDeh7FvKfaUtSUC9Ve0u
         4Zp7ZqWKDz16/FM2byWJSGyz0jRgZ0B7sGti6CvoqGsdqAylYW8wF84HR5tTdGgf3B4M
         uIyxQl5754rM9i9AbehDPj95dGk7t32ww1Xzqz1zvuveM4HW4SFLLEBkSe40nuCBZ+Oj
         Z+8Xm3OVHsz1neabFM1q1f2c1A/naybS7akXFVg2SAbPV941PCITGPfgC9YwCqGVX2mK
         jScUI9Y4lyJ9QQ5XTh4q7CSUUjwJizJHx8fTNdZa2v0dJp2SDa4MGPLGsQM6o5bETBXe
         DAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951957; x=1751556757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIODlzXqnC6bR1NnIlD5Ra9HGYOoS6BNr32H/5XQfhE=;
        b=oDXlBb3lW3OD/8ChTLpAMk7OWIlQ1aXEhar7O/J55d1ed+JG3K97l8Ne3ufNHrs5zE
         VDOaVDzZ03H+++JJf1FIPgnZEaNvxcD9xjD+CTKOZ67IjNGsgBWSnz/zKCgqAg0GzGDH
         QM+9lDBgWFb7/hUekv0Fk29VTlnT4Iq1kUFKaztKN4pKm+5VPitjRk1J1qHMSfcTeOFO
         cwyuLWNlYTeX7R/cpZYe9yH7IHnrya3x63ora8J85cO7rlpF1yQ/GmDkATnKkcNq3SUZ
         AuAXCpF4dlPcujmnUn3gnxb3TlZ7J29mNlvm+mjiMl5U1Q6zrChKYjB7TRw2D0Y66u0B
         2BFg==
X-Forwarded-Encrypted: i=1; AJvYcCUstmGvSjESt/K9uYrx7gCioDokyA1wPGSrUm29f+Dabm0teL3By8sHfk+6jLc98SyB7iE9GykDlQR7wN+g/ZuR@lists.infradead.org, AJvYcCVrLUoPS+SMHIp2/jc624MqORGQJ+O51zaXWBXvP/KTgDCQnfWboVlycbAdE2qW4ZqwFDjq3gdFyII=@lists.infradead.org, AJvYcCX2ftl9uUHzFismlJXFiWjq77fLkAgLEsbryKux+moPP1gctOg1w2Vk7oYeraibMcUIXSgaAu8PEXiRj6Q=@lists.infradead.org
X-Gm-Message-State: AOJu0Yzi/2hs8UObWsdCCxT4zyYYoTvZNQsG/9OgQNb+kr3cb6teacPG
	5EkwX3hfThLfda3S67B6YG+r8blB4UbWWeSFRE/JjxncMaRHxzV/qucJ
X-Gm-Gg: ASbGncs1cmHE+I9QNB/2iNCQpZVxds4tC+RcVx2oWtUxT5djWoancob8ipL01F6yPjz
	g6iMMBz60uyHGHHZ572fXpNpYZwGzS/CVmT9gLAqBRdbaQs4YAJJTae+qCJeC6tEWiK8f1ogfX3
	H5whZnFLNGWXl2nKkj7UlrG4Smsl9BdpyO+7x6bAUzqpeIuI8ChDCSmVt2auku+5VyTKu9ClQsV
	ab/ACJFlTcmFxT2GTur658kt4qT7DBJGvqUmhLangSur5XM8cFV5IWyEKJTCagv+FLoDsaXrapN
	6p4Xv4FRU4v0bCt7uhXhQIUG6JiC/hCEjD8RTGr37PqDBBuVCebYnl8osb+xsAC6NVtTjtfJ7v5
	0m9UlM0WuWq6qHi2O3uqVObmZKCRqjg==
X-Google-Smtp-Source: AGHT+IGOOgR6U3IUglZM4Cl6ycrypcWsOKlsDtFSbRY/qbGVasvQKBWsuTTYRYjSxtgLuzO8PX+T5Q==
X-Received: by 2002:a05:6512:b8a:b0:553:a490:fee0 with SMTP id 2adb3069b0e04-554fdcf457bmr2652845e87.10.1750951956874;
        Thu, 26 Jun 2025 08:32:36 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ce1fasm42792e87.174.2025.06.26.08.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:32:36 -0700 (PDT)
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
Subject: [PATCH v2 05/11] kasan/loongarch: call kasan_init_generic in kasan_init
Date: Thu, 26 Jun 2025 20:31:41 +0500
Message-Id: <20250626153147.145312-6-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626153147.145312-1-snovitoll@gmail.com>
References: <20250626153147.145312-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_083238_795149_F37DDF1D 
X-CRM114-Status: GOOD (  12.52  )
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

Call kasan_init_generic() which enables the static flag
to mark generic KASAN initialized, otherwise it's an inline stub.

Replace `kasan_arch_is_ready` with `kasan_enabled`.
Delete the flag `kasan_early_stage` in favor of the global static key
enabled via kasan_enabled().

printk banner is printed earlier right where `kasan_early_stage`
was flipped, just to keep the same flow.

Note that `init_task.kasan_depth = 0;` is called after
`kasan_init_generic()`, which is different than in other arch
`kasan_init()`. I've left this unchanged as I can't test it.
Defer to loongarch maintainers.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/loongarch/include/asm/kasan.h | 7 -------
 arch/loongarch/mm/kasan_init.c     | 7 ++-----
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/loongarch/include/asm/kasan.h b/arch/loongarch/include/asm/kasan.h
index 7f52bd31b9d..b0b74871257 100644
--- a/arch/loongarch/include/asm/kasan.h
+++ b/arch/loongarch/include/asm/kasan.h
@@ -66,7 +66,6 @@
 #define XKPRANGE_WC_SHADOW_OFFSET	(KASAN_SHADOW_START + XKPRANGE_WC_KASAN_OFFSET)
 #define XKVRANGE_VC_SHADOW_OFFSET	(KASAN_SHADOW_START + XKVRANGE_VC_KASAN_OFFSET)
 
-extern bool kasan_early_stage;
 extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
 
 #define kasan_mem_to_shadow kasan_mem_to_shadow
@@ -75,12 +74,6 @@ void *kasan_mem_to_shadow(const void *addr);
 #define kasan_shadow_to_mem kasan_shadow_to_mem
 const void *kasan_shadow_to_mem(const void *shadow_addr);
 
-#define kasan_arch_is_ready kasan_arch_is_ready
-static __always_inline bool kasan_arch_is_ready(void)
-{
-	return !kasan_early_stage;
-}
-
 #define addr_has_metadata addr_has_metadata
 static __always_inline bool addr_has_metadata(const void *addr)
 {
diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_init.c
index d2681272d8f..cf8315f9119 100644
--- a/arch/loongarch/mm/kasan_init.c
+++ b/arch/loongarch/mm/kasan_init.c
@@ -40,11 +40,9 @@ static pgd_t kasan_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
 #define __pte_none(early, pte) (early ? pte_none(pte) : \
 ((pte_val(pte) & _PFN_MASK) == (unsigned long)__pa(kasan_early_shadow_page)))
 
-bool kasan_early_stage = true;
-
 void *kasan_mem_to_shadow(const void *addr)
 {
-	if (!kasan_arch_is_ready()) {
+	if (!kasan_enabled()) {
 		return (void *)(kasan_early_shadow_page);
 	} else {
 		unsigned long maddr = (unsigned long)addr;
@@ -298,7 +296,7 @@ void __init kasan_init(void)
 	kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_START),
 					kasan_mem_to_shadow((void *)KFENCE_AREA_END));
 
-	kasan_early_stage = false;
+	kasan_init_generic();
 
 	/* Populate the linear mapping */
 	for_each_mem_range(i, &pa_start, &pa_end) {
@@ -329,5 +327,4 @@ void __init kasan_init(void)
 
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized.\n");
 }
-- 
2.34.1


