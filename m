Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B13C7115C
	for <linux-um@archiver.kernel.org>; Wed, 25 Jun 2025 12:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m8+Li4ZqAZW0QY7sIIldmBLFf6VQ+4AeP6Iv95ugt8g=; b=Mz1TRqb9wt7vpEy/19idHz/lwL
	RCxdKe8XR8xnp7/IDqVTFk3EoqcA0kev0C7S0AEktajxgGLoPNfMBJPpgQwfSYwxPAxRCf2yyLZuk
	RMw0bZM1c/7qdU3Z5UUhZNZcTvFm4kQF55lcldZXy8YcopG69J86YAiVIFTTJWQZD1Rrsz0D/SBQY
	pjsY095dJPigWjVsdhC+++JWG704scgKkHOhM6Q2RcVeHwuUbayxbphzrbzfMEify8AaoUCL2BPbv
	TDM+8u6H9eVkUdVcFUAIh7tTbNM9PWEcSeQgcKA08upzxXjwdz+H7Gdg7NjQBplumnUV68yGQA9V4
	5dwXY0NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUOvq-00000008a4C-0ZUU;
	Wed, 25 Jun 2025 12:08:50 +0000
Received: from mail-lj1-f176.google.com ([209.85.208.176])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUMoT-00000008CqX-447G;
	Wed, 25 Jun 2025 09:53:07 +0000
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32a9e5b6395so12342051fa.0;
        Wed, 25 Jun 2025 02:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845183; x=1751449983; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8+Li4ZqAZW0QY7sIIldmBLFf6VQ+4AeP6Iv95ugt8g=;
        b=IjMUB5EqKuieSa+B2KVdHGjdo4MQEIi9R9UzBjJDV+hwTg2dunt7M6jLshh9Z84Xqg
         2IjPCO28jTzUOWaUDXJcjMLKyA7rtQpIAeAv5v9AK1+IESV/bdaCosUgBzpHpgFhzYHv
         j0EZQQJDuQPv77BH9mVLbR4dR8kHcXIVpSqz4DzyvlYIj0TEW1WSZGFb2LLI65p2s60w
         1LkBm1RtEQ3iBi0S44THT8ubhcmCrVnoWd5F/Wc2A42eyEMJzT9/KL8jNU0+lscMEB6I
         sQUC6ltYXQXBOdkm7u8/vh6/CiLOCcrOepHTHuLG1sUGop43wS6oePz/0DPX3MBw7IbZ
         ufqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845183; x=1751449983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8+Li4ZqAZW0QY7sIIldmBLFf6VQ+4AeP6Iv95ugt8g=;
        b=rlUTNCreL0rYopenSUBLRhTJ3ZsigRMBKf7GchJ73p9DTU5KXjUY4elEKJ736FkQ9y
         YpJGLckpJBxLeWxueSvB0bO19ei1pCbj8MUhk60//lqW4sSIUI8riJL3p/fBgogWFhwT
         HU0UPpecjmtxNk2Hn2FlP3lHQq/tleyUz/JFMz+KDc5y51p8yuGB8YSXuhXJdhPTGenI
         yer8hJo0rKE47nWzpduu51wkPe6LJAqNRtz2HsF9BWvcHu2s7BQBtxY1Bs0/hwa+cdFB
         nSBU7BjGlCkEhScO7LN7bBeQ/XvjqQ8Ckqxam7Jf8JChpTO50lPwMyapqwGHsKP5/rE5
         qfeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ5dM+9wVBoeL9vyPg4aj1rmE8RemPp7ow9U1Zw1k5+F6gGhk52jwRZbl07h18LMcjzqtd6NYzhLCf1+qaBn71@lists.infradead.org, AJvYcCXFfDiPFw2ERtCP3gODEnX7wGoDPV7qivyrAri3cWRv0CQZ2zaHi12XIWzV/y2JOAywXQbSoEDIX/k=@lists.infradead.org
X-Gm-Message-State: AOJu0YxNihKwFW7pzDhGGtYlvN1nUAQkHjSFj2pN8r8Cy7NEeDLxS6HT
	q1N3QT9U2J54VlAaKbm6QGnrJi0amfD94yGEBJCzkwI3+J0nnlIsavc9
X-Gm-Gg: ASbGncsWmgKQGAlWjKpF0TkO34hzVd6sdos1FHmnTSC9o7/pQv/PT2x8JATCxxkoDYd
	wAH4L5eolfPjkl125ob7H4NTHeCqNvN2P5stmOxDXw5LggnwxBWZkmo5KnHzG3AnzHOqU1jNml/
	xN/S38FxrhKqBQZmguzTjtPYOiLG6fpJR3lzm3unZqHi0Cb6yf5XBHO+gj/x6C9MXOLdA+wG5FV
	3UbveZML91y7OulikRH3VCJV8KLnON8oodF+UYd5EirXpTdV5x7vUKKKSGnPf/eQ/QGzYuK8kaR
	ncvOQhng0UAHmwgNomDzOHMGl6ddithtfZmIMqtW5wRc7R29CS0VAnoVXSDugqOR6Xyra4kp6js
	/KxGUkxAQFA7b2DnX7nNvqXvBwUu8VQ==
X-Google-Smtp-Source: AGHT+IFM+6Gp9FKNRVxfpjNXcdXOUjE/qQpWABAqK3bSElIsQlHP18BbIkRAqZ9Oq2fiOL+vDX3DJA==
X-Received: by 2002:a05:651c:e11:b0:32a:714c:12d1 with SMTP id 38308e7fff4ca-32cc649716bmr4987311fa.1.1750845183165;
        Wed, 25 Jun 2025 02:53:03 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a36c0sm19311851fa.62.2025.06.25.02.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:53:02 -0700 (PDT)
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
Subject: [PATCH 3/9] kasan/arm64: call kasan_init_generic in kasan_init
Date: Wed, 25 Jun 2025 14:52:18 +0500
Message-Id: <20250625095224.118679-4-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625095224.118679-1-snovitoll@gmail.com>
References: <20250625095224.118679-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_025306_004526_E409E8AB 
X-CRM114-Status: GOOD (  10.27  )
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

Call kasan_init_generic() which enables the static flag to mark KASAN
initialized in CONFIG_KASAN_GENERIC mode, otherwise it's an inline stub,
and the flag is enabled in kasan_init_sw_tags() or kasan_init_hw_tags().

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/arm64/mm/kasan_init.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index d541ce45dae..abeb81bf6eb 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -399,14 +399,12 @@ void __init kasan_init(void)
 {
 	kasan_init_shadow();
 	kasan_init_depth();
-#if defined(CONFIG_KASAN_GENERIC)
+	kasan_init_generic();
 	/*
 	 * Generic KASAN is now fully initialized.
 	 * Software and Hardware Tag-Based modes still require
 	 * kasan_init_sw_tags() and kasan_init_hw_tags() correspondingly.
 	 */
-	pr_info("KernelAddressSanitizer initialized (generic)\n");
-#endif
 }
 
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
-- 
2.34.1


