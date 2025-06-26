Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4DDC7EE31
	for <linux-um@archiver.kernel.org>; Thu, 26 Jun 2025 16:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nxtugr6OI+iAiBoQ5DVdScoZ4wigsSWWp7UsuEUnh5g=; b=XwRBv0vscg8ETxnl5plVvrG57A
	BLPD3DxNfWG/fg7AGgFw/kQ7dm59Uwkg+N1qm7Z+IFFufPMkngJbTdNJ43dvBhNSEiX8XdS/jKB4Q
	gffRmA9DTFfrJLHpU7HHUVmb3xsJjKvrGb3wYZ4YKgG34LytTFxEuLMVlgSC9LuxzNpiO1IpnLa/Y
	3SwP8kofooCHiJ8L85g4Q93L4QZrZl9/bmA4UQytZOqDG3ppWUrKwJqlhUj/kvEEXjUntCbAhoHfl
	bK9FLwk7uKAoECDG78eufeCLiNpUSO0WoT3kA9ADTDLzNCRSWjl1lRMOc3VEyBrQD3odtO+5UJlYr
	A7YP8UfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUpKk-0000000CFMU-0NQV;
	Thu, 26 Jun 2025 16:20:18 +0000
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUoaW-0000000C82E-0Yfx;
	Thu, 26 Jun 2025 15:32:33 +0000
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-553cf020383so1233114e87.2;
        Thu, 26 Jun 2025 08:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750951950; x=1751556750; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nxtugr6OI+iAiBoQ5DVdScoZ4wigsSWWp7UsuEUnh5g=;
        b=mwVX0x7i3jlVJf+/ZC0EYuM6eTy2so09gHW3rSflGlpN+OnWrRzl6y5HQSGDZgZ223
         PDdwe2khT/DvM4IcaDGPIJjuMExfot0g45MTE4aNZR49Xv1IJr8z5/heTJIm9eZyfbnW
         jwv4LpKB27ZrXgAUVd6uPlU7oYrkJoXiDmo/cIRMxYy+P8zFV0K57uoMNBV/tgXkKt80
         daNsV/3cftH6LieV6fv9ecJ2PQI9ekrbuG71fPGZScsjNJLXti+Uae2/VQtca+Sh/q+1
         uBTYSCLRUSGnP2E6FvQgXtrrE7ucCULv4hX7R4kd5bb/lxDDnwiZnRH5C/JUDext6AJH
         wSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951950; x=1751556750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nxtugr6OI+iAiBoQ5DVdScoZ4wigsSWWp7UsuEUnh5g=;
        b=Y9YDGHX6/ZkyO6MyfGqiL8T1Q+UqtEOPiMy/6EpweU98AQ7jEh90wuqf9PrfzQ+bHn
         39UvJP9IKf/SaUhP5O+des79ilRBZVaoYNcCiI5vXKlZ2LPfxSibvl2DNfNao6DyS0Cl
         DjDbhBwpzlQITYUxNpavfcAtmmX3JeNsZCb3iS/aFiXBFMIVQWvY2pbr/3sgOFl9C3Gk
         ggAZqnAwXsNo8a8iWFS8D4yx1Q9nQSYgu1f7oLkZZp+ZPCXzkBhfDlKrozurOuKd3nBw
         RTwWhNLSmWWxVqafouC3NhoDGW1n6oPDu8qEeW2wxdvOMtKB+IWnQvjHOXsYXa95IIZi
         c3DA==
X-Forwarded-Encrypted: i=1; AJvYcCV43EeWGPYXXFxjhsqDjP9D3QdrSMT8HFfi00XfVkOm79oqXGj6fx51CHuTHJ6rluO2tOhqtV6LWLY=@lists.infradead.org, AJvYcCVZW7QZm2RP713yDnXu0dGIB2Fn3Q0j37NbkuLkC676yseQs6PrVdHiWQdQ7C4799mMzk4E4eRhK1QdaK8=@lists.infradead.org, AJvYcCWmceqMiAVjsPagL7Px7GXdQImFq1LBYtq0ttXtms0XZa5VVzAQG9pzKvudMd35pq/Eksr8rgG6lF9UNoabjXlt@lists.infradead.org
X-Gm-Message-State: AOJu0Yx519jJZkjBl5Z3qIIBPwy7EWtIZOehO/70Yirg133G++r8b6en
	4/Mc2OOpWANQ+urWm4rwPnmjm4s9AfgfzT125cS2UXPGecG8a2KADglf
X-Gm-Gg: ASbGncvdwlkz67vlmVllrD6HmnHKlJdRUnJ+nOTSUogoSD0J6Z/eWFm9vbvJI7Hl/MC
	Ats6fh7CnEBqCcHBdodouhibgeTFyzRRpg1kdPGx90bm+bXNMTNzvGCBUaQGRLYM0fYOs/yREmk
	V+gfmL9EXubKpj+IGMhKJR5asuNCx+QFSB9YhynbFIwInxtGCq6iC8BvVNjW2x8ytiEY4fAa/4b
	F/1j9bO7drYLFq2gZ4po3PNfmBbH4s2BPy7KB6YNPcCcimwWwEWOVKwNGO0AUgf61mu9/EbY9nr
	YaTm7LgwwMx9Xpm+Aq9Q9S2T1znUtZJ13aMY83nlwtoDTH7kBOGmz5yJeRULzELVmcNrjt4c9ph
	Wmf2ZmppEqFWpkHdIivQJiGsKXShSzA==
X-Google-Smtp-Source: AGHT+IGGt6yu06Z/Fb2uJjOxPY5fFcWkWfnfjRjUezmHyuS+t/QogNEJZXQVSUvZn1n0IiNOe7m/dw==
X-Received: by 2002:a05:6512:1193:b0:553:ccef:e31f with SMTP id 2adb3069b0e04-5550b4749c2mr141485e87.13.1750951949806;
        Thu, 26 Jun 2025 08:32:29 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ce1fasm42792e87.174.2025.06.26.08.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:32:29 -0700 (PDT)
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
Subject: [PATCH v2 04/11] kasan/xtensa: call kasan_init_generic in kasan_init
Date: Thu, 26 Jun 2025 20:31:40 +0500
Message-Id: <20250626153147.145312-5-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626153147.145312-1-snovitoll@gmail.com>
References: <20250626153147.145312-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_083232_189925_5D6A61EE 
X-CRM114-Status: GOOD (  11.23  )
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

Note that arch/xtensa still uses "current" instead of "init_task" pointer
in `current->kasan_depth = 0;` to enable error messages. I haven't changed
this because I can't test the change.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
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


