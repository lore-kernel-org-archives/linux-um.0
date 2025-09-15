Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27511CAC58E
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 07:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iRYpO586U8lxEybD+EbMysICiC2ETCm9BgFccrVd91I=; b=eOMNd8szFYJtJISnrf612qnmpq
	mJG4O4dj9L0UzUDJrKJwGMEwSv2fTs3K3070ZYJB/eZChagvoIibPHrzLr5Ir3QDk6CmbW0KODhTV
	fc0m9PuhlM7mw1Xkij7P25Yw+mwWWcTMRv+p6+mj8D6a5qO/qMtmiTaUavmLHpNLKX85xSsAUzjFU
	mF7YJpLYH39QJZBrkWnnSc38w/QxdzJ188iTzqQbhOFC1MSwDnNtVx9qEMozFDJ591sSJmv0CjWng
	aYi4niBYzddE4pJZNVIjwsayI6bXm7Negd6k6FJ7ZHzNSfkBXkrDBEv5/eKwRDZgcxwLbsebJ2miZ
	SKjICk4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3XN-000000031lj-3dlk;
	Mon, 15 Sep 2025 07:22:09 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3XL-000000031ip-2I6E
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 07:22:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iRYpO586U8lxEybD+EbMysICiC2ETCm9BgFccrVd91I=;
	t=1757920927; x=1759130527; b=EIrdbYluLDEsj8CFBqUgr58zc2GYT+Izv7gdQLb+9UZ3BL2
	1KS1vYtW/sI3+xvqv97WdijmbWz+DIDaTqNhlvBUaunCG9KfF9gEIUYVXtykEUsKt1m5PSKqgn6j+
	UI3vGUDWNu0QRWrIVIXrxnGXVAc3Y7OKEXhpxIFg8ELhSIB7lLwim7HhH1EENvANJIPT+6e/i6Zh4
	whe1XiCuJ20NLB2xfcvbaOIK41iB8gZEjQyJn1enmFqd8y93aoI+q0IEWK00EucKz6YrNpxt9yreD
	vj5ie/jku3M1FitO1dA9gDb1EWZUDj1V9RM7lmRZwlDgy39qnrcEbwmkymlYN7wQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uy3XI-00000005w6o-0Hco;
	Mon, 15 Sep 2025 09:22:04 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 4/9] tools/nolibc/dirent: avoid errno in readdir_r
Date: Mon, 15 Sep 2025 09:11:10 +0200
Message-ID: <20250915071115.1429196-5-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915071115.1429196-1-benjamin@sipsolutions.net>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_002207_584053_00139A9F 
X-CRM114-Status: GOOD (  11.29  )
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

Using errno is not possible when NOLIBC_IGNORE_ERRNO is set. Use
sys_lseek instead of lseek as that avoids using errno.

Fixes: 665fa8dea90d ("tools/nolibc: add support for directory access")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 tools/include/nolibc/dirent.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/include/nolibc/dirent.h b/tools/include/nolibc/dirent.h
index 758b95c48e7a..61a122a60327 100644
--- a/tools/include/nolibc/dirent.h
+++ b/tools/include/nolibc/dirent.h
@@ -86,9 +86,9 @@ int readdir_r(DIR *dirp, struct dirent *entry, struct dirent **result)
 	 * readdir() can only return one entry at a time.
 	 * Make sure the non-returned ones are not skipped.
 	 */
-	ret = lseek(fd, ldir->d_off, SEEK_SET);
-	if (ret == -1)
-		return errno;
+	ret = sys_lseek(fd, ldir->d_off, SEEK_SET);
+	if (ret < 0)
+		return -ret;
 
 	entry->d_ino = ldir->d_ino;
 	/* the destination should always be big enough */
-- 
2.51.0


