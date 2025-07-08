Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086CFC83F10
	for <linux-um@archiver.kernel.org>; Tue,  8 Jul 2025 09:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fQRA7fOKKcoE8Wg6bFhC04E8YAfABDlnJrRBKBQ5SZA=; b=CRItvLgNCPkddx+0bH4ZYbjdgK
	5iPDacyF/9IT7kxpw9aFIeQYQV22SgsDtsAeZd4cPLxAmxMRZWJOJ5kG7oBmtk+wCua/U1EvcIC7E
	wHs75yGQtv3hoh0PpraKDOfzdXYcrbqZm8gTOsmeDRe4+1FsGmjb+gI7v6mi13sJJsXNczis0O//L
	sG02y9hF204tkRqNJ3ZIBh7HyE1N/ICmPvJSGHUmeBY1GnTBiFLPRF3I1AlYcwg8Sx1uxEixy4j5N
	3W/a9YKdewPYhybodjcKzTjoh5qrsH43dxOYB7pC94DKxaZ4VCoPJI+ZbaNKXQ4SZ9wXsSXBCBbd1
	mMm4BkfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ4v4-00000004vXE-2q3N;
	Tue, 08 Jul 2025 09:47:22 +0000
Received: from out-182.mta1.migadu.com ([95.215.58.182])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ4Fh-00000004qMr-3P6g
	for linux-um@lists.infradead.org;
	Tue, 08 Jul 2025 09:04:39 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751965475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fQRA7fOKKcoE8Wg6bFhC04E8YAfABDlnJrRBKBQ5SZA=;
	b=A1rNJmc0B90/H1YEftOq+YJY0D4hOxzJM10heK5CKQL0O8KSK3XyVY999yKngDMGb9o8uv
	qcDa2rYcBtfUWYYhA7/SqkTFpCOZ4mx6tBYDwvf3lc1iQ2HxA1y/1Q2cIEEScKbNnuXFX1
	1vcSknezddgn9oBkZOr5WVZpazszObY=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 3/4] um: Avoid redefining ARCH_HAS_CACHE_LINE_SIZE
Date: Tue,  8 Jul 2025 17:04:02 +0800
Message-Id: <20250708090403.1067440-4-tiwei.bie@linux.dev>
In-Reply-To: <20250708090403.1067440-1-tiwei.bie@linux.dev>
References: <20250708090403.1067440-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_020437_993516_4657901E 
X-CRM114-Status: UNSURE (   6.60  )
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

From: Tiwei Bie <tiwei.btw@antgroup.com>

There is a generic ARCH_HAS_CACHE_LINE_SIZE option introduced by
commit c2280be81de4 ("mm: generalize ARCH_HAS_CACHE_LINE_SIZE")
in mm/Kconfig. Select that instead.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index c2d2d2d99bbe..9083bfdb7735 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -6,6 +6,7 @@ config UML
 	bool
 	default y
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
+	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
@@ -83,9 +84,6 @@ config NR_CPUS
 	range 1 1
 	default 1
 
-config ARCH_HAS_CACHE_LINE_SIZE
-	def_bool y
-
 source "arch/$(HEADER_ARCH)/um/Kconfig"
 
 config MAY_HAVE_RUNTIME_DEPS
-- 
2.34.1


