Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914FA108B8EC
	for <linux-um@archiver.kernel.org>; Fri, 20 Mar 2026 10:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TycOeWVZquacUlciRj5W3aWhpreqS3TXqwdxrkjDt0w=; b=jajOLoUOs6kzGKxV3oXTCo33+N
	s3iVkseZD5I+CBlN3TUISlfVohcaAYwG2gqpbkPRGyIuqin/idXE5U3mzk6s+VtG9KUeKlDmzrKfy
	PCVMjYr0r8VAfWxLj/zOvvf1ZzWxux0YGiUVvHB67gQDES74JGNx08y46fCQB+ju57x4HIQQXZ5pQ
	PrrzncBh43wvG1YuCwYanpzvAoihz4uypakXUc4M8pJsLS7m1qefL639S9A6Cur5ku2s0AYy8LrjB
	ikUBRKfnGrnUP1RWa3O1lLhQdDfWYBS4PrlDlajVinjePst25hPpBLn5F7zfkod4ZA2/8iackXhHw
	7uIJRhNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Wtp-0000000CZJu-47l1;
	Fri, 20 Mar 2026 10:16:13 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Wtm-0000000CZHY-2Ung;
	Fri, 20 Mar 2026 10:16:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8A6B0436C8;
	Fri, 20 Mar 2026 10:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FF9C4CEF7;
	Fri, 20 Mar 2026 10:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774001769;
	bh=ap9t23GAznSjlYBwe3WH7nSlcvQ4uwkCMM8JPtwfdBU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VpGnIYfOhfS5un78DFGTJ5loTHw41DGnYvLF83kfJLhLDtl86vDxsK7+kZYUzaYnE
	 5V9zcIkNRIqSzj4tbwQLydHMYDPmXOCMLIySJ4ULjxFk/lefzNfI9hnLeFOCIGnnDl
	 mAxr5fguFL4uy3itIhWz2Fy0cYKrzKJpZhkuV6STy5rmqivM3mA46b4dMOAVIm8aX5
	 aL1J/e+lrGnyidQShydB7ZP25CoL8lbUtLPYsSX+m708iSuLKQWfBy+aNV3CStt/8O
	 sw5JQcZVkYlp6nZd/W4kU0jl8JC6+CIhgGnco8oF5shbFK5ws3inZ7cQkjFITK2eiJ
	 D0/iPE2qO9fcw==
Message-ID: <a7535063-abaa-4f67-a090-4a47098f10e7@kernel.org>
Date: Fri, 20 Mar 2026 11:15:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/23] mm/vma: convert as much as we can in mm/vma.c to
 vma_flags_t
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
 <44a952b98d68fc231ab231de6de04b077866bab8.1773846935.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <44a952b98d68fc231ab231de6de04b077866bab8.1773846935.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_031610_682635_7ABEEA94 
X-CRM114-Status: GOOD (  19.46  )
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
> Now we have established a good foundation for vm_flags_t to vma_flags_t
> changes, update mm/vma.c to utilise vma_flags_t wherever possible.
> 
> We are able to convert VM_STARTGAP_FLAGS entirely as this is only used in
> mm/vma.c, and to account for the fact we can't use VM_NONE to make life
> easier, place the definition of this within existing #ifdef's to be
> cleaner.
> 
> Generally the remaining changes are mechanical.
> 
> Also update the VMA tests to reflect the changes.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Nits:

> @@ -2338,8 +2339,11 @@ void mm_drop_all_locks(struct mm_struct *mm)
>   * We account for memory if it's a private writeable mapping,
>   * not hugepages and VM_NORESERVE wasn't set.
>   */
> -static bool accountable_mapping(struct file *file, vm_flags_t vm_flags)
> +static bool accountable_mapping(struct mmap_state *map)
>  {
> +	const struct file *file = map->file;
> +	vma_flags_t mask;
> +
>  	/*
>  	 * hugetlb has its own accounting separate from the core VM
>  	 * VM_HUGETLB may not be set yet so we cannot check for that flag.
> @@ -2347,7 +2351,9 @@ static bool accountable_mapping(struct file *file, vm_flags_t vm_flags)
>  	if (file && is_file_hugepages(file))
>  		return false;
>  
> -	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
> +	mask = vma_flags_and(&map->vma_flags, VMA_NORESERVE_BIT, VMA_SHARED_BIT,
> +			     VMA_WRITE_BIT);
> +	return vma_flags_same(&mask, VMA_WRITE_BIT);

Another case of possible refactor, if you agree with those pointed out in
earlier patch.

>  }
>  
>  /*

> @@ -2993,7 +2998,8 @@ unsigned long unmapped_area(struct vm_unmapped_area_info *info)
>  	gap = vma_iter_addr(&vmi) + info->start_gap;
>  	gap += (info->align_offset - gap) & info->align_mask;
>  	tmp = vma_next(&vmi);
> -	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev check if possible */
> +	/* Avoid prev check if possible */
> +	if (tmp && (vma_test_any_mask(tmp, VMA_STARTGAP_FLAGS))) {

The parentheses around function call not necessary?

>  		if (vm_start_gap(tmp) < gap + length - 1) {
>  			low_limit = tmp->vm_end;
>  			vma_iter_reset(&vmi);
> @@ -3045,7 +3051,8 @@ unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
>  	gap -= (gap - info->align_offset) & info->align_mask;
>  	gap_end = vma_iter_end(&vmi);
>  	tmp = vma_next(&vmi);
> -	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev check if possible */
> +	 /* Avoid prev check if possible */
> +	if (tmp && (vma_test_any_mask(tmp, VMA_STARTGAP_FLAGS))) {

Same.

>  		if (vm_start_gap(tmp) < gap_end) {
>  			high_limit = vm_start_gap(tmp);
>  			vma_iter_reset(&vmi);

