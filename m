Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FDD606A323
	for <linux-um@archiver.kernel.org>; Wed, 25 Nov 2026 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yWgJsl7w;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PuifylfB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=EmbHvxSdAW/q1vOhxvKGf/qq9lAABR8oLeslWOTBY9M=; b=yWgJsl7wl3cKMf
	80KREyngJksDVqAFIxzlLeBcEcrmyDQ9tuYLCgWM8XXrjfm8BAGtHQn93AFrY8EEuIoJJqtR/GNS4
	gqEFNRGBEzFCYgroOuz0HPKoeJ+JLuBu2uY3+CGyjHllxCNoQv01X4AMyby9tXS1Ke0CSlHFB/8k6
	MQi8zOIgnfPokQIX7IotmcTWeiwxaL+bsjMnq+Hr3E236IvKYNK/Hi6vo06mR+grdG682k+s9y0Zj
	IFc0wPG75CEdnYGPlwR1Xi3CeO6dfjVynCC8dRIRnGt99N/Nm7mY0ZNBwTBNHGrVFHP7k5hYobQy9
	MGk0oB+2sEYoaFKhtzZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWKiT-0000000BNpP-0A3e;
	Wed, 25 Nov 2026 21:39:49 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWKiS-0000000BNpJ-0co0
	for linux-um@lists.infradead.org;
	Wed, 25 Nov 2026 21:39:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 92466627C5;
	Wed, 25 Nov 2026 21:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F741F000C4;
	Wed, 25 Nov 2026 21:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642787;
	bh=EmbHvxSdAW/q1vOhxvKGf/qq9lAABR8oLeslWOTBY9M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PuifylfBLGxCFHUkMhv/Mi8wFziI0lMC4HyaLotkpoyRMiK/TrqZX1AG36tnHuzoq
	 1WDRGhx+pHP7Nh965qPGtyLktzTqHZnDX+4Gh6hbSSD1omJfsf6XgD4SsJGobQnmI3
	 1feZaKZDJZvZVS7LexZ5PqMQicYfd5h8t+kiTsAk+fqrXTEZwdyxXYwnoq9TKkYv9Y
	 6UoVFGwIcQjP0rlrQartx7T9JCZdrZOPwM1GlbC3TJPbh16Dk3C0rtWzKA0VySGrC0
	 ld/K3k6FWZZbjgdKZNNrbnwCNGJ2AOltLaYpYBFbkIbdiXNq+qiPT3Hv4zKdppHG6x
	 vYPnf/H0PmEVA==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Wed, 25 Nov 2026 21:37:13 +0000
Subject: [PATCH slab/for-next v2 12/14] hostfs: specify SLAB_MAY_ACCOUNT
 for inode cache
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-12-7c680f02a734@kernel.org>
References: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
In-Reply-To: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
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
 "Harry Yoo (Meta)" <harry@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Alice Ryhl <aliceryhl@google.com>, 
 Andrew Ballance <andrewjballance@gmail.com>, 
 Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
 Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Amir Goldstein <amir73il@gmail.com>, 
 Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 linux-security-module@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Eric Dumazet <edumazet@kernel.org>, linux-um@lists.infradead.org
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 fs/hostfs/hostfs_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 613146e76dec..8d748ff838f3 100644
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


