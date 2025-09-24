Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F979CAC5A5
	for <linux-um@archiver.kernel.org>; Wed, 24 Sep 2025 14:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z10b0FVwCq0i5SVTTgonk/hnK8AmJrJFJmxu+fzz9NI=; b=b610T1C2WlfEizOny4EVdAAL1H
	OTnJoPbPeGGtcCnmce+vNO/ZFFLVbUKjYYCL4686K9tD9hT32BZN0lTDyybvAyFkw/q8fz+K5uYHT
	ZVkdCDi/j5gu4RJw/OANSkAcskD8BUeW6+7liw9NlGAotpjWkbgzwSFBJ0aI6V9WO1+UgnTVW8lh3
	ls9MsPU1askOYmSQ4+v0l/N9IJK+vh2He2tey724EHANAPsaaKLfYiIiNHZaFJcu/6Tuo5Heq3n2j
	t7y9NHzO4s9/7Ehf1shMLRQrBwOdjFhDVznAjM8NR4Gm5IBJ8yWm+Kd/oBQl1me8JxEgRlzuKlAle
	ayCQmbNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1QNa-00000000aqQ-1Gtg;
	Wed, 24 Sep 2025 14:21:58 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1QNX-00000000ajH-0ZSq
	for linux-um@lists.infradead.org;
	Wed, 24 Sep 2025 14:21:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=z10b0FVwCq0i5SVTTgonk/hnK8AmJrJFJmxu+fzz9NI=;
	t=1758723715; x=1759933315; b=gacHYJcsksoJrgZw8Qe+4D54xOOV60mBuGy13K9PryVdkCo
	OQWmqOKUvrkd4Jl7lT/27raD4YkSwEnE4QvwcNItpQ5pcXYU1WEMaNh+owkAp7s3Obx5HRobcNUzh
	R/vrT6o0dp34UKPnLXT8g6LqYzHsTZ+K0vhvaLQYUqL69Qj9sKgf8qFOVhiy8v3lGwrxoi/kywHqX
	0TQyxKxjdUmZij0QfG6oWIS6+c/YuxuHvRlq6zJubfujXTGR6KVXEUC5hYYl9TUUExjhca4Ktbr4A
	KmkPCHBPwcXxGf4CjmxJZ+HMPug+VB5VSt7Z60pGEjOq/B6BYI8GfUIb/J86Loow==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1v1QNU-000000090Bz-0suP;
	Wed, 24 Sep 2025 16:21:52 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 04/12] tools/nolibc/dirent: avoid errno in readdir_r
Date: Wed, 24 Sep 2025 16:20:51 +0200
Message-ID: <20250924142059.527768-5-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924142059.527768-1-benjamin@sipsolutions.net>
References: <20250924142059.527768-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_072155_183673_44C37329 
X-CRM114-Status: GOOD (  11.78  )
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


