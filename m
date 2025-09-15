Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE396CAC597
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 07:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ELAWiFcBCxLD83jcc9mACALAjBu4TVZ8afWkcSqdi7Q=; b=N+v3lN5dPpgiLXTcyUsIEPPZRI
	py6lkY5SPfJjT9IwgVlcNZBY8RMRP9FFcmcLG0v/N7tKvgCxcoTntVh5vi/eCJ8h0/IPyBb5rnRCF
	INuif7/F5dCWjwMKU6ojdH6cpMOx7UuDqgcldN6s+udzu7V7t1RYhJV3aJwDifRxxkJx8hrDKVC0t
	n7svyukf1wenLR1B/+nX3vtZMq9alXnxq5f7uljfvXil5/XurJOM6aGwJsy4ANRPavKSYOg4b2SDJ
	jXvoNpUbosqaJr668BSs66Z8aYUrMT0xecsT5ZNEcFMo4zI2spHcH5GOpMpI7EWsQxXUpX9XaXCUp
	4s5eFbnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3XM-000000031kK-2V0y;
	Mon, 15 Sep 2025 07:22:08 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3XJ-000000031hp-4Am6
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 07:22:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ELAWiFcBCxLD83jcc9mACALAjBu4TVZ8afWkcSqdi7Q=;
	t=1757920925; x=1759130525; b=oFP3ymfIkMl05BKpLXN8Qy3SmflcJMQoCRMfj1Fj3Uawi11
	k8l8pp3JplXPx6ABH+gMudbIBZ/PbIkiDsKiJ7WN4P/hzwbIat26XNH/ywll5F25udW71Gn/w1VqU
	jH+8K3+QFqaxeSall8mRgd9gvT0Mor8cXRL1RSfCUG4JLqvmkFakUdiVcWqmR8G/a0O9GFauJXFbE
	IwJQGsuNR9SfVf1G69hpkydjzNJZamWlYWmypWYVmHThm/1CTz45qtm0qdwnmKcves1WznBN5H8m2
	6X8QQEEAMw4St3H4X1mzwqVFYWZObNVwntMZtItFJlIOaOLPL6bIHyY9lHYe6dCw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uy3XG-00000005w6o-2zYm;
	Mon, 15 Sep 2025 09:22:03 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 3/9] tools/nolibc/stdio: remove perror if NOLIBC_IGNORE_ERRNO is set
Date: Mon, 15 Sep 2025 09:11:09 +0200
Message-ID: <20250915071115.1429196-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915071115.1429196-1-benjamin@sipsolutions.net>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_002206_035128_78DC8DDA 
X-CRM114-Status: UNSURE (   8.35  )
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

There is no errno variable when NOLIBC_IGNORE_ERRNO is defined. As such,
the perror function does not make any sense then and cannot compile.

Fixes: acab7bcdb1bc ("tools/nolibc/stdio: add perror() to report the errno value")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 tools/include/nolibc/stdio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 7630234408c5..c512159b8374 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -597,11 +597,13 @@ int sscanf(const char *str, const char *format, ...)
 	return ret;
 }
 
+#ifndef NOLIBC_IGNORE_ERRNO
 static __attribute__((unused))
 void perror(const char *msg)
 {
 	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
 }
+#endif
 
 static __attribute__((unused))
 int setvbuf(FILE *stream __attribute__((unused)),
-- 
2.51.0


