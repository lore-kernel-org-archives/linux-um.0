Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED84BC7EE33
	for <linux-um@archiver.kernel.org>; Thu, 26 Jun 2025 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gODL4ePLEui+bgBCtMqPW0nf/RnbL8ytBUu0XwvP9Tc=; b=e83KfGub4ShgSNJpAw3NG6XGHK
	SbjF9gXQu6VGId1tjFsYJ4rqkImyFNj0cwhQYCBrhsK3fE4L4QEUYoLlQsrfWzVrkHC48ugX6kD5G
	10KXHHB29LSkYISlJGOuvY0ypq3DFeqSTFigaAMORlMcrWHmFh+w0MSaFC/KGkhksM1QosDjQ6JR4
	tQ5JTuCjNI/0lNVNK7tFQ1RR2pN1yMp5cU7qXODoeC+aMRgad+xNwzVUdavuGNI/OMAyt7OBguIIl
	2l5oFUCVFGzx7+3jwIiPUDVLMovrB/Yx+32Zwomm0eYumoGv1OQ9k9AXpk8rgIJbZRBSk0FZa/zaO
	JaUR7s2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUpLC-0000000CFe7-2cRW;
	Thu, 26 Jun 2025 16:20:46 +0000
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUob2-0000000C8My-2MQF;
	Thu, 26 Jun 2025 15:33:06 +0000
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-54998f865b8so998927e87.3;
        Thu, 26 Jun 2025 08:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750951983; x=1751556783; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gODL4ePLEui+bgBCtMqPW0nf/RnbL8ytBUu0XwvP9Tc=;
        b=hl+dYfVTYx4FqSYzrfgU1DA1zE9VCBO3B6I1H/dqKKrm8pX0OAb1rTHjLrjgPwVHN7
         XMUxyZnbvnaWQXcA6EfBE8BnzgpqVGPVLWTS7wWnklYXLnyoSmcvmaLSQx1/tjKyA9qq
         My/AEMdoA7Fjn66sz9PblDYoaDtCdtak7iVyNoE2JgB+OIn1QWlKVa+bowsYq9NyKFk9
         xjvzjfg0Zt/LXlNCUWQpXy/Ws0J3+VzWEe9Wo7+Vd6cwdRgIg7MekxoWb+W5wXeNQSlg
         4eyZWgvH3stw+P1pnogpcxYhvf8eixe1/6GlpHkl7BzGHPDzxQVPsso7pGfQEwBCnZTk
         ahvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951983; x=1751556783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gODL4ePLEui+bgBCtMqPW0nf/RnbL8ytBUu0XwvP9Tc=;
        b=FQDqN66YgGRxjBBB2VIcF+QCpmQNi2TdQ955Inn5l8PoM1RcsaPh+5X+l43ZGdsPT0
         aSq7mg67WiHTQNAFuj/ohtgD8bolaWcd/rg8gog3tiJ/c6Q8eb0bLj56kmRRhBxZQDGU
         gS1V9WbJQ9tKLL/GSEmtCKoso7/WHyVzB+IplQiFZtoAdGSAqgAD/ySugRXxAzkeBz+T
         bt7PH839NTkQgXxyR8jrtBZgnb+YA1vZjEIYvHplfUZHt3P/WkSl0XmVv/Dqz03KiPBl
         31DeGoyG6Iazh+3LcEWfZpZrJdGrTMUc9u3ZUUzMNZBvf2LT4QjN2tcvWYOQria13OKi
         L0WA==
X-Forwarded-Encrypted: i=1; AJvYcCVAqNQ4uA+wBG/GExZQjxrr+zMfXyo7GqmOjpVYtbItjuDh8BXVpae2PJcwQMqfFqhhwuvx+Z2PNS9kwgKpvu/p@lists.infradead.org, AJvYcCVEUEuXPrwoXWJNhem2wSjsD+MTggMLL89Qr+8fjzm+FaB64ASyLDL8m0y6Sv43dsL8LZMe7zzkzL5QtA8=@lists.infradead.org, AJvYcCX+WlsORZqw0pFmRzL6zlW+p+A/lUieg2spoicdt2E4BXrRk377mKiqzwFM7qiytBYQT+UoiRa5jwM=@lists.infradead.org
X-Gm-Message-State: AOJu0Ywc+CdJlc2Y6M2Q+b7yimzt5e8HBhaY6DMKR+Vc+gYjqpSYB3GX
	yfrqwT7bMoGghpjVLYIiGpMUsG+xt6Yknxt+P245YDq9h5mjHV0FjC2m
