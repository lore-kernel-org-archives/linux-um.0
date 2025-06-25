Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51661C7115C
	for <linux-um@archiver.kernel.org>; Wed, 25 Jun 2025 11:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8HfJTJJcJZY7/fCA0Tiz5Rc62kUV3pDrNC7eedpHA74=; b=4qw2/FoIsuzLdFDhHP4iHI07zD
	aRAC0xM3bF7fgZp6ZgOGzUavjNrckpaAg8qVqab0DU2qUg8xCc93sSBWn4WhbVkh6BdQ9GhQYudEc
	dgS7LoMlTUuQf5FQRCzrw3CtN1NFVytWY9U9kepIelbWiumQvH9eWHGXf3fYB7laEIxOYrqArQBTo
	oSnPpul2a/VtxEeCWYNqt7/2LIqgj95xMf/ue9bXXNC+BGTDPWc/zIjqjF1iN0rskyhvAG10y/B3+
	K8RFsCSv5RAfH5tCzjvkao9108IIRQENH1vv5imofQ4qYACzQj+Kz5NGOX27h4Kw9pSQN5Ar/hm3b
	BLfVzNbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUNx3-00000008PjW-3LcC;
	Wed, 25 Jun 2025 11:06:01 +0000
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUMom-00000008Cwb-2KN7;
	Wed, 25 Jun 2025 09:53:25 +0000
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-32b78b5aa39so65437301fa.1;
        Wed, 25 Jun 2025 02:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845203; x=1751450003; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HfJTJJcJZY7/fCA0Tiz5Rc62kUV3pDrNC7eedpHA74=;
        b=ghp23qTvsZpDnzeXAhgip/OBlTBk9h7yF5aPX4bAztxrW+A8dd5LVw4dXHjmOAtnLm
         UJgKc6LnIZd44QqfpRQNtMRP5Ct61/Zo8FWfyzZ15YBY9na033HzyFNtrnRJMkonECzS
         coh2vuBXy8wJQQWwnhvOTqmhTDW9QE22KhFJGW/TDy6NbwCsKMlZW3mSuuOlVk+EGjCm
         MJrVhEv5JhtL2/AmuGspTdqZoFqyzYA9RbgdaJWEPpY5YftDmpkufu6x81MUD9Of/Qxu
         YIiMforK7JpHb94CVdtOGimvWhskNgnANqSj4JBjADMemLLQnDUgNCNtn4TbcWuCoAFl
         cPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845203; x=1751450003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HfJTJJcJZY7/fCA0Tiz5Rc62kUV3pDrNC7eedpHA74=;
        b=ZhkwxkXD8tZvrSE55f08XJtJeECRGZch052NMJZ0dyB6OVpPcOMApZZAjVnfCgH0jP
         5xEboWNM9PTBjm84LaVN+XuosRK5ku2v+tLkCEOXVw6cMq7MDEfiwBEp1LW1mIca2eZB
         eK8pDO4mG6BiUPBYaLV3QT4K/vjg+wkZCTbqpq69LnH1GTGX36BYxb4OZzmtF5ze3ibP
         sACTjKxSvWcsIMVd2/J4tOMsfScSGcC086CHwTc5Vd4SiRVCY0fyViRgwoIdl17JZX1l
         XROJBtpriwZ0vBwtaAtLKWrX2kik6X3sxyN4XT1Wab0qUXZdnQox0UcPhhaVc2WDWFVq
         Q9ig==
X-Forwarded-Encrypted: i=1; AJvYcCUkcWTyPbOvy/C6yvbMHuNWTr5/uy+sRxnYKLXF10voBdKYW9mn7KWFq1RP8Ysi59gKP/TI95a/4/FzxcxXnrZq@lists.infradead.org, AJvYcCVBw4WZKkheDHFTRL4FsBdZcGf40nEP6b3OwYUYCgdX3b0PnijaW/SozvVfmGyHS3c95IgQnqUSQjM=@lists.infradead.org
X-Gm-Message-State: AOJu0Yx/spmUBZW0yV2fKk0OTtLyQMS58piUdJIq8JK1V9h5Uo5zOCwU
	XTsaYgMTlRuQbhKc3uh76BmT3X0KjQmC4ZD1gPlevu6BrHOn1jW1ywNL
X-Gm-Gg: ASbGnctd/gjP1hrOHVny1+iZgAkiYITEEWOttrpX1zjTNlXVwvsercKZhANZZFJokkN
	zRbHrS8Gc67oUZk8+0OTrLOlnLosarR9xiJTke2ST23XEcAcr2MB/niA6gVvosVFQT/OOgD2NAQ
	JE2zHDhCvsQ/Ga7sFY0igQWgZErEX+SZ9d7NeRLMMWbSYryyWdBeWKvYQqMKpkXdFpokmcEHJKZ
	sUJZUPkmYeGwurqmZIa8d9UD5OtS7r2slAvMTc4xlICB1S1oa6L/w+JzZWhKsAzYtlq98aTEaSg
	3QH8wcc2SM12582Ad2//GHvqz6UBaG3zofIko8cGtyIQXJIegs/B1cUXiSFCdoOfXUEBqX0Z2sN
	f8VuGfzyCAWLCes2n5gyzKqR7cplZlw==
X-Google-Smtp-Source: AGHT+IGryY1FCOgoaOa1ABgKWf+F5LHoFKkqdltui071JTPn8wvOuq6kBWhaIRALdveundDdtHS+Sw==
X-Received: by 2002:a05:651c:31c:b0:32c:a771:9899 with SMTP id 38308e7fff4ca-32cc648af6cmr6208261fa.9.1750845202774;
        Wed, 25 Jun 2025 02:53:22 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a36c0sm19311851fa.62.2025.06.25.02.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:53:22 -0700 (PDT)
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
Subject: [PATCH 6/9] kasan/um: call kasan_init_generic in kasan_init
Date: Wed, 25 Jun 2025 14:52:21 +0500
Message-Id: <20250625095224.118679-7-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625095224.118679-1-snovitoll@gmail.com>
References: <20250625095224.118679-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_025324_595546_AEDCFCD8 
X-CRM114-Status: GOOD (  11.39  )
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

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
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
index 76bec7de81b..2632269d530 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -21,9 +21,9 @@
 #include <os.h>
 #include <um_malloc.h>
 #include <linux/sched/task.h>
+#include <linux/kasan-enabled.h>
 
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


