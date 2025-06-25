Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9BFC7115C
	for <linux-um@archiver.kernel.org>; Wed, 25 Jun 2025 11:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ovwzGubQ7EZCWb++7xcfiusg6EJnFDR8lh6aTJ/PpoI=; b=ZSAAvTPI30NEIuHH/jryof6FsK
	hzYGNBrZLuU0UFixZ4h/3pRW2D0EhRfSuheXKFOJ59UGoAE2s5XLOJf9GQPdOCdqb7SLdsCiuJNKT
	1AQyPMHxJH79IEJQbp00OjiEI5wH+iKlGGCZL1LcmyU9ARUFI7vBBdSOT2A7QKpaM55sSWGiiHZdr
	icrfEoZl7fIVywwxp/nNjypuwNe/B9b0NSZcCk3DM57judz30UVIS9N3KQw5ZNa/syf0yDKMtFkxo
	hAAq6YTN5CeAtYY38hZfSgjfM3WltOzIXoIV8lZUl0CBWvqpxqyuBuuf4wF4GNk1LrzV38lZ6b+1s
	bWkCTeNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUNxY-00000008Pps-3vme;
	Wed, 25 Jun 2025 11:06:32 +0000
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUMp2-00000008D36-22Sy;
	Wed, 25 Jun 2025 09:53:41 +0000
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-553b6a349ccso6281957e87.0;
        Wed, 25 Jun 2025 02:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845219; x=1751450019; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovwzGubQ7EZCWb++7xcfiusg6EJnFDR8lh6aTJ/PpoI=;
        b=NIRyhuWp7fRYF+bcANgGVORlbL8wJLeYCJT7PUVQTcswWFhT/XUJJKnSqwxKd+bLkW
         q5yjIS6MwUdDrBHDogEiXLtvOdkA4Mr2Vn2qAo8Ymvjx+ZnDRSs32t1QIO8/T8expOu4
         HrvxQEtHCo3Y4KAaQQEHdkXf7Irha235zv913Ra5tNvehU0hvmsa7ehpeV6sg9i6ge/m
         9aafg0y5+SNwPu+8/nTHZPUrYhEawriU18fjmOEuNePQW/i4vfc42rXYUv3Q5zKrPO6r
         7A8Wsf9teRi+XpLzklFpAzea4+4WMPT1vpLq6Trd2BwguF3NI2KyrgtXfzvKVSKAuuyF
         6+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845219; x=1751450019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovwzGubQ7EZCWb++7xcfiusg6EJnFDR8lh6aTJ/PpoI=;
        b=iGFaIK2FnSXDaTkOdfIp9aDS8WC56oXkeUgpTRVXKtMqwp+hXiMM8EUQk3QKJDOIs/
         NOH67zvBiuN0x7iYvZ7zt8/n9iQJLRWmBFovaTufTqL4jjXbMwOX8f9nMHNHrfm285J9
         HU1gXVDZfSGmsGdEd/GLrz4ezWjf0d60LHzyBytUeTdUZp/BLWC9FwvmsohNKOLsqpDW
         Jdpo7TyisYbvkH/LKKPt6PBmmwMJC5DG/HHm6yqI+O2LdZ17NqZz/ozONYDJflmoWsya
         BfGEmpEzJLkxr9k5Lid1P7tCQ5CLzYc4+Cy9nX6fcV4UKMSG5lAIKkqO9D9qK8yNmll/
         oqcA==
X-Forwarded-Encrypted: i=1; AJvYcCVINPbRNSL/kO3lgj4pkPoUFamNwQPqvKvXvjMb6KQqlr54uhWCwfPDbWHSOz+EjZZVsEslCcJAN4c=@lists.infradead.org, AJvYcCVna/igZHcyGbZTt4/yXIEUpiyCp8bxXy2UDBCesSNVK6RbIcBECQe6rW+Aw7aCErz9wLJffkHAjKtso7+32S2s@lists.infradead.org
X-Gm-Message-State: AOJu0YwR2hy3gxSYeobc4G0YtAul6vUGslS462UNgOsU8PJdG/h82Lpv
	cw9hnJezm/vTyoniixpDwjCjHx43uKTHvxbJMVVUlFKv3JlHNtFN+KdX
