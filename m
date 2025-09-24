Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67564CAC5A5
	for <linux-um@archiver.kernel.org>; Wed, 24 Sep 2025 14:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UVHwzh9sHs6Xo02VEWpZXjxZy4cbskfDXgmFGFBhsbs=; b=BfR3rkTlmm4tKMBethmrpySM4R
	jquz0yUXidLpEUC3SB3hw0J7cPSkeVh6RW/+Kw2cuZZafI0l0s0yqYxY+ytLyByuByNzKsi/F3smm
	Aimx56wQ8byqbF068Lup9egRD1/7rE6Mt41mxZs2RNEs7V6foZl0anadY0xB2ZEScdD1THytwM9oX
	cd/a6MeqoDiXhPxy0k3eTVpfeQx7zNGbdL8rt5O9wkZNqwF2mCrxNRcxoehaIvPdfjTC9MHXMQpt6
	LirhqiWHfN4w8ald/9721OCuLAOJ2k9mitJiOPGKmixStJjFjNJ2aRLgo2EFAFubbavU+yHyXaHc8
	w2j4Hvtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1QNi-00000000b3r-0g3V;
	Wed, 24 Sep 2025 14:22:06 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1QNf-00000000ayO-2sZ2
	for linux-um@lists.infradead.org;
	Wed, 24 Sep 2025 14:22:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UVHwzh9sHs6Xo02VEWpZXjxZy4cbskfDXgmFGFBhsbs=;
	t=1758723723; x=1759933323; b=mrh4tmy7F7sSzMUbq+JgGMWW8LXaEwFPj97HEudfh7zi50v
	1LOFMoRoUm1r/iRyPn4gus+x48+vlF1qVXoC2NLZRf0Qr1PflODS96gCV9PEjtLNqpfaE9JpcORS8
	+cXRe465X9zhEUKpQE3NKQum7ysMrjP2i7ibd2kk46AKEqFChxi28mkWN1yDg9HX4tGLNV3HQbi9e
	EYr4Eh05JIuR143MxEQfUMDsGjKsCRYsbJHJ8X4V4XNh5x5hghhhG9qSs7sKKvJpwSM9hVpmZv/SD
	AfkVOqBg7HpLSOAKoVjk6DBlMaTEnp7nMj+znqjAKGqQ9vvXg+Cm7hFuWTsFPPhQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v1QNa-000000090Bz-44BP;
	Wed, 24 Sep 2025 16:21:59 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 09/12] um: use nolibc for the --showconfig implementation
Date: Wed, 24 Sep 2025 16:20:56 +0200
Message-ID: <20250924142059.527768-10-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924142059.527768-1-benjamin@sipsolutions.net>
References: <20250924142059.527768-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_072203_722708_B584978E 
X-CRM114-Status: UNSURE (   9.95  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

This is one of the simplest files and it can be switched over to use
nolibc without any modifications.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index b8f4e9281599..4b206a40b611 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -26,7 +26,7 @@ obj-$(CONFIG_OF) += dtb.o
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
 
-USER_OBJS := config.o
+NOLIBC_OBJS := config.o
 
 include $(srctree)/arch/um/scripts/Makefile.rules
 
-- 
2.51.0


