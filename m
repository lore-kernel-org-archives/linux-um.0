Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445D0C87FDA
	for <linux-um@archiver.kernel.org>; Tue,  5 Aug 2025 15:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fypRqRD7duJ7p6/XnMiehAY4t+I2qqoeS7XCKLtEaPI=; b=sFRgYctuYulbwhQeb+5IFMeZxq
	iR52I7yvikq1ZYJ2jZnWJz7xuFGD8qq69Ec2F2ZfWiOG6NfXwYert1dq0YGMzCW9ovbyYFQW9B4WL
	hVsgCLRIlLoUB8QhkIaSysW/sSAJz/mPTkgbKxAEyUhg4fZwfLGuYmJU9UNJXMOjozA+f3o2nehFL
	B2cIm2JJe3VZN1HWDP062SMCux8mmJimvjNfEkw2dVLvRO0D0TEUtLWie9x2EC47SwDPfO/eY3FHQ
	xB0ZaCuqWKjM7K7BTMGmbb6JjhjT0iZkkh5pBNdu0gcq2FBg3AuOMs7VpfWzpQupNymLWKjeHWw5V
	QWoQhO3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujJka-0000000DAbv-36h0;
	Tue, 05 Aug 2025 15:38:52 +0000
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujIci-0000000D0VI-1z6u;
	Tue, 05 Aug 2025 14:26:41 +0000
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-55b7e35a452so6931194e87.2;
        Tue, 05 Aug 2025 07:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754403999; x=1755008799; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fypRqRD7duJ7p6/XnMiehAY4t+I2qqoeS7XCKLtEaPI=;
        b=MrWVtvSM380hC/PgtJQ28RMvmxPv1GKhDjD4nKER5Qn415ssQ/76ZsNS8lVBbwL657
         G6EipxsE1w+xiyxWWXvH644WI1s29EG6lezsE79XqPjC+TUJwFwojgsYjBXtHzKZMWXI
         JbskPXA1qohoiBGEF7O0hOEUIIivS0tN2PZbDzq2SvNzzbOcgWrxgisJOzCAFMMwHpsh
         QeCb9fUSmBXcRYDKs9hV4hjhgzSQ3P1LOUH19CLjsSOWoeqEV59msVHhKllnBbcCQOq1
         2GrvTl2B75/5mjkKmfy9KIIYVmuiFjHAlVWjnnHS49kNiL/ufthKnVkhFliPQcAvNXQj
         dTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754403999; x=1755008799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fypRqRD7duJ7p6/XnMiehAY4t+I2qqoeS7XCKLtEaPI=;
        b=eHsoqFscFCYHHRGwLBSE1lEdp/lwLC0wMlw+FNL6/MmlSyqBmw0utuF+FPCQj3min6
         K2UaC9CLNFtS5UydjETv/K5UINMi4KKc3H4BYpOKdZFE7VGWZRqq6OUO2lCh7VJ1gAkk
         jAPJK2tW+H0zbSbgo4u0XMGvd8uqxUtEMxcpuUlgyAFkMLj0yRhMJwQIRvnzPehYChzy
         hc4/95AtK8okcAh1fbwXOON7ChGQn/k+TaEDhH/10cp5GOYHR1eNb1xnTqAhzAcGHkWL
         tnRLTw0izYGjSQheUgocult+oRP8/bHEaA7QsyTsZQCZnK5PT0F67yj1zl0h42Y2nAz/
         SSRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVot+FuYCFHW3sG+iGdlbso0nBLmWokWHWo6IukqSzhY4E5+PZhkIiySq1wuGpiA1eL5T1HCdiITzGYdw==@lists.infradead.org, AJvYcCXV1Q6Ve2fYueQKY3uDcF7OdKUWgUqqOvP6X6UZa75Rmq7w95547DXTJCFhkuB6HFejKDphiYeVQ+4=@lists.infradead.org
X-Gm-Message-State: AOJu0YxoWh/FWHxCkMt3iKUle49heyj+PAk63s7tRh4Dx5SksrvV6n0H
	pzHpVDMrh3HPmCKeI2eA/cFTQnjOHhm2bBPlH4znjJlPTmNc5MYVcneK
X-Gm-Gg: ASbGncszd/XU27qDRnIp0xnY6nA7dBJJ/KKEWBbRFQJuQOsk7fphs/ppyCOIYWJgOfa
	N5ifMrQsb443eRZ87oXC+yQEM5qePYtXzgNK9+4MfBKgMoQEL7Rn4QqCyc7+tDuwfpqbjIgEX6C
	Ldy7127PhQzLq4SJBErmJl6yq3f72evllNiKMzedtjCyUaQsaOvmQ4VX40dDrZXVf0zGa9FPiDc
	K0smg/TjDaX0V8Dnrt/5I2dUUxfCgHsw7NWXsbUxGDqWTZJw3DOdyoBsXxYVidTzzs2RRI98W26
	NJuxx8yiC8e87tUVxOVNNXf4nUflckBe1mczhTmyX9PlXrz63PXMcks2lI/p0T8UbV/ww+m/4C/
	kPszvZeyGqD75NRbezQ3FPGvpLMjY7FqOdDR0xmX+wmw2pVDRfkdXugq6m6BmGJSf9AXMmw==
X-Google-Smtp-Source: AGHT+IE4tVfY0GDnGQOdh7BehbCQ960f1sYrnnyIro3xm6jwPaApab0fDljnNDBd9SZqMzry0nuyew==
X-Received: by 2002:a05:6512:a8e:b0:55b:5b29:61ef with SMTP id 2adb3069b0e04-55b97b89544mr4329067e87.56.1754403997895;
        Tue, 05 Aug 2025 07:26:37 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889a290fsm1976379e87.54.2025.08.05.07.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 07:26:37 -0700 (PDT)
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
Subject: [PATCH v4 4/9] kasan/xtensa: call kasan_init_generic in kasan_init
Date: Tue,  5 Aug 2025 19:26:17 +0500
Message-Id: <20250805142622.560992-5-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805142622.560992-1-snovitoll@gmail.com>
References: <20250805142622.560992-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_072640_511028_273484D2 
X-CRM114-Status: GOOD (  10.93  )
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
and prints the banner. Since xtensa doesn't select ARCH_DEFER_KASAN,
kasan_enable() will be a no-op.

Note that arch/xtensa still uses "current" instead of "init_task" pointer
in `current->kasan_depth = 0;` to enable error messages. This is left
unchanged as it cannot be tested.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/xtensa/mm/kasan_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/mm/kasan_init.c b/arch/xtensa/mm/kasan_init.c
index f39c4d83173..0524b9ed5e6 100644
--- a/arch/xtensa/mm/kasan_init.c
+++ b/arch/xtensa/mm/kasan_init.c
@@ -94,5 +94,5 @@ void __init kasan_init(void)
 
 	/* At this point kasan is fully initialized. Enable error messages. */
 	current->kasan_depth = 0;
-	pr_info("KernelAddressSanitizer initialized\n");
+	kasan_init_generic();
 }
-- 
2.34.1