X-Gm-Gg: ASbGnctsqIEibrzLumTSmB70fqhH5Es1hwpWiZfixmaKA0e7wBm1bYSXejUXcRHHK28
	vXx1WgPq3hFbS7xWbbQb+ebfFs9Rau5wltXLk+oFUcyL/8wBMN/y4Un2RwVLipS1pyNQ8xImN87
	9zSdSkHUr80aDYBx6f9Oxs35C9rxxQ50a8VzfjqKm7aAMXS6Bu50buERkMPQCqulRW0O/qoC/dl
	IjT8EoJvKZWDPNE3v4AQWkFyaVFgD+0JKEWDqv9h9+FvYtmzLJiizTFBavy3bQ93ubRzq1ypyYb
	6+KymeJ78zpiq14ZxQG+fuaVZx5slBoXSfesb+TCh/RsVQy0YrVqpX2c1pYWDKNqaR3Aaup5bfr
	OITUHCQGVF81wPxGNEgaoaV6nhdk14g==
X-Google-Smtp-Source: AGHT+IFtokin1pGKu8SGoAO+egXDXmR37EPc9QSc1BH26CQqVKh0GZxc7OuPefULxYvAjMzQKpLkUQ==
X-Received: by 2002:a05:6512:318f:b0:553:ae47:6856 with SMTP id 2adb3069b0e04-5550b474cafmr117706e87.10.1750951982600;
        Thu, 26 Jun 2025 08:33:02 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ce1fasm42792e87.174.2025.06.26.08.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:33:02 -0700 (PDT)
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
Subject: [PATCH v2 09/11] kasan/powerpc: call kasan_init_generic in kasan_init
Date: Thu, 26 Jun 2025 20:31:45 +0500
Message-Id: <20250626153147.145312-10-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626153147.145312-1-snovitoll@gmail.com>
References: <20250626153147.145312-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_083304_600328_F0E06BE7 
X-CRM114-Status: GOOD (  11.09  )
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
Also prints the banner from the single place.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
Fixes: 55d77bae7342 ("kasan: fix Oops due to missing calls to kasan_arch_is_ready()")
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
Changes in v2:
- Add kasan_init_generic() in other kasan_init() calls:
	arch/powerpc/mm/kasan/init_32.c
	arch/powerpc/mm/kasan/init_book3e_64.c
- Add back `#ifdef CONFIG_KASAN` deleted in v1
---
 arch/powerpc/include/asm/kasan.h       | 13 -------------
 arch/powerpc/mm/kasan/init_32.c        |  2 +-
 arch/powerpc/mm/kasan/init_book3e_64.c |  2 +-
 arch/powerpc/mm/kasan/init_book3s_64.c |  6 +-----
 4 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index b5bbb94c51f..73466d3ff30 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -53,19 +53,6 @@
 #endif
 
 #ifdef CONFIG_KASAN
-#ifdef CONFIG_PPC_BOOK3S_64
-DECLARE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
-
-static __always_inline bool kasan_arch_is_ready(void)
-{
-	if (static_branch_likely(&powerpc_kasan_enabled_key))
-		return true;
-	return false;
-}
-
-#define kasan_arch_is_ready kasan_arch_is_ready
-#endif
-
 void kasan_early_init(void);
 void kasan_mmu_init(void);
 void kasan_init(void);
diff --git a/arch/powerpc/mm/kasan/init_32.c b/arch/powerpc/mm/kasan/init_32.c
index 03666d790a5..1d083597464 100644
--- a/arch/powerpc/mm/kasan/init_32.c
+++ b/arch/powerpc/mm/kasan/init_32.c
@@ -165,7 +165,7 @@ void __init kasan_init(void)
 
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
-	pr_info("KASAN init done\n");
+	kasan_init_generic();
 }
 
 void __init kasan_late_init(void)
diff --git a/arch/powerpc/mm/kasan/init_book3e_64.c b/arch/powerpc/mm/kasan/init_book3e_64.c
index 60c78aac0f6..0d3a73d6d4b 100644
--- a/arch/powerpc/mm/kasan/init_book3e_64.c
+++ b/arch/powerpc/mm/kasan/init_book3e_64.c
@@ -127,7 +127,7 @@ void __init kasan_init(void)
 
 	/* Enable error messages */
 	init_task.kasan_depth = 0;
-	pr_info("KASAN init done\n");
+	kasan_init_generic();
 }
 
 void __init kasan_late_init(void) { }
diff --git a/arch/powerpc/mm/kasan/init_book3s_64.c b/arch/powerpc/mm/kasan/init_book3s_64.c
index 7d959544c07..dcafa641804 100644
--- a/arch/powerpc/mm/kasan/init_book3s_64.c
+++ b/arch/powerpc/mm/kasan/init_book3s_64.c
@@ -19,8 +19,6 @@
 #include <linux/memblock.h>
 #include <asm/pgalloc.h>
 
-DEFINE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
-
 static void __init kasan_init_phys_region(void *start, void *end)
 {
 	unsigned long k_start, k_end, k_cur;
@@ -92,11 +90,9 @@ void __init kasan_init(void)
 	 */
 	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
 
-	static_branch_inc(&powerpc_kasan_enabled_key);
-
 	/* Enable error messages */
 	init_task.kasan_depth = 0;
-	pr_info("KASAN init done\n");
+	kasan_init_generic();
 }
 
 void __init kasan_early_init(void) { }
-- 
2.34.1