X-Gm-Gg: ASbGncsbyTYpwTwo5vJ5uHpgfa38DuS8Twm0YHdWF0bcR2gRmlOsiGGa8/y47GjHYHU
	TQ4Kr4odLzxCMaQdKWRCxXKEC5dYNujKLKAzZcSGYBkK+R3efIFGgHj/KcOwEpKOcdYWoAh9CWm
	rL/PBiFMKuU5pIig5tqSqJhzXFf4ZlitjQ2OX1ZAi84WAaHZSxhYZQ4IveEP+KZna8IQsIHd7g8
	nyBMuNlcP+COZk9pnv2qJUAZuV7jxyNRrXMz65WEZCZu0NZueYDEmUF1j6t69mDd2ZtUqv+J8fz
	qUmS+8HR3bQosmjz1SPnQs8YXB8dhOXy5lgAv7hAao0vbwBiK5MRiyly42355hUD+TB6PsC0V3X
	FIqrYysJmFilnx+M2qXLaUiMw82zavQ==
X-Google-Smtp-Source: AGHT+IHEtWnCbJrLGTsCzIsOmvfz7XrCUuinYoJ1YMkmnRrIevIL2qUouOt7T42E5UqDFgQKhJfguA==
X-Received: by 2002:a05:6512:3dab:b0:553:26f6:bbfd with SMTP id 2adb3069b0e04-554fdce00cdmr639671e87.8.1750845218713;
        Wed, 25 Jun 2025 02:53:38 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a36c0sm19311851fa.62.2025.06.25.02.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:53:38 -0700 (PDT)
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
Subject: [PATCH 9/9] kasan/powerpc: call kasan_init_generic in kasan_init
Date: Wed, 25 Jun 2025 14:52:24 +0500
Message-Id: <20250625095224.118679-10-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625095224.118679-1-snovitoll@gmail.com>
References: <20250625095224.118679-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_025340_532630_2F1570C0 
X-CRM114-Status: UNSURE (   9.88  )
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

Call kasan_init_generic() which enables the static flag
to mark generic KASAN initialized, otherwise it's an inline stub.
Also prints the banner from the single place.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
Fixes: 55d77bae7342 ("kasan: fix Oops due to missing calls to kasan_arch_is_ready()")
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 arch/powerpc/include/asm/kasan.h       | 14 --------------
 arch/powerpc/mm/kasan/init_book3s_64.c |  6 +-----
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index b5bbb94c51f..23a06fbec72 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -52,20 +52,6 @@
 
 #endif
 
-#ifdef CONFIG_KASAN
-#ifdef CONFIG_PPC_BOOK3S_64
-DECLARE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
-
-static __always_inline bool kasan_arch_is_ready(void)
-{
-	if (static_branch_likely(&powerpc_kasan_enabled_key))
-		return true;
-	return false;
-}
-
-#define kasan_arch_is_ready kasan_arch_is_ready
-#endif
-
 void kasan_early_init(void);
 void kasan_mmu_init(void);
 void kasan_init(void);
diff --git a/arch/powerpc/mm/kasan/init_book3s_64.c b/arch/powerpc/mm/kasan/init_book3s_64.c
index 7d959544c07..dcafa641804 100644
--- a/arch/powerpc/mm/kasan/init_book3s_64.c
+++ b/arch/powerpc/mm/kasan/init_book3s_64.c
@@ -19,8 +19,6 @@
 #include <linux/memblock.h>
 #include <asm/pgalloc.h>
 
-DEFINE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
-
 static void __init kasan_init_phys_region(void *start, void *end)
 {
 	unsigned long k_start, k_end, k_cur;
@@ -92,11 +90,9 @@ void __init kasan_init(void)
 	 */
 	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
 
-	static_branch_inc(&powerpc_kasan_enabled_key);
-
 	/* Enable error messages */
 	init_task.kasan_depth = 0;
-	pr_info("KASAN init done\n");
+	kasan_init_generic();
 }
 
 void __init kasan_early_init(void) { }
-- 
2.34.1


