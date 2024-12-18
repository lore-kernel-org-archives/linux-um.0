Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1D7E77187
	for <linux-um@archiver.kernel.org>; Wed, 18 Dec 2024 11:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LBITfqfai7J37XOUwox6hatMirnCfP5i+juTnBH9htY=; b=CRF2HDBTnsqO6qG8a+bSmDJZyw
	Gf8U9tH6nPdKdLQtHu2+At8TuCWLUh52PTYsQLVj8p2g2WzTDZVpvGv39C37kHngcImWhVD3yx55k
	kEcXAUM8I/08TNrCp/8iz9LWFjMx5iSTkxgILP6o1p4B0lDh2nKITzAvXiQs4kP7hfVLSyNH2+A/Z
	VG1fonimq6BV1k74cV1w9uERfBxsAbPl/t6LpunTM6fgj1G/frk2VU5t7gS52XLTEiB3gAhTi2LCL
	8OUucllIuZ+0StXmFf5vKQMTYzByJES8Vh+2xYazkMDNYVwwa4guHVZFe7Y8AFEc7vY3iYogK5lW7
	9DzVbpHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNsbX-0000000GW2o-2nSr;
	Wed, 18 Dec 2024 11:52:39 +0000
Received: from smtp-bc0f.mail.infomaniak.ch ([45.157.188.15])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNsac-0000000GVqS-2vhm
	for linux-um@lists.infradead.org;
	Wed, 18 Dec 2024 11:51:44 +0000
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YCsTl5N3Fz5DQ;
	Wed, 18 Dec 2024 12:51:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1734522699;
	bh=LBITfqfai7J37XOUwox6hatMirnCfP5i+juTnBH9htY=;
	h=From:To:Cc:Subject:Date:From;
	b=zRbHESjNAMyorCyUxpToqsVkVTb9pimoRoGs0s3pDSN3/nzFAbd0LCV7OY6Mgsy1j
	 MVgvoWuJkO/M2vdvInk+sls7zzXfr49hylKMF/DljnGCFh6rraGLCeG8RiuFdF565M
	 RZfQf7x3Ny5Ex2EhNSuKRVgUNkIqmxAj3LPC7PY8=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YCsTk3xmFzCGS;
	Wed, 18 Dec 2024 12:51:38 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: linux-kbuild@vger.kernel.org,
	linux-um@lists.infradead.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH v1] kbuild: Allow building of samples with UML
Date: Wed, 18 Dec 2024 12:51:23 +0100
Message-ID: <20241218115126.264342-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241218_035142_871368_71F4B5A8 
X-CRM114-Status: UNSURE (   7.83  )
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

It's useful to build samples/* with UML and the only blocker is the
artificial incompatibility with CONFIG_HEADERS_INSTALL.

Allow the headers_install target with ARCH=um, which then allow building
samples (and tests using them) with UML too:

  printf 'CONFIG_SAMPLES=y\nCONFIG_HEADERS_INSTALL=y\nCONFIG_SAMPLE_LANDLOCK=y\n' >.config
  make ARCH=um olddefconfig headers_install
  make ARCH=um samples/landlock/

Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Richard Weinberger <richard@nod.at>
Fixes: 1b620d539ccc ("kbuild: disable header exports for UML in a straightforward way")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 Makefile          | 1 -
 lib/Kconfig.debug | 1 -
 2 files changed, 2 deletions(-)

diff --git a/Makefile b/Makefile
index e5b8a8832c0c..6e2cce16a2a3 100644
--- a/Makefile
+++ b/Makefile
@@ -1355,7 +1355,6 @@ hdr-inst := -f $(srctree)/scripts/Makefile.headersinst obj
 
 PHONY += headers
 headers: $(version_h) scripts_unifdef uapi-asm-generic archheaders archscripts
-	$(if $(filter um, $(SRCARCH)), $(error Headers not exportable for UML))
 	$(Q)$(MAKE) $(hdr-inst)=include/uapi
 	$(Q)$(MAKE) $(hdr-inst)=arch/$(SRCARCH)/include/uapi
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f3d723705879..fac1208f48e4 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -473,7 +473,6 @@ config READABLE_ASM
 
 config HEADERS_INSTALL
 	bool "Install uapi headers to usr/include"
-	depends on !UML
 	help
 	  This option will install uapi headers (headers exported to user-space)
 	  into the usr/include directory for use during the kernel build.
-- 
2.47.1


