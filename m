Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40CB60A382F
	for <linux-um@archiver.kernel.org>; Wed, 21 Oct 2026 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NXXV7FH1;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VAQEqFAq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v5h8ao2sl0gSDsVo7bAD/bZpeGjj83T87XQIb40RcPU=; b=NXXV7FH1vvCJGoV1UFFtEyeDq3
	RV7T1nsLNVAzTzStSMJT5St4PZ7YACfZ/BBeUnlkKAZr6OuP8DI1riZc+0ZhuFyw0PofmA3X90dEU
	1938KuWbTYAmIZSBbm+ohmZDpBUiBLu1n6hIfmsQKJYnQXpaO9pVRGV/hrZAWcTL/gEXNE5K+en7m
	lGDPKdUDReMwatRv31f0eIMDlPgds3PK3b8NjSul2FgLbQ2ba0oymJMCnF5p0k9wVYXL2vWR93OHl
	n3iKwryjhS+p5Zg/GxofXvxdcI8pRPf7ZzQMrlNrcfBWrn2nKVZ0cGXlCuQF3c4dfwqwDeXbQkOeG
	5+z0WW8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJUnj-0000000BkE3-2ptL;
	Wed, 21 Oct 2026 11:48:11 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJUnh-0000000BkDP-3GWh
	for linux-um@lists.infradead.org;
	Wed, 21 Oct 2026 11:48:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 88EEE4021A;
	Wed, 21 Oct 2026 11:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA461F000C6;
	Wed, 21 Oct 2026 11:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583289;
	bh=v5h8ao2sl0gSDsVo7bAD/bZpeGjj83T87XQIb40RcPU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VAQEqFAqztqAv3qcxYHFlzZ1jnwzQHztkQm2Ku6wB0q3Zn6zx9WSz/DftIPSC4uQW
	 UQEGhZzE8CTFEjNhoxKw6waO8eavv3OLCCMKLx1GMsRQ9ICbb+Mox0wzsrZ1867sBL
	 aruuh8VMrFgTIUoyxKK4IXRW4dLn158hDVknl84KDCH0v2DbNKnSO/snpqe1npTURl
	 GRaxsmZQIx2WoRZi/tK+3tf9KSujh1BQnvJPcZk4NjeHAeE5TaNft5yEaxTDGnru43
	 KMZoUuUMx6pEJeQlPxds41+IXvnl0aoR1n+LeH4ZuyqzqPYAlaVVAINqpFtQKt6k6I
	 FLmCIoTGX4RiQ==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Wed, 21 Oct 2026 12:46:53 +0100
Subject: [PATCH slab/for-next 12/14] hostfs: specify SLAB_MAY_ACCOUNT for
 inode cache
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-12-096800aa3330@kernel.org>
References: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org>
In-Reply-To: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, Muchun Song <muchun.song@linux.dev>, 
 Hao Ge <hao.ge@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 "Harry Yoo (Meta)" <harry@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

hostfs inodes are allocated with GFP_KERNEL_ACCOUNT. Specify
SLAB_MAY_ACCOUNT when the object may be charged to a memcg.
__GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.

Path: lookup -> hostfs_iget() -> hostfs_alloc_inode()
  -> alloc_inode_sb(sb, hostfs_inode_cache, GFP_KERNEL_ACCOUNT)

Assisted-by: LLM
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 fs/hostfs/hostfs_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 7add056d47d8..2d55f53569ca 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -1078,7 +1078,7 @@ MODULE_ALIAS_FS("hostfs");
 
 static int __init init_hostfs(void)
 {
-	hostfs_inode_cache = KMEM_CACHE(hostfs_inode_info, 0);
+	hostfs_inode_cache = KMEM_CACHE(hostfs_inode_info, SLAB_MAY_ACCOUNT);
 	if (!hostfs_inode_cache)
 		return -ENOMEM;
 	return register_filesystem(&hostfs_type);

-- 
2.54.0


