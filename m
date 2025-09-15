Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190BCCAC58E
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 07:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JY7XXxDvbM6ze0ff4yyO/d8yJdh8zCwsbDmZYeFp3+Y=; b=hFAJFzfN2xjTL8LadiO9XYNhop
	Y/m4hqrw3RMpD85lCfpUSeZZU4kKSyjIq2c5EKX5dMHZ998aUYpISlhFOzaoEvF5xKvMfUGh6RhBu
	t5bwLz+1nq6myCYdshGY8u0n2tThOzfy/HWyJZzBi8F6hQoPysn6uULLoK5V8iUuOhtz9L/gifnUD
	IOKDz2DBLTMOyfqnzPkJdJSx80CK+l/yOK+krl6VTyRaxPnkJ6ADLfbiqxKx5/Nxu5XZFz82XKOge
	opuA9FrsXRexA99FNaeyCOqjTXsYtG1T1/KWg1uRWeIlMcEBguoYiS7EQBR5G1VXey7X9QKyKHuWy
	w+5i2qBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3XL-000000031j7-2T2A;
	Mon, 15 Sep 2025 07:22:07 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3XI-000000031hd-3tOv
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 07:22:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JY7XXxDvbM6ze0ff4yyO/d8yJdh8zCwsbDmZYeFp3+Y=;
	t=1757920924; x=1759130524; b=Od3S6pPW9cppUBgU/LqXHsuXqWb47P/Gui/8N0w4JUSfq29
	7KktVuZ8V09NZ/RGgi2Um/txd68xHI8odZJ6tHxNAa6WxY3KN6jmD4gSOtB+I834XjUouVrPAPlvi
	kmGKqbMlK8Bq4f1AYLOSV7SDMQw1S4TEMSKuFMnF/+PT4nzZZW/VC4uMHg0/vLc/aKXPyauEyfUmD
	cEZfWChDfLls2rtzB42lRsNVdLG8qIRFxgu92Rfsil4LskhcGKoTg0evRJYdy9UIpDO2OP9n1lWY9
	jh7tQDU1h5Dnf9z5gATpirvPBGRfp0wltmCJZtOf1WHKg1/oghAy9QyDO9tWQtOg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uy3XE-00000005w6o-06Px;
	Mon, 15 Sep 2025 09:22:00 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 1/9] tools compiler.h: fix __used definition
Date: Mon, 15 Sep 2025 09:11:07 +0200
Message-ID: <20250915071115.1429196-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915071115.1429196-1-benjamin@sipsolutions.net>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_002204_961063_6FCA6D6D 
X-CRM114-Status: UNSURE (   9.00  )
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

The define mapped to __attribute__((__unused__)) instead of using
__used__.

Fixes: e58e871becec ("tools/lib/lockdep: Remove private kernel headers")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 tools/include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 33411ca0cc90..b2c40621d441 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -127,7 +127,7 @@
 #endif
 
 #ifndef __used
-# define __used		__attribute__((__unused__))
+# define __used		__attribute__((__used__))
 #endif
 
 #ifndef __packed
-- 
2.51.0


