Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBE7103E192
	for <linux-um@archiver.kernel.org>; Wed, 18 Mar 2026 14:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f6SQBnbLtk/tDiFJtuG2lyke9l9pURsRfwk7gcmlJ5k=; b=v7TPGIKvDtBzOx3Ezj9+DeJRfq
	6uiWF7sDxTUlguE+Faa6X9e3XcLXhq9KYdYXl565ba083E571NdRpFk1QjqviFBt5oQn9zq9uXnqR
	TvicqW81xIYG/SyYvCem99Ajd1Np2fYSz1Lrl3wz2RL8OttmTcNYjZHYyTvYMkBdSXBuTp5fb08St
	SzWuD+80g5JJJgQ5qF6nQlKbNQxQoRTcyjplNUKQ3uybYyurKeQKPrryb29qFkBml4Ru4aclCITB2
	lrd5utw6v68j4a0dmf/Ngiv0y3n5+D4iG2smKi7Gxfxj+BDJNSBkjkU33FDWZ+Qn+fBuh4wcHG20e
	uQqls5Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2s51-00000008byW-3fWA;
	Wed, 18 Mar 2026 14:41:03 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2s4x-00000008bwE-2IGD;
	Wed, 18 Mar 2026 14:41:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 773FE432F4;
	Wed, 18 Mar 2026 14:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F29C2BC87;
	Wed, 18 Mar 2026 14:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773844858;
	bh=QPe6wXvdAXZ1WsVrzW/I1Ea8rZgbDN6tCubJm34Z2So=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ngbdPPAxWjFSAiZvMouaeaCI+yNsZe/5Ks8XfwK23bbuJ+JwMl7yKx8wLk1AN3mNT
	 TMgJMbhcekeQl6cZDmfGyt8APhVYsofGCMvUz7w5d4VSUqCEDHmA0FWwHmr908obc6
	 Ca6I5aFuRQUI1yi4z3tpGvtErfL8rr5nKPdU3xQY3LcDhPRgWknRM3aO06irdxNWBm
	 2TlgtJ0ipwGbJWHORKvyo/BwbM/qZgR2EjBk9w3ApuIqc+XrUbVpU21pCoE11NYSNq
	 L1oljmENCVJ0s9YwPt8FVfCFDTEwjEsGgigo721LFalxDK0WN06IRwXdh82jFvxUSk
	 UiZTvvvmHDYJQ==
Message-ID: <4620167c-bcfe-414b-85f6-a5d28563b9af@kernel.org>
Date: Wed, 18 Mar 2026 15:40:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/23] mm/vma: add vma_flags_empty(), vma_flags_and(),
 vma_flags_diff_pair()
Content-Language: en-US
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Kees Cook <kees@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Dinh Nguyen <dinguyen@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Michal Hocko <mhocko@suse.com>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
References: <cover.1773665966.git.ljs@kernel.org>
 <ede9b0f8a2e2dc72e7fbc1a0ddbeb513364c28a2.1773665966.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <ede9b0f8a2e2dc72e7fbc1a0ddbeb513364c28a2.1773665966.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_074059_636507_9218F87E 
X-CRM114-Status: GOOD (  15.69  )
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

On 3/16/26 14:07, Lorenzo Stoakes (Oracle) wrote:
> Firstly, add the ability to determine if VMA flags are empty, that is no
> flags are set in a vma_flags_t value.
> 
> Next, add the ability to obtain the equivalent of the bitwise and of two
> vma_flags_t values, via vma_flags_and().

Nit: "two values" is vma_flags_and_mask(), while vma_flags_and() takes one
value and list of flags, no?

> Next, add the ability to obtain the difference between two sets of VMA
> flags, that is the equivalent to the exclusive bitwise OR of the two sets
> of flags, via vma_flags_diff_pair().
> 
> vma_flags_xxx_mask() typically operates on a pointer to a vma_flags_t
> value, which is assumed to be an lvalue of some kind (such as a field in a
> struct or a stack variable) and an rvalue of some kind (typically a
> constant set of VMA flags obtained e.g. via mk_vma_flags() or equivalent).
> 
> However vma_flags_diff_pair() is intended to operate on two lvalues, so use
> the _pair() suffix to make this clear.
> 
> Finally, update VMA userland tests to add these helpers.
> 
> We also port bitmap_xor() and __bitmap_xor() to the tools/ headers and
> source to allow the tests to work with vma_flags_diff_pair().
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


