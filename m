Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C58CE7717F
	for <linux-um@archiver.kernel.org>; Thu, 12 Dec 2024 14:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:Content-Type:
	MIME-Version:Message-ID:In-Reply-To:Date:References:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MqRaP6NHgBTc/Myf3oNdfD32UoCYzdt2X4DCHvv/yeg=; b=Sg7+mKl7ZkJEl7/8OF+JzCYQ1w
	zLqxwDRQJi+efG9DWXSO0chMRu82iXyYSlQdoX7M7pwVM6ZNmN8lqwk7qdx9nBhlALlwG532IBegn
	NmxWvDFguaie+I+UpqLcVqrQ9876Te964My8pCKKPCqG78q6n5J57VJqSnsfwIM7i+4jRU40u961V
	3H/bxivBhsIBlqFOkxdAXnsprIUSPcJ7vak6Q0wz3EQn/MCZ5R0PK7HFL8vmEsieVFV6HnQ1AIkA+
	S1JbtO39x7X/HigTVzrroIUcR9fOx/xEZhfDJp+AZ5LYLtKP8Iyaf/T2v3ewUPhUZuWRcMrZKA6Rl
	mL2DsEAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLk7A-00000000b9W-0dwN;
	Thu, 12 Dec 2024 14:24:28 +0000
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLk6C-00000000b3V-1x9p
	for linux-um@lists.infradead.org;
	Thu, 12 Dec 2024 14:23:29 +0000
Received: from in01.mta.xmission.com ([166.70.13.51]:37672)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tLk5t-00BfnV-H5; Thu, 12 Dec 2024 07:23:09 -0700
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:59852 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tLk5s-0070Kb-4n; Thu, 12 Dec 2024 07:23:09 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org,  ricarkol@google.com,
  Liam.Howlett@oracle.com,  Kees Cook <kees@kernel.org>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Christian Brauner <brauner@kernel.org>,  Jan
 Kara <jack@suse.cz>,  linux-mm@kvack.org,  linux-fsdevel@vger.kernel.org
References: <cover.1733998168.git.thehajime@gmail.com>
	<d387e58f08b929357a2651e82d2ee18bcf681e40.1733998168.git.thehajime@gmail.com>
Date: Thu, 12 Dec 2024 08:22:47 -0600
In-Reply-To: <d387e58f08b929357a2651e82d2ee18bcf681e40.1733998168.git.thehajime@gmail.com>
	(Hajime Tazaki's message of "Thu, 12 Dec 2024 19:12:09 +0900")
Message-ID: <87r06d0ymg.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1tLk5s-0070Kb-4n;;;mid=<87r06d0ymg.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/f/Wxjl/Fysr+iPoDi9zb/QsVJKuStryA=
Subject: Re: [PATCH v5 02/13] x86/um: nommu: elf loader for fdpic
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz, brauner@kernel.org, viro@zeniv.linux.org.uk, kees@kernel.org, Liam.Howlett@oracle.com, ricarkol@google.com, linux-um@lists.infradead.org, thehajime@gmail.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_062328_501962_6E9DADAB 
X-CRM114-Status: GOOD (  22.41  )
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

Hajime Tazaki <thehajime@gmail.com> writes:

> As UML supports CONFIG_MMU=n case, it has to use an alternate ELF
> loader, FDPIC ELF loader.  In this commit, we added necessary
> definitions in the arch, as UML has not been used so far.  It also
> updates Kconfig file to use BINFMT_ELF_FDPIC under !MMU environment.

Why does the no mmu case need an alternative elf loader?

Last time I looked the regular binfmt_elf works just fine
without an mmu.  I looked again and at a quick skim the
regular elf loader still looks like it will work without
an MMU.

You would need ET_DYN binaries just so they will load and run
in a position independent way.  But even that seems a common
configuration even with a MMU these days.

There are some funny things in elf_fdpic where it departs
from the ELF standard and is no fun to support unless it
is necessary.  So I am not excited to see more architectures
supporting ELF_FDPIC.

Eric



> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> Signed-off-by: Ricardo Koller <ricarkol@google.com>
> ---
>  arch/um/include/asm/mmu.h            | 5 +++++
>  arch/um/include/asm/ptrace-generic.h | 6 ++++++
>  arch/x86/um/asm/elf.h                | 8 ++++++--
>  fs/Kconfig.binfmt                    | 2 +-
>  4 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
> index a3eaca41ff61..01422b761aa0 100644
> --- a/arch/um/include/asm/mmu.h
> +++ b/arch/um/include/asm/mmu.h
> @@ -14,6 +14,11 @@ typedef struct mm_context {
>  	/* Address range in need of a TLB sync */
>  	unsigned long sync_tlb_range_from;
>  	unsigned long sync_tlb_range_to;
> +
> +#ifdef CONFIG_BINFMT_ELF_FDPIC
> +	unsigned long   exec_fdpic_loadmap;
> +	unsigned long   interp_fdpic_loadmap;
> +#endif
>  } mm_context_t;
>  
>  #endif
> diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
> index 4696f24d1492..4ff844bcb1cd 100644
> --- a/arch/um/include/asm/ptrace-generic.h
> +++ b/arch/um/include/asm/ptrace-generic.h
> @@ -29,6 +29,12 @@ struct pt_regs {
>  
>  #define PTRACE_OLDSETOPTIONS 21
>  
> +#ifdef CONFIG_BINFMT_ELF_FDPIC
> +#define PTRACE_GETFDPIC		31
> +#define PTRACE_GETFDPIC_EXEC	0
> +#define PTRACE_GETFDPIC_INTERP	1
> +#endif
> +
>  struct task_struct;
>  
>  extern long subarch_ptrace(struct task_struct *child, long request,
> diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
> index 62ed5d68a978..33f69f1eac10 100644
> --- a/arch/x86/um/asm/elf.h
> +++ b/arch/x86/um/asm/elf.h
> @@ -9,6 +9,7 @@
>  #include <skas.h>
>  
>  #define CORE_DUMP_USE_REGSET
> +#define ELF_FDPIC_CORE_EFLAGS  0
>  
>  #ifdef CONFIG_X86_32
>  
> @@ -190,8 +191,11 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
>  
>  extern unsigned long um_vdso_addr;
>  #define AT_SYSINFO_EHDR 33
> -#define ARCH_DLINFO	NEW_AUX_ENT(AT_SYSINFO_EHDR, um_vdso_addr)
> -
> +#define ARCH_DLINFO						\
> +do {								\
> +	NEW_AUX_ENT(AT_SYSINFO_EHDR, um_vdso_addr);		\
> +	NEW_AUX_ENT(AT_MINSIGSTKSZ, 0);			\
> +} while (0)
>  #endif
>  
>  typedef unsigned long elf_greg_t;
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index bd2f530e5740..419ba0282806 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
>  config BINFMT_ELF_FDPIC
>  	bool "Kernel support for FDPIC ELF binaries"
>  	default y if !BINFMT_ELF
> -	depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
> +	depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENSA) && !MMU)
>  	select ELFCORE
>  	help
>  	  ELF FDPIC binaries are based on ELF, but allow the individual load

