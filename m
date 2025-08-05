Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A233C87FDA
	for <linux-um@archiver.kernel.org>; Tue,  5 Aug 2025 15:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DdpO03g2oqaaq9F6m1+GGOlZl0qQTOQbdkE3YGqW9w0=; b=4IErp5W+d03oZAi36MvJjqhfpx
	FnSkuNDBGqiZnYaiVHVbPyixg2aQKTrF0s5kYuynKbitdLTee4MlxNGqIRmax9erawap4jN71VzDw
	ovH4aaaA1rzJ4Cm+9pOkvKt+y/k2DwGjXuNkzv90nZ+9uQimBvj3gmChhYa1uRe1hWyJxMXXXJaEG
	gGb+fSxZCS1B/CgB2UzYzGEJp34TbOzoP2Z0wDF7A9Vvdx5MTHeaznZk1IE1C44Q5RoXgNmVDsc0E
	YW9mDvGoS2COEge5ICK9AAtZ0G7jIbPEc1ufkgMXvsIBIwUX2UYMXmc/KEQU3l7F1iBALRwmPEJyt
	VBKnUdYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujJkl-0000000DAoN-3HNB;
	Tue, 05 Aug 2025 15:39:03 +0000
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujIcr-0000000D0bE-0kUQ;
	Tue, 05 Aug 2025 14:26:50 +0000
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5561ab55c4dso6047226e87.2;
        Tue, 05 Aug 2025 07:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754404008; x=1755008808; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdpO03g2oqaaq9F6m1+GGOlZl0qQTOQbdkE3YGqW9w0=;
        b=Wq0Nh/Wa63ibLjw9YZmEEr/2vYF4UTnEH4oSyu42Pj3MG2UXk+QZ0NvmGiLWlsYmH7
         OGucOzvJFlAxnlJofARHo+DN2Q6L50RKKJlt1/f1cDVZGeKLpNko19hqqB9hAomOYHBw
         CB663QyxwFBBssi6U1sIpSxBGgje/fEf+g5tSLPa76s4x0GnOt8xkfhP6RIn7FZyzMBI
         s1cyNlWAr7YVPhyCkLI6aZbgQ4gJQvHP4sux3clzF+JQLxGTMfs/63CEtq2c/w2p2jbl
         yXXcPCsemPiaquwx04UD5D1RzJ94rgOm5+y12bISzHwGQTBlEjJB3XUoUhRoFTGlNG5C
         3m0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754404008; x=1755008808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdpO03g2oqaaq9F6m1+GGOlZl0qQTOQbdkE3YGqW9w0=;
        b=hRXNLqrHSaTplEnN1El4XN7VhXHRjMt6FrdF5Ay8bhDNCllI7HQugkDYInjFk487tL
         j3ENomJQv/z7pUbFRBuW6DbrFUWLsxu/+BYZZ/SgQhkYposMjQhxnqxHH0vEvcrpafK1
         AzVZ//vZpsLau5rSQISJkhRdMmbIBIGw++D/3itNDOceIPDnNAN4Y0JLZ3pEQ2NgOnyM
         0zs0fHriOQAsrgGtJ1/srcvgi4pEN8zI9ECCa4J/ojjH+5tzZ0JwaU8holn6eg4F4O31
         hvP6WMC2iFfRq6GbGk0krzFnarQRWcPhHmlmsaxorwj1wKIy/l7WGeMhnvAOSBpzHMHm
         VZjw==
X-Forwarded-Encrypted: i=1; AJvYcCUrHOHvsCzAVs0WII9kI+U1BJxoqKI4X0vyMdDVD6yJKGFXx4uvnotnNETmokw7scE2xmAezL2IHj1vMA==@lists.infradead.org, AJvYcCW9pRbLo5Jdr6dNUnF3R0viJ49lq6drBWPdekl0LGALIkbHe5omxir5xYdm8Bc9JYtHZSIrhwXwJn0=@lists.infradead.org
X-Gm-Message-State: AOJu0YyREbsTL5NkA2mt1IADDnP3SavRcUSv8CYCe0IUvBiM9lG01nfm
	rn99Vb27jgCfPYlk9r8lEfAnLSN78kjtKEZsbmcXJZVfAxhxbr1VPQFw
X-Gm-Gg: ASbGnctL1mK4HP9KZBv2GTUNKvYFDjy6u4l9hj4Q/FqwAASBfqSYAAvFjjojMvb1g8p
	B6QoZcGLFDaUws80HTjvKO88u4beMMTl8o0GyFp2iJKOzCXgJH6eAnfAaSsMo22JKhZl0SJrwry
	ABz3ovBcU5uZqcXWI1IMM4CZAm9ydezqzUYRyODT2jpvNL5jCpLb1kDmvPM+ijit/Ubg9PQ3Xmk
	O6Ptppx7nLbYVSFgeUga6CRFyjc48NKtwLM+PMWxPWrQp43JcYsyqRi8p+e/fVW10zzaQJb95Cs
	+ZGxJMzbMLbSoKnA9+zo9ozujPqRnOBFk/YB0T7UYqrv589/37nwzvIt664gFMHwRPlUJLeP0CC
	fhFaczL3y94MdgGlx0+xp0IUhq8Yp0YGH46LNobiplmIiQR1kliDDqPuk1bR3rJ8YLw/uXQ==
X-Google-Smtp-Source: AGHT+IEVcUaDrsN/KncF3Ds7Ejr3CDmhOGcodfBsVHrYzHQORJKCgwrZQppnXPfaGPKlSAziWl9h7g==
X-Received: by 2002:a05:6512:1254:b0:55b:842d:5825 with SMTP id 2adb3069b0e04-55b97b9395fmr4615455e87.43.1754404007496;
        Tue, 05 Aug 2025 07:26:47 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889a290fsm1976379e87.54.2025.08.05.07.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 07:26:46 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: ryabinin.a.a@gmail.com,
	hca@linux.ibm.com,
	christophe.leroy@csgroup.eu,
	andreyknvl@gmail.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	zhangqing@loongson.cn,
	chenhuacai@loongson.cn,
	trishalfonso@google.com,
	davidgow@google.com
Cc: glider@google.com,
	dvyukov@google.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-mm@kvack.org,
	snovitoll@gmail.com
Subject: [PATCH v4 8/9] kasan/s390: call kasan_init_generic in kasan_init
Date: Tue,  5 Aug 2025 19:26:21 +0500
Message-Id: <20250805142622.560992-9-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805142622.560992-1-snovitoll@gmail.com>
References: <20250805142622.560992-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_072649_230242_CDA45F3E 
X-CRM114-Status: GOOD (  11.04  )
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

Call kasan_init_generic() which handles Generic KASAN initialization
and prints the banner. Since s390 doesn't select ARCH_DEFER_KASAN,
kasan_enable() will be a no-op, and kasan_enabled() will return
IS_ENABLED(CONFIG_KASAN) for optimal compile-time behavior.

s390 sets up KASAN mappings in the decompressor and can run with KASAN
enabled from very early, so it doesn't need runtime control.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/s390/kernel/early.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 9adfbdd377d..544e5403dd9 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <asm/asm-extable.h>
 #include <linux/memblock.h>
+#include <linux/kasan.h>
 #include <asm/access-regs.h>
 #include <asm/asm-offsets.h>
 #include <asm/machine.h>
@@ -65,7 +66,7 @@ static void __init kasan_early_init(void)
 {
 #ifdef CONFIG_KASAN
 	init_task.kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized\n");
+	kasan_init_generic();
 #endif
 }
 
-- 
2.34.1


