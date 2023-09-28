Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C850CE732C5
	for <linux-um@archiver.kernel.org>; Thu, 28 Sep 2023 11:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bIEQEBhlL7xANnpHyfyYBON1rzrr7mNMh15qluv0Gss=; b=f9ndqtj/4fvxRR
	P4/fdph5dTceof+/8p4LH/xAlg8Zn3h613xb1NJy+TpFl6zFQglTnAHQOh1d3K9A3MHuQ/bADbKzp
	jx4m14ur+/UzrJ1p0noJDrJWhYCRt/ht0p+n734AuFsykVxTCI4yM6N5WRENjO6O4dlUhW74YdI8v
	Ayn7kWwhF1jOzb4zc7fMAoPGvGdyJQsEW7JhGQ8O14vQFsXczNFXOjjJkssGfSY0i0VG52PUjs6Pn
	1lTe55/qZajyj+rKj3nLlNE/64OHcYCBGHnRfDmxi3ENvA7C7e7wO6f8IuDciW87ldxPsJoYvqzTL
	xnsoQgsXpDAhhRWTn2MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlopS-0033gl-2s;
	Thu, 28 Sep 2023 11:05:10 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlopL-0033bM-2d
	for linux-um@lists.infradead.org;
	Thu, 28 Sep 2023 11:05:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 42486615A9;
	Thu, 28 Sep 2023 11:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F72EC433C8;
	Thu, 28 Sep 2023 11:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695899102;
	bh=SmTKj23nuBjnbVRWTNodKzI7DTaJuxdAze07oBOhrrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L5QgKS9W7u596mXt8KF2kGCF40fQKt3AAdokcCeWA/jCXHC6cCL3EiH0HTC6hpVNh
	 jg/9vxbojQzwyPjMI+uWdIktjRu5n4c9p4vp3127MYw2QK/BxQrQFzOjqgr8+eOLyP
	 qDmXAX8zaxb22aHsML8eUME9AI49KprABJli7zFNSYyM6kQyEMUiYJ2LQDxxRbFzBd
	 GUUs3SaFGffhXSR05lYBiXnt1RX1Ub0tcCi6Gr/RANngVZhKHaYJxbT1rNiq/zO5L2
	 thx2c6ofSj2cpUam7Eckec2ZknPAVVU7bKgpxcvifXGifxRY1xgkkkMWB3be1PtxRC
	 CDo8DKQZwTJxg==
From: Jeff Layton <jlayton@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-um@lists.infradead.org
Subject: [PATCH 42/87] fs/hostfs: convert to new inode {a,m}time accessors
Date: Thu, 28 Sep 2023 07:02:51 -0400
Message-ID: <20230928110413.33032-41-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_040503_931997_201D3A2E 
X-CRM114-Status: UNSURE (   7.85  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/hostfs/hostfs_kern.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index dc5a5cea5fae..ea87f24c6c3f 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -513,10 +513,14 @@ static int hostfs_inode_update(struct inode *ino, const struct hostfs_stat *st)
 	set_nlink(ino, st->nlink);
 	i_uid_write(ino, st->uid);
 	i_gid_write(ino, st->gid);
-	ino->i_atime =
-		(struct timespec64){ st->atime.tv_sec, st->atime.tv_nsec };
-	ino->i_mtime =
-		(struct timespec64){ st->mtime.tv_sec, st->mtime.tv_nsec };
+	inode_set_atime_to_ts(ino, (struct timespec64){
+			st->atime.tv_sec,
+			st->atime.tv_nsec,
+		});
+	inode_set_mtime_to_ts(ino, (struct timespec64){
+			st->mtime.tv_sec,
+			st->mtime.tv_nsec,
+		});
 	inode_set_ctime(ino, st->ctime.tv_sec, st->ctime.tv_nsec);
 	ino->i_size = st->size;
 	ino->i_blocks = st->blocks;
-- 
2.41.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
