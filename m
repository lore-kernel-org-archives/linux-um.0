Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051F61093190
	for <linux-um@archiver.kernel.org>; Fri, 20 Mar 2026 08:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IIQYWNglnf1cpJWekLlvTi81VUzC2YvRS4Y7/+4rsT0=; b=bXdjLAdoj1M100TzQNmAJqMU8E
	n/YTns9gCCVCJ3HLIItg4zV8Hp1NwPqm7Lvnpumgs4ms1ClKwkxFFJ0zL3ToaR4NxWJnKZZZaXNIc
	zEDX5XkBktg7ANJqxtyQ7o2faWTJ7+kNvPR1aeBv3l0Ufz+hIs8hvtd3SA2sfubsOxd2fETJ20dSk
	emAYdcKkZA2dkxvx/f1kOJsZ0rzYIuXXkmfcz2+chB4WlEO1z/5JUK7yGp//zS0+cutJ4EVMROCYt
	pdgfIkgFHyi/0cDBVaocIOZlsGJMWrCoqUd8MdDQeV03Sxe+RpiRbuBIwvegtxO413RLXlyxq6RJ2
	Mko22Nsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3VXN-0000000CPP7-2N7l;
	Fri, 20 Mar 2026 08:48:57 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3VXL-0000000CPOI-19WB;
	Fri, 20 Mar 2026 08:48:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D799E60121;
	Fri, 20 Mar 2026 08:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C6FC4CEF7;
	Fri, 20 Mar 2026 08:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773996533;
	bh=AVThdTFHSI3D63/uFwXEr2OGdo0OiWz7degFLaawtVQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aVDuHUfdDD8S+qMhhcb+8iyq+IuTk2K0qpRAv1mnSPjQTT7GWau5uX1CNTdDtfR/0
	 LFp++8Dnz2QwIE1kWsO/Av6uPpJORJ9xnJDFjFTcwzcgktO9VxcKv+wSUvrzz529wf
	 Jleh6q8+Izcw8eTwQjx9H+19qhhqrrp8JH/iFcDfQPCQTH5ptvLmvsD0tj3RuwnSdm
	 11tBmRkm8T9VJyB6mHacHEUYXp0QrFVfjmR41FNwWWw2f9UTt8GR5oY9fomV0MX3gt
	 Xge1GZpeSPAeqwc5HQZYEgN6ad+xpQ+XJTcqZodE/t9TJgLMJDqXmC2Sy8iqPyspGC
	 oOpqQ4TUqrEMQ==
Message-ID: <7bd728dc-f370-4e64-a120-bd8fdcd3207a@kernel.org>
Date: Fri, 20 Mar 2026 09:48:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/23] mm/vma: introduce vma_test[_any[_mask]](), and
 make inlining consistent
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
 <7ea63af87bd35f20b204a14ad4912592e02b15a6.1773846935.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <7ea63af87bd35f20b204a14ad4912592e02b15a6.1773846935.git.ljs@kernel.org>
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

On 3/18/26 16:50, Lorenzo Stoakes (Oracle) wrote:
> Introduce helper functions and macros to make it convenient to test flags
> and flag masks for VMAs, specifically:
> 
> * vma_test() - determine if a single VMA flag is set in a VMA.
> * vma_test_any_mask() - determine if any flags in a vma_flags_t value are
> 			set in a VMA.
> * vma_test_any() - Helper macro to test if any of specific flags are set.
> 
> Also, there are a mix of 'inline's and '__always_inline's in VMA helper
> function declarations, update to consistently use __always_inline.
> 
> Finally, update the VMA tests to reflect the changes.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


