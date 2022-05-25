Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntqSt-00B9PN-LT
	for linux-um@lists.infradead.org; Wed, 25 May 2022 12:50:17 +0000
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E4FD93F367
	for <linux-um@lists.infradead.org>; Wed, 25 May 2022 12:50:08 +0000 (UTC)
Received: by mail-ed1-f72.google.com with SMTP id v1-20020a056402348100b0042b4442b954so8542734edc.22
        for <linux-um@lists.infradead.org>; Wed, 25 May 2022 05:50:08 -0700 (PDT)
From: Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 1/2] um: Kconfig: Fix indentation
Date: Wed, 25 May 2022 14:50:00 +0200
Message-Id: <20220525125001.47009-2-juerg.haefliger@canonical.com>
In-Reply-To: <20220525125001.47009-1-juerg.haefliger@canonical.com>
References: <20220525125001.47009-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Juerg Haefliger <juerg.haefliger@canonical.com>

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 arch/um/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 4d398b80aea8..12fe6a08dc35 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -81,7 +81,7 @@ config ARCH_HAS_CACHE_LINE_SIZE
 source "arch/$(HEADER_ARCH)/um/Kconfig"
 
 config MAY_HAVE_RUNTIME_DEPS
-        bool
+	bool
 
 config STATIC_LINK
 	bool "Force a static link"
-- 
2.32.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

