Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B697606A326
	for <linux-um@archiver.kernel.org>; Thu, 19 Nov 2026 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ByMLXUnF;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=IauTXuYM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=hBxa+PC5mpz5OLUJXsieQgD+ieotdVFdQhUJM5j17fs=; b=ByMLXUnFqicacr
	jEXn7hBZ07SQcziF+TNtF5iUJIXSK+pla1XtwpiAVtFtOa/FrqXkp+lwucvwyjy0f6msIf1ogXOel
	4nlaPHzDhQwtVIb6d/qZfd43uz/puvU2IQhPe/2HRsP5tqriIbZY9tXNrTT5ERLaQRiDjyrlC3xGE
	fJZACu6xOMEtbrT377loENqZpe+Lp5lYr14o8lh+ONmGyQtBSUTYNHF3EsKwa+CcqwF7JMKZElRim
	vogXxArfs4u9ZTclMsgv0tc7DKe+8Fm4FPM8Bd1i3qlQ5u6zSGZ0YA5ZEPljLEcIsUrrfE5jxeg71
	l8t+ecyGmyoW5YxQ4lXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU29X-0000000C1nw-3vOP;
	Thu, 19 Nov 2026 13:26:15 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU29O-0000000C1e4-1HWK
	for linux-um@lists.infradead.org;
	Thu, 19 Nov 2026 13:26:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hBxa+PC5mpz5OLUJXsieQgD+ieotdVFdQhUJM5j17fs=;
	t=1795094766; x=1796304366; b=IauTXuYMIkKvdG4oE1w9UiY8wv791LnsxpiE7PNKxu2T5xH
	h9I57nds2GZpmKvQS5e4xahAcePoNPo1Mk+1wOUYu19gcKYW6nmso4saVfVqHvKMBX7dTWteun15L
	z9WwMMfT9vd0/BMcCcsJq5z0rnYeCaazPebWueDj7y0t2y6Rsy/bpxTe2JyZ3sd0l81W6yjWsyBSW
	x8oFoLtPAK6hvJmwR5BXA/hXeZrKKqCQNqML2Qh+5xPUEOl8l70XajfLUo6DW5UAAI/5UeGcfCw4H
	v9sgRuDbghnfLnzCF9b6bgKjGTlbVgayM+8dTj/v1AR9nxEKc+WZkVhXIo3vJyYQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xU29K-00000004LQj-3ZSC;
	Thu, 19 Nov 2026 14:26:03 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: =?UTF-8?q?=E5=AD=9F=E4=BB=A4=E6=BE=B3?= <menglingao@xiaomi.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC 5/5] hostfs: set timestamps on file creation
Date: Thu, 19 Nov 2026 14:24:42 +0100
Message-ID: <20261119142556.13d3393fcff6.I19f7ec8cc562893585a89223ec3c429b92c80403@changeid>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119132555.228479-7-johannes@sipsolutions.net>
References: <20261119132555.228479-7-johannes@sipsolutions.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_052606_354298_1032B88B 
X-CRM114-Status: GOOD (  11.46  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Benjamin Berg <benjamin.berg@intel.com>

Otherwise we will create the file and then read the timestamps from the
host file system. If the file is not touched/written afterwards, then
the host time can leak into the container.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 fs/hostfs/hostfs_kern.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 09640dd6f373..587ec51d34d6 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -747,6 +747,7 @@ static struct inode *hostfs_iget(struct super_block *sb, char *name)
 static int hostfs_create(const struct mnt_idmap *idmap, struct inode *dir,
 			 struct dentry *dentry, umode_t mode)
 {
+	struct timespec64 ts;
 	struct inode *inode;
 	char *name;
 	int fd;
@@ -766,6 +767,11 @@ static int hostfs_create(const struct mnt_idmap *idmap, struct inode *dir,
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
+	/* Use the internal time for the new inode */
+	ts = inode_set_ctime_current(inode);
+	inode_set_atime_to_ts(inode, ts);
+	inode_set_mtime_to_ts(inode, ts);
+
 	HOSTFS_I(inode)->fd = fd;
 	HOSTFS_I(inode)->mode = FMODE_READ | FMODE_WRITE;
 	d_instantiate(dentry, inode);
-- 
2.56.1


