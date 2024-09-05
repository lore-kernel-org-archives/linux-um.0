Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97408CD4F51
	for <linux-um@archiver.kernel.org>; Thu,  5 Sep 2024 04:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GJxcrlRpA7xjaDp1f7t4aVNh8eR9s342zQrnnOBKUEg=; b=uHtb+R4WTFlzroRktTjiHH8m1D
	gZBUJbj0g9osaVEnsOfJRAmpOhsmkK4fWnBjyBVqh8UKsxg1C9CtLGF938tWpNF95yrPiOi6QEa9/
	bZrXaSmMrzC1uCSaT3TVNv9tFyU1oOrhAJrVhxDW4IhHm6Y7Pn9tkxCjBPiDDMybO8FHXuCOHRZao
	MVpb8fjI3TGhFCCASPjVrRaUWeYQ/DdgT0r5Vuqk6Rq/3jmHYGZScG7rRjV/GcAFxk0HJt5OGvHq1
	A/H+BCokxGEQtxIGayAvxCBT4yJm690rVCmQH/3tulzFqGFM4toBGM86E6m6V8zIs3hMZaS5IDJ/v
	J5Kkb0iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm4LC-00000006yKw-13aI;
	Thu, 05 Sep 2024 04:43:30 +0000
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm4Cg-00000006wpT-3LUJ
	for linux-um@lists.infradead.org;
	Thu, 05 Sep 2024 04:34:44 +0000
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-457cfc2106aso2155971cf.2
        for <linux-um@lists.infradead.org>; Wed, 04 Sep 2024 21:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20230601.gappssmtp.com; s=20230601; t=1725510881; x=1726115681; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJxcrlRpA7xjaDp1f7t4aVNh8eR9s342zQrnnOBKUEg=;
        b=ZkkyxZRH633u6a8IUhkWGLC5QQR93iI97xGeEI6JKdr+awsKWqzcOR1iVDbKhrIr+S
         N+20P2W9b+/ye/Puq7HkQAsKAbIxu/9pel55gBFWmxjq3MkD1wPl/LVfYXEnLcj1mPZd
         O2O7Jjcans0fjxtnlK8yxwPGt/TJeO/VwHgdGOxFzgAjQk2efv7gIE1E19bG1yItjK1q
         7G661lxsVtC2pP/yYzd5ZQ/jxbakQgV1BCn+JwdfoIyrNtpHiH75b9bFXkwQRPivUh5O
         Y4B1NKaYqa2viBSrwgdvfwXz4fwlSCb7tcsZpaZD8PtHSpxSrmMsjRNCKFjGrOffdROw
         RMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725510881; x=1726115681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJxcrlRpA7xjaDp1f7t4aVNh8eR9s342zQrnnOBKUEg=;
        b=pxQUiioBUe7TQGPXAugsvkZkm5LmFQANbQ91WIUSWLMFrKPdIN95tDqM1gqZVJBRvE
         Ufn7/tqMaVHBzYHnfPv0sxg6PRg68qEY7Ln+u/CAqhMeM0GahV4/RzlMeBktdZKDms29
         +jPX7LOWhSKWsPbrXZHLHS7zhE1fMVM7ziXwi2ymk1G18QeMA9MMA9DadWDEtilZZGZ3
         ehhLFodcMCviTDJ9RJXaMHYgqlKi06LIMXKLiihfVQoAFbSvmOrHwgQwKGUMA3FmYv+y
         BaayXAjlJQJolB8YxxFkXmpMQ/7EYzpjMV3C8rwsRHHGtFHtwKoBOr9ODtERqr1RUNoT
         tjRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHBY2v3hkdfSnaYHUcAP1ktHslGzdqokOIhjiKIS6A117D6s7n5RACgqDpBbhQkTzQntyofPfPTg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzfn0BcxA3nWhiSLJwPFmoau7K7DWSOgHMRA/ncLEOaxv+QYFSC
	91x2TBnoS0LBT0VzRr/HUM7p2Zbz0NLTphP6nH3OFXcxUlrOttimIk5oKqaGYw==
X-Google-Smtp-Source: AGHT+IFj3a9cchP0/vieZqbkqznpCBKGRkfgZYOb8Jn2LlQ3lfAJzRpY8vMS81DOZGJeiUwzkUU8QQ==
X-Received: by 2002:a05:622a:993:b0:456:847d:47a5 with SMTP id d75a77b69052e-456fd7da328mr225326911cf.38.1725510881546;
        Wed, 04 Sep 2024 21:34:41 -0700 (PDT)
Received: from node0.kernel3.linux-mcdc-pg0.utah.cloudlab.us ([128.110.218.246])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b4cf4csm4182341cf.48.2024.09.04.21.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:34:41 -0700 (PDT)
From: Wentao Zhang <wentaoz5@illinois.edu>
To: wentaoz5@illinois.edu
Cc: Matt.Kelly2@boeing.com,
	akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com,
	anton.ivanov@cambridgegreys.com,
	ardb@kernel.org,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	chuck.wolber@boeing.com,
	dave.hansen@linux.intel.com,
	dvyukov@google.com,
	hpa@zytor.com,
	jinghao7@illinois.edu,
	johannes@sipsolutions.net,
	jpoimboe@kernel.org,
	justinstitt@google.com,
	kees@kernel.org,
	kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	llvm@lists.linux.dev,
	luto@kernel.org,
	marinov@illinois.edu,
	masahiroy@kernel.org,
	maskray@google.com,
	mathieu.desnoyers@efficios.com,
	matthew.l.weber3@boeing.com,
	mhiramat@kernel.org,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	oberpar@linux.ibm.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	richard@nod.at,
	rostedt@goodmis.org,
	samitolvanen@google.com,
	samuel.sarkisian@boeing.com,
	steven.h.vanderleest@boeing.com,
	tglx@linutronix.de,
	tingxur@illinois.edu,
	tyxu@illinois.edu,
	x86@kernel.org
Subject: [PATCH v2 3/4] x86: disable llvm-cov instrumentation
Date: Wed,  4 Sep 2024 23:32:44 -0500
Message-ID: <20240905043245.1389509-4-wentaoz5@illinois.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240905043245.1389509-1-wentaoz5@illinois.edu>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
 <20240905043245.1389509-1-wentaoz5@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_213442_862631_73DB4C88 
X-CRM114-Status: UNSURE (   8.15  )
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

Disable instrumentation for arch/x86/crypto/curve25519-x86_64.c. Otherwise
compilation would fail with "error: inline assembly requires more registers
than available".

Similar behavior was reported with gcov as well. See c390c452ebeb ("crypto:
x86/curve25519 - disable gcov").

Signed-off-by: Wentao Zhang <wentaoz5@illinois.edu>
Reviewed-by: Chuck Wolber <chuck.wolber@boeing.com>
Tested-by: Chuck Wolber <chuck.wolber@boeing.com>
---
 arch/x86/crypto/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index 53b4a2778..57f3d4921 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -119,5 +119,6 @@ quiet_cmd_perlasm = PERLASM $@
 $(obj)/%.S: $(src)/%.pl FORCE
 	$(call if_changed,perlasm)
 
-# Disable GCOV in odd or sensitive code
+# Disable GCOV and llvm-cov in odd or sensitive code
 GCOV_PROFILE_curve25519-x86_64.o := n
+LLVM_COV_PROFILE_curve25519-x86_64.o := n
-- 
2.45.2


