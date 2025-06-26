Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD51C7EE31
	for <linux-um@archiver.kernel.org>; Thu, 26 Jun 2025 16:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UAzHyennbJbJNQdO/m8GiAxn8DKdiS3FDiXvLMA3BPc=; b=TRv8rY1TE5Pce29CFQTk/S3wKK
	Kn38Kj+yW5SC/MUoerQDjg52MBsRTneFIW06VCFyojWqOXWba72ypfGjsNN86cVsH+SPfCLhX1KMm
	dQ/Ou0m6UwgBOex2QUsTkzQ6IhzEiUywgYMjLR3M0nCGZpR4eKmeW8xLpWe3fKa5c8TxqdcvJpPC3
	HDm17yx4wEa8Ns5UsrHMTBBI14CZB2z82Q+vK5xDBS76pKMJ5TFvg4QbmeUCgW2NFOwg5PlnCoZcP
	G1cZWkCnrE3Ht1UlOzSNqVSlKA1l15Ly7vy6BddAPg1NQi9MfdM3X4tt7v+Qw0ed5PaKoEgPvuijv
	PrH29KvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUpL6-0000000CFYz-0tGo;
	Thu, 26 Jun 2025 16:20:40 +0000
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUoaj-0000000C8Bf-1GmV;
	Thu, 26 Jun 2025 15:32:47 +0000
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-553cf020383so1233418e87.2;
        Thu, 26 Jun 2025 08:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750951963; x=1751556763; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAzHyennbJbJNQdO/m8GiAxn8DKdiS3FDiXvLMA3BPc=;
        b=UFbJz2OEUewycv3IPFTayVmUrsKl8Ls8/73LLmtQtmMd9DkAaqeek+pKKCXZBrcWHH
         TleQtF5pLb89C03TOZI44VttdcOCJhQRFx5HEQd98g2eXp/7PvqCEpnFG7Nxe2TjfXWx
         J/LQTWUyOvUQ4v/oqovc3N/5Guq1GHMqdLXJDVBXHmHsB7mMvkqap/B8AjC42zBy9x5h
         1K1sU9/uFNFqakbLQmEKTxjCbvau5btH6mCgEU1lmXRKneiV77HTAvShIwpQrSaXJL6B
         Av+g456EAZ3MnSJT8QbunFqzf04W/il/6pZtjIxo1K3CUXSjPjYHkoPqhY8jAHOfOJya
         QtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951963; x=1751556763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAzHyennbJbJNQdO/m8GiAxn8DKdiS3FDiXvLMA3BPc=;
        b=S3b/v0hDbSFMyAl1Uywx7kWJxrkWqNq1jys55lPxgvAPvMehGv6WDddUJtsA8ompm7
         SgFUkOoD1RHj5ug6VFPG2E3rUGd6SzwfgPURZIGXvmJbPTqx9JJk/ZCdu0msZHOCGOXS
         VkBCMrWqgt4NPtm9hjoPDkEPlwASzwNpKCE0Vohzc56UdLVVl/1TYcIR5k20CN69wMlm
         tHESKQ3rC1eaUAfmmdg08zRw7sXv0iASF6eoVnq58gRpp08hQ5wpcFKwiryTqwd1L0k9
         fs9ZsMUgrfHSNIue1A8lP8EbifIvSk6SFDtDZNREq4VK0wxue9pi6ZFtPKRhjxodJN0+
         CEuA==
X-Forwarded-Encrypted: i=1; AJvYcCVPcVvy05CsyzDipYXZW1XPTUehnz4y+UGfR3GCGOQSQyQm5axoOXrK5CUJxYU8VudU0i5Z/8eFpauabojvDFzc@lists.infradead.org, AJvYcCVdvTr4jol7fP/eWK7osts5sUUmMQpKLpEEzEUnwQPGxQufcbDPXEefrkMAHe5hBKFvhCnzwzrLEUY=@lists.infradead.org, AJvYcCWhDHmF40OkdHh6zo765nd7Mos18UVy5fZhZ78+cfMrOiwfj0G/GLQVUPeYRy/kbqgD4KVDICX/y1pY7bA=@lists.infradead.org
X-Gm-Message-State: AOJu0YwZkemHGYKbNWGHIlBYEn0ihZ8wnFBxDNJdM6a38+3rI/eoFj6+
	oPEyuf8aBJCG5ruAT640dWDrZz+dKunQn9ys4w/lY+oHD08jejlRTCCL
