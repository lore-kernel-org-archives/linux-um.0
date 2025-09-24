Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F064CAC5B5
	for <linux-um@archiver.kernel.org>; Wed, 24 Sep 2025 14:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6yjSl7NQvkiVEY35fXfoYnNnDHpwXZHvAt2SFrR0I98=; b=znnNL169aAYFWah+kueDk80EOx
	tEl2D2uny0F8+zfoUtw4zeCJlQCD3AvbE2tPOVbIlLVPxT6oHSF6TDTNYmJFcM2N2gSAv/LM6K8VW
	XaubJwDtVyzBX7Da2y8pLdY8Rwhr3Mv0T5kptpcEs6dpPFlCDvIEhVj877kHa9lqD41SG3KvAqWMh
	t1UvcHPAWvJCkhTb1UlYHgk/BHf+klrn4nZvuc4zlUArh5QcMn+lX9IttuREb3IoOgTUdswcRPyqL
	dw5bG3BMWLUpF3sSYhFOtK0Wm4JJ8PjXLbIknrq3hlIuMNBtaaBTmI2LtaD1EqaEc+rJqh29w3v5p
	ZmwQBq5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1QNY-00000000an2-34Mv;
	Wed, 24 Sep 2025 14:21:56 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1QNW-00000000aiY-1ukw
	for linux-um@lists.infradead.org;
	Wed, 24 Sep 2025 14:21:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6yjSl7NQvkiVEY35fXfoYnNnDHpwXZHvAt2SFrR0I98=;
	t=1758723714; x=1759933314; b=l6CZpQiFvK30S18nEvantsJDVsRC/JkDo5FRC9HNzpp92Nb
	gvb62CyYTZsLjtK7e5/zWkCf6E8IcYaEgQZMEhcyp3pl/OBYg+SxuJ0hUZ7NigOGSM/YtfMV/YqEV
	B6rlmwcK9OhnAl5Ynk7LJzyODaL5kqGFnyvVhWI53E1tpdcrgenWupyT5GTkJH9S3lApOs5nTgM5N
	8wqgKDQ7Hcw8iR5e+cC8RmavGKzTnFXbSkWJVh//hVqAicFEqlrlUW+mjkEEKTE1QagbWevIgWmYx
	anN1MLIqj+hEifQTCFaW0vSYgZYy3xSdEvCX836JbIQJDzO1gokZQ7eafG7IHV7A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v1QNT-000000090Bz-1Esg;
	Wed, 24 Sep 2025 16:21:51 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 03/12] tools/nolibc/stdio: let perror work when NOLIBC_IGNORE_ERRNO is set
Date: Wed, 24 Sep 2025 16:20:50 +0200
Message-ID: <20250924142059.527768-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924142059.527768-1-benjamin@sipsolutions.net>
References: <20250924142059.527768-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_072154_494415_486E32AE 
X-CRM114-Status: UNSURE (   8.46  )
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
simply print the message with "unknown error" rather than the integer
value of errno.

Fixes: acab7bcdb1bc ("tools/nolibc/stdio: add perror() to report the errno value")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---
v3:
- Change the message instead of removing perror entirely
---
 tools/include/nolibc/stdio.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 7630234408c5..724d05ce6962 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -600,7 +600,11 @@ int sscanf(const char *str, const char *format, ...)
 static __attribute__((unused))
 void perror(const char *msg)
 {
+#ifdef NOLIBC_IGNORE_ERRNO
+	fprintf(stderr, "%s%sunknown error\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "");
+#else
 	fprintf(stderr, "%s%serrno=%d\n", (msg && *msg) ? msg : "", (msg && *msg) ? ": " : "", errno);
+#endif
 }
 
 static __attribute__((unused))
-- 
2.51.0


