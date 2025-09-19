Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87357CAC5AD
	for <linux-um@archiver.kernel.org>; Fri, 19 Sep 2025 15:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wzmf8ozQSXaIG/+ku6O06QBDiFnQHnI35uzHRTGApx4=; b=LhAir5vkiK93Oq+eaMD7q/wt22
	5GIv+bk2mmPbqk22zMY4i86W8xmG0wzn0wd43UA0oIshfu9r23VFOTkYTPKEJV3WI+sJy5v9uOObj
	2Jv93kKh6NVR+ALu6HJWlJ3OLxydtOlztTql7bAwAXDOjS04b66fN41YMf415kbMuZj5JRkHzfc2t
	85f7A9GPht0hOtuuGyF3TfYuf2yz5cz3nKo139fea+KdKuKqyXaufkaYYQIbKTBJI6iRnENhHGFbO
	a87CJ2v4pN2EmWDztrjtsLLPw7HVlo06n6sINXjxueHWk/OvEq0iVrBht+TBkCSif7tk+MQscBySj
	1HUTPlKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd9f-00000003MG1-105h;
	Fri, 19 Sep 2025 15:36:11 +0000
Received: from s3.sipsolutions.net ([168.119.38.16] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd9b-00000003MBJ-22gY
	for linux-um@lists.infradead.org;
	Fri, 19 Sep 2025 15:36:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Wzmf8ozQSXaIG/+ku6O06QBDiFnQHnI35uzHRTGApx4=;
	t=1758296167; x=1759505767; b=Bn7yr6WXMzv4W6iEFHWC4z16M6HR+yHNvRb6FQTvMCUFNC2
	Yamly5mty4+1ZSq6ouky6NTLMMUenHDcl5EqLnfNx4RoLcLfclu8avXXthuZ7tEwhdMLi4zD4Af+D
	zE7D2MNF/ePa0wqPReNKKln5dZ1gNgEAhGEw8cfp9sA6Fu9gDWrWkg/TXdE68YjBVcMdLJPJQDXIy
	k3r0nfvmmtsOol3NobwEA63q3Qac4jGnozTwQHTPmjboIahbiPfYsQ5ZYRgesjlkZdtOnTWrSXlc0
	HygO3uyyaU28usRvWdH4zYaP7x/7bpavAm8JDAWvdgBkPYUThDKkKeavayhaniAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uzd9V-0000000G6O6-1ALo;
	Fri, 19 Sep 2025 17:36:01 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 03/11] tools/nolibc/stdio: remove perror if NOLIBC_IGNORE_ERRNO is set
Date: Fri, 19 Sep 2025 17:34:12 +0200
Message-ID: <20250919153420.727385-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919153420.727385-1-benjamin@sipsolutions.net>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250919_083607_523837_FF281A6B 
X-CRM114-Status: UNSURE (   8.83  )
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
Acked-by: Thomas Weißschuh <linux@weissschuh.net>
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


