Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBBBCAC5AB
	for <linux-um@archiver.kernel.org>; Fri, 19 Sep 2025 15:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z10b0FVwCq0i5SVTTgonk/hnK8AmJrJFJmxu+fzz9NI=; b=rPXqPZYmY/72cd6wiXyPu1h1bW
	uAzBx+sdk0bIv+AekiGvUtb2xjy3nWRxd0nJ6m3SYd5RM4NsAVw+6ssdxKsYlax/QncxYFBS9u6/o
	aS+zv5h5nanIk8M+iojZ5JlmlfVCF2ehq943Fyuqj09zz3jxN/IHnYqBapBYOlJLKVB87gTyKbORm
	WSBz3U2nbmS5iSAv6fyg94Mj/PsmU8Q58qgEBa+l4yLLkXkJnC4p/LeH4BfiMCQTw0/vxpASqP76r
	dUHypy84KCbza1lkn4670rBW7jKDvt68nJZtbkYDBfzVC6vafqF+789hgVd/ziVRoEXDtuKXqXnlp
	10L0sRLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd9e-00000003MF8-2o53;
	Fri, 19 Sep 2025 15:36:10 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd9b-00000003MCC-2iHi
	for linux-um@lists.infradead.org;
	Fri, 19 Sep 2025 15:36:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=z10b0FVwCq0i5SVTTgonk/hnK8AmJrJFJmxu+fzz9NI=;
	t=1758296167; x=1759505767; b=uZ08VsNPIfqORymjADXtWf+BvNxxC2RPMb32Nilljwg30nt
	NlaTHAp8GW8min9esyV1OAfSpqgfXbq1R42zt1M29RlKPCukoDq3zXLwsl1mUrGr3MGxG9pJ2skXU
	dZCddjrFIUnpqIFQF3QBZVoJvWOZsM5ANsMr/3meKiSqoCcGb9yJduXNb4bDbX5Sb/KwKTIvYotPX
	pohaIeBCJOga308GV57Bqc0Tg7OClsyZII1F3ISCUOqVR6gsrFo0cpfHLpolo8c+i+zvJwdBXs5Eg
	w5UL4dGsNyhl2OutpHEkyUOwlTgrVLRMtXK5uP9qdPZoxi0ZZZJDgsqzy1DIqVHA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uzd9W-0000000G6O6-3qcL;
	Fri, 19 Sep 2025 17:36:04 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 04/11] tools/nolibc/dirent: avoid errno in readdir_r
Date: Fri, 19 Sep 2025 17:34:13 +0200
Message-ID: <20250919153420.727385-5-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919153420.727385-1-benjamin@sipsolutions.net>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250919_083607_685183_0DFA9CB4 
X-CRM114-Status: GOOD (  11.97  )
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
Acked-by: Thomas Weißschuh <linux@weissschuh.net>
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


