Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458F9606A320
	for <linux-um@archiver.kernel.org>; Sun, 22 Nov 2026 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yL1/ItIg;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rYecjr5w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:References:In-Reply-To:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NSMLR6o7mSTpUDIhmxU/RxFIM3/A8VrEBsLCPmJ8qJg=; b=yL1/ItIgWy2KZFUAzgOzZmo3kz
	bRuK922yFd07diBGWfnhOwhJAMBypobdT7t1OelW1Uxm7PK7xL94vDmzICI89oSIzCsyBESjo+KSN
	pFVQYlM2cQ8hy/3WUkk74zHM46q5Ch8dYf5GmroOg5SVg3SLZqIxmw6tmb2EWqb0VXBQakxVrGg6I
	qiJUsMIQRqrHyMMKZP0FU8A2BvtcpecatHDd5ibwYcf7MHPC9t5uCHl0Pu7SP62SaGMTq1v6TebGp
	W7klpcD1yrP4PmkeYoHjp7yCU8wcDz75x834SjkWYuVEMe+VzvFBDWZmPZ42vU/zeJk/ckELagcmH
	lSflo3gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV7po-000000019Te-04Pd;
	Sun, 22 Nov 2026 13:42:24 +0000
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xV7pk-000000019TI-11zB
	for linux-um@lists.infradead.org;
	Sun, 22 Nov 2026 13:42:21 +0000
Received: by mail-yx1-xb131.google.com with SMTP id 956f58d0204a3-677bc4704cbso2788095d50.0
        for <linux-um@lists.infradead.org>; Sun, 22 Nov 2026 05:42:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795354939; cv=none;
        d=google.com; s=arc-20260327;
        b=MLVaIWPp4n5cEs/GXdjwfQOfoxVrvsszf4jpDSBGAjvlDF74nOEuCgWE/lhkv+9a7y
         D7pEr5xdXusrHgDhpY/Fu5oWKPTmCQXtUvlGNGPre7IH6z7meAqQr/vISe3yt5Ap8VgV
         S86DeC5DQ53dbJnEJYBhHyWSZZjhyoBK25yq+BUzkqLVWh0wVd9wVF99jw3yr256oOme
         rApPTXa9ZUtrR0461tbSQDpsTwp678Dh1DGycCPY4K7Sq8Vzl/6MraHXIRZDGPkUJO+q
         HKPAOQ/FBVdK5WFuVTxTmEK4V0alnqEW8kVvp1ifZqEZUSnTy/wg7Y+yICO3oeeVjt/v
         3MkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=NSMLR6o7mSTpUDIhmxU/RxFIM3/A8VrEBsLCPmJ8qJg=;
        fh=/gBKL856m721509318RIdz8U4fuFWBADYUOnmaP+UV8=;
        b=EkNaRpQwqGSVbvlyrz4zKEbBbkmiC3JyzoteOqZOdqZYms7utlHe+s67x8KNVM0j55
         lgD6OUYkWaWzbdoE4+07scSKkEJU8kuFHRPEjNxLSnvXGYLrz5PMjTsFZ6bDO7wTpThB
         0LtN0loJDiwf+6WVhUE9J0FwVt6n6iS2oT5DdLBF7cBIqSAF+ZQgtau8g0GSLEDVx5oK
         ZPGAv6UjYUhknYCVcHplQbnLE5wNknsqJ1sNW3bysON/RQoPgdhtrCsfaZ3LLwmmeiA/
         NKhc6ly4EgzHyx8Tn3uTmfu8Uv36mBk10369MHYiYUpKlPfkLvU9s9/DJz4JW7eCqoS2
         xk/Q==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795354939; x=1795959739; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NSMLR6o7mSTpUDIhmxU/RxFIM3/A8VrEBsLCPmJ8qJg=;
        b=rYecjr5w4XY37Nlosq705kxGUWVmNd7ppmJZQTpmMNuR6J9eVUK+KBjJCAYPZ2cmI/
         pJlrRvv6RW3XuhyxkSYQ1JHg4ErI4rz213fU0CFkxkaUjoynrPqwJYfrlwgYHDfv72c7
         ws0Miu7CGSUeSKZnDngDtuaFFkr5Dnj3pSyuSaOQvVMRJGoyPYnp/W8gUY2maLzkHDXG
         M0Bg2eXoZyYyWYtbooMbCJWW+LWHa2EWih/5vAR2fLEOhHHUs8WpuKWp1agvNezN+Hb5
         hvWufak8vkq+59Z2FQkEBDZZ5M1rk7LYVLpgkkdr9sx4YBF73y/h3tjnb1k/vQP/3TA5
         PjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795354939; x=1795959739;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NSMLR6o7mSTpUDIhmxU/RxFIM3/A8VrEBsLCPmJ8qJg=;
        b=yl/ACE8Dg3lAON52BDdZAg5MztBAvsxRp556oPc6HHNNisdDragYUpNoTRBM8E27Vw
         gtL2EPeYXK0s3tEoxWy/vo0yA06Rtm1ndTc7vDVALpvl2ATAdN6S26WNZQXiES15zVwI
         yATWp7arJfc8GknKo13u3PzxS4NaekR3WzrW1z6LImaSg1dDG9g0EyhCzb9CbfiZ4/uD
         wcQfZ2181F7ClAnQngwKfIHbYXpr+6CcL9ZTtQWO0Sxqjb5m9bD/HTux5mB0eNuinxb3
         dRbzfEjaoyoauu5EQxKiLEpfQhJtliGkC62/IzxD1T+3PuEZtdCFwXUFzBauvwKVNeVi
         XKsQ==
