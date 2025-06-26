Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1E7C7EE32
	for <linux-um@archiver.kernel.org>; Thu, 26 Jun 2025 16:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZBJYqNEFUsGcSKAGhcxt9dDlG97Ga+bpIV5ghyvlETw=; b=4tKRhzHdMjiKHKYOyBT91HUaHa
	pzkrAFnGOBqcfNcUWKK6Q5vxODNFicvAZ2DUHPfsx+rXO+8tp265f5GeajxTj+Pu5UiCFX0S3mk4c
	Krta62f7+Pa0TlPl+Wpe2dl4MLIfQphWTQ94gUglDoKBue4V5v5Sb2nNX+h5L+RwZ31bi0M0hhMXH
	cg2uBCIOuQ2Z3P+4OjIv/K9A3XIPtLleo6LHGk3qb7FQOJmHMpwd9dI+qknUoSBNa4SxKr6u2ySV+
	DrNx7ZSXsmNEQEjUuQa9j/Nb+oVzajngczv6pCjMaERdjtuWwXLYuNPxs55KoBlo5ITxFRogEdyly
	OnHPMVQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUpLB-0000000CFcX-1TiA;
	Thu, 26 Jun 2025 16:20:45 +0000
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUoaw-0000000C8J7-0KMp;
	Thu, 26 Jun 2025 15:32:59 +0000
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-553b6a349ccso1266248e87.0;
        Thu, 26 Jun 2025 08:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750951976; x=1751556776; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBJYqNEFUsGcSKAGhcxt9dDlG97Ga+bpIV5ghyvlETw=;
        b=hf1iYingVrVFxq0X1NW+LxC3Tddg3TOpoWjMg8l9qBCJtsBU36AHZ/qaoSq9aU4vwK
         BHIWkHfG9Jcn3QUt/0ZCtesYVFtUDB0YaKbkTX1LQ3XpfFlrd2HVXmJAg/VB9mR+HkM5
         ZsZ54X6RsOZU07eG+cgw/MrXXMuVoee0fY0zNIJ0P9beNmbFw9tSqSleTLs9nNwDaL1D
         cySslPrcxCDcVYUl2dw8jcTdQaCieT3HthssHDIylATpCYe84pWYKyxaxcIkbNyLkfR4
         Ug7Icrd34OTLr0H9wRj49r1TlW0EAypcMSS/GZV2os1y0FuSsq3IGj6Rg4CMN2hIKwUE
         YGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951976; x=1751556776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBJYqNEFUsGcSKAGhcxt9dDlG97Ga+bpIV5ghyvlETw=;
        b=c7ttiiqtYMWjND26fkxx0YhXNggsDKMNI3sxfOLI/gy7j2kl+1OG3nsuVtweE9aOx2
         3IqnqxtA4e0hsHMuEnVE6x5l3hXL3QcAMwGp3JzdxUVxCXUulpEpqvuRNqLBtm29G3zb
         SVP5Tadtn3FMld9nqSZj0vDJT0xTU+6VvPIzdkwzuPBasNAsCeLroYXj3qvUkE8pURdh
         /wBP0KkAfX/oANjFzEKUZQ4XO2NGTY9Bueqw8BQxowVwcu18wATft8jI0A2pDhCfJe8b
         amAqWqj+D19N3VOzYsKaeK5SX90+QfzJrMxnH6n1iZjuZGN+r3b9tuc7JhcUpdtLvRlS
         ZKSg==
X-Forwarded-Encrypted: i=1; AJvYcCUbjcJAwTh5FgrUQWfXxqvYLkg72g05Y4R4mtUsszXlhdeBxqeC+rddCex6WC6dbvM/NV9XzHcyTgw=@lists.infradead.org, AJvYcCVv9baKbdSdKaFZ47GH0z+Tdulr7lEliT9lkdDS9tBbnS4ilMuRRbfRCT6IY6mnxvgjQToN1dznhQJPE4yQbQzM@lists.infradead.org, AJvYcCXC08NkRe+XRkov2drBWB5umzDWjx1iEACHPssLtsSmucfdKAn2rFCLqA9RFJ1PlQbvf5W8U3hpB6B4xIw=@lists.infradead.org
X-Gm-Message-State: AOJu0YzFLXI8vmxcCLUhqT5IXsC+xPFqVb/vFn2S5G+TjCe4kI9o9KbH
	PjeNqYaH747hhDAjZfYIt9ZKMSuk67gaN9VyABq3vMEaamYGsTe7mFJV
X-Gm-Gg: ASbGncvdcOxA8rDt4rGToQ+3oiUR4qqXy8VL6uC/pUU4HWSp8AB/CKQZ4RK0Hrg/se+
	+0ZYAS6u0DJaqAbPv8krh/n0FyrjTm+QaE/SCJV5yTcKnHQBliMHLsVl4yiGiIVTlVxJqQeGV8H
	QOInowQ+mYfy9DQTATnkPFPB4B8KCPYn3d1uBBcCX+DUHLNSunGmquROqVl9QGY8AE4+RuTetm3
	G8710IQG1+Op02kfCsuvJJ2DMr0Q7/yrWr8Vg7NnsAWK0UrTYcrq/unGC6MDWrbMueX+X8nk6Jv
	hNSFJx8ckPUUPiZQKL6n/9FwDrQhSPRDQ3u/X341bj+z+98vONHNG6A3uXSLnFL/V4ezpCYzYTy
	rJZwn/Pvpz3AhpsinMiCMv0BVRlrbL6hkPZTtRARk
X-Google-Smtp-Source: AGHT+IEFT2kc8D9hjhRCI4Kut+1atHj8fN6ClIv95YfFL1i2Q+3r8LuVnLNmbJZfRzfJp4+oWdZNgw==
X-Received: by 2002:a05:6512:3dab:b0:553:26f6:bbfd with SMTP id 2adb3069b0e04-554fdce00cdmr2633203e87.8.1750951976245;
        Thu, 26 Jun 2025 08:32:56 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ce1fasm42792e87.174.2025.06.26.08.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:32:55 -0700 (PDT)
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
Subject: [PATCH v2 08/11] kasan/s390: call kasan_init_generic in kasan_init
Date: Thu, 26 Jun 2025 20:31:44 +0500
Message-Id: <20250626153147.145312-9-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626153147.145312-1-snovitoll@gmail.com>
References: <20250626153147.145312-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_083258_118856_A6427822 
X-CRM114-Status: GOOD (  10.29  )
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
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/s390/kernel/early.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 54cf0923050..7ada1324f6a 100644
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


