Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F57C4345F
	for <linux-um@archiver.kernel.org>; Sun, 14 Apr 2024 21:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VJGyYtAAQc4uOgSGlTr4UuHrBeMB45QcA76q/h9gFi8=; b=KZvoboqP5R/UniAkCUGCyi9zbD
	RwXIdYbnHifgrhdWm0Ocb1RNVfTTv/fhJYMGaptY/UaOLUiaQv3Mq/2GJt8U1oMFqjcmeVlfMkwKk
	KsbDi8vIYpqib0FNZq0TYbRu83HuylOQs497by+6gQCPJzkSjR4kPT8X26weCnYov3u5Zunzyn/Xk
	7sGLeK2kgBy7tN4SJK0cV3q+8xrDhaOr+pyA0sa6qDWotfeuLX2QkhHvmtWfv3IkwcpsJuTxuAkBc
	cW93CE1tkgdIGezEjVoRcVix0TBhi9wMvuf07iGiGcUqsybckpsT8hNeVapdEQKp8hCRv03le1EtT
	gIgf1R2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rw7GY-00000006Q2q-3IKq;
	Sun, 14 Apr 2024 21:19:58 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rw7GV-00000006Q1t-13FK
	for linux-um@lists.infradead.org;
	Sun, 14 Apr 2024 21:19:56 +0000
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-346407b8c9aso1183418f8f.0
        for <linux-um@lists.infradead.org>; Sun, 14 Apr 2024 14:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713129591; x=1713734391; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VJGyYtAAQc4uOgSGlTr4UuHrBeMB45QcA76q/h9gFi8=;
        b=QkmZ89QKcqb7b3ddYCnrMe6G4FOjf3vNX++QnkTDF6AhcrYogNjVtx0zdwjHnBajQj
         QsSmYFyuFFqAoX1VKQIDPu9Y++yDpKwNRO7SG0PthdRTVnj5bG3lVR9eM2bBeIHCO2k3
         L+vcxXDJf//PDYMvkoJszP1MAL/+bzrdY2iVjJ5jWldNnqQGgHhRJ7bLO4g0WwLXkSYc
         zFBqPeL9LeLloksMjWDK6VHeMZ7UfK4JwC0RB/AyGDjNPQsWjEdzC2W8PhpHB064dqGu
         mneZlQul+XOkAzI0la3o9BWzeENWIvbahvCnvuTewHPfOIpnP/qG+MLlZ9MJoPD+2mrJ
         e1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713129591; x=1713734391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJGyYtAAQc4uOgSGlTr4UuHrBeMB45QcA76q/h9gFi8=;
        b=H7xYwRGFKpWPA+HHpGCevKe1bZ4+Rqr6r0IwxZU50eJj/ZfNJZBW9MSyRpyUEQTTIT
         Sc5u7gG++iJCybUI9hPGlRV+9v1usE0tDlfjN7CmgO4Wn4oNR1ZrgQ9oBFHe3GaG5gfu
         6e7tD/af3OL6glUzEKnWWl4rGuDuIa3g+5pCByOR1cwlXbTkMo/eeGK3O4yIZTkpEkbH
         O3RLnUarqPZv6ZJ3Pndm+N9GmoO9K3iq7TEBLJeuMAAVtjAR6dx80meE5FOC8muFc+BM
         nAiwqIEf2mssskC8DIaC2v71PWYfaXCMbRLKd6zg9ragkTDROuVy22fBXimsLnN9Z2bx
         cj0g==
X-Forwarded-Encrypted: i=1; AJvYcCXDqoQmPV6K8GnQ+VTQnDc89H8xgVX8hI8Bs5/lGCxs/IlLJwZyzQGujr+9ojVoMkqqsU3nbUMn6gCSSW7apiPgMEDOsCs3jiPB34Bv
X-Gm-Message-State: AOJu0YwyDkiRQWNFf56X0oW5g3eRqmYF4EJNvHO+xT5SqiEUos5nl5SI
	C9XQ7pzogo1oDN9pH4EMZn0XeQMl6xmOOJDkbWG+PHpB/1dNUSDaykJ20Q==
X-Google-Smtp-Source: AGHT+IG/cPe12BQbE7o8QMo/GuWNnKDEgTsL2Xt3udNupBXE7QpBpi4Z6on6F0LOcXbx4fypPCRikg==
X-Received: by 2002:a05:600c:1c97:b0:418:2a57:3806 with SMTP id k23-20020a05600c1c9700b004182a573806mr3043430wms.0.1713129590469;
        Sun, 14 Apr 2024 14:19:50 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:5535:5568:577f:20c])
        by smtp.gmail.com with ESMTPSA id jg25-20020a05600ca01900b004169836bf9asm16436315wmb.23.2024.04.14.14.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 14:19:50 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] um: tlb: Remove unused flush_tlb_mm_range function
Date: Sun, 14 Apr 2024 22:19:34 +0100
Message-Id: <20240414211934.393303-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240414_141955_317091_406B7F4D 
X-CRM114-Status: UNSURE (   7.48  )
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

GCC 11.4.0 produces the following warning when compiling the kernel for
UML architecture (with UML defconfig):

arch/um/kernel/tlb.c:579:6: warning: no previous prototype for ‘flush_tlb_mm_range’ [-Wmissing-prototypes]
  579 | void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,)

This function is not used anywhere. It is not exported with
`EXPORT_SYMBOL` either, and therefore it is not usable for dynamically
loaded modules. Remove this function.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 arch/um/kernel/tlb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 7d050ab0f78a..70b5e47e9761 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -576,12 +576,6 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 }
 EXPORT_SYMBOL(flush_tlb_range);
 
-void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
-			unsigned long end)
-{
-	fix_range(mm, start, end, 0);
-}
-
 void flush_tlb_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
-- 
2.34.1