X-Gm-Message-State: APuU4Z8Z+BQLsE00R6MlkMOVHkvaCMqFowbBtJ78WCBwMvc1Pi2/QAZt
	3gU2aoAQAUmn6sZP2qm+fBZS/59zPazN30yu4q4wDUuLaF7CuL63Mo17IcUQFABoPZsZxANEZC7
	yTvV/qBbczPXzq9P6jjQzCmb6wAP8mrzHrAeMB/s=
X-Gm-Gg: AZFdTZe1iQmcVnp8slci0NGId9XdT0VhRagLcJjtPVufv0CeXrBRT8sj7XywpMJFkFd
	EMu+rmfNGkQLRbnYDkJ+g0nm8VicgFXqtSyUGNuMdEBwr7ffmf3McbT22ErqDiZCSTyb1Fvodai
	HCI1JdsEFmMXDFs6XrGpVKlcq4D9xrh+nedTEuNyG4XraZ/0G7wKcOzS+8GxQdkkZr5ojazoSx/
	l7lOMd7e6wHUUd6To8KewvKjUCLcnt7LEoD1alHrUBBbzMZ3sWk2LAQPBV+Aw5l6Fs1kGWCKo7x
	p+La8CKAnvk48yprdbVl8WiLpe2Ot1mSWIB/YGd7te4/p7ef9aVLmQYLPTDrbgIC6XtX/rBOCne
	xEkDPEHPdE0U6mZ6kxVwLb5rDLdLreFoQaxI=
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:690e:1449:b0:67d:b6db:e65e with SMTP id
 956f58d0204a3-67df43f32f5mr2994442d50.44.1795354938890; Sun, 22 Nov 2026
 05:42:18 -0800 (PST)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 22 Nov 2026 13:42:17 +0000
In-Reply-To: <CAB2K5aBaXG7Jhi+0UyVfpGan+5XXch5zOg3tM3=kqnO1+8F=fA@mail.gmail.com>
References: <CAB2K5aBaXG7Jhi+0UyVfpGan+5XXch5zOg3tM3=kqnO1+8F=fA@mail.gmail.com>
From: Haikal Firmansyah <haikalfirmansyh.kernel@gmail.com>
Date: Sun, 22 Nov 2026 13:42:17 +0000
X-Gm-Features: Aa3M54qAA-HlQzgE998uYFVLibnyThcCZCFr_50Hc8gXcKYinsvpXQ_miDqh8r8
Message-ID: <CAB2K5aDppuZ-ASWFm8ShTNChoWjtVqFt9sNbv+L-wY4jPRVDBA@mail.gmail.com>
Subject: [PATCH 2/5] um: Kconfig: select generic vDSO options for UML (MMU only)
To: linux-um@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261122_054220_592642_40F6A770 
X-CRM114-Status: UNSURE (   6.24  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Select GENERIC_GETTIMEOFDAY and GENERIC_VDSO_OVERFLOW_PROTECT
so UML can use the generic vDSO framework (lib/vdso) instead of
its hand-written syscall-shim vDSO. This is the Kconfig half of
the generic-vDSO conversion; the code half follows in the next
patches.

The selects are gated on MMU: GENERIC_GETTIMEOFDAY pulls in
VDSO_DATASTORE and TIME_NS_VDSO, whose code calls MMU-only
functions (_install_special_mapping, vma_is_special_mapping,
zap_vma_range) and therefore breaks the NOMMU build at link time.
NOMMU UML keeps the old shim vDSO (um_vdso.c), which needs none of
this. This follows the existing pattern in arch/riscv/Kconfig,
which selects GENERIC_GETTIMEOFDAY only "if MMU && 64BIT".

Signed-off-by: Haikal Firmansyah <haikalfirmansyh.kernel@gmail.com>
---
 arch/um/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 7245e3ada..faf4b197c 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -33,6 +33,8 @@ config UML
 	select GENERIC_IRQ_SHOW
 	select GENERIC_CPU_DEVICES
 	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_GETTIMEOFDAY if MMU
+	select GENERIC_VDSO_OVERFLOW_PROTECT if MMU
 	select HAVE_GCC_PLUGINS
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
-- 
2.43.0

