Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9071088E5E
	for <linux-um@archiver.kernel.org>; Thu, 19 Mar 2026 17:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yq0Z4EvpFDaoTFhe2HEhJ8Ykr3BfFmyB7X6eG+YCHX0=; b=ap2rXL7HVbexSIndaltvUbCe9z
	tjZTzs1RxtGZR3WOGehLYlKXBpw+r4ZrfL7KyBWS+OgNK/tk3VHCsBR/X2G+AG7c669Q/bBTIZkx7
	/t7700Rz0Axc098Wm/Zwvrbe9N8P2E0DiFpOn1bTVnS8V9gdae5bd8DpnT6qj7eG5DlMe0M+q/Jsy
	TAOXcmLoOsHUAcZ1fxqMvUI44Q90nQ94DPOGPlYQhixz0UngJOgzPyQE4kDeDNW4acnseq8ITPwtX
	K6Nmg76r/w3bpqXbsk0OD0eSLN7v+IZs2hhIJ7M+sqRtv7Nsz+y+nADWRDugCCpO0QhOy4cTMZyBS
	2Y8fau9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3HA9-0000000BCYo-3dpD;
	Thu, 19 Mar 2026 17:28:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3HA7-0000000BCXq-0FfG;
	Thu, 19 Mar 2026 17:27:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C229960053;
	Thu, 19 Mar 2026 17:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C008C19424;
	Thu, 19 Mar 2026 17:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773941277;
	bh=wnmsKZ1D1KfzQIEHQIk8Eq+6eKtEf+x/yXH1sCkJxLE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ni11x5qHEQ6U2LG6CI2Vjyjh8t7GcOt+96zl91V9r2Di7PZwwNlUqIZVECtb5H2w5
	 aQAItB7sZ8iybPVrttsTi0XPAtP+zr/ASNQ1euqvkmHf5ydGP6UZqDwpxf8ALEXyxe
	 8pCPJtXU8n7uKWcfbNhSoQVeIfHgpw1D/+DaX6oVnt1IqKlW7ofgHpLFNeb9PCwYJO
	 z9xyzSEe9mrHUJmqAXRi85ear0h0WPeoMl9z5fS+NVNSAnh6OhiWOJtu46EqEDWHpx
	 ropdkm9HGkEYmJPnTkidmpipti0N5Xx1ibqNhPY2cRQYPPciTZ+SLEtNcx/Gs/2xYI
	 UmlXn7wXZROVA==
Message-ID: <624d9f1f-656a-4a63-888c-e953b90bf56e@kernel.org>
Date: Thu, 19 Mar 2026 18:27:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/23] mm: unexport vm_brk_flags() and eliminate
 vm_flags parameter
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
 <297c7690f17257ba11a7b8c94fe54709a64d89fb.1773846935.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <297c7690f17257ba11a7b8c94fe54709a64d89fb.1773846935.git.ljs@kernel.org>
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
> This function is only used by elf_load(), and that is a static function
> that doesn't need an exported symbol to invoke an internal function, so
> un-EXPORT_SYMBOLS() it.
> 
> Also, the vm_flags parameter is unnecessary, as we only ever set VM_EXEC,
> so simply make this parameter a boolean.
> 
> While we're here, clean up the mm.h definitions for the various vm_xxx()
> helpers so we actually specify parameter names and elide the redundant
> extern's.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  fs/binfmt_elf.c    |  3 +--
>  include/linux/mm.h | 12 ++++++------
>  mm/mmap.c          |  8 ++------
>  3 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index fb857faaf0d6..16a56b6b3f6c 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -453,14 +453,13 @@ static unsigned long elf_load(struct file *filep, unsigned long addr,
>  		zero_end = ELF_PAGEALIGN(zero_end);
>  
>  		error = vm_brk_flags(zero_start, zero_end - zero_start,
> -				     prot & PROT_EXEC ? VM_EXEC : 0);
> +				     prot & PROT_EXEC);
>  		if (error)
>  			map_addr = error;
>  	}
>  	return map_addr;
>  }
>  
> -
>  static unsigned long total_mapping_size(const struct elf_phdr *phdr, int nr)
>  {
>  	elf_addr_t min_addr = -1;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0c35423177bf..42d346684678 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4005,12 +4005,12 @@ static inline void mm_populate(unsigned long addr, unsigned long len) {}
>  #endif
>  
>  /* This takes the mm semaphore itself */
> -extern int __must_check vm_brk_flags(unsigned long, unsigned long, unsigned long);
> -extern int vm_munmap(unsigned long, size_t);
> -extern unsigned long __must_check vm_mmap(struct file *, unsigned long,
> -        unsigned long, unsigned long,
> -        unsigned long, unsigned long);
> -extern unsigned long __must_check vm_mmap_shadow_stack(unsigned long addr,
> +int __must_check vm_brk_flags(unsigned long addr, unsigned long request, bool is_exec);
> +int vm_munmap(unsigned long start, size_t len);
> +unsigned long __must_check vm_mmap(struct file *file, unsigned long addr,
> +		unsigned long len, unsigned long prot,
> +		unsigned long flag, unsigned long offset);
> +unsigned long __must_check vm_mmap_shadow_stack(unsigned long addr,
>  		unsigned long len, unsigned long flags);
>  
>  struct vm_unmapped_area_info {
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 79544d893411..2d2b814978bf 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1201,8 +1201,9 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>  	return ret;
>  }
>  
> -int vm_brk_flags(unsigned long addr, unsigned long request, vm_flags_t vm_flags)
> +int vm_brk_flags(unsigned long addr, unsigned long request, bool is_exec)
>  {
> +	const vm_flags_t vm_flags = is_exec ? VM_EXEC : 0;
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma = NULL;
>  	unsigned long len;
> @@ -1217,10 +1218,6 @@ int vm_brk_flags(unsigned long addr, unsigned long request, vm_flags_t vm_flags)
>  	if (!len)
>  		return 0;
>  
> -	/* Until we need other flags, refuse anything except VM_EXEC. */
> -	if ((vm_flags & (~VM_EXEC)) != 0)
> -		return -EINVAL;
> -
>  	if (mmap_write_lock_killable(mm))
>  		return -EINTR;
>  
> @@ -1246,7 +1243,6 @@ int vm_brk_flags(unsigned long addr, unsigned long request, vm_flags_t vm_flags)
>  	mmap_write_unlock(mm);
>  	return ret;
>  }
> -EXPORT_SYMBOL(vm_brk_flags);
>  
>  static
>  unsigned long tear_down_vmas(struct mm_struct *mm, struct vma_iterator *vmi,


