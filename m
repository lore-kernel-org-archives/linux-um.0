Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8668ECFD312
	for <linux-um@archiver.kernel.org>; Fri, 11 Oct 2024 09:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OOVgHJWb8aIu8nsLafcNeHRtNCU+jcBKUUidMTXtnX8=; b=M6h/A0Ple/4uhBG/iXOuMFyKQS
	qxC95o9IyB2UQv/3G8oniMMTJ9us2JDZPZHYvN35DBaL5H2c5YxbDZyz3O3Hlx3BdGOqzBNv9SKed
	jqCMPUY4Ok7s1uqsWWcxNDxQ3/UCPZ3/ITXiauuaghrd28Y2lHNd0e0PoWWtcGZW+hwucYQvE+nwC
	aFs8D46h6hIa2tJP61jaroJDQbg7yDXPKQXHbyTjziEKjFScSQQvnWBZvXmwH/fJYxor8A9Oozfr8
	KTDJ3iip+awiKd2rFmtYWRArgakRsMex5EXWPJimkTiow88DKzxjFvxgOfirSwrUzxJjKRB6Wq5cg
	wddrYluw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szBoB-0000000FoBZ-0QCx;
	Fri, 11 Oct 2024 09:19:39 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szBnU-0000000Fnuu-3ZTU
	for linux-um@lists.infradead.org;
	Fri, 11 Oct 2024 09:19:06 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728638333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OOVgHJWb8aIu8nsLafcNeHRtNCU+jcBKUUidMTXtnX8=;
	b=qV61jMqt1rbSXMy8nrB0deuV3ixLNQ6r/kkW0phr5qiZK6cbPaWQBEMZKFud1Cj14vYfjc
	09x41BGu3YfYG+03oiHkiqy1pTRWD8Vt8J6iybrqFIekk9UcyQXOTmRk1nggMQ/242E98+
	dK1RYGdBRW+xUrrqb7bNXm8mFf1tM5d3xEneXgCbe/L/ZYwuAo0W8AxfuDSKq9k0A80kuK
	eIYEPFU6RYkabtLAesczh3oA7YF8xDYlRr8nz2ZtfoTIyKq0fsLKNY1GdT7VyvuIV2hUM6
	4sLiofZkT+8pIiLK+Y1CwvBaWL5R9nyBQkbaCd0jYtRGcA+ZtlNTHwAEX2N4Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728638333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OOVgHJWb8aIu8nsLafcNeHRtNCU+jcBKUUidMTXtnX8=;
	b=AH/LVh1sjzAFjZVwPqws2qdH0dvDy2IDOxCiGMLgJDjAQdYO9m1sHYu/NTnx0yP9Wb9lnz
	5aaCW1OlFDgukBAg==
Date: Fri, 11 Oct 2024 11:18:26 +0200
Subject: [PATCH 2/3] um: vdso: Always reject undefined references in during
 linking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241011-vdso-checkundef-v1-2-1a46e0352d20@linutronix.de>
References: <20241011-vdso-checkundef-v1-0-1a46e0352d20@linutronix.de>
In-Reply-To: <20241011-vdso-checkundef-v1-0-1a46e0352d20@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
 sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728638330; l=1685;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=4nsH7iUaC1vNnWJLnteSYFDSKO+10nuui0NbMwzEzIs=;
 b=mRjvoxyz1Kbnltp6CHWtfEnNKzNvxFmhTwBwSDK6FK+FYQokpv6ZbWdD75ppr6tcxEJ9TIPc8
 KYz8CU9O2sGCdeBgVQdjMKxdtyI2OyOIfg4niB1NRuUzk9EG00M7NWF
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_021857_109481_F0D22A08 
X-CRM114-Status: UNSURE (   8.34  )
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

Instead of using a custom script to detect and fail on undefined
references, use --no-undefined for all VDSO linker invocations.

Drop the now unused checkundef.sh script.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/x86/um/vdso/Makefile      |  5 ++---
 arch/x86/um/vdso/checkundef.sh | 11 -----------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 6a77ea6434ffde178d07b4466ec18ca83718baae..7478d11dacb713384655ed76af3b469aeb5bae81 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -56,7 +56,6 @@ CFLAGS_REMOVE_um_vdso.o = -pg -fprofile-arcs -ftest-coverage
 quiet_cmd_vdso = VDSO    $@
       cmd_vdso = $(CC) -nostdlib -o $@ \
 		       $(CC_FLAGS_LTO) $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
-		       -Wl,-T,$(filter %.lds,$^) $(filter %.o,$^) && \
-		 sh $(src)/checkundef.sh '$(NM)' '$@'
+		       -Wl,-T,$(filter %.lds,$^) $(filter %.o,$^)
 
-VDSO_LDFLAGS = -fPIC -shared -Wl,--hash-style=sysv -z noexecstack
+VDSO_LDFLAGS = -fPIC -shared -Wl,--hash-style=sysv -z noexecstack -Wl,--no-undefined
diff --git a/arch/x86/um/vdso/checkundef.sh b/arch/x86/um/vdso/checkundef.sh
deleted file mode 100644
index 8e3ea6bb956fc8fead5e280bf82a52287d1328a4..0000000000000000000000000000000000000000
--- a/arch/x86/um/vdso/checkundef.sh
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-nm="$1"
-file="$2"
-$nm "$file" | grep '^ *U' > /dev/null 2>&1
-if [ $? -eq 1 ]; then
-    exit 0
-else
-    echo "$file: undefined symbols found" >&2
-    exit 1
-fi

-- 
2.47.0


