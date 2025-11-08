Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AE5CCFA1E
	for <linux-um@archiver.kernel.org>; Sat,  8 Nov 2025 08:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uu/tPbxU9/ARLStujrsMBWUmhOTcbpkoe1nFm3w3B10=; b=Ql0LYGg5pacQOnXxtV2a76dOhZ
	AgsHJ6yiVGsS5ksw/A/3MP0IJl0QmeVrLFRaZwvvhdjL3/etYipgA5kCaLCFSL62YWYggBI3LDmpw
	4+k9+Y5DNmFohKE4U9fsLILA4wkSZ4UTBjaTXsMgatUqw5RSnKqngJhugAq6U4ba/FW7hbDsxYRVG
	SSBtWpAQ8d0ZRkJoTeZ+untOTsZIf1bTCPlLybUPqQ6xpNb9ATjB5CcIU2uBua37odzzIkJ5VCH4K
	adQx3EZer8THnfkhTvmLoxVpbMbWBzgbolV/PAAClbKGFJHmPK3khvaq2zNJVRn6UW5P+WucUAKGb
	7jWduK+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxp-00000002j6I-1OvN;
	Sat, 08 Nov 2025 08:06:25 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxl-00000002j4B-3Gov
	for linux-um@lists.infradead.org;
	Sat, 08 Nov 2025 08:06:23 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-782e93932ffso1266328b3a.3
        for <linux-um@lists.infradead.org>; Sat, 08 Nov 2025 00:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589181; x=1763193981; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uu/tPbxU9/ARLStujrsMBWUmhOTcbpkoe1nFm3w3B10=;
        b=ejO06VqR/86gMeYCTyUBMfpbE6OyN43krj9tbwXZfdN6crpqeWfh39qWwgmPlpcfb8
         liS5qw6UMTp4tD/IknW1Mb7DJTQf3dA27n82aQO7KOGsTF/N6jftaUOhm3PGST/k4b8a
         Mje082JaD2WnpLIDgjIJveMKN0WrtZWumiTLgWvigTuaN/fTEoGhVNpsyFBKIbvdgeqs
         hAfmial9gX3jBR2GsqqXaKGmYi6+U1+Je7g4wmpAoe/bHN4qiIC1lMpeaeG1gBFo3WFE
         NCvp8D0z7xIxmpPD/XLEPvtYbnX4taBlB/PNlQeZ6x5AJ1GyNs48ItBh9wbSW1LO9fPV
         6q6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589181; x=1763193981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uu/tPbxU9/ARLStujrsMBWUmhOTcbpkoe1nFm3w3B10=;
        b=wiLml90kTFIAdjFB58IN5AlAXoZCNY9RO4bxj7Py9wV8VSlTNf57glw7kQO1uOHXc2
         reHdE5mdoTYuSCmiVZqMl4Wx0f9pgYoAqiTA+t68d0TSX9/XGra8iVcAf888tec2+VrQ
         +5+zV47+UeISp+2VjwRX53vmdbEW6cfFN2Ite7jg6m6q61Q9KgRaxKvOlIwveoeJoKsY
         +0PV3CCHAZ7uwF+VjGOSQlFOzI4r2vtliKZu5MnWF6lst3vxLTTnrrNWLckNdUk7LNqk
         uDc3lw2j5K+F89iSoL29XeEb15MZ4YBLyqluAY1+V3/hulCPTrGyahiPXVLauiS4sQG7
         wQkg==
X-Gm-Message-State: AOJu0Yypy/GCZaEnRhynYoUnFaQkBwcanDYth6eKof0zXfIetalVH3Bh
	23pgtAio8mnj5E9JYLx//uMseHAluRbPxjUFnkkUFUgaWgyX53knuFrdMZ8IKA==
X-Gm-Gg: ASbGnctZon9uqu4QechmNhkxyt3tPNlmwdycSYpAfJut0Weij54nmOVFMEmCo2QekTw
	2IirKZJQW3BgAhHBnBLxCJTNFwtsPp8h352xaRZGM+5gduwMorVO8f1GDJcHupy4m3mbn349nLL
	v3lQ3PaDXuBc3Fck8qFR3KGq9uB7fKZyITLg0rG8rn3SraCl8zvyGsk1jo5y0h81KL4/AHWoAmo
	Fv/a/rFCxLbC10eFid3+Y+w8njbL5kEkHo773tGRX9whZDFCUkSw5+5Gq+TE3p4K58NhfW71oN/
	Q3g6w0giTXzRUL+8MYvrJpFr++SMAwQrK5TBK7+g/84w3yZ6rLm4wPgMF0qGMdncmVc6P25KrVL
	jPk156k+GpNEW+pTId/hLhkkXYS5laUiJ8SQdyzteicwXM430LSRNbII/iGrV0lj/Fi203kkVYZ
	GPcq5oyYEv8p6BU2R1ACCwZJbU2jlq5fFkO9QalNxuszKUyViB56na6N+m
X-Google-Smtp-Source: AGHT+IF7mUz86StpMhyTBEmSmjCP/Jl1AFr+f+bpRD/SCMI1b/IQXHVDAjmvzlL0XUw1PqOX/qeczw==
X-Received: by 2002:a05:6a00:2ea2:b0:7aa:2cc6:8c38 with SMTP id d2e1a72fcca58-7b225acbff2mr3066155b3a.2.1762589181042;
        Sat, 08 Nov 2025 00:06:21 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccc59eb6sm5189098b3a.67.2025.11.08.00.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:06:20 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 3163611388DB; Sat,  8 Nov 2025 17:06:19 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 11/13] um: nommu: disable SMP on nommu UML
Date: Sat,  8 Nov 2025 17:05:46 +0900
Message-ID: <a9d5519fe7696def8c00a1bba7b3c6c832d5dfba.1762588860.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588860.git.thehajime@gmail.com>
References: <cover.1762588860.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251108_000621_836057_841F26CD 
X-CRM114-Status: GOOD (  10.78  )
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


