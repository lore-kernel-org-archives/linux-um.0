Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FC710854D2
	for <linux-um@archiver.kernel.org>; Thu, 19 Mar 2026 17:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aaebET4GlZqyVpUhTjcsc0nipoEWgjWeux2s80xj4dE=; b=kh+eI/iUlHt4ig3e+af1AVCb7J
	ItcsHNuO9+A7cSi+dIBm2D8FDJx3muBCywaxmGIxo/3KltdMxwSG7oziHFW2DiMRwZKncgqfTvDSY
	bTcM7Uxs2ITlSRIQROVsMV2LW3Ho2ENkaVCQqxibAPAFGcxZQ1aHmCJ5m90MGTKs2IWl6H503kbsz
	4ZoroP0e8LpuAoiQDhzmpcJnWzE5sfqEfvyNqSo4Qk01eIaj/wajuMV5vM9yZX24GPlRfxTFQl3kW
	WBIgypkXVERqu4Jhz5oPm92y6nondeo1bcd8bQ38toLl9serQJZ5hnz+uDlav+R1xH2N+4U9xL39q
	/1jNa7CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3H33-0000000BBcn-3P4r;
	Thu, 19 Mar 2026 17:20:41 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3H30-0000000BBbN-1Fxd;
	Thu, 19 Mar 2026 17:20:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6B1244180A;
	Thu, 19 Mar 2026 17:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73FCC19425;
	Thu, 19 Mar 2026 17:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773940837;
	bh=7WKgNaoLHZy+p07zFzG+uBXisQ4HbwxhhgHjiSoiZqk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ffSI6bz53zQJuafJNtvM0FXrQJK6TSoiAy3TsE/OHG+oBO774YE9Uq3ERY0vLajMq
	 foC9QTSU4NBbGhonH60yk0rap8lV3ZJiY0EdZg4ohtjFxDdP03WSSuv7FxOfb2gNRf
	 4Tk0tb7MTeJ/T9jngjYvWOB7yaJiVrqkxSsZr8VaEiHU45hzdr+GUo5kh19vXtO0bW
	 q9aU3TOVflRNsW/UNdynX4mjKb683rFQGdGwpblrX7NCqBLWvGBpQLTxS9zEs4EM+S
	 6Jfsi2AkaiHj/WZ4zV6R2NgeHtz6Hh0jtHlsQEY+sWmOdz5CYdHv4iR/em4M/Sr5Ei
	 2g4iqlwGBs5oQ==
Message-ID: <50ff8894-3013-48e3-91ae-e96499ac394b@kernel.org>
Date: Thu, 19 Mar 2026 18:20:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/23] mm/vma: add append_vma_flags() helper
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
References: <cover.1773846935.git.ljs@kernel.org>
 <868641e2dbf62e3e04108a0b8092df25c250e3b9.1773846935.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <868641e2dbf62e3e04108a0b8092df25c250e3b9.1773846935.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260319_102038_381037_200B3EE1 
X-CRM114-Status: GOOD (  10.07  )
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

On 3/18/26 16:50, Lorenzo Stoakes (Oracle) wrote:
> In order to be able to efficiently combine VMA flag masks with additional
> VMA flag bits we need to extend the concept introduced in mk_vma_flags()
> and __mk_vma_flags() by allowing the specification of a VMA flag mask to
> append VMA flag bits to.
> 
> Update __mk_vma_flags() to allow for this and update mk_vma_flags()
> accordingly, and also provide append_vma_flags() to allow for the caller
> to specify which VMA flags mask to append to.
> 
> Finally, update the VMA flags tests to reflect the change.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


