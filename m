Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EBA606A323
	for <linux-um@archiver.kernel.org>; Thu, 26 Nov 2026 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JEz/gT4s;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dVVGBgUe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=WaGhGP18N1e5WQjSL7Kf13XBuOe/Lyl+VKElqyiI+RE=; b=JEz/gT4sEnrPOzkaMdTgJ65u7p
	5jZ3pKeYe6d60rHOseYRv3eIUtre8CnPb0S4j5+rCcNre9+d1BagR9zDrhkPNBNcM9TZ2/t5HiX0P
	W81YVrqJ3lRAxAWWI0/oXeDNlvqI47kchJQKoWncLdfiWTfkzUjjw/ReD1V1ZiNILptx5xJKcGoIy
	XplShsM+bxSFbwL1liM4N09Wa+Dsmck5fEcY9u5yhOs/b/6JP9uGWIhk9WMd6SDc9l2wt/aELU1T4
	iv4X14B13ho9UjNBUxJqp2xH2abV+9y6FYL6y2BBGBkQcxY+/h4v3ENarz1opuwsNuZlLpDLiAPNA
	fbKN3bMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWbLZ-0000000Dj2L-2eEA;
	Thu, 26 Nov 2026 15:25:17 +0000
Received: from out-218.mta1.migadu.com ([95.215.58.218] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWbLL-0000000DiwE-2atF
	for linux-um@lists.infradead.org;
	Thu, 26 Nov 2026 15:25:05 +0000
X-Envelope-To: linux-um@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=e8n4p5I4AJEqksbOANyj0Uvx8iI2baqGaT4jyvFlF3s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795706700; v=1; x=1796311500;
 b=dVVGBgUe9owodYdGtln7dPUN0WIk3zQGtK7GCZTw6lfdipbYqFHMw0LFhVZI8JKiHj+WsVSd
 rbidA0agbBLiw9bFTKrdjACzbkA/wZ3FPqDUSunPEUSfUSar+tGgjt4oTqTDIZE0KadgDSWuLpd
 BbL4GL+aNZDp2IMQHMncHFDg=
X-Envelope-To: linux-um@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id e28c61dcd929e842;
	Thu, 26 Nov 2026 15:24:58 +0000
X-Mizu-Trace-ID: e28c61dcd929e842
X-Migadu-Flow: FLOW_OUT
Date: Thu, 26 Nov 2026 07:24:42 -0800
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Harry Yoo (Meta)" <harry@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Muchun Song <muchun.song@linux.dev>, Hao Ge <hao.ge@linux.dev>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, "Liam R. Howlett" <liam@infradead.org>, 
	Alice Ryhl <aliceryhl@google.com>, Andrew Ballance <andrewjballance@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Amir Goldstein <amir73il@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Eric Dumazet <edumazet@kernel.org>, maple-tree@lists.infradead.org, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Mina Almasry <almasrymina@google.com>, 
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, linux-arm-kernel@lists.infradead.org, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, iommu@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-sunxi@lists.linux.dev, linux-um@lists.infradead.org, 
	cgroups@vger.kernel.org
Subject: Re: [PATCH slab/for-next v2 00/14] mm/slab: mandate SLAB_MAY_ACCOUNT
 for __GFP_ACCOUNT allocations to avoid wasting memory for slab metadata
Message-ID: <20261126152250.GB738059@shakeel.butt@linux.dev>
References: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125-memalloc-prof-dont-waste-slabobj-ext-metadata-v2-0-7c680f02a734@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261126_072503_830837_34D1D655 
X-CRM114-Status: GOOD (  10.47  )
X-Spam-Score: -1.8 (-)
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
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MSGID_MULTIPLE_AT,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 09:37:01PM +0000, Harry Yoo (Meta) wrote:
> TL;DR
> -----
> 
> The purpose of this series is to convert existing slab users that
> specify __GFP_ACCOUNT on allocations to specify SLAB_MAY_ACCOUNT on
> cache creation, to reduce memory waste for slab metadata with
> CONFIG_MEMCG=y && CONFIG_MEM_ALLOC_PROFILING=y.
> 
[...]
> 
> Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>

For the series:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


