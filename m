Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65027C7115C
	for <linux-um@archiver.kernel.org>; Wed, 25 Jun 2025 11:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iNdRW1IbQwaJLK3IU9ZGilulsvtFwP6FJhql802bOZE=; b=V8KWM7rQ0HyInrF7R4+zwIovTQ
	P4oGcItc6RS30RgpyZ7z5RI0ak/cDQppMHR50B/AEpMy5qpbTco07XDQqSUuYOhcVE4tnVnf9evdz
	lOSNsPkehvgsxT/Tbd+2HFnHzU14SkXkOpPLocesKnQTKWdhwSn9p94P7O8fAIS+hcEclJM9mlqpV
	AAgb0d2W1fTG0SV53k2qe8sAteJZ2bU2WBPytvmELlPa1Amz2YBcOZyhos23ra2P8vnoWaOpqqUly
	D0tSdV5HbR8/z36kQqLfi1tcFo0Cw8Ax3pOkG7IsXmm18wnZOW2iYBlfn5zuO6reyvd5u0ORrAR9V
	u9c4yTTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUNxE-00000008Pkz-0fFt;
	Wed, 25 Jun 2025 11:06:12 +0000
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUMor-00000008Cyj-3NiG;
	Wed, 25 Jun 2025 09:53:31 +0000
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-32b43846e8cso12551721fa.0;
        Wed, 25 Jun 2025 02:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845208; x=1751450008; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNdRW1IbQwaJLK3IU9ZGilulsvtFwP6FJhql802bOZE=;
        b=b7pwcZXELNsl06bwFDbS4ygaMuBsvEFUsp5SQizikNDAQGLTNooq/NGIyhd0Ho1nZb
         k0aBJ/oyf/sTzXJhRp/cfb9D9ketYl3a1ZUnI8K9TbsgO3Hnv21ZPjyVDMWp47vDHQ1t
         s17099Uh0l3b7strpSlSJyxojIR4uGLIOuCIOsYKaJ/6f7CHdWcH9imoGzi5ETV6qsiD
         +at9Dd2sU5V0V6y31rRyHp69x/HDkmMl68EhVqEnmyjqjt8toQ0QN9/IrdtoA/JgZXVW
         F3oyhhOR1E69rTmMWTUqNVQiAQUQgwy0sFFtcEjRzjJaDQx9Iyqmp7190n6aubPX/tpZ
         O6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845208; x=1751450008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNdRW1IbQwaJLK3IU9ZGilulsvtFwP6FJhql802bOZE=;
        b=Dh1uKwzUSM8fJey0NeclYh0a2slY5Ir0YaBbAvTyzKX16UY+9xFoaBfBrusAKFYbbC
         iF9bE9TNAjEbGck1A+W01WxWQapCaM5WL4+S+c17JMXj1JHjqau5IvkWXLEEMacRS4GV
         /tWsx4v5z3eQ8yOnXtK9K9qUxwCftlqotXLL3jUGBRRNkG0r16dXVo8hz8ByylmwSmgQ
         bG7xIHF+RkjxLI6LD+5VQ6mOu0chFY2q0a3WyenKjaiZKXyfd7IgLOaRCVR6vnHIblWs
         dPF39SXiJj18yJI4SiiezNzMDQvxlaUNyzueGz/OonskOTUFxKAH9Bfu45FODaVlwqm+
         rT+g==
X-Forwarded-Encrypted: i=1; AJvYcCVPd3Kk0xdy3SDDhc5RY/ewA/h+tpMBNcJq+pzwIrmv615U1KJNCR0aAy5ckHI4cUbNVVUKY03AX9ZhpSzNd5cc@lists.infradead.org, AJvYcCWxLn/cktQJGPwgsvTAIIzcYrOYY+51bBJ9L54Ytgpy8T33ShoWkanxF/IzVoVAtjXbRlRvYke43Ts=@lists.infradead.org
X-Gm-Message-State: AOJu0YwqFX4OwccA3tuiVqKOj/63zsRlC0v8KdjUi3E4EiGYp+VaXEjM
	DhaxOr8tmJ7s8H02BVemEpWBKqjdaDJKzWH30auI1axfwtSh5Sz0Y1bf
X-Gm-Gg: ASbGncvfr4VWKEqFmULlnGWkuXBFCLI4bSy5GIoErPmtxJSmTZa+LADaIVEaCBrFgfU
	kEn77HwIW0xj9F6OXq+29etSyvJHGTiMvivzm+JWjUjT9EwI2tF1U2vTieT2VW6txFfBo8VOEWs
	NLFKtd8atDuI66GaZ8nBHtd9wAaue0BoItROL69VqCViATMSu6o2fCJq2+kvz0kMiiFpsJU87vX
	txCFcvYJTS2AcG2IO/mOHoVZaYQBnWXTHRxNkJejnbHVN+QmNxROsER5LwE+SINvMAyryJgF56K
	LmD2PjqFcVitavEccuULiduULwSzil2Qtu0eoDZsaTEMhyZrC3oS43z1WjT+wo0pm88vaHXFIWU
	VRxNHfT/p51IJJxcX7F9VBRqq1LVt+A==
X-Google-Smtp-Source: AGHT+IEEyG7BglU4Us5Yezwlbfk1A7iCiSut02wYI0QnYJbbPrBalxPgrrZo+Iohs0E8JQ9l3Ex35w==
X-Received: by 2002:a05:651c:31cf:b0:32b:33c7:e0c9 with SMTP id 38308e7fff4ca-32cc64b7c27mr7419481fa.16.1750845207836;
        Wed, 25 Jun 2025 02:53:27 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a36c0sm19311851fa.62.2025.06.25.02.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:53:27 -0700 (PDT)
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
Subject: [PATCH 7/9] kasan/x86: call kasan_init_generic in kasan_init
Date: Wed, 25 Jun 2025 14:52:22 +0500
Message-Id: <20250625095224.118679-8-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625095224.118679-1-snovitoll@gmail.com>
References: <20250625095224.118679-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_025329_839071_28E64BDD 
X-CRM114-Status: GOOD (  10.16  )
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


