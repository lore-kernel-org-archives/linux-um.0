Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89718C624A4
	for <linux-um@archiver.kernel.org>; Thu,  3 Sep 2026 08:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sd6gEu45kL7QVkA3QJVyGVItKAS2nyT21y+/hoFhCyw=; b=VnbQSq8JYuB89WPvD+ZaMLYKNT
	jojS3giqUw0s/0UAJfGlOhgNPml8FDlnW/jL7CABIaD1fTQRFScf86GBhZSAtTwj8hNfESpHXXi9v
	HC7y6OVCrm+xHqsUBQUcI2IDX4lblG3+cLMnlQUG92HObH6XvPLZPUmkBRNhmAFzEak5HMENPNty3
	8lw8AtGw0gq/Fwl9a+hAtsxylQ6BMNOMoRS7GmSA+S5uEqb7Elnf/bqFwsMhQaxhLaNQOX9/lTJQs
	VRRmzeorVPZIte6wZkc6il+82plCZq8qBDXW7bCOZD3YuFxH+02OoSo6yAqG408407iR0LbYHpfjI
	4srioDZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x22iI-0000000GmJ5-12dj;
	Thu, 03 Sep 2026 08:22:26 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x22iH-0000000GmIa-1aoG;
	Thu, 03 Sep 2026 08:22:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CB1E1601FB;
	Thu,  3 Sep 2026 08:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF2F1F00A3A;
	Thu,  3 Sep 2026 08:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788423744;
	bh=sd6gEu45kL7QVkA3QJVyGVItKAS2nyT21y+/hoFhCyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gq9cd/CTw4krLSlM6xfxyByPn+d9o9AHDucF1BZ0uIAQoLLXP39WKotfWt+0vaOQ2
	 nzQAl7UFgXIDhuCtbKhGZ2nkN0XaOElgOmruowZVAczze7sgMMBMDKCY5/qwCsA2c0
	 VFrIYsi+TpXhPCv2Diwq2ZCkVH7vfOEZ92b/obiZ2EFvXnWRD9/RVQdBDgIWwWzXtV
	 yk2671K9lffJrRZ7mLsndIGYpdD6nZMEAsaNsvdbucN49dU6JsmXDkLhuZ9tu+FURd
	 Z0mdSO4fmgk0AE6pEWzHv5TZ915nDk5byuw9kIqq75tr/yAM6xKWlHa9jkCXEGVb+6
	 f3W8Rp2Nt6rdw==
Date: Thu, 3 Sep 2026 09:22:14 +0100
From: Will Deacon <will@kernel.org>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org, bpf@vger.kernel.org,
	paul@paul-moore.com, eparis@redhat.com, sgrubb@redhat.com,
	oleg@redhat.com, richard.henderson@linaro.org, mattst88@gmail.com,
	linmag7@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
	guoren@kernel.org, monstr@monstr.eu, tsbogend@alpha.franken.de,
	jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com, James.Bottomley@hansenpartnership.com,
	deller@gmx.de, ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, davem@davemloft.net,
	andreas@gaisler.com, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	chris@zankel.net, jcmvbkbc@gmail.com, tglx@kernel.org,
	peterz@infradead.org, luto@kernel.org
Subject: Re: [PATCH v2 04/13] arm64: pass pt_regs to audit_syscall_entry()
Message-ID: <apkuNj1paR_GO3x9@willie-the-truck>
References: <cover.1788351089.git.rrobaina@redhat.com>
 <b4ab47d2551d090520b4fa81a884b5988b9655c7.1788351089.git.rrobaina@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4ab47d2551d090520b4fa81a884b5988b9655c7.1788351089.git.rrobaina@redhat.com>
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

On Wed, Sep 02, 2026 at 11:43:37AM -0300, Ricardo Robaina wrote:
> audit_syscall_entry() now takes a pointer to pt_regs and extracts
> the syscall arguments itself via syscall_get_arguments(). Drop the
> individual argument registers from the call and pass regs instead.
> 
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  arch/arm64/kernel/ptrace.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index f743cbec1c3a..65532b2a8cd4 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -2476,8 +2476,7 @@ int syscall_trace_enter(struct pt_regs *regs)
>  	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
>  		trace_sys_enter(regs, regs->syscallno);
>  
> -	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
> -			    regs->regs[2], regs->regs[3]);
> +	audit_syscall_entry(regs->syscallno, regs);

Acked-by: Will Deacon <will@kernel.org>

Thanks for doing this.

Will

