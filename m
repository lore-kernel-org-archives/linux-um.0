Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044A0EC01B0
	for <linux-um@archiver.kernel.org>; Mon, 23 Mar 2026 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pBxuE79q0h/5XA82Gqv80sB/5+DcRUE+NdGM983xYdA=; b=LKEAv1oJ0GJ3Hzy9Z4Jkj+YhZW
	2tKP9d+OUaBGJuGOsMmHPFTE+i4/jEjSvPx7hhP2n4vHI/7j1+OVnSjtptYQ8/LfV8Qpu7LlYKz5W
	GKtLxu1NK75um6kP3Jb5FeHylFShx9YyxkMzB0V2b8iAOdlWtWD/jdXNXuhmgXJjE7nosoTYulb0P
	ywP0WWRH6SsaydMJJA+wmYGCqcMCQf3mh4SKswM96QV65SP97n0xzGwS8npo2XYMCVpAgLG43j3Y+
	aTGGYUDcBbnWPbdYf9rR5ngCmYcsHGJM+0BZSsRYI/vc1iNbQjfQw0sUQMos4snLTUUFiFNB9O+YK
	l0A0zbTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4hXW-0000000H45f-10Cv;
	Mon, 23 Mar 2026 15:50:02 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4hXT-0000000H44O-0tyL;
	Mon, 23 Mar 2026 15:50:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 30C9443D7C;
	Mon, 23 Mar 2026 15:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79346C4CEF7;
	Mon, 23 Mar 2026 15:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774280998;
	bh=PE+T0jq3B8ZtYRDz678LEyuTz6jmDPCQy5RpPTYrDcc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XdKC0tlgf1MZ9+nFlKePnzFurNne6QPx1E6YWyTEqc5Cy4/MJ7viljpcXJeeYfD84
	 LwWQhNPsI2I9K0v1c33u+VAYFjbd8O5XNRv7oB6hk9aWRLevlIqBhXTN/OJlKMwQKf
	 P5Vz/q+wIiOUnPmbE+gPP+1XyMVrMVU51S9pyTagqqIblZpcRImI+DCS0rQGs9Ppmv
	 uI4cbcMRaN1v0kgvKPt9I+2sGELYGp/hsRsweEovyazf3HWaMCdkqf89a80XhZaKnl
	 owytQQeI/86OfShIGnWbjgDPLE70BmD03V3uE7cRvQ8417IfFC5O/o3RDSK2/SzDZz
	 cVIvEtMGRKwxg==
Message-ID: <3945a9c5-565f-4126-8d46-1db584b09e79@kernel.org>
Date: Mon, 23 Mar 2026 16:49:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 24/25] mm/vma: convert __mmap_region() to use
 vma_flags_t
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
References: <cover.1774034900.git.ljs@kernel.org>
 <1fc33a404c962f02da778da100387cc19bd62153.1774034900.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
In-Reply-To: <1fc33a404c962f02da778da100387cc19bd62153.1774034900.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_084959_299701_32339A7C 
X-CRM114-Status: GOOD (  14.97  )
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

On 3/20/26 8:38 PM, Lorenzo Stoakes (Oracle) wrote:
> Update the mmap() implementation logic implemented in __mmap_region() and
> functions invoked by it.  The mmap_region() function converts its input
> vm_flags_t parameter to a vma_flags_t value which it then passes to
> __mmap_region() which uses the vma_flags_t value consistently from then
> on.
> 
> As part of the change, we convert map_deny_write_exec() to using
> vma_flags_t (it was incorrectly using unsigned long before), and place it
> in vma.h, as it is only used internal to mm.
> 
> With this change, we eliminate the legacy is_shared_maywrite_vm_flags()
> helper function which is now no longer required.
> 
> We are also able to update the MMAP_STATE() and VMG_MMAP_STATE() macros to
> use the vma_flags_t value.
> 
> Finally, we update the VMA tests to reflect the change.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


