Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA860C7EE33
	for <linux-um@archiver.kernel.org>; Wed, 25 Jun 2025 12:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aOegpAuvdkFcZey7AJnC2ppf18uuNZebWg0aRe4Uqy0=; b=Xw/d2VeknCEmia9G3KV8Cz3k06
	0v+ibzCyZ/r0eyD368FKvK2L2ACHX1iTfotc5HNfloAWl7nWm5fdEky0mI33wmyqemMVVwayXKjl6
	LLeZkQ68yfSkiL252xNgLb1oSPFAQL2v9KazCQImYRj+xZTIbAoKBzNmL+uGM13rsUUexFSreR6RS
	7w7nukOucAbYYwBG/ogCxjO6MG8CE9SUJ7IvBxOCjyoyQrTs7aaAVM+AHopxuzR00kpImKmWAULjS
	dUYod+KvBWEcZaZlQ1oUmPCT5uwAfTc3Q//XauYO79Y+8qER0P917tgqtQZpWGfKcu2Hkj8IoIuVM
	hHuaBr7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUOvq-00000008a4U-3DZS;
	Wed, 25 Jun 2025 12:08:50 +0000
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUMof-00000008CuP-3FSK;
	Wed, 25 Jun 2025 09:53:19 +0000
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-553cf020383so1334011e87.2;
        Wed, 25 Jun 2025 02:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845196; x=1751449996; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOegpAuvdkFcZey7AJnC2ppf18uuNZebWg0aRe4Uqy0=;
        b=MbfQa6LLULiOPeE4i6pwrW5yUkeqNpldEGfKZGUZXpW0iXSgI9VmZXY2ShSrXEFycB
         Tvu0Tp8p4i2D929v1eTd416xWqc/SPlP9224SL/IKx4OrIKhhlDYaMKs2w1ooRs6CwGo
         3RD31lic4OqWvHwOM2ZumzM69V3NvMTBSFS1M0WF/kFgS+xM/D9ZVrPsnRG61AaP3AF3
         dMdPNUBAHaHYfQbCjparDSk1ccNfdgWRyPNoVujdGo3JjSjL6Dk0KKKQzKlujZQeB24X
         yLMLAQRuQY8kIvJgnUNepYzDG+lgKrBe6neNtFk0I1VIyx6nUPkxbA9gZEc5ZikJAgEf
         nc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845196; x=1751449996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOegpAuvdkFcZey7AJnC2ppf18uuNZebWg0aRe4Uqy0=;
        b=IrS5ZPCNS6EiQasOENhKkoZVqjtNqwYep+51nLGCEQgoI1coJ403GqiFrGKgCmos8E
         +n8zckvzyAdSzi1LEpyfs3z+1tLNsJmB7DY5oqNh/pXP+t0rPoeAVUoPvk9lk9+5u5dB
         XTfhpqv7a0giGm60dU2/uxYMfOeGxI9WVINfvySYPQ+ubIVJS/LVO2RjThqALvc+4bki
         8t4Brcuua3m8hFZHcEHaFwJH+7R/dgrla2SoMn1TODT9VAatU1wv2GLp9gwLB2R2v7Ht
         GVmEZYwlpaZgSDmX7quHE/okT1gSr7YAD3Dn8xReKyaFIHGmgx2rNO7aGiu37x+yD3dM
         m3cw==
X-Forwarded-Encrypted: i=1; AJvYcCX0eTvYl9t6Ak4Eijkvbwjf6WOOy/dqDPPAPlEH+OgkA8w8b5BcINLojC8+jZlP58zLqy6PrztRDGvDGrTGubjQ@lists.infradead.org, AJvYcCXMDURTZHLHf3s8G/ESmcPe18Qd4ztN78QLnd0LFyi4CDuIGVDULJMcZGYLCBDzVFeGZ5xnBCN9lQ0=@lists.infradead.org
X-Gm-Message-State: AOJu0YyRNTIj1uAZYHMwvVi1tUpjdPQnovemL+63FqodraDN0X9Hayig
	EGqIe4NKk6KhGyu6F68mQcs40EF1os27dakKgOfqRXSrMzEv1XOBRKk2
X-Gm-Gg: ASbGncuzAhKoEg5opBTpzIQLD7QqH68gr+cvU0qsG7LphcOivPh1DynCxeqxvvq1Pfq
	/Fme4wwKnz87SPtO6VUk1qGeTen4q9OfMpU0+eFn2y041nF7hRefGLeOOb9WEprXHT0qFodiR5a
	yXHWbaFeCPpW56e7Pd5SROEvRzNEK+kiTEoh7ynmeqOfDhX4z2Vv1m5gx1hC7CXJqNjupzprbWS
	to1pVTsiLnOc0fnci+qrHIK/sx77lKb4nnLUqK4ceo5NRu7enjnYDgrafqTi/AukLR8Q9o1Lglr
	+x+ZeEIWd0nWaDnpgdXFsIVBpgezKgzsAoJ6DXM8jDWx1GVTetnUjNvnLNAsX0e4Zvfl8Cn6LAQ
	2oyIRXqzxUAQchFTW14R8Z50sUWF95w==
X-Google-Smtp-Source: AGHT+IH5sVpXWqNvgigVbtHVAfe6SjaMuU3V6+6bSDasNHNXTwQEDyYqvBChJ5Rb3116y8fRmuAdlw==
X-Received: by 2002:a05:6512:b1d:b0:553:ccef:e31f with SMTP id 2adb3069b0e04-554fdd428c7mr668464e87.13.1750845195630;
        Wed, 25 Jun 2025 02:53:15 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a36c0sm19311851fa.62.2025.06.25.02.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:53:15 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
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
	akpm@linux-foundation.org
Cc: guoweikang.kernel@gmail.com,
	geert@linux-m68k.org,
	rppt@kernel.org,
	tiwei.btw@antgroup.com,
	richard.weiyang@gmail.com,
	benjamin.berg@intel.com,
	kevin.brodsky@arm.com,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	snovitoll@gmail.com
Subject: [PATCH 5/9] kasan/loongarch: call kasan_init_generic in kasan_init
Date: Wed, 25 Jun 2025 14:52:20 +0500
Message-Id: <20250625095224.118679-6-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625095224.118679-1-snovitoll@gmail.com>
References: <20250625095224.118679-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_025317_812018_160EA6C4 
X-CRM114-Status: GOOD (  12.66  )
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


