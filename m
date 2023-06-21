Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37A4EB64D7
	for <linux-um@archiver.kernel.org>; Wed, 21 Jun 2023 14:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GYaUASjvkxSuhxxtDH55LdKs7bPfPKH/FbUX6ISehBI=; b=xD0jpFC/V8dnL0
	UOxvkjYYLmf8S8/CEHzdHrLacSESM2mfx9ZgaYHAK7ldB7qqwDQUE3ad/LMv1iKyOkEKA0ScOcKZk
	S5cwpBkHzMfAM0Awgjl0Q5BT/dQyAPaaShG547SoMBsz4JPyr5fYXdkDqizZ4ttxC7JsP1BUw1fEH
	/2Ks3sjDBahLFrGKdGCqmCxyX+9uvnrlyZFp2Eu9beNaDDTwnWIzstMJH4o4dM+/t/brZn7oLq4w7
	0mveSeXxDZkh4kaxvdNl8XE0h4TUL+LY0RoocQK3ojCWAy8+yMZEm0yGO2e+a149lxK0C5QLgTMgV
	yVOHxodxgW9BmPVD1fOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBz8U-00Er7w-1e;
	Wed, 21 Jun 2023 14:48:42 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBz8S-00Er7Q-1T
	for linux-um@lists.infradead.org;
	Wed, 21 Jun 2023 14:48:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 044EB61536;
	Wed, 21 Jun 2023 14:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A660EC433C8;
	Wed, 21 Jun 2023 14:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687358919;
	bh=7kDZ0zSAuiZG3Ri7kKTPNFkOkI3vdeQNaeHRn7Yk8hM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=urrRE+Ul2hVmFhbrwq9sLzT1y4Q0DRerCmZqwlbqL2Ncta4KFzKp7HaNR7245ScwN
	 /L0gu2ol0rpyseaLYWMl8wc0hiNg0t25hbFPjNTofAiMIZ3bRbfFVmau3LmGpfZQza
	 W/+4CsBak8HhirWT1F8eC1YB37WFHe/H5PO3jDGe+dSlwVqs0Wjj6E3Iy3CTbfvJv+
	 fiqa8JMFh0e1JrdNEaJGSariji2RmP38B7lkCq3kHB3/JyryfrRmaWz8+We4vC+VRh
	 9XRVLfzXtHM1vK08bNVzGFUAsG+1Av/ycs2PHAp5jUhKTiAAcb0s4jXqQfr9cEV7mX
	 GnSwP/rA6COWw==
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 37/79] hostfs: switch to new ctime accessors
Date: Wed, 21 Jun 2023 10:45:50 -0400
Message-ID: <20230621144735.55953-36-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621144735.55953-1-jlayton@kernel.org>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230621_074840_538215_A125D5E8 
X-CRM114-Status: GOOD (  11.70  )
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

In later patches, we're going to change how the ctime.tv_nsec field is
utilized. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/hostfs/hostfs_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 46387090eb76..2248a2e599a7 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -517,8 +517,8 @@ static int hostfs_inode_update(struct inode *ino, const struct hostfs_stat *st)
 		(struct timespec64){ st->atime.tv_sec, st->atime.tv_nsec };
 	ino->i_mtime =
 		(struct timespec64){ st->mtime.tv_sec, st->mtime.tv_nsec };
-	ino->i_ctime =
-		(struct timespec64){ st->ctime.tv_sec, st->ctime.tv_nsec };
+	inode_ctime_set(ino,
+		(struct timespec64){ st->ctime.tv_sec, st->ctime.tv_nsec });
 	ino->i_size = st->size;
 	ino->i_blocks = st->blocks;
 	return 0;
-- 
2.41.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
