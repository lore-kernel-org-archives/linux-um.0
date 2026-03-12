Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00810106ACE5
	for <linux-um@archiver.kernel.org>; Thu, 12 Mar 2026 19:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dppx5bZj4+zeqj0N8m+gDYvEY1V3ochaIFGxa6FTN9A=; b=F408ZEiy42YEYl3PPKe13qhsO6
	A4uEMRZLHT+rZoRrLqf5+L8vke5l5+GCaomGzxD6bDj1wdYqjmptbFnKH4cQpBYCFD941AGF8m6jp
	+AOYj9hk5g/SDKDKqK7iVbvUrU/Ocb0AbP+QE7WFl/sheYuNsdM57nZpF17EkTGclz+AAmHnXAEUy
	SNk1P5zN+mE2lDcxeXk6N16YIuGl051M8PuVLdEEac6oqYA7KHxXEyMng0i2PcaTXISqgje4fmKdM
	GYTvcMlw5s5fT4RKuVQHATrvV7PnVn0l2myJ4ixB+uCUJK41lteIwK4KPZx0AJfCHsWIIAc2Sev6H
	Vgx0oEEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0lk6-0000000F6iB-34ld;
	Thu, 12 Mar 2026 19:30:46 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0lk0-0000000F6dT-3pnJ;
	Thu, 12 Mar 2026 19:30:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 406E160142;
	Thu, 12 Mar 2026 19:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7617AC4CEF7;
	Thu, 12 Mar 2026 19:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773343839;
	bh=dppx5bZj4+zeqj0N8m+gDYvEY1V3ochaIFGxa6FTN9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MpZymGjSfeezPsAxTR8is/y91vPi0xEPN0K7IFHZz77hM83w5Vj26pRQa3IjU+zwy
	 tbXTe0vQVq6U2m+k9m9HlIImXQzU1M/vS/yGyO63HG8DiJ/vWb+uh3H//T9IyA4hRD
	 LHmNXH5dbPF1f5a6PD6COunVyQVhVzAFmLKrarzr4fRbA4mQYsRv3xiTnLsrX7/jL3
	 WHpFX+yadIsp2XaB8uyt+zH82bPt5Vn2z3z5NgdxkOECEMl6n7PpL7zmNASsxMRVme
	 OdW87Byykc4nbucZ93idCIAIBC9mWbsdzDxSrxwiqiZl0Wrvakg+Vhl50YtatzUzD4
	 wIPQgYElJZvAQ==
Date: Thu, 12 Mar 2026 19:30:38 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Kees Cook <kees@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh Nguyen <dinguyen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@suse.com>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 02/20] tools/testing/vma: add unit tests for
 vma_flags_[empty, diff_pair, and]()
Message-ID: <9198d18c-a1a9-4321-bf34-13e48172eab4@lucifer.local>
References: <cover.1773340636.git.ljs@kernel.org>
 <87517d01b3973aa43f874164d0741d02cb123537.1773340636.git.ljs@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87517d01b3973aa43f874164d0741d02cb123537.1773340636.git.ljs@kernel.org>
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

(Please ignore this patch, it was sent by mistake, the correct 2/20 is [0])

[0]:https://lore.kernel.org/linux-mm/ae25ef9cd48e20553babaad3868da1cf74f16af1.1773342102.git.ljs@kernel.org/

