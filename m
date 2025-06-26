Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD8FC7EE31
	for <linux-um@archiver.kernel.org>; Thu, 26 Jun 2025 16:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iNdRW1IbQwaJLK3IU9ZGilulsvtFwP6FJhql802bOZE=; b=DL27mJEB0cdqXWqz8P2+gW6C9E
	CAtLyX6htnb9a9pwrF5eQnGX7ysHzVa4laa5cfgekdnkFrAAEmutjaBCdnVxl9zjjcKltZIh2M3N9
	43yjoWTvfzwyhVqv8v71hPt8t0G4KS+APWaukY7JxC1H0d2JgoqmLk9EcnMc/6KrrVykX5oZyjYTX
	0gXtXI1yAOoHFW5KnvT/tlrH7zXJ8YP3X3+ve8aCVD1KnyEx+akiRNOwMTm7tCsWfgNkdoog/T2S2
	jnk58V0MN/gnTruV8c63xQHNrUi2od3FzR55yHe3ipH43G2A5559hdhv6iz1NBmzlV3NfploQNktA
	fP/mr2LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUpLA-0000000CFbY-153Y;
	Thu, 26 Jun 2025 16:20:44 +0000
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUoap-0000000C8Fb-1XHg;
	Thu, 26 Jun 2025 15:32:52 +0000
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-553b3316160so1021411e87.2;
        Thu, 26 Jun 2025 08:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750951970; x=1751556770; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNdRW1IbQwaJLK3IU9ZGilulsvtFwP6FJhql802bOZE=;
        b=G6ZpMr473w0DIEpB/Oy0Jq2isu9p8+Z220y+h//cRG58TRcgxwz1B4rKk7SIjE9hV0
         m3MXFOzQw3UGXg4MHEtv0VXQSaxhjCoI7MGWv+QN67DTfzmdh54aaVkfi+SjrppzWGfy
         ts+cmBWWU1bzKgnpSqdhDKUmHzBfhYY0i6dLskqxvcX0gVhtOOWfgQDHA+Q3bnNvkmcu
         kp6q7Y6bfZylevmUd7ewX6ODtLoa89XVXtjRD5U9/DMfkTjCghCyho8pKHGnBtGWQrrW
         pRWxH7zlBeY95FiU0PsO/nz7XhoLJo1m0Y8qYLOEyAvfqIa77IkhgZfCugTDuOJHN+Ki
         2rFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951970; x=1751556770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNdRW1IbQwaJLK3IU9ZGilulsvtFwP6FJhql802bOZE=;
        b=m05xMy3YxTmXESSeZmNYEIqLQVCFUfCrvypxedXDRyuKnMOLgeL/FjaBTuX3dmzV5+
         OUJbYM/1gUByPb+J9Py1cO0CjBBKHMKTNAHjiVz20FLIlvst2v3pWkOf7VemB9KIN0/i
         rnBoUIahnYShFb9A//wjNFJfa4/UVrq5gkfnNkezfZaJ4MIMRUw4FhTbNpjpBK08GKwP
         M4aXP+0LqTjtpB55wZJBLVcXY1ijKBchoXlRHtn/3PdJixd5woU92iHM6Ke06Eq6ilXC
         14U4aGns2i5eTDob7Ojgbr9+NRfOkOboVWGrIaqM9umrcZKTHrDI2n+XX7sCmLQUGy2Y
         6u5A==
X-Forwarded-Encrypted: i=1; AJvYcCUK/Cmdu55b10F1H075/bmjq7FUJcsKWBJ4iuaHbU1+jwejZci0riKdpqQCgBS0IlqtZFbfamU6KFjUvzI=@lists.infradead.org, AJvYcCWYlwMVq+lAgoTOiKPPhcnwaDtrI7A4Wl2YrrSwekkKqz+5c8jWBPRaF0m7z3/IHcVF4f10mnpxvRI=@lists.infradead.org, AJvYcCXVX5q6W/RQDgbxl6PZGg/YymJexFaFRCjtvIDq09TGGqFX1FkYEDFyWK+n1XrZnzdOC0lZ4peGZuGbqMOJpLuE@lists.infradead.org
X-Gm-Message-State: AOJu0YyFMinM6RMZbZdZdLYcbpaLIwQ2w1pwVkMIqc5WAzqIPOUqJyci
	unyvo4kNdE0dJofz1ifEOo5iQ25ARHXA9zuac8Y1YiCfPxnOPg5a8JME
X-Gm-Gg: ASbGncu5KeUwxsRyxPmd7PQ2RLek930iqp4NUhhNV60YuOMarm4NeO8l7k8aXm7/bMy
	uJaQbA8mGaF6wCUvm2OMj3Sbykw4j8410Un7PA7RvKkrE7qc6qKgMMx4qRePW6GWe+ictbcwPC1
	HgJkjEcPEJQHbnmJWU1CHZ2bOiF6C0c2nmoFJhQx+03pCesuf9QkAFL1iPo9AEfJGncUeCwC7XN
	2l/8tNh1JUzGLtoSp5LrDzmoIRja6BZNVKNlU6XPNddSMYRD9SP9tZQZvgxOwYnH4YHoK+3mKPg
	+PtGFobjeqGh1Dvo9vqh8DOPK7qxNoVrEDsilbsB1D4edOosEG3vHOAIGhhwmEGj0+/iNRDODVE
	qwP5QjZzCwzM2qVKsZ7p2fuWwt4cjMg==
X-Google-Smtp-Source: AGHT+IEJ8rUJC6ORRfCQpyeVpgt13wcImWaXJ02l+Sh7w1+4iNgFiJrQa6DpXH1RNUwTGuIGr0B3/g==
X-Received: by 2002:a05:6512:3d8d:b0:553:d637:1e96 with SMTP id 2adb3069b0e04-554fdd1d556mr3088387e87.31.1750951969599;
        Thu, 26 Jun 2025 08:32:49 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ce1fasm42792e87.174.2025.06.26.08.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:32:49 -0700 (PDT)
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
Subject: [PATCH v2 07/11] kasan/x86: call kasan_init_generic in kasan_init
Date: Thu, 26 Jun 2025 20:31:43 +0500
Message-Id: <20250626153147.145312-8-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626153147.145312-1-snovitoll@gmail.com>
References: <20250626153147.145312-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_083251_394825_D9331B61 
X-CRM114-Status: UNSURE (   9.89  )
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


