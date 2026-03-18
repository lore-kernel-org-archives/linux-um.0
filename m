Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413EB103E191
	for <linux-um@archiver.kernel.org>; Wed, 18 Mar 2026 14:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FYBZKpgI6tybeKvEVdsHvPcDW9/RMvTX7D+4dmU7p0I=; b=NZBbHvtCG6btx2Mkl1F0U/GGae
	Oq7/QnGx5BGhZ7ytuHMpulXdubceOc0lOEjwEFHlKvmASL6gNhIBwbS6kFczVwBwWGumcm6MWD8Ik
	ayY7j0bW87j614G8un7zzNnTfLotomjgDeVmrcF/sD+PVdg3BmKISiKnECTScK8FBXgeo4xBymCBi
	ll2E0c1cmAsZGPJ6eO1hlOA1ToHTFkSSrkvEMMzlSMaKFJC0ixBqePAubb4PmuoFpHOAYJg67vNsG
	z3521CEH6oTvYqkDldhh9Z+dPlQ/d6q1m9ejVsLYJx77TCgHC8aM3xA+OcFHBUTSuOwE+quBD2GJ/
	oLszFMfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2s6b-00000008cCi-2NAf;
	Wed, 18 Mar 2026 14:42:41 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2s6Z-00000008cBp-0l2u;
	Wed, 18 Mar 2026 14:42:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 616DA600C4;
	Wed, 18 Mar 2026 14:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C9AC19421;
	Wed, 18 Mar 2026 14:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773844958;
	bh=o3Vqfegoze9voxgxHT8hNS1xVKI7tWzSZbrQEQde8dg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Brfo6kwquW7beM2eQzf+4i3bKNLjG6pitESp5wXj5j3/u4EMe+7TKVtW2kDQi189b
	 ksXjz2HFO5CzN39JGKjLjl5Cz6xte8b16X4vUnfN0qyNtCbUwrFXww9J7LQMWeH4tV
	 XxLcTaXa36dEp3pR9f5ACT1A0MF31tlrAm2w9z71HsxNJA+lhDEy4wTslHSjno+Jr+
	 oUiTxttBYh7Xfz9WqNET76CHoWG5D2z7or5j/VSvQHP6oD/BMerKadPNSlJmAi/h8i
	 4hOfDPVsWi8QZQJI/KS7nt3ccmQBTwTGOCza7YTyeCo9Fsju2QNwapLG0bKt1L3tAC
	 KTJlXh0jWxX4A==
Message-ID: <b706a64f-c142-419d-a151-931847cf8444@kernel.org>
Date: Wed, 18 Mar 2026 15:42:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/23] mm/vma: add further vma_flags_t unions
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
 <a37030f2eefc90147e84f9273e325cc289cb9e1d.1773665966.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <a37030f2eefc90147e84f9273e325cc289cb9e1d.1773665966.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
> In order to utilise the new vma_flags_t type, we currently place it in
> union with legacy vm_flags fields of type vm_flags_t to make the transition
> smoother.
> 
> Add vma_flags_t union entries for mm->def_flags and vmg->vm_flags -
> mm->def_vma_flags and vmg->vma_flags respectively.
> 
> Once the conversion is complete, these will be replaced with vma_flags_t
> entries alone.
> 
> Also update the VMA tests to reflect the change.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


