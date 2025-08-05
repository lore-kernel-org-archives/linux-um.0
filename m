Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742E3C87FD1
	for <linux-um@archiver.kernel.org>; Tue,  5 Aug 2025 15:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4lUgc2mQ1RFMODut/DxjH0e3nH7UxMqXiDg2xTFsSSw=; b=DNBnjbtSQNVhmHW5B4luH7ygOd
	IEPywyo17CIu5HEFdHb9K/P2U8RqSU/dHmEw1Kmv5FWBlpma0dSzG+hzz6E35xmqEUmyjrFnSrxDb
	b1HkYoisttSUU68NRP+LX77qfgigHZxCjT7+NggVyMOfwmHHE3zRrPjBOTN4qO3JWjE4MXK9ZoCnC
	nLmk5RyJ5hhSN/rmbu8H9aviHAFFCTbEvUrzLGQLKS01T5f7VAYoE6sdRSM2pCzAtOga4B3Jwv+5+
	scm2Va5gYcRT3RgZxCfg1kOuZoUzrbgE0AVLf2CxVmBKyrF9WARHm3YdPPA8UGSX6XMkDwaxOvJgV
	L47Qurkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujJkk-0000000DAkb-0IsG;
	Tue, 05 Aug 2025 15:39:02 +0000
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujIcp-0000000D0ZW-0OEZ;
	Tue, 05 Aug 2025 14:26:48 +0000
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-55b733911b3so6124931e87.2;
        Tue, 05 Aug 2025 07:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754404005; x=1755008805; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lUgc2mQ1RFMODut/DxjH0e3nH7UxMqXiDg2xTFsSSw=;
        b=Xht3zyKf6u3Xke9tANeXN1V6Rh0IXgmTnUrDwTqOcL8nJgP/zOT3GGCL8FgS926/m0
         69Jcu5lns2VVeUeW5QwUoR3Ft3lVXqNjQ/Go76l8fLv+szSeWAiKDdsMEf57mhVJBT5n
         Gh0MBszKz1vNYleH0nA+WK5uHPHCWwa/QpSItnjcz26LhXRNoBu+4f68OaGJlX2w+8dy
         PZD1x3odRJXIZp+RYwdtqD64XygDFE6Ii3kHDiaHf8LYeSxbqN2v4Pl+jnKj3ocue6dG
         Ilg4CRnX3vmobHF1DKLGhZ0jAhpikIaq8tp3jjxNsXWzUwIuN69SOZi1dlC4mHn/OHcm
         XLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754404005; x=1755008805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lUgc2mQ1RFMODut/DxjH0e3nH7UxMqXiDg2xTFsSSw=;
        b=wEX+mj3NNd93qQEqSv+Uxv8kjwsu5qjNW/letFx11lXRWPLDAW0yfBkQCmor1bG+4m
         didycjMeIhMzzpYfFkjA0+6cnEOspDRKPyXV166kkPzT042ZWaEJvIOr6310GnRK1BgR
         Yel5/CPuxAEkEDDPfNBrNWCuSzLEVlwOs5e9tCEDvKMGD2t9+T1QgvFFOXkefC2mteUd
         8sfHW3EgEZXRVWdj2muqLI8ivLG0jQ+vANjn5K5gIR6wXquxpm3BLm2gjn+QgUllYiVD
         SZ/1gyE7Gze8AuUAA25Z3aIIxQZAqziGmDTvYbzDL6+yLuzjAuJ9/Ya00eJwrDGF1w3U
         HbLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdeQLERe1wQ4khIIyGeXmi4QNVqyYEsk53W2M8ASMN1YSkqr4fo8GgDratnjZ+8kbEBkFWei/O3sc=@lists.infradead.org, AJvYcCVaDPCj8sPvusUIyg5DqJ+2+W1QWwbXxPDtssWRxVLKm9zSE6pfkuqY3tJpAQcimaTT8fYqLV88OwPVdA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx9Va27n8vcj54eTPbJ5VpRYKLq+7E2vXFmEj843KOkaiD3pniT
	pkAi4UdzgRP8TEqKd/BF3Sun55c+V13WDllnJMZ78VwdMiJLJ4cTXFv0
X-Gm-Gg: ASbGncthXmr5xEEmCj34IlYgrLJy50Rd3oqOvWeUL6yBwmLrKKPhKXqjOdKfh7xmh5g
	S2/lfF4r72popu55KzqSvVlEKFtNj2fJtwfR5Y1VbB058kfXGt6SW9/hPxboXAf6ObV5iqMj/uE
	7U2dbnPPaagSBvxRf2zkOvlbhqO2twouXpTEzeU+3jFK3hwrPGVNRJvyUL8XBPSMm43W01oippl
	1/XmsTXz0scJBby1Y8Stz6cgRCb9JSF64uFVnmN/uLMoikaeBBzFy5ZFytyMLhMWN3pIIO4p4sn
	o8k4rMIpLkmnsvtiEHv5As5YIC9DOXZi+WseUftWYP06u6djP4llJvJZZ+Nsz9lmkJMZQ+7QTk0
	aCECA9p6PcGj9KE9oy8fat6ugXrvD7w5MTAMIUQGS+jGWSsp4SaBML2fpKImJy7utQ2LQCU7eiT
	wmSahr
X-Google-Smtp-Source: AGHT+IEfdK6xUGSau1shbIGz1OserWC83V4+ELanbWHlOwkRpBjVR9Bm+3vZR0IX6iJXBqrfn1b6mA==
X-Received: by 2002:a05:6512:3c97:b0:55b:8277:22a2 with SMTP id 2adb3069b0e04-55b97ac64ccmr3140519e87.21.1754404005154;
        Tue, 05 Aug 2025 07:26:45 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889a290fsm1976379e87.54.2025.08.05.07.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 07:26:44 -0700 (PDT)
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
Subject: [PATCH v4 7/9] kasan/x86: call kasan_init_generic in kasan_init
Date: Tue,  5 Aug 2025 19:26:20 +0500
Message-Id: <20250805142622.560992-8-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805142622.560992-1-snovitoll@gmail.com>
References: <20250805142622.560992-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_072647_131009_796D9722 
X-CRM114-Status: UNSURE (   9.85  )
X-CRM114-Notice: Please train this message.
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
and prints the banner. Since x86 doesn't select ARCH_DEFER_KASAN,
kasan_enable() will be a no-op, and kasan_enabled() will return
IS_ENABLED(CONFIG_KASAN) for optimal compile-time behavior.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/x86/mm/kasan_init_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 0539efd0d21..998b6010d6d 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -451,5 +451,5 @@ void __init kasan_init(void)
 	__flush_tlb_all();
 
 	init_task.kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized\n");
+	kasan_init_generic();
 }
-- 
2.34.1


