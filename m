Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56EDEB64DD
	for <linux-um@archiver.kernel.org>; Wed,  5 Jul 2023 19:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RlnGkQm8Rp501NUh+FcloFEwBYrXYug0v2idlsM1oxU=; b=DVn4KjZP5ZkP3F
	zT2sjkBXtr0Lz612TY/LpUUTHGRPiunzf5UOLdQOlZ0mnWNCCuno13nuboiVbfwB1H8clasMhi814
	5KuVP5lgBnH+2NChZc3Jfih19vEw4xYZbtA/NcpY/8M2zMontPWqVTfxXmtnCSpipwD5BOYr81bXA
	mbg8QbquawaarD8/2e9J1Zl/64wL2fhO5WcLYZrHd7KrFCjU3GYoH8IuiP2d4C5sUnzJwfeXp2pzJ
	LxW1H2zv5kGO9IQ1uQsIXejDQ/3iErCmjiDYdSMBpC1EFGdSyC83eu+3PVugYgNUChe5ttjbsh2sH
	J19f9d2FR96fk+ThDTKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qH7nn-00GqYj-2q;
	Wed, 05 Jul 2023 19:04:35 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qH7nl-00GqXy-25
	for linux-um@lists.infradead.org;
	Wed, 05 Jul 2023 19:04:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2C1E561718;
	Wed,  5 Jul 2023 19:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2349FC433C7;
	Wed,  5 Jul 2023 19:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688583873;
	bh=Q07agmN+3+t14XXRG6FKQDnwU5RN+rMKtJn4NHdEWos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QkIfF+SdhLDlA6hyjj0ReVT8TuhVzupOEUrHVW1NoCL0TKXJ6VhiTU4HAAY9HUPxI
	 EIlpEW655H87oQuluOyUe84GuJS3XSH1DmOCPy0l2+r1UCkn2c0Ys6DBxzdeZxF/CE
	 4zI97zX8fF44I5BUOzZfc7IxAf4k1wTpTy0CfO7rFSdvWIQ+tFpDRxtE57mD0ZPsbM
	 SFRhL8QogFgK4DkrTPfL+fjPJN0squ60mBnqmQ1OspfOoKhnxEdanEUc5C2dgTmX7i
	 yvOMmEzu6ZSg88WKi/2glAMJh/J51GGR3EeFgBaohUXR2oTe0PRe8IfW9NBTioLufs
	 THtBLd8+7Xeqg==
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH v2 50/92] hostfs: convert to ctime accessor functions
Date: Wed,  5 Jul 2023 15:01:15 -0400
Message-ID: <20230705190309.579783-48-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230705_120433_724715_08CD24C9 
X-CRM114-Status: GOOD (  11.02  )
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

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/hostfs/hostfs_kern.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 46387090eb76..182af84a9c12 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -517,8 +517,7 @@ static int hostfs_inode_update(struct inode *ino, const struct hostfs_stat *st)
 		(struct timespec64){ st->atime.tv_sec, st->atime.tv_nsec };
 	ino->i_mtime =
 		(struct timespec64){ st->mtime.tv_sec, st->mtime.tv_nsec };
-	ino->i_ctime =
-		(struct timespec64){ st->ctime.tv_sec, st->ctime.tv_nsec };
+	inode_set_ctime_to_ts(ino, &st->ctime);
 	ino->i_size = st->size;
 	ino->i_blocks = st->blocks;
 	return 0;
-- 
2.41.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
