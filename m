Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3880CAC5B1
	for <linux-um@archiver.kernel.org>; Wed, 24 Sep 2025 14:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SesBRyEDdeL4b2WR08hExbhuW4gCAOOUoslrVli4iZo=; b=kMk6RKUe1FJutLTah6BRVz3UeQ
	zx6LFidmRN9mvD8zIIL17Toh+v9qoV1ntgvR++L4KmhjC+xd/8VVADNOju+OWswFpILv/hAWkvFnB
	tHbqaEQXTNdYpLI86k4JgKcJaA3x7sJANajLJ6ueC2dVxywQo/T/OLWDgB4G+XpIk1AaYYf9uqdA6
	kI13viA6WvoRYI5pxS43eJUczaLaLcg+P86JKJgNrZ76Q7hbk7p3ZkfgHrvMlaLi86kF4IaQj4onT
	xlF/DE/m6qwm7fXHnKzPZ1fexqmlOLp3L0GoWoOmyngUBPMRK9Ig/oHrZR6vAczwt22dnCKXE7Ivc
	IFEDmMDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1QNb-00000000at6-2oXf;
	Wed, 24 Sep 2025 14:21:59 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1QNY-00000000alZ-2qfB
	for linux-um@lists.infradead.org;
	Wed, 24 Sep 2025 14:21:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SesBRyEDdeL4b2WR08hExbhuW4gCAOOUoslrVli4iZo=;
	t=1758723716; x=1759933316; b=AQolnZQd2mpvLFsLH/qs7+RikhwBAbzve1FjtV2kjwRopvY
	1XysDKzsjoJG/GkAHug/5P8xPB1Q6v8rAjiCnSBxodIqVycB9KSrbQPG6Ry/YiG/hfyiQj0xn1NCm
	jbF/D4NORwNBGstoWqlJ6Hl1P4WXlkjZGFMnxbfflR8LMlf5NknMW1id5eyEQCgUkbTc46h6g/T6O
	ryKKZK4wt8R7o5f0ffDmEZGJ7j2ZmF9dHFu5s5IZXQS6jz8Aj2BxkwymInUR2oeWrPmYmt0NL/Pry
	GgSX5I8nN8cMbdWhY1m6Nhi6IHSS3Bf94NAsUTiM/5nPfYjwCwkYxgyNcXnukugA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v1QNV-000000090Bz-1qiK;
	Wed, 24 Sep 2025 16:21:53 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 05/12] tools/nolibc: implement %m if errno is not defined
Date: Wed, 24 Sep 2025 16:20:52 +0200
Message-ID: <20250924142059.527768-6-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924142059.527768-1-benjamin@sipsolutions.net>
References: <20250924142059.527768-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_072156_784846_DF13CBF9 
X-CRM114-Status: UNSURE (   9.31  )
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

For improved compatibility, print %m as "unknown error" when nolibc is
compiled using NOLIBC_IGNORE_ERRNO.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 tools/include/nolibc/stdio.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 724d05ce6962..1f16dab2ac88 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -321,11 +321,13 @@ int __nolibc_printf(__nolibc_printf_cb cb, intptr_t state, size_t n, const char
 				if (!outstr)
 					outstr="(null)";
 			}
-#ifndef NOLIBC_IGNORE_ERRNO
 			else if (c == 'm') {
+#ifdef NOLIBC_IGNORE_ERRNO
+				outstr = "unknown error";
+#else
 				outstr = strerror(errno);
-			}
 #endif /* NOLIBC_IGNORE_ERRNO */
+			}
 			else if (c == '%') {
 				/* queue it verbatim */
 				continue;
-- 
2.51.0


