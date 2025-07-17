Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F23EC83F3B
	for <linux-um@archiver.kernel.org>; Thu, 17 Jul 2025 15:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tj0938MKzJL3dLX2pSfruVoI7qA5XRt5dsqIl4I0tCY=; b=vrbDSzZrSBGKP9P28HoyhOJ47v
	+uIj9DN8R4J8aJjpW9PcyLSYHr41e2qUntEkxUjghec+4A9qCR5sgpsV7u4f/Tgn41T9BSq6a0QQ/
	QEL1Qx0wnXxizqSY4f1IP9mSy/UG84yykN45jWVolABuMFAl2bwo7kq2N0lUklhaOXFCOHTdwIrkh
	n9rxK5oFDnYfLvyC/JDfFX2wsRBn7QNr6SB0wJgvuzBw3ZYR9a8BlFkF74fbkJcuGYakHJVFPJCKD
	fPf9GfrpVg5iJ2LBqFXIiFBxlPQ7EE6XYv4jQ40hWIiehN38L+VVvodrfsgn1UzeB5G7IVwgEjMf/
	dcdU4dPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucQ92-0000000ASDo-3h5v;
	Thu, 17 Jul 2025 15:03:36 +0000
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucPaZ-0000000AN24-0eWS;
	Thu, 17 Jul 2025 14:28:00 +0000
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5561ab55c4dso1030739e87.2;
        Thu, 17 Jul 2025 07:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762478; x=1753367278; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tj0938MKzJL3dLX2pSfruVoI7qA5XRt5dsqIl4I0tCY=;
        b=HJZ6xnezqyyiQnX+sGeI7s0vWM9j/9mOR+hurNGgkJNpkOpZIn7P7Qs5wEJYZyqGem
         WhMQ7AGkD4YY9zjSNLZk6ErNePq4gvnsMDjIvE5ef4JzqIqueemtN/AAbQ/+O4Dubg2Q
         OUsjzwK6d3IKHnWgl8XC8GFYe6zPsyE2+rUt5CEspAE84ggfmE7GMQbiy+pdVRczBw0f
         2g0Z+R075kQuk8PNc3RZhXL66egt3EcTnsSCaxYWYk86v76fEBARPCFJI4RXTkhpeLn7
         YnSwRTvmo0OeqL1/eNx3PoRESc2344JY2wjxwNyGqzGwxwYL3OfnGZUSv9FOKv0xhBGI
         X9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762478; x=1753367278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tj0938MKzJL3dLX2pSfruVoI7qA5XRt5dsqIl4I0tCY=;
        b=h9mW9m/9HJN52ohHZwUPwWppaYwWyqbXTOdb5z9vw6ZnIGDSFSYFvbrjEe8z0VZVuT
         lciaaaVkLKv5ewiIcZBDyZVi99DHN7oLsXuYbPgLs/P7Ne2Ouv2G+9jUfAV49oUDY/MJ
         9koYq/CbfN8HujgYItnUuShfEH+qCNHvrgtnW57PCG4qOOhBxafdOJzhASN2QDDax+Ab
         VpHaLw0yTRqLEzq+WeG4xbxH+uJQ1ELLBI9KOwYq3qTPhnA3mYEqlaWyx7eTwVrqXPyM
         J4Lb76PTZTGf+MsR5lZGW1H/nAGFKPePY5wtXBBvcP6r+z2uapFtPLMNVMgE8bR82E9f
         fjuw==
X-Forwarded-Encrypted: i=1; AJvYcCVC5fcTvUzuwcuPcHn9WJq591jjhkOd7Wsa8OBpeDa7ExUg1ViJ/VY36M2TWt8fYWVwxAB2dyppFJg=@lists.infradead.org, AJvYcCWrpPGdSIha+PB0HdPjJygaj0VyBZ3/02G5OfGuWH4JFkolgz2yIzpbEzQ7fEXwjPZ7sox1l5Zc7JheiA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy7Y9yhRFU2PC0Bt0epjs5Uw+e1yYu4PhuIssnWNMBIFxZOe+RC
	WjHD0yntGNNM4P+wsiT2ZBI9QR//eYCLHHgyJrUZWfDtm4O4gBpWZ3xn6iXlxmE7k9g=
X-Gm-Gg: ASbGncss72TIrk4bdqq7NVp3KpP5dFAbDhxbq6uJzv4qN/iS6Et4uef68AZPC+CYpT+
	RKW54FEPVwVtgjaM1xwtg3ZX+uMjtTCtmFJAjv4wqyifiRy4E8v2p74WMEJqQpqLrhtq9nhbqeI
	19hw6xvmjc4B39FEqEZxutFYGL0jfEfxkoKKxeIb58rjza8EQHjyBGmEiK/oQ+QJ3TgFN5n7sb+
	lbAYuCC9BdnzaRrC5f5qR9ct9IH9DIHrflSKHTyb7UXn1VFb0ZnYAsoJLv8x6eetSBuyRK9LQUB
	XAEvIjPpwEy3NsbrwTI2rWQlZgJIj9E6Iq691U/Q3prDimuipwhmSa0HLWwy4IM1xl7r7LKuCRw
	aupDobQVMSyIUJWNTbqrHIT6IFf3kwHArl7mAOfNefYhZ6U1p45xKbEbJkzlo8huvfsoMQphGLp
	Y2Jwc=
X-Google-Smtp-Source: AGHT+IEgw9d3ZuJ+QMY1MR2nr/3qOXMGIgWnHA/W5FJZ5VigpFpebSW6/CzlCrWt32sYjXVTTwrchg==
X-Received: by 2002:a05:6512:360e:b0:553:d12c:fef7 with SMTP id 2adb3069b0e04-55a233137ecmr2448163e87.14.1752762477204;
        Thu, 17 Jul 2025 07:27:57 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:27:56 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: hca@linux.ibm.com,
	christophe.leroy@csgroup.eu,
	andreyknvl@gmail.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org
Cc: ryabinin.a.a@gmail.com,
	glider@google.com,
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
Subject: [PATCH v3 05/12] kasan/arm: call kasan_init_generic in kasan_init
Date: Thu, 17 Jul 2025 19:27:25 +0500
Message-Id: <20250717142732.292822-6-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717142732.292822-1-snovitoll@gmail.com>
References: <20250717142732.292822-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_072759_191165_65A47D85 
X-CRM114-Status: UNSURE (   9.25  )
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
and prints the banner. Since arm doesn't select ARCH_DEFER_KASAN,
kasan_enable() will be a no-op, but kasan_enabled() will return
IS_ENABLED(CONFIG_KASAN) for optimal compile-time behavior.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/arm/mm/kasan_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 111d4f70313..c6625e808bf 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -300,6 +300,6 @@ void __init kasan_init(void)
 	local_flush_tlb_all();
 
 	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
-	pr_info("Kernel address sanitizer initialized\n");
 	init_task.kasan_depth = 0;
+	kasan_init_generic();
 }
-- 
2.34.1


