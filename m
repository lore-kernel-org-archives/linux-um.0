Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F1BC369A2
	for <linux-um@archiver.kernel.org>; Mon, 14 Apr 2025 15:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jbPFUD03S5a+/mIPyYPIOOdYImmpF80z4OIO3LBNPQU=; b=rDyVDXxnLWgtb6FAVTj4A26Mam
	HBy4zkQPPUXzSq4WE06L1fdXqUJQEAVOqO2f+CKGNZ+wYTKy08AMkbRCtvePdOlLWEag+N/QaLhFq
	D2uSUcs7ZrVziwGjTlmtLwdMyObyic6BqAsbS6aAWvH475V+MEoRzJobyBXi3RohpY7s2BMu8PqEC
	DhHa5rbwu+QQonRHmivQW23Ov8+qHMYKQS7z/yRn0Htu7qBufOiYMY3va2zK5l3JtpoZaHIjgGAKe
	y05WJEIWh8FrqjVjfp8M1yjsygtSmxR6GWJfaCIPo+dHt077JC+uhccejElmlYtRYKSNAIPxEEOyl
	i6mMyxrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4LJG-00000002X3G-0wyV;
	Mon, 14 Apr 2025 15:01:18 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4LFF-00000002VfN-3HO0
	for linux-um@lists.infradead.org;
	Mon, 14 Apr 2025 14:57:11 +0000
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-ac2aeada833so870366166b.0
        for <linux-um@lists.infradead.org>; Mon, 14 Apr 2025 07:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744642627; x=1745247427; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jbPFUD03S5a+/mIPyYPIOOdYImmpF80z4OIO3LBNPQU=;
        b=REqOTYXXPDZC11BhRbtzr91oyKvJr7EWJCShlRwnYZ7ixmWDkrar/heianocIUiZ1o
         bZ0D6o2prPx0aQbhLBp+UsPo4hqGrQHeKyjR6y+E4EKEFIF3oS+j/RXhIObg4ut7zcRo
         PyMeQBVmufuqIRkByK1WtU/tMl3ZmnSWHdze2q1GHo/ufFCocbxwlhnrI2r0UMA95wVI
         gv1IUNB6tHhQm4PhLGm4NJpBGuVTDDxIGuZ4ESjs5ZXpNUA/oq4PirEtePvD2iyekjf5
         lMm/1+IExBL9cKQlzFNBcfgLB3nRTbep/0BvWvIQaPOlVpCW0592nR3jIeXDT/EGxqdK
         V9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744642627; x=1745247427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbPFUD03S5a+/mIPyYPIOOdYImmpF80z4OIO3LBNPQU=;
        b=l0d/3GsOv3xu7bK8wttX3NZZFqeTSpDf4FmPdObRxOvrD+rTJirGi56RO+jlk3Xl4q
         RUhPm8XE4OMPV06PsQfFakFGpSOrz89eaZCKVnLuUHN2PJPgCNJ5DZb7bGj1yoiolyKo
         STj+cFG6DCqeb/kBNn5yQreIGuFIPWKBz4ui7LbKSDALSHM0jJVczXbNkHM+K33rlqsS
         7UzrSX2gEb8l3q3nAXiDwSdWdkC06c9FV4w3FUyRD3xxFHBsTCHfBgxCA5GYlYyXQDnj
         a6DZCVVyWowCM56i6PO1tMm8675dUEh/GHdn5Kd94j4w2+cHVF1uJAGVUAp0ED9Cahj0
         GJRw==
X-Gm-Message-State: AOJu0YwZ03DvrL3gQyczlMQNGzQcQrdzg65XCYuZ6dDCjLrbq4kLfOFN
	zZaXfAldg7NRTBWjq4qaWYFHc2vu9ffQrXU0bfiwKgwItApl23zCt2NlDGBLig0=
X-Gm-Gg: ASbGncu+jx0g0XKc5VAoGS5W/X/Xwvrdd4bp8xPDNwglkYBajXG/M5VCc3x8cZn8Far
	nhzzdGnfBxV1crxeLcV+BjImdiu4U+8rr6asBdCSg+L4bPWauh30RsOsB+G0rPY1jKOytC62MqI
	Cqn4LK0bhlfRtTT7jXslaUZfdl4PDoVPqzrQovZMNsbRMhFvD+1xQFZ/qQNFGGheA+XK49xs9AA
	mmqiI2UTaDGFgwdqtmaNAzBCz9+XpgJo2OtHhhjIEtJxK0bIPWq/5FCXQ4sOeFrWuc8XN2LRwur
	rPK92CQRVYnH9PJXvf5z0OrsBnrEc71bxcBQiXsok4L0bi5oiA==
X-Google-Smtp-Source: AGHT+IFQk+j582/Pz24BY7Hge7dbHQW7HWZ3XGap1nVfXL91YVs8Nc6fP876u076Lvogcj7kpax+Dw==
X-Received: by 2002:a17:906:f1cf:b0:aca:c6d5:1dde with SMTP id a640c23a62f3a-acac6d51ebemr1063278166b.8.1744642627062;
        Mon, 14 Apr 2025 07:57:07 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb4142sm929983966b.101.2025.04.14.07.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 07:57:06 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-um@lists.infradead.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] um/asm: Replace "REP; NOP" with PAUSE mnemonic
Date: Mon, 14 Apr 2025 16:55:57 +0200
Message-ID: <20250414145650.10776-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_075709_819725_B2C74764 
X-CRM114-Status: GOOD (  11.59  )
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

Current minimum required version of binutils is 2.25,
which supports PAUSE instruction mnemonic.

Replace "REP; NOP" with this proper mnemonic.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/um/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/um/asm/processor.h b/arch/x86/um/asm/processor.h
index 478710384b34..233a7a0d29c9 100644
--- a/arch/x86/um/asm/processor.h
+++ b/arch/x86/um/asm/processor.h
@@ -24,7 +24,7 @@
 /* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
 static __always_inline void rep_nop(void)
 {
-	__asm__ __volatile__("rep;nop": : :"memory");
+	__asm__ __volatile__("pause": : :"memory");
 }
 
 static __always_inline void cpu_relax(void)
-- 
2.42.0


