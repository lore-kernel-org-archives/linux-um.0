Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F54C83F1A
	for <linux-um@archiver.kernel.org>; Thu, 17 Jul 2025 15:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4lUgc2mQ1RFMODut/DxjH0e3nH7UxMqXiDg2xTFsSSw=; b=kYa69Bbfc1ddeazcQBarDEp7tF
	gMCdvAJ8N2BID7U6ggBUCkTB99R+bnzEkCnF9YcljJw133Jn9HmQpnSy9ARDooyk7nThSwW41xhlv
	FO5PMQfnD75pjNeE1OI8ve2ch5rQRE9CnGhjWn3NYO3Dw92+R8TvRC6qp/fci6GGZ9HqAxxdhidqt
	HwkpOFVHQ4D+bBnEKFBtUE0dCxcrAGhGDG3ZcJbdvZFOuEez8mmBzy6UxqBUFLRntWs37deo8vB4j
	roN5RQ7urFVWZuY/dn8a8usnWVAnR+yrltYZkSgj07Td4phiIHkWD5gbgf03tP4kM6n0STCNU4cAg
	j7a/CSmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucQ9E-0000000ASRg-3Oyi;
	Thu, 17 Jul 2025 15:03:48 +0000
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucPam-0000000AN97-1BIu;
	Thu, 17 Jul 2025 14:28:13 +0000
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-558fa0b2c99so852434e87.2;
        Thu, 17 Jul 2025 07:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752762491; x=1753367291; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lUgc2mQ1RFMODut/DxjH0e3nH7UxMqXiDg2xTFsSSw=;
        b=lAxEJ8sc1ipJAUMayJmTLhjQy6K0mjR1xudzVUjLLGVdQVbHKi1Cuxwl/wPNOEgK3S
         emLWRXRz9TR3NwnnQ0Zkvpu/elNMPtKyQS+r835tOrgOxtv51ek9uurjX0NQopAAY7a2
         7Mg6taAG4T3ronOZbiV24v1YdwkONpmYiSUhuZTT0NY5Yny4dQacN2v+bjv/v5p346HP
         Ca9uvseZowaFjGRn+M4RoF+acuPdIfWPkthssKhV9W4p6uVAtNSaf3lqjcpp7O3C4lLE
         Rjciig2aZOoDfQF6t6hZJrAjc125WO3b1CkzvyH9mh7+T68P5uBHCqbw9y9rTEUkcIJm
         GPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762491; x=1753367291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lUgc2mQ1RFMODut/DxjH0e3nH7UxMqXiDg2xTFsSSw=;
        b=NzXgLCrwBGqpuGmvFtxaxuwuuNod7hl3lxFEbEOlVcih7jFdjsuCVaGL9CM/WaY4C3
         WampQSE8B0iBxVK5Dp6Zyd5BGKbDNFlMYkhR0j4GjNcz1t2Zsrp4K6zJfZ2oNKP0by58
         6cZgrvWNPSF2ZeiztDiCDedmHQv1VLVNifdJyTatYlKakpUcm88s3UJR37ywbWNz6N5R
         7J9ZX2L6b5nWbqk2eO5eUdpI8i/dp6nBZ4Ai+YREOJCdeb6UIwMS3/9ht1kSPqOyRzlK
         xl2CCIGimXR7bJXFfuqDBtZoR92EU1MRLC19DvDrcD1l3pzW5Wpj16n83QHhRecu7eEp
         +b+w==
X-Forwarded-Encrypted: i=1; AJvYcCUCXwbYd0fbi/HTJ4NJVOJ17omKenBsQJrRBqcUvaEH2rSuxUmNI2me5xU0FVLcsAwFIQbUXn+PBDHYpQ==@lists.infradead.org, AJvYcCUWk93qT0IN0ErCjrwAr2DvIcoS+XnErpJOWYpjib1FE3L0vq1v5RavwRq12jxDdDLM1G/adg38WxM=@lists.infradead.org
X-Gm-Message-State: AOJu0YyToF75K3ckbdv05AweoIHjfoSl0sb4frMS5eQeeZfXJHWgJKD7
	QX3AyBM5razoiPtGt5TT/mDaJg4VQGm+ejBfWTgiHw3LcB5iquRa+Le1
X-Gm-Gg: ASbGncv4pkBzMT4JPZA4k66lY7+907R8zidTI+r5LsTVf1w89nDZBcVKRpkqq5+ZxJh
	ZaaExuc62PjJO+BHV9BOqdALXq/BqaZuQ1Y88I5objHQSdbuV3mm+CqLTLaK3bHPj8qWGxSDwhv
	s5iph83k5qZBKhNtCNo6ydHMvxw6Mlex1czPrC6nggwNWRgaLHzhouQ6itTvzE7p+pRVqjlp2WK
	aX6byYFQgEtQCaN+kJIn/5Se64OdWZwOYgOdiRwq1BNVpCxefPGD1r3ezgdgJuCuOq8ka9QAwrt
	I8TYVhWHI2k2DbJFzxoosNVxjI2/KhpZj8fmkDvmrjTfMmxYqleKb8cv9Zott9N4jseW1ENO5ht
	Vmt2JuKk2X7HP6rAtzRLJbx4I+NiRwWGczMUpk0RKF7sp+4WJtWgIzHosUuqw75B9cMYi
X-Google-Smtp-Source: AGHT+IHDhctOdPCboINtKeXrLTUszqbBiUuSpXqwZ8iJGfUdyizY8inGgvaZnyh7hxTvzKTa8fgC6w==
X-Received: by 2002:a05:6512:618:20b0:553:23f9:bb37 with SMTP id 2adb3069b0e04-55a233b2fbemr1641277e87.40.1752762490421;
        Thu, 17 Jul 2025 07:28:10 -0700 (PDT)
Received: from localhost.localdomain (178.90.89.143.dynamic.telecom.kz. [178.90.89.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55989825fe3sm3022975e87.223.2025.07.17.07.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:28:09 -0700 (PDT)
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
Subject: [PATCH v3 09/12] kasan/x86: call kasan_init_generic in kasan_init
Date: Thu, 17 Jul 2025 19:27:29 +0500
Message-Id: <20250717142732.292822-10-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717142732.292822-1-snovitoll@gmail.com>
References: <20250717142732.292822-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_072812_333288_8F2D5123 
X-CRM114-Status: UNSURE (   9.05  )
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


