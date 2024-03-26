Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6CEC54E58
	for <linux-um@archiver.kernel.org>; Tue, 26 Mar 2024 07:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yYWj2Gn9osrAFD6FEND6e5qyKYrw3yLcAlVsmaICSiU=; b=DUy4/Dqm4J9z3vfU7qnA1Jgdng
	1rW/UDBfhPOkpnVNudgYVRwW0IS9FfRqLsPqfKkrPrMF9TAQ2XLvW1r078/4078F7zJfj6wT+ZLUy
	7b8mtzNUSt1H+oomu1PBECo7WxVqnlXVSp7naBU3emimfK9tQAVvDiVAGtDmuAMWO+3kqeg5DcAP5
	L9tMHchPWv55cGlx+V9Sns68vnPIkmGm2BiFSKNZMVNglJsc43oeMxrYNUb2qbetgu9C5eJkQXpr4
	SgURvBiblp01Jy63LA1JahsiBDk7kd/+hs0OwV7iOAgaFNO/VC4TQW7u0HHrUX723FxVuKEt3K16I
	0GLbC15g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp1Nj-00000003Sxo-37c1;
	Tue, 26 Mar 2024 07:38:03 +0000
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp1Ng-00000003Swg-0h3M
	for linux-um@lists.infradead.org;
	Tue, 26 Mar 2024 07:38:02 +0000
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-60a03635590so105406817b3.0
        for <linux-um@lists.infradead.org>; Tue, 26 Mar 2024 00:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711438676; x=1712043476; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yYWj2Gn9osrAFD6FEND6e5qyKYrw3yLcAlVsmaICSiU=;
        b=et/hObq14Dj8ztI5nEj/3/WLu+qgT0wkB+1rMW1tBFch4YhEFTqitWeCyWeE9VJTBh
         HFygqh3BIbBurM+xgzL39w88SInHpVyrNkvPdgQ3mSAJR+mqHtA3nDs48osbfwVR32V9
         dBL/SsUzxK+9uJfwuY9pmVXsGz4zWL5WBUu9TdpX6wIvckGkdPo8Lz3wTQNLkIlJz+vT
         Ee8sG/s4r5OdUJ/nOMvV/Ee0jNWlaY7E3N61BKt8upL9oJE3TZo4HDquqONi7aeI/rlh
         E82Ysu1Xrn+Ua/tp4E87kAwqK2gDosYrNrHFX1ADdYHYR7PgKOsuSua3QuJx2RYt53Rm
         8t+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711438676; x=1712043476;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yYWj2Gn9osrAFD6FEND6e5qyKYrw3yLcAlVsmaICSiU=;
        b=D261U4tdtm7LGZX7WSaHqu9LzZqa+iDLw7s4n3U4m4kARcCuSCPoQJTWrOLp+cuz8a
         +P5+EEWy3r3TLClVItyiq7dAsQLp8E7Uza+hW8qTyo9rzOvmyHm2DAfBa9TJPAblIHEE
         yN7ZnzvI6Y3bgxzaRDFhn/flPDVbRzV6rfDN7kfMBLj2yeYichHeGdY3KZX2cZS8pKf9
         KGUFqWo3QQ9HFYDZmZJCfSFegnRBKKwuttlVAjRG9eNFRX6/i+ltsEAj4heuGqqEx+sw
         eEiTQ5sh5TEiXtHLgBYPffSGwrDn9oF9fUia7H1eqkxCdKx56YraXf8uvRq6okWD6X7S
         DwWg==
X-Forwarded-Encrypted: i=1; AJvYcCXSNriI3sbMCOM3rLD5cyUFkTylLLII9xNK7WNKFuQuR5MZfpc3FuY7vaerNjYtqlwOSNN1Wz86EDrg/Z4LuUlA3vP4kN/Om2mGLA/j
X-Gm-Message-State: AOJu0YzzwX29tb4fFLUz2RTtc18t2R0pWFxPSznDyV2YzW3PQRdwR3bP
	ZHMP9FrH8Y4B9DDFMUdiSDkE2yjBi8wQveP3m07pS2qXeL+h1QVdMQHknyaV3exRZp/BwyCdJ20
	RRg==
X-Google-Smtp-Source: AGHT+IGPHjQo87+r2zhqmR6kCCDNQTsYC+f2ZCJS3JAQtG++EJPcIBJevN+jcis5On9vmS24q4aOrBZ/Y3Y=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:f77:52ef:ebeb:2cec])
 (user=surenb job=sendgmr) by 2002:a05:6902:100a:b0:dc6:ff2b:7e1b with SMTP id
 w10-20020a056902100a00b00dc6ff2b7e1bmr2849789ybt.4.1711438676435; Tue, 26 Mar
 2024 00:37:56 -0700 (PDT)
Date: Tue, 26 Mar 2024 00:37:50 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326073750.726636-1-surenb@google.com>
Subject: [PATCH 1/1] arch/um: fix forward declaration for vmalloc
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: sfr@canb.auug.org.au, kent.overstreet@linux.dev, sj@kernel.org, 
	richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	surenb@google.com, linux-mm@kvack.org, linux-um@lists.infradead.org, 
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_003800_282055_DEFEA435 
X-CRM114-Status: GOOD (  11.06  )
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

Patch [1] replaced vmalloc() function with a new definition but it did
not adjust the forward declaration used in UML architecture. Change it
to act as before.
Note that this prevents the vmalloc() allocations in __wrap_malloc()
from being accounted. If accounting here is critical, we will have
to remove this forward declaration and include vmalloc.h, however
that would pull in more dependencies and would require introducing more
architecture-specific headers, like asm/bug.h, asm/rwonce.h, etc.
This is likely the reason why this forward declaration was introduced
in the first place.

[1] https://lore.kernel.org/all/20240321163705.3067592-31-surenb@google.com/

Fixes: 576477564ede ("mm: vmalloc: enable memory allocation profiling")
Reported-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/um/include/shared/um_malloc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/shared/um_malloc.h b/arch/um/include/shared/um_malloc.h
index 13da93284c2c..bf503658f08e 100644
--- a/arch/um/include/shared/um_malloc.h
+++ b/arch/um/include/shared/um_malloc.h
@@ -11,7 +11,8 @@
 extern void *uml_kmalloc(int size, int flags);
 extern void kfree(const void *ptr);
 
-extern void *vmalloc(unsigned long size);
+extern void *vmalloc_noprof(unsigned long size);
+#define vmalloc(...)		vmalloc_noprof(__VA_ARGS__)
 extern void vfree(void *ptr);
 
 #endif /* __UM_MALLOC_H__ */
-- 
2.44.0.396.g6e790dbe36-goog


