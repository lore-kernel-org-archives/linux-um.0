Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE23606A324
	for <linux-um@archiver.kernel.org>; Thu, 19 Nov 2026 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cViyaV+A;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=UIje6bDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Xv/CtX4y0G6mlSmophgtGLK8szxHToO8r/3rld+L0GM=; b=cViyaV+AiR92Nc
	FPFNjNaNpb8XMRnQYADmM2WS7mjatfDf0CjNdB/+k+BCU+C9RJyNL+8T7RPy8m7ww6cj0IE1MN3Ls
	bNRqS3bTTo9IJt8dxrv5F1zUwwstsfWQsPxasWOx5DxdBNcNCa7R9EkyL0Ak/CCr1C3LpCAoFezPe
	zg/A7S7VdnaAIlJpeItigc5HnPnxnZzC1D5ixr9ZXHLsgDTfbifsQltWpttuNuR/UIffEGgR9HBd8
	gwP0miOG7c2msmcSMUXrryK0cV8jalT4FTofdXQ4fv71ig5ZN2G/w+0dDK86MHzX6Wpg3EPXhnpjm
	I5EyHS7wivGQkHwt8CYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU29Q-0000000C1iQ-0mCA;
	Thu, 19 Nov 2026 13:26:08 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU29N-0000000C1dR-0TEg
	for linux-um@lists.infradead.org;
	Thu, 19 Nov 2026 13:26:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Xv/CtX4y0G6mlSmophgtGLK8szxHToO8r/3rld+L0GM=;
	t=1795094764; x=1796304364; b=UIje6bDTCKnMPL4MNxI9egCphPyD7mTG1d4KxpnbZC6o/+R
	lMAqgcQMK+c2dWR3b2cgliWeRs94JWYzWo0JYiCHbNaIMeU+YLCreSRI1SKg6cSfNGERrLIjBsTF1
	/s/TkGjCiBiNfovdHSGhuhApo+oWF3KmaH5ij81eR/PgaSAjaDn/oNCPnHMfZJEIDBEj5n2cU6Dq8
	8lrbBvHKrLEcJRU8PPN03471Rsxuwqm3LOa98qswtFF1VTVcr73/iKza/vsVoI0gqoSLhy0IhR6xt
	P5H9dGcH2Tlb3wNXRrFy+bcqrQ5cTy6nePA8VFzA/kjPu3CPn2L5dRIcyGRQWPyA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1xU29K-00000004LQj-0y7E;
	Thu, 19 Nov 2026 14:26:02 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: =?UTF-8?q?=E5=AD=9F=E4=BB=A4=E6=BE=B3?= <menglingao@xiaomi.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC 4/5] hostfs: flush times when closing FDs
Date: Thu, 19 Nov 2026 14:24:41 +0100
Message-ID: <20261119142556.6938063dad73.I9cef49a77f45d22782d3d119495a55d1fca8b8d5@changeid>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119132555.228479-7-johannes@sipsolutions.net>
References: <20261119132555.228479-7-johannes@sipsolutions.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_052605_306185_605E9C81 
X-CRM114-Status: GOOD (  15.82  )
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

In time-travel mode we have a different time from the host. As the host
updates the timestamps when the file is written, we also need to update
them after the write has happened. Do so when we destroy the inode as
that is the point in time where we'll forget our own timestamps and need
them to on disk in case the file is reopened.

Not for upstream as-is. If not in time-travel mode, we should just use
S_NOCMTIME while in time-travel mode we probably want to do something
like this.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 fs/hostfs/hostfs_kern.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 224683fd74cb..09640dd6f373 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -239,6 +239,36 @@ static void hostfs_evict_inode(struct inode *inode)
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
 	if (HOSTFS_I(inode)->fd != -1) {
+		/*
+		 * If writes happened, then the host will have updated the
+		 * timestamps. This is a good time to ensure timestamps are
+		 * correct as no further changes will be done by us and our
+		 * internal cache is disappearing.
+		 */
+		if (HOSTFS_I(inode)->mode & FMODE_WRITE) {
+			struct hostfs_iattr attrs = {
+				.ia_valid = HOSTFS_ATTR_ATIME_SET |
+					    HOSTFS_ATTR_MTIME_SET |
+					    HOSTFS_ATTR_ATIME |
+					    HOSTFS_ATTR_MTIME |
+					    HOSTFS_ATTR_CTIME,
+				.ia_atime = (struct hostfs_timespec) {
+					inode->i_atime_sec,
+					inode->i_atime_nsec
+				},
+				.ia_mtime = (struct hostfs_timespec) {
+					inode->i_mtime_sec,
+					inode->i_mtime_nsec
+				},
+				.ia_ctime = (struct hostfs_timespec) {
+					inode->i_ctime_sec,
+					inode->i_ctime_nsec
+				},
+			};
+
+			set_attr(NULL, &attrs, HOSTFS_I(inode)->fd);
+		}
+
 		close_file(&HOSTFS_I(inode)->fd);
 		HOSTFS_I(inode)->fd = -1;
 		HOSTFS_I(inode)->dev = 0;
-- 
2.56.1