X-Gm-Gg: ASbGnctMKmAckgnVHdQfpSVheCrr/MV6v2ackV7LvPSt4Fz6bzGLDRLY4dymf9SHixC
	QJ+uVHHu0CGY80fE18vSJFN8Izi87CiraTCXnksnZwWaKSI1prhp9sARSZpWerhQSQln2ILQ0t2
	vgLqKvhwJaDFU0OYRrQd3GJ00NUescd4ZlOex1dNxapI/nZXeKR1fgEPLgfxqF0A5hX+ChghK4/
	1Fj/YEXPPvn4vZxijMViN1ddiAoJArKjpvL0m5tT3NYZxvFBzqkar+ECpKOfzeQxXdWOESoVsWt
	j6gqB0FHYpjzlfWQNw5dGI3vPrhc9jDU2YiPl30AdERKB2/+6yuFERhfCxTIVqhbu3ayBmmPmtH
	Uf7bT4Xca8tbMIbZuJUd0IiibuHGA9A==
X-Google-Smtp-Source: AGHT+IFtddewk+sZIWQ3c8HpfmVyVU50AdMchy9LvQ1Hdy+bQ74fAWulfETp69JVrreL6trc7kJUOQ==
X-Received: by 2002:a05:6512:2392:b0:553:5d4a:1ce4 with SMTP id 2adb3069b0e04-5550b467d15mr132805e87.2.1750951963311;
        Thu, 26 Jun 2025 08:32:43 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ce1fasm42792e87.174.2025.06.26.08.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:32:42 -0700 (PDT)
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
Subject: [PATCH v2 06/11] kasan/um: call kasan_init_generic in kasan_init
Date: Thu, 26 Jun 2025 20:31:42 +0500
Message-Id: <20250626153147.145312-7-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626153147.145312-1-snovitoll@gmail.com>
References: <20250626153147.145312-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_083245_347709_450F8AA5 
X-CRM114-Status: GOOD (  12.86  )
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

Delete the key `kasan_um_is_ready` in favor of the global static flag in
linux/kasan-enabled.h which is enabled with kasan_init_generic().

Note that "kasan_init_generic" has __init macro, which is called by
kasan_init() which is not marked with __init in arch/um code.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
Changes in v2:
- add the proper header `#include <linux/kasan.h>`
---
 arch/um/include/asm/kasan.h | 5 -----
 arch/um/kernel/mem.c        | 4 ++--
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/um/include/asm/kasan.h b/arch/um/include/asm/kasan.h
index f97bb1f7b85..81bcdc0f962 100644
--- a/arch/um/include/asm/kasan.h
+++ b/arch/um/include/asm/kasan.h
@@ -24,11 +24,6 @@
 
 #ifdef CONFIG_KASAN
 void kasan_init(void);
-extern int kasan_um_is_ready;
-
-#ifdef CONFIG_STATIC_LINK
-#define kasan_arch_is_ready() (kasan_um_is_ready)
-#endif
 #else
 static inline void kasan_init(void) { }
 #endif /* CONFIG_KASAN */
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 76bec7de81b..058cb70e330 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -21,9 +21,9 @@
 #include <os.h>
 #include <um_malloc.h>
 #include <linux/sched/task.h>
+#include <linux/kasan.h>
 
 #ifdef CONFIG_KASAN
-int kasan_um_is_ready;
 void kasan_init(void)
 {
 	/*
@@ -32,7 +32,7 @@ void kasan_init(void)
 	 */
 	kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
 	init_task.kasan_depth = 0;
-	kasan_um_is_ready = true;
+	kasan_init_generic();
 }
 
 static void (*kasan_init_ptr)(void)
-- 
2.34.1


