Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B907FC7EE30
	for <linux-um@archiver.kernel.org>; Wed, 25 Jun 2025 12:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GQiI3pji6r3skZCyeT+2q6FDZmdcyPERVGy1ENHzh48=; b=BkcD4by18s3qPPv2OVbhPy1aCO
	avb+IjNMSWrvSgTG138uJjVUB1p+6tt+imA1nSxJuLTau1wjyKIP4yV7T0NP7KLZQVE3cWMDVcLva
	+qiSDuK5QvlJ7nprNdYj2fRnMtkRWaiQZzlldKWaLZYz9+W7EhNkpYdPQCE384gKQGBwySfjrWvm0
	4L9jPk41owNf9I9oZfckP4s5k3TEguK8J78MrWmcGmxKqp6xF7HzuMlMrXRB1h2jhbvhvrV7lB3bR
	ZXqCWISgXUx4/XO1mhnfTK3TaPO8XFpMdAKuIojynl74WiFjgbiyL3F94NIK4oQCr7eM+U7df5G/h
	r6G3JpTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUOvq-00000008a4K-1r6B;
	Wed, 25 Jun 2025 12:08:50 +0000
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUMoZ-00000008Csh-2ISC;
	Wed, 25 Jun 2025 09:53:12 +0000
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-32b50f357ecso52646641fa.2;
        Wed, 25 Jun 2025 02:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845190; x=1751449990; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQiI3pji6r3skZCyeT+2q6FDZmdcyPERVGy1ENHzh48=;
        b=GMqmkWGiB0dEsR5jAMFVDohRnYgCnBfogePB9vM8FHRPHogulScDRMdj5zv49MEKo+
         CJv+CEv03/jEByLfwAX8hzUpL8mWBdmVMXxQL5WMqvg12iS8xsn3PdAeBThxebhEDetM
         +C4+9shTG/eV4uDHxZs/jdlIdReuZYd8NQqcoe5CWLj2AinEiPZdNBO+olmcG/0AqBfU
         U/ylI7m0asB0az4BRufo26bGBSTrLRjyHzQVib0HsDIc2nAoRZFo7sOsvmLgVV6XEXwC
         oKgEjbpXdBCnTYXD6WrP4bbI91yb076Mo6BdWf1/OxS+4Vy7cqgo748iQQm/saCcvPng
         zfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845190; x=1751449990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQiI3pji6r3skZCyeT+2q6FDZmdcyPERVGy1ENHzh48=;
        b=AedbDpo5Ru8/s4sFgImMo1VGMV1OqwjhJVFZJDvnZUytT0q4XzLCgZcsGv1L4nPrt8
         uXqv3U9whm8dusi+0OfEsaEE2BYOEC0TnUAoLqSbYiYLsGOaDR3f0quNclE2N8gPqrx6
         GgxEt4r2/WO7M7bCo/AQXmtYaDODJ/5Q0JXpjm5EmVe/9sXtrMGNqQMukvlMXnIC+2bE
         prPgqjCZMwXmujqHFyTHoe1QLmLdiNrjE9No4Oom6sP/IC+I8CBYD0WzPN7J7lE3FKC3
         doiYeGfedHBJD3TM0MLpAvanu7MvxYKEbGn1agvQUqulzF5RwAJP0eXoXFtcVYqWSxjT
         20Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWJD3QqTnn/vgYaOzAi73zdqd3OaC0c7ZkRLgTLiGOUUJ4uhnMmtX+esBBUIGXeCBjpEA0NVY/0+Ww=@lists.infradead.org, AJvYcCXbp4kD1Vmfu7MNy/O4JXQVDUSwUqMowC9qKDbDfIu7tHTT/ZsK138WW8dHG/9v0PkigN2Gi1In76zARQI82wEH@lists.infradead.org
X-Gm-Message-State: AOJu0YzYGSc8IVZ7Hn5kPuSb1iMdfmVhracksGZw0EoNwkRAyY3oMl41
	ymCmRDPI4iTQAo5BI9JCnVO2D1rUL6NhfNmwNWC3PhQJoAFCGYQwxSto
X-Gm-Gg: ASbGnctAWbnde+0LzUc9rrpmae1FvUEEAZRrR02Z+OkiGt0tV9PuFLvHGL239XjFPAM
	SnW2RujSn6ukNfi6EtVNcwW9f0SKV6i+hqmHbxMpw8s/RinN1Zu8y6lu/o6M8yyOb6Pp4rcEfSu
	JX50PCiEeQuYLSH9fiGLByx0tIwB/yqwhwtfR5vKvCAe/xZAgGh8EOn/OBWR+JMRl4f1+eve/Iu
	ZWghyGkrYpI9Ce300MHRGHyQ4a3vgokMlV1yaq9KnFgtzGYebX/4XCzYuToMZSujRnS9oajFDk9
	T/ukVz+hBnbrxdHA1EjEDoKmDwMymUAQptlcGxHd3Oxto4vryRENRgMWggyHvnuUA93jSPkLA7D
	u9qH/7clvOm8ZYnIF7oJ1sl2gSc7xZDCiMvE9LdU2
X-Google-Smtp-Source: AGHT+IEfK1Xq7ZnXyT0Os2Uk+Tl7A2yRnzkJG2IvrwiF+G9b2Q8GisEMs1F3MxkK27tqhocl20BnLg==
X-Received: by 2002:a2e:a54d:0:b0:32a:7270:5c29 with SMTP id 38308e7fff4ca-32cc6421a2bmr9358961fa.2.1750845189565;
        Wed, 25 Jun 2025 02:53:09 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b980a36c0sm19311851fa.62.2025.06.25.02.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 02:53:09 -0700 (PDT)
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
Subject: [PATCH 4/9] kasan/xtensa: call kasan_init_generic in kasan_init
Date: Wed, 25 Jun 2025 14:52:19 +0500
Message-Id: <20250625095224.118679-5-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625095224.118679-1-snovitoll@gmail.com>
References: <20250625095224.118679-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_025311_585010_1A5FE307 
X-CRM114-Status: GOOD (  10.54  )
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


