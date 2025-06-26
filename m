Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225B8C7EE31
	for <linux-um@archiver.kernel.org>; Thu, 26 Jun 2025 16:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PCoYbCl3wZIeXCSyY3ZNY+HzBteHxI7NOqzCSDqwFag=; b=ZRH+IhaHz/TunEgpsQzokcPeWI
	KA1x6KQzMQrL7t0+VFzh41Z16X6oEHQy7niwVVYsibbN7DJDzYu+cJHl+//P8iPfRa42TY2gnnHhn
	Fx5ulUAcI+br7g+r55rLXHpUe2AHaz3ggPZHY5dmQAuC+Dl/Bmu1Jia96rBvRi7P861EeE0t0aFwV
	VxqQFYIgUZX8FRC7oIcb+W42bVRC8Ue7AKjbxRPYhHN3BmxgCaLt5pjhQGkbJSJOe9+8tvI/ITbvr
	rID4eLKh8XILRgzOiN4uY6T3653YX8FgQqcEAdwzXtyTQ26ofSHqst2l2X75vt8cdc50ago5RL45y
	ytnnIz9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUpKb-0000000CFHs-3jUc;
	Thu, 26 Jun 2025 16:20:09 +0000
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUoaP-0000000C7xt-0rvs;
	Thu, 26 Jun 2025 15:32:26 +0000
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-32cd0dfbd66so9023921fa.3;
        Thu, 26 Jun 2025 08:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750951943; x=1751556743; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCoYbCl3wZIeXCSyY3ZNY+HzBteHxI7NOqzCSDqwFag=;
        b=BQDMQr4YjZ69+HuoTBRP5/JOh7hy92ZNsdY/84J2o7KP16ESf2VR0+S0OAzTGRu8zO
         32fJ752Uru1WMMNMQegWBjTSf6UpR/iwS0PiJRwD+27FWfOq9fddJ4+UJLb5jKSNIC6A
         4H/LbO+i4Rhf2XvfgF4zGT1Adj/k+SW0FU6MWoS5JnQzDKyWSCV5mFAAzJrHaRTQkJed
         CaqXqCWqxu0gL0kwLm9a3Ib5LYfn0N7i5i4K0N0EJm6gRNuqOIYcGIETZk/9NwuPKWFW
         NTNgjzyaoS6N/HiOAtsujowDbwj3sYABQA45WJ5bgXHMIYhLOR+fGCYf5/VtX5aA2nNM
         rQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750951943; x=1751556743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCoYbCl3wZIeXCSyY3ZNY+HzBteHxI7NOqzCSDqwFag=;
        b=HAeiWzarxQiGYaV9v1QTf46esUdZ/9b/uhJ4QBkO/8rBmlArHPGfUmQUEaj7ZTCD9O
         RC8NqhDdjm4+vzHs3lOOsTy4yTyYRiYYmvIkOJptt0IqPt8mSbz4nMt+UjLi/C3uYymG
         FC88D4R2qXAmZzfqi6qX0KRCysIey4yZ/XcoHowF+zsh9ixPr0au7Q4+/Uu/UTu6PyRZ
         idBPbNeULiOG7iDaVxKWZgTGrm7t7GVEuUDo1QNppiOyVeXPdr536ouu8QAlq0YdU9fh
         XlrOnqnRQqGVgb0qZz1Lvallw6GuAvn9jQjsLdD1Flk1jgc4c7kF3qitUs97UclUVJJY
         mOaw==
X-Forwarded-Encrypted: i=1; AJvYcCUHY7IpRe+6Q4ePOhlrEwqoVXd8PoiiqoHf/lyBN4toqoQQmc7zmhCFNirehJx+jei893CyTSl9HMI=@lists.infradead.org, AJvYcCUURS3lbCSSd5VUYbch4ZRJGlYihe82pZRwWGUx6qxEy30zvo3CueV+cZCnHLWIrfB7rWAkwz2TUu4v3VU3ba13@lists.infradead.org, AJvYcCWnPs24S0O2/Gk12LH1gl8hOmT6M2+DfsZxJRMJarNEG0FgWV2Wqh9/csAGxHYUQ9O9pu8H/uIuUW5sM1w=@lists.infradead.org
X-Gm-Message-State: AOJu0Yw7bqFZMrv/LSu47zGLjP8MUYfCSsdLvR628xsdnURCkcSfnQHK
	VfBOehsWXWxlS6mlRV5XuaNnskiSiswEsYeJ7NCvzJX0lSGv3iKt5qUO
X-Gm-Gg: ASbGncsluXbhqY4tr3nrWkJ/l6DCXhugBUJeSvheDdhyrsUBcBT1zj9lr5DEC5ZXL0K
	jE3JjoKunmVkXmKZ03MHFuaP7Sn3Pp8Pv2cRGFm60KnnhF/MwySKPXxgyjuxs9yKSMySPSw9d9i
	75Xc7d590OsOXdhfkLRDZ6UopWJtKh9AJg0Nkl8tI24MwT95lyJ1YNVaRTNsiBMp0OCUdNIjCkw
	lZRZwUtuYkeWCEzNaLDJgHS9BaTZMhaUYunpvK7k0r3tGASRibsT516C1kN/hN75Bdi761htdkm
	Wu2a4QOHjJYkgQ0iROBYR3QKPWKYRXQHf7gDgi6SakL6kZCLIX8ZC2YIjvalAvqQcvLMSzadijx
	mrnI7ETvMy8M2XoYud3FHwrHQt31mZ6H6biWxiE0/
X-Google-Smtp-Source: AGHT+IEkjyG404mf0WVWC0akoOQBzKpFWvtutC6can+yvjxVSyNvAZo7Oo5uRf5TEFNgUYRmuuUuuA==
X-Received: by 2002:a05:6512:3da2:b0:553:26a7:70ec with SMTP id 2adb3069b0e04-5550b79db9cmr1980e87.0.1750951943188;
        Thu, 26 Jun 2025 08:32:23 -0700 (PDT)
Received: from localhost.localdomain (2.135.54.165.dynamic.telecom.kz. [2.135.54.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2ce1fasm42792e87.174.2025.06.26.08.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 08:32:22 -0700 (PDT)
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
Subject: [PATCH v2 03/11] kasan/arm: call kasan_init_generic in kasan_init
Date: Thu, 26 Jun 2025 20:31:39 +0500
Message-Id: <20250626153147.145312-4-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250626153147.145312-1-snovitoll@gmail.com>
References: <20250626153147.145312-1-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_083225_240572_521F1E3F 
X-CRM114-Status: GOOD (  10.09  )
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
initialized in CONFIG_KASAN_GENERIC mode, otherwise it's an inline stub.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
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


