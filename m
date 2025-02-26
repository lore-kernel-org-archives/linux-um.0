Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77C6C021B8
	for <linux-um@archiver.kernel.org>; Wed, 26 Feb 2025 13:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ffUtlDgn+1104ARBjRrukGIDGUi8geC9/KGM3iC88r8=; b=s2V0ZoVOTgvyYz0FPl1ehaGYnQ
	jS380tLg6LBcqUsR3ntIUx1pUZY9h/jV6Kt+tlto7g+o858DVdfZwZwBD1XOULeC4FxTDmaz8aatk
	SHpcO4RlXz6ANFJ6g66jYWtV7dkXl7HVw9Lek0Cx3DmzbUk5RgsEEeizReBY5W3JzcvcdYKrHn8tD
	3ES03ktpgT+r8MmRQYeCxCweNOce4Ozq4cECwFtvLF1uAX0mhOdYMboIkSBsTzuWtut1c5OC6+45E
	RmM/lQtMHaUO744VgR3MZg1Sqy/eMZiSLiFIwC8EyaNvOhNV2IFyYCAfF/0EWagA4t77+n7ygHD2Y
	rru6VyJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnHSo-00000003v9F-23yI;
	Wed, 26 Feb 2025 13:28:38 +0000
Received: from tor.source.kernel.org ([2600:3c04::f03c:95ff:fe5e:7468])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnH9h-00000003mwE-2y3h
	for linux-um@lists.infradead.org;
	Wed, 26 Feb 2025 13:08:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 56AC56121C;
	Wed, 26 Feb 2025 13:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FF9C4CED6;
	Wed, 26 Feb 2025 13:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740575332;
	bh=nTMS76C2pWow6+Hfgqh3RiybiXmTOBQMbdZsndNGZwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ME+RHoILBMzVIp4Bd4JiiRk4Zlv7nlYJbwH5NzZqAcRGuI6rJKgUlU1llm7Vtw3Tf
	 4ebQiXFU0kNxnVHeQgCvfouU9KvoefwQA2t/HfFgGDKgKSdVFdpofwLTAPXkXRvMUH
	 SH2P2YslThNNKFayVjaBX9SX5grXSi+2YFekWeerRDXyUTszrOm4wNHRJSgeBVv/+5
	 cMspK3A85HxXWQrUjM4LwqB4ZlOMkauTW9nyVFPdjNYMnRhho5h4aC5MtTiPa7sbPA
	 84fYFnfO5fN8F5jpzVYHhLZkqznILr1ANJCJmDnK+veGUA50chEcnihUHeQRC9PZuN
	 ZC1MjBx4fMNBQ==
Date: Wed, 26 Feb 2025 14:08:37 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-arch@vger.kernel.org, linux-um@lists.infradead.org,
	x86@kernel.org, briannorris@chromium.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH 3/3] x86: avoid copying dynamic FP state from init_task
Message-ID: <Z78SVdv5YKie-Mcp@gmail.com>
References: <20241217202745.1402932-1-benjamin@sipsolutions.net>
 <20241217202745.1402932-4-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217202745.1402932-4-benjamin@sipsolutions.net>
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


* Benjamin Berg <benjamin@sipsolutions.net> wrote:

> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> The init_task instance of struct task_struct is statically allocated and
> may not contain the full FP state for userspace. As such, limit the copy
> to the valid area of init_task and fill the rest with zero.
> 
> Note that the FP state is only needed for userspace, and as such it is
> entirely reasonable for init_task to not contain parts of it.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> Fixes: 5aaeb5c01c5b ("x86/fpu, sched: Introduce CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT and use it on x86")
> ---
>  arch/x86/kernel/process.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index f63f8fd00a91..1be45fe70cad 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -92,7 +92,15 @@ EXPORT_PER_CPU_SYMBOL_GPL(__tss_limit_invalid);
>   */
>  int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>  {
> -	memcpy(dst, src, arch_task_struct_size);
> +	/* init_task is not dynamically sized (incomplete FPU state) */
> +	if (unlikely(src == &init_task)) {
> +		memcpy(dst, src, sizeof(init_task));
> +		memset((void *)dst + sizeof(init_task), 0,
> +		       arch_task_struct_size - sizeof(init_task));
> +	} else {
> +		memcpy(dst, src, arch_task_struct_size);

Note that this patch, while it still applies cleanly, crashes/hangs the 
x86-64 defconfig kernel bootup in the early boot phase in a KVM guest 
bootup.

Thanks,

	Ingo

