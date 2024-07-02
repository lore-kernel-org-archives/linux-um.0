Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA8EC3064D
	for <linux-um@archiver.kernel.org>; Tue,  2 Jul 2024 10:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BR31r0/GyEQg10K6LF9tVXA7ERRH71Ecsu0MnG+PXDw=; b=fzu6StUoGl3vJImHi1SvfQPgY/
	CSQnXbVmYxiJ9EU5Ph/KYRUgbmrDogFCIPlvKuUZyZd1o40n2fmxgQ32p6IkpoT59o7jiLPFeSuH3
	RVCAFNiDTr7xdm2ZT5beVWNMddZydWkKp1wqrfsllqaJa0N+yMdNxWwfBww4jiX9O71esQz6m8fz7
	5omE4S8+5F5++zAuA+8uq8uffYuVpUp1bnKBAZEuuQodvH2yckwkOlupmz0nFWFhLNY+iSNIx4pBv
	22qjd+K9wgr5nRSXL00+qLr8Wer+j8y+ghxk0QoLvw2H2hP6LDH4e7OywzVaVTzdhkZMQFAeV4mf/
	NSDXCbmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOaQZ-00000006IPJ-0Gka;
	Tue, 02 Jul 2024 10:07:59 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOaQW-00000006IOk-1LKj
	for linux-um@lists.infradead.org;
	Tue, 02 Jul 2024 10:07:58 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1sOaQS-005UKs-Jw; Tue, 02 Jul 2024 10:07:53 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1sOaQN-001drE-1O;
	Tue, 02 Jul 2024 11:07:52 +0100
Message-ID: <2c584137-211b-4746-bb6b-ebdec4c486af@cambridgegreys.com>
Date: Tue, 2 Jul 2024 11:07:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] um: Enable preemption in UML
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
References: <20240702102549.d2fcea450854.I12f5a53d80ec1e425e66ef272b1e95cb523b608e@changeid>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <20240702102549.d2fcea450854.I12f5a53d80ec1e425e66ef272b1e95cb523b608e@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_030756_415825_64AC2EDE 
X-CRM114-Status: GOOD (  18.32  )
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



On 02/07/2024 09:25, Johannes Berg wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> Since userspace state is saved in the MM process, kernel using
> FPU still doesn't really need to do anything, so this really
> is as simple as enabling preemption. The irq critical section
> in sigio_handler() needs preempt_disable()/preempt_enable().
> 
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> [vastly simplify, fix x86/um Makefile, rewrite commit message]
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> v10:
>   - rebase on top of various other patchsets, including Benjamin's
>     page table updates: https://patchwork.ozlabs.org/project/linux-um/list/?series=408104
>   - fix x86/um Makefile
>   - remove FPU save/restore code since it's not needed
> ---
>   arch/um/Kconfig      | 2 +-
>   arch/um/kernel/irq.c | 2 ++
>   arch/x86/um/Makefile | 1 -
>   3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 1faefc0a18ea..dca84fd6d00a 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -11,7 +11,7 @@ config UML
>   	select ARCH_HAS_KCOV
>   	select ARCH_HAS_STRNCPY_FROM_USER
>   	select ARCH_HAS_STRNLEN_USER
> -	select ARCH_NO_PREEMPT
> +	select ARCH_NO_PREEMPT_DYNAMIC
>   	select HAVE_ARCH_AUDITSYSCALL
>   	select HAVE_ARCH_KASAN if X86_64
>   	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
> diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
> index ceda4bd2e5ed..534e91797f89 100644
> --- a/arch/um/kernel/irq.c
> +++ b/arch/um/kernel/irq.c
> @@ -238,7 +238,9 @@ static void _sigio_handler(struct uml_pt_regs *regs,
>   
>   void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
>   {
> +	preempt_disable();
>   	_sigio_handler(regs, irqs_suspended);
> +	preempt_enable();
>   }
>   
>   static struct irq_entry *get_irq_entry_by_fd(int fd)
> diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
> index 17b85209c43d..36e67fc97c22 100644
> --- a/arch/x86/um/Makefile
> +++ b/arch/x86/um/Makefile
> @@ -31,7 +31,6 @@ obj-y += syscalls_64.o vdso/
>   
>   subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o \
>   	../lib/memmove_64.o ../lib/memset_64.o
> -subarch-$(CONFIG_PREEMPTION) += ../entry/thunk_64.o
>   
>   endif
>   

Is that all we have left? I lost track of your mm patches and they do not apply cleanly to master at present.

Otherwise, the fpu-less on top of the older mm works fine for me. Testing it at the moment.

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

