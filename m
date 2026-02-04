Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B7BE8B38A
	for <linux-um@archiver.kernel.org>; Wed,  4 Feb 2026 02:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uu/tPbxU9/ARLStujrsMBWUmhOTcbpkoe1nFm3w3B10=; b=U7QSp/VNvnlkLiDb4M6Cm+Oi/b
	l3fcKMfdAqwOP70WCU1moAfyV3rRWiWmEiknXN98zr3pPYFQyCdO3LMKYz01v71t4f5TwMn97JLIv
	rP2AlD8abqV/jdWUXc+Cp8RhtkK9q1Mo5n6VWqSuizjfPq5ERox2p6w0iBO8yDjWCBXWcAZkhBtCO
	OJUt02twk9bc05Tyl4yqjPb7uX4qs0fPfATH/2oSusL3Fm5yK8FjraXPZg/np6JXK/LQGg++K1uQp
	wmzdcaFJ7tQKZ/OTo78yDN5dtrrGQWyvHkx352hnh36MQSQv8k2ZfzspYscq4lEh1L8/Gcph1ApVE
	nyEciwrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnSdG-00000007mJo-1zPt;
	Wed, 04 Feb 2026 02:28:42 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnSd9-00000007mDg-3ewY
	for linux-um@lists.infradead.org;
	Wed, 04 Feb 2026 02:28:40 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-82318b640beso3543848b3a.0
        for <linux-um@lists.infradead.org>; Tue, 03 Feb 2026 18:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770172115; x=1770776915; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uu/tPbxU9/ARLStujrsMBWUmhOTcbpkoe1nFm3w3B10=;
        b=F3xjQu7jt4Nn+uF8pUqww01oC9wFjWI1P/lNa7D8REdmiV8ti7KSr6r2F9RVwFE2Is
         RjxMkErOZIErzFc0al2LxmBsRzPYWVIiJSPixt+tOOASe+er5i7zA+Thp7pWpaDufiSR
         xWtDFSHvOUJ9JtOsWFvu3ZjuGTBaX3b5RmuDLcP/LHM906WtR/EjMb1/xNvfCb+XwkIP
         c4uNPHPwgNgchB3qCZuUMb7onGXao+bG5XJSiHqNbrTwzw3qKUkbvucvzDncPoRrYzis
         qQY2z8CaqW4juPG2EA984V9Ll10x5sBbpOQSPve5xz6AzN360HknS7FC8XBefiNWQT+m
         fElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770172115; x=1770776915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uu/tPbxU9/ARLStujrsMBWUmhOTcbpkoe1nFm3w3B10=;
        b=N6H2AUjj9ciwlfFFpR4pKfCjFIXnu4yBG4XCOuDetDlDzJlapHsos7dprL/elkeprF
         1ZuTCI6lXnEbBKDsINukH9yRvFe5lXrz9+LTMnTWlxfN3HmfloP1YRGAu6oqM4WDQ6kj
         tBNJb2W2Mbc5OyUuYkHfVbDX1OqZ8nImk6D7EaVkkj4C3ZRzEsoXOKWI7zJdVtdmGZ/c
         iA6l+imBrH/YZFe0zQW55aPktB/TX2M33p6qn99iXIVRx54mCoj0gFj84eGRMaJNZlM8
         qfdemvDfPYFDLLp6qrun3enUCPgoLXOw55b8kZXcUam4RxAjC1ew2jy3ySYTW1vsDrVl
         0lCg==
X-Gm-Message-State: AOJu0YyMv7Hj2OFF1Eg4wUriLjPXLycGo77f1TW5phSXFHMWi4a7Oywo
	poMbosZ/5C5loWgyM4Q+RDkAziI9u4j+PMi38qWXftBv+Bhpy1y8+KlH
X-Gm-Gg: AZuq6aJfykaUHDERRALW0f7dfqEZ2hVXAygNvEzkvbsYWWilFPacEqTDhzeID4U1Ggt
	1wVDOYvQoNsCUKBip9axjhvf3FbkF+kHgE3CekmIS3l8dIGc6jTcmI5LqlO2gTOb/Fp+uXufnoh
	TyuudrTLF0nRUDABrJ4NToGZm/c3l2Ym9pWZpoD7Z8+vPmrfMTpJ6Exn8m65QvHXiUffrEaaWjV
	mNPsmXpOS41y2C+HQcEV8HOPQX8G76wq6sNOAqDKM4ZG59d4JWxzO/Ja5A/ZQ+nWoCBAMCyzV3D
	HwSGqMw2xExENjOmxsStWgVfVnuYZsLAx5ZpEEyLw2FYYS+Jhle5IwZkI+tVnOuXp8MxtkL1QVl
	2En5T8Is7T8bf3fLJ4WKHv/zqqLaErHoBDjGOKU2OaAwGCVgAh0OuIjlFZAtEHSaVG+Y49It9Hs
	hnRPYC7loRvgsdeDjdReYdYfJCImUyJ51VzaEniX/K5SLIzRLk2ytHRbJk1cWqb0x6Kijm+Y0Gj
	e92kaOK8PhZph+e
X-Received: by 2002:a05:6a21:2d43:b0:342:d58b:561c with SMTP id adf61e73a8af0-393721081a1mr1490301637.27.1770172114792;
        Tue, 03 Feb 2026 18:28:34 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354860be66esm848846a91.2.2026.02.03.18.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 18:28:33 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 523EE1200C45; Wed,  4 Feb 2026 11:28:32 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v14 11/13] um: nommu: disable SMP on nommu UML
Date: Wed,  4 Feb 2026 11:28:09 +0900
Message-ID: <3b9e3e4b85c9bdbc4e1fdd123c8270652a88e1e9.1770170302.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770170302.git.thehajime@gmail.com>
References: <cover.1770170302.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_182835_915889_24A1C9A5 
X-CRM114-Status: GOOD (  11.37  )
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

CONFIG_SMP doesn't work with nommu UML since fs register handling of
host does conflict with thread local storage (more specifically,
the variable signals_enabled).

Thus this commit disables the CONFIG option and the TLS variables.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/os-Linux/internal.h | 8 ++++++++
 arch/x86/um/Kconfig         | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/um/os-Linux/internal.h b/arch/um/os-Linux/internal.h
index bac9fcc8c14c..25cb5cc931c1 100644
--- a/arch/um/os-Linux/internal.h
+++ b/arch/um/os-Linux/internal.h
@@ -6,6 +6,14 @@
 #include <stub-data.h>
 #include <signal.h>
 
+/* NOMMU doesn't work with thread-local storage used in CONFIG_SMP,
+ * due to the dependency on host_fs variable switch upon user/kernel
+ * context so, disable TLS until NOMMU supports SMP.
+ */
+#ifndef CONFIG_MMU
+#define __thread
+#endif
+
 /*
  * elf_aux.c
  */
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index bdd7c8e39b01..f12e2e4e0a12 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -12,7 +12,7 @@ config UML_X86
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select DCACHE_WORD_ACCESS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
-	select UML_SUBARCH_SUPPORTS_SMP if X86_CX8
+	select UML_SUBARCH_SUPPORTS_SMP if X86_CX8 && MMU
 
 config 64BIT
 	bool "64-bit kernel" if "$(SUBARCH)" = "x86"
-- 
2.43.0


