Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51161088E74
	for <linux-um@archiver.kernel.org>; Thu, 19 Mar 2026 17:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EuEjoftA1+hiXPIV+9bi9DU3ZElxVyYPyAtLVA/TK/A=; b=c0epIKZrE715qaj7aJXaf9GGq5
	c4bcDCy9VYTEAjAlWtLXSBmWwDGRcC3/ySaoBOmzInA3mJJrRLNoPbSH/oUWHnW56mU7iCYkB4DDI
	oU6xc3vRV5xxwYlZ5N+OCGqgbN+IJ/ZLoLPV8QVJBR6YCNrO9fnVO7uMN6Hv9sGvsGaal3gESQcNo
	U1ado7fns6+s8MPslmTxhzZHAg4Kc8IwteNRwnkqC71nxeSIL4mzbh9e5+LhzNsDZ9Jm87ORptT3Z
	7w+bdT+ImUOjXW9go9/nqk1IhmmNh9FGXG2yVxMHigg6V4Pi91WVdzc+OKegv0/gZFMiVoIwnASo4
	iXJ3RI/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3HKn-0000000BDdh-14PQ;
	Thu, 19 Mar 2026 17:39:01 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3HKj-0000000BDb8-23ph;
	Thu, 19 Mar 2026 17:38:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 82C9640786;
	Thu, 19 Mar 2026 17:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179C3C19425;
	Thu, 19 Mar 2026 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773941936;
	bh=Hivr+4pDKuDtiIkYu2gbJDWvORBSel+6FMp1v9HmeG4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AwsdLrRji7S/5bKRIRoLy9oMGfPTq7CI03hWA5bepga8vECo4/3RvNVeYeizQKIwW
	 R9UN16H8ZaF5yK8yAVtizkZh9zEgm8LSZqWA/t1UeGp3EhNubKGLgbwTBmjS9ANHPQ
	 CKr7ivIecBornjtAgZMvvL1T+6+bs5ktKzdaTNRhc0LyaeH1C0j44VGifmhwvaAXJM
	 POmn8ELyxElL1bT/10KjExBS16LBEqK+xysiliEZ0LVwQMpB+qDKVPe4l/rYse1i4L
	 PzUuZBXSFeyQ5M9ynh9jcooBzTBMkDLSF06baAlOeNctRGjpEyjMmt7dSbkQmkwwU3
	 AvDqZkxp71zew==
Message-ID: <b5f6f86a-3321-46ee-a481-23c2ee219618@kernel.org>
Date: Thu, 19 Mar 2026 18:38:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/23] mm/vma: introduce
 [vma_flags,legacy]_to_[legacy,vma_flags]() helpers
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
 <4fdffd05ee7fabe2dc313850a4300bf184beba69.1773846935.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <4fdffd05ee7fabe2dc313850a4300bf184beba69.1773846935.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260319_103857_581357_BE4C1DF2 
X-CRM114-Status: GOOD (  10.35  )
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
> While we are still converting VMA flags from vma_flags_t to vm_flags_t,
> introduce helpers to convert between the two to allow for iterative
> development without having to 'change the world' in a single commit'.
> 
> Also update VMA flags tests to reflect the change.
> 
> Finally, refresh vma_flags_overwrite_word(),
> vma_flag_overwrite_word_once(), vma_flags_set_word() and
> vma_flags_clear_word() in the VMA tests to reflect current kernel
> implementations - this should make no functional difference, but keeps the
> logic consistent between the two.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


