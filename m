Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BECDC4332F
	for <linux-um@archiver.kernel.org>; Sun, 16 Oct 2022 17:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jE+xSHPgA+kNG/yJvI18cZL9VIm3nBiTgV1R0YxNIq0=; b=mkAZydxQg1w5YI
	jrb58u3Y/Q+kmhSyy0xajAbJMZIjZ9cC4tF2J7lfDB2kYfVo6iJovcuuUUwgbrwaXdurjC20TgXz3
	1vEXOH8guWRh3QJobKjvksxke+DIlXBZwsUtYc8KI3xja6i5JUEzGvtKfD7ZYC7z9pQUA76Co2+n7
	+/M2tcaCyCZPulQWxf8JrOGdte28rSJnrW/5a5bH8UhF/B8jlxz4GzMaznzIfgNsHKvLq3pU8gYzY
	SNQVXFhaz57sA2e9NmevQ7fC94xuCLo7jg32yjESp3P3LyTDPwjH3zyUQDjRMsi4nIMrqG/Dl7j0t
	3Occ1ZHsBD4ZpqfXEn2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ok7or-002wBo-PB; Sun, 16 Oct 2022 17:53:01 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ok7op-002w9P-7R
	for linux-um@lists.infradead.org; Sun, 16 Oct 2022 17:53:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/QSZlP10x6sKv7h8Gtd9mwjASy+NA/rKPLXm4tqQL28=;
	t=1665942776; x=1667152376; b=S0XBVeIKKtkBh3QLc97sY7UA5QsLy9kFHjlhRGVgsHLAk3Z
	qSqoj8kGcH84cfgYhwrhfT9YQiLVXA9wTA9NTCty6nniovG+Jfla5SDWzqcgaz+brYWqJ9kkn9z+r
	mDiKLwinj4+7i033ZTOVQ2bAKfDNZIUwySiXip1vLms4E6Y0IudBPYLoMF/WS0hHuyYQjoS7nh7hp
	VtPVQoe3OThyLkFtTwZXWeZAjinByGWj1rhCF90PcodHvR07200k8nUEhrz6O+NlRFRJ12xy+Fyds
	5qEStx0UAlAuZZgEgxh7Wk39Tk1qf81rAS77JKCRbIOSIKP7msVWWckI17btLaVQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ok7of-008UHd-2S;
	Sun, 16 Oct 2022 19:52:49 +0200
Message-ID: <f0b1f33108fec467689b52568b5ad7c906eb5435.camel@sipsolutions.net>
Subject: Re: [PATCH] um: protect find_task_by_pid_ns() with rcu lock
From: Johannes Berg <johannes@sipsolutions.net>
To: Dawei Li <set_pte_at@outlook.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Sun, 16 Oct 2022 19:52:48 +0200
In-Reply-To: <TYCP286MB2323CA02DF3A741B5F58B297CA269@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
References: 	<TYCP286MB2323CA02DF3A741B5F58B297CA269@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221016_105259_287375_F55F8974 
X-CRM114-Status: GOOD (  14.27  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Sun, 2022-10-16 at 23:10 +0800, Dawei Li wrote:
> find_task_by_pid_ns() is safe if and only if it's under protection
> from rcu read lock, implements the protection.
> 
> base-commit: 193cb8372424184dde28088a4230a5fed0afb0ad
> 
> Signed-off-by: Dawei Li <set_pte_at@outlook.com>
> ---
>  arch/um/drivers/mconsole_kern.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
> index 5026e7b9adfe..6b80e766ae80 100644
> --- a/arch/um/drivers/mconsole_kern.c
> +++ b/arch/um/drivers/mconsole_kern.c
> @@ -683,7 +683,10 @@ void mconsole_stack(struct mc_request *req)
>  		return;
>  	}
>  
> +	rcu_read_lock();
>  	to = find_task_by_pid_ns(pid_requested, &init_pid_ns);
> +	rcu_read_unlock();
> +
>  	if ((to == NULL) || (pid_requested == 0)) {
>  		mconsole_reply(req, "Couldn't find that pid", 1, 0);
>  		return;

This can't be right - the 'to' pointer is used later in the code (not in
the existing context), so the protection, if needed, would have to
include the later "with_console()" call?

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
