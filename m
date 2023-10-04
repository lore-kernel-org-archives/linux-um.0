Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E839EE7C4F6
	for <linux-um@archiver.kernel.org>; Wed,  4 Oct 2023 18:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CygtTp/1ojotB7Qjmd5MF+GJTtNM9C/AGjg1P68o6gA=; b=pqun6Od+uRnT6h
	sAHJzBQmhx2ZaHTORL9S6MNWsVKs/iGcCo2MgeC2u0+JUPViS/ARZlnvjvRCRY0zUc3rQjj76uXif
	h+k+AH/jO95fP4R/u/QMNiBMKUlzXoaTKxccnlstsUUJTz5RDwrKdAMbeKRd2f/DG54zGzzpB4285
	5WSgRNqP91T3e9wtgL3QH6UxVyNMJTVmj0pZlSNB/swFm1X/RKS0u0DpqDfFe937MHvqOJDL9hZyY
	Yrr3uZYDmUWocTJJM93InnYN6pnNohnEFex5YfXyTAIuuUItGyZd3jat1L/oacNzhVRLI2oTqcnhO
	ot75k5zh7ezAV6A84NiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qo719-000kJj-1j;
	Wed, 04 Oct 2023 18:54:43 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qo715-000kHP-0W
	for linux-um@lists.infradead.org;
	Wed, 04 Oct 2023 18:54:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 85DAFCE1C02;
	Wed,  4 Oct 2023 18:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53314C433CA;
	Wed,  4 Oct 2023 18:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696445676;
	bh=wyvNElsQFY/wD3VfgQOB/p8jSKpTCN3KRbRtfrvrqrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZWi31j1jUlgmDJkHPPyOFkz0C/QfZm5d49XioZxpJyhP8DyIOttETytNY39PK56W5
	 IuD3/BaYV68xTWkyv1GzhxiqtqQIR0q0Uz6NUGhmS6uAWx6d3aSmKhnAinEDw9se9u
	 DyG/Eecn1IPpkAkJcPdA80ZrxQWID5H9A3omWWXFXi9KxJq0Aec4BBg41YB+8UZsgF
	 o+/mCrLuEZ+33CrEGfZnaRjeyBde09bW87tvr8+Vul5mLEE4IGZuYVCiPXJ3vQQb4J
	 qaWGhTshUsAAutavZ980pdGkNSOjnci6gt/dG/0Nn4CMcPqu7XJWm9gDCWNjG/X0PB
	 fG0ZHVUaGTxLw==
From: Jeff Layton <jlayton@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-um@lists.infradead.org
Subject: [PATCH v2 43/89] hostfs: convert to new timestamp accessors
Date: Wed,  4 Oct 2023 14:52:28 -0400
Message-ID: <20231004185347.80880-41-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231004_115439_379252_30BD82FF 
X-CRM114-Status: UNSURE (   8.60  )
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

Convert to using the new inode timestamp accessor functions.

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
