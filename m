Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E2FC7EE32
	for <linux-um@archiver.kernel.org>; Thu, 26 Jun 2025 16:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m8+Li4ZqAZW0QY7sIIldmBLFf6VQ+4AeP6Iv95ugt8g=; b=s0JRXKQiFqjCyR2xndwzLg+gfe
	94taABiIzcwYEGQmJcaS5F54vSYc9ektJSXC8/qoQYdRLsv2bEUV7ZPaZPjUjKWZtjqmKpKdNJeBC
	gktv9lKKUKrY1NWnwdP9Oj/QYOvsNhsYhHMIx0gJ1+QdGb0c1hY/81Axy5C4q4ZQSc3k8prJsUs7+
	7Vtzeblr0B+5lGMAH/6HIRHMq+fyXVDCdQX4U496UtnHfaBBqjewjBogBUmP+QJpeU2aY3fvI3T/r
	3LCN1gPjnaZ7XAZk0oHqqpK/Hv54FhzaRYhzPqhK7VfrnHMCZaSm1eJYaTZ7t8m92JJDLtpg0UY1K
	KnWDepig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUpKa-0000000CFGZ-3VXJ;
	Thu, 26 Jun 2025 16:20:08 +0000
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUoaJ-0000000C7tJ-0LqV;
	Thu, 26 Jun 2025 15:32:20 +0000
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-553d2eb03a0so2528873e87.1;
        Thu, 26 Jun 2025 08:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750951937; x=1751556737; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8+Li4ZqAZW0QY7sIIldmBLFf6VQ+4AeP6Iv95ugt8g=;
        b=bPPGUnoIymsQqZILIEjXlToTO5ka/TnpDgP7tZM5kbkZ7Wsy5AU2cnHsQM2QmY+xrk
         sqyZTLRJH9SHgza2n2Y3/9Ylrcf98qlI30IS5jdMXaLrinL04ooJtn3iGukg5P95boNk
         SUQVYXRjePU6bmACc3lsmRiTBoofmMdJiu8gltR+qGl8LuBEisAECEdwyhDbodiZ8AnG
         2boGczSvIc/Ggj8iQiEdK7fzqSmLWwyhwV1MVx5xIbQrPxtMzvb1s1CUJTOxq1lnXInk
         iJAUnzVRE/OFJkax6K9EjpP9DLj+0OCMb1RmLP4CeP+aLvWkcU+rr3c2QLOAEibzBwsp
         h/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951937; x=1751556737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8+Li4ZqAZW0QY7sIIldmBLFf6VQ+4AeP6Iv95ugt8g=;
        b=u/UMYeMQukIeHaxZSvzfzOui6k9khEhlu5ZxbF9aE8x20pqPutUNM9eXk51tExPS+6
         Zt77VVLEC9VOdzH90RkrNRbss3x4gEZ5qkcXMBPSeryhgV2Oc/y53YMwftlTJMt61X1M
         D9JoXexuti0ykFdnZKDItD3GiHMNkyzDy48kZuNFvK8i1jPw4SuxsZ/Sqmqib0345S02
         dXJezR6FxIrQXgPaRa0h+UL5cDD0Nr+4cv6qpAc+GluW5yMae4r9zhobv1EzztY+ucOM
         L4qGUp2mtK5LSR12XdWiMTeUBcCUqX7L8bnTgcgyizOp/P7J+ebpj7UMwyBf6yn8vzPJ
         HDCA==
X-Forwarded-Encrypted: i=1; AJvYcCUfECoL+BVY36J87EE3HE4kHaG4gj0wIZ957M/vxO6yJFbx9luzURWOskFf8YU2qGk0pUSRJCAX8pM/2oKlkDXq@lists.infradead.org, AJvYcCUlg6y7zvKsUOCKDalyA9955niR1NB7GxgmC2oo4sVgYKe/EL9GxGjGeneV7PQKO8xFOsdRWgg+kLQ=@lists.infradead.org, AJvYcCX9PdQgl3fFiEQKlqS6lhLBEazFg/4vFMZnTOWlcOU7QA7jR99pBVE8P2BL9ikRD/tdjUMCtrd26hQboLQ=@lists.infradead.org
X-Gm-Message-State: AOJu0Ywn3KOR17ThUykn4aX7yeGoIGPVfhoR2TL9yo+dpV93hNoFbYaX
	RNgJAAU1p0P3cKlRxEQhiEdI++Fedl1u2bNbKyqkH9YQ4dQC0uNn36/C
X-Gm-Gg: ASbGncswNt5SWWh4C8Nw/TVi3pakT7D/m7YdEwLZHBskLYjwQV7zws3gM0ZICyfEKQ1
	qYrDN21TXNPqd6t9lT8Ekx3b3qq60rXBmD5GCMaOOY+RsTiZShYTnZR2dudHqN9E/SDZfgQGbiL
	H4pWL13mCyOpKVP3kRFul9fSlYnVfEYMeoQNCuYFzIBmNAehUP3uzUvgxGuaTCoFqPpCOmiwYgw
	RGZg46YPTzWZ4Vo5Qs9mZYrjGvk8pW1y1Owp3dZbCa2ap6Y1Jy2b31yIBn8yT6XNHKvx3FRXPKP
	5xQbA77uGaQGW5G89EKJZlwwTUM8q/uNWZecX/nwIPtDg2cOB1YFWNjmV8t0Y+ZAJ0zCb41w42/
	clnWUyqovp5tqiOmjXQsGwCwUXbeGfQ==
X-Google-Smtp-Source: AGHT+IFV82PjQkEQV8pwkpgH+uEG2XxjLf7tDKt0/XCF6qX83TTzJXquCdeUIk26UtVJ1dwuwllM0A==
X-Received: by 2002:a05:6512:3e0f:b0:553:cab0:3800 with SMTP id 2adb3069b0e04-55502c95046mr1480652e87.14.1750951936982;
        Thu, 26 Jun 2025 08:32:16 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ce1fasm42792e87.174.2025.06.26.08.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:32:16 -0700 (PDT)
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
Subject: [PATCH v2 02/11] kasan/arm64: call kasan_init_generic in kasan_init
Date: Thu, 26 Jun 2025 20:31:38 +0500
Message-Id: <20250626153147.145312-3-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626153147.145312-1-snovitoll@gmail.com>
References: <20250626153147.145312-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_083219_119142_F6DF30F5 
X-CRM114-Status: GOOD (  10.31  )
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


