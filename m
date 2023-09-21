Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458EEE706FC
	for <linux-um@archiver.kernel.org>; Thu, 21 Sep 2023 09:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q130wZ+GjDSJwBZll08JQabQloZVougC5E4n1duP3L4=; b=CXmwLpR6FkWjRJ
	N8EWq3UGCvbTmO+sAkWFNFJOTIZboxbFGaiB+rhjhmM+iGXfte/f4ZxqDCTDn9zDAVqEdtRQ2dp/g
	0ENMt8PXtvospVDdLwkmx/BONfkekkVM5/ifr+xhLMtnAqdjjGECGQpXMe4NUdhFLEG24ECNHbVXw
	6dw3aZNW80q7mqDFcwPm6jw/UVQbDo0F7ac61mPNCEQhAHmHA+NsUmP/rz0x5tSWUdjq3zdJzUfsx
	XcQhrH51xry5zXkmZYL3zjBW7OEzx6ruQMpqn/tsm5vr2gQwSn3l1bnTB5tlbTNiH+JuMCyus4zyt
	XjRQbUq6yWrBm3gHTC9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjG6V-005bpe-1E;
	Thu, 21 Sep 2023 09:36:11 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjG6O-005bo6-2n
	for linux-um@lists.infradead.org;
	Thu, 21 Sep 2023 09:36:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DB+5IwEwH7JFxV81kGxR0Qtl5i7N1YWDxdS5cxfGpGo=;
	t=1695288961; x=1696498561; b=vXyBjux7wllX+UiY6KvrKHTt+uCO57doq3LNL7BtgmSxcBs
	fNkYVCVbE2XuLVul8hFNyUwZ6OuNcB7X58JwkcjCWmGeIT6tya3ccYOA/XBO5EERlVnM8eNQfNI9V
	QdDJRO05aT34Bn0EWVxQkFZ0Ih76AEQZNDlOSpI/jDlByf6Rni2X3J0rP9wVIwTVZeSiZGXuz77uE
	Lf1CQqHGqh5nYIT4Xl+GyeVHibMyy1ua0uKMfu6u3rZPNAeIuqPxwzcPQwA0sGu9aNkB4k4aRKYXP
	D1tHX5REwMeQhyX5d+pBM5KGben7ygSrT0razy6fL8fgx9prIrc8mPidlJSLkCIw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjG6I-00D6YO-1u;
	Thu, 21 Sep 2023 11:35:58 +0200
Message-ID: <15376711a221bbeaf45a278f56b944dcc9b6f2cc.camel@sipsolutions.net>
Subject: Re: [PATCH v2] um: Enable preemption in UML
From: Johannes Berg <johannes@sipsolutions.net>
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: richard@nod.at
Date: Thu, 21 Sep 2023 11:35:57 +0200
In-Reply-To: <20230921092836.190291-1-anton.ivanov@cambridgegreys.com>
References: <20230921092836.190291-1-anton.ivanov@cambridgegreys.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_023605_186180_915492D9 
X-CRM114-Status: GOOD (  13.30  )
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

Hi,

Haven't chimed in here before, but thanks for looking at this! I
actually really wanted at least the things you get for debug from this
in the past, so much appreciated.

I think I actually tried a simpler approach and it kind of even worked,
but my userspace likely has very little FPU usage.


> +/* UML knows about 387 features up to and including AVX512, tile, etc are not yet
> + * supported.
> + */

Do you ensure that somehow? Warn if it's there at least? I may have
missed that.

Or is it just for the saving? But what if you don't save enough and the
host CPU has more?


> +void kernel_fpu_begin(void)
> +{
> +#if defined(PREEMPT) || defined(PREEMPT_VOLUNTRARY)

maybe leave it as an inline in case it'd be empty, i.e. neither of these
are defined?

> +	preempt_disable();
> +
> +	WARN_ON(this_cpu_read(in_kernel_fpu));
> +
> +	this_cpu_write(in_kernel_fpu, true);
> +
> +#ifdef CONFIG_64BIT
> +	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVEOPT)))
> +		__builtin_ia32_xsaveopt64(&current->thread.fpu, KNOWN_387_FEATURES);
> +	else {
> +		if (cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE))
> +			__builtin_ia32_xsave64(&current->thread.fpu, KNOWN_387_FEATURES);
> +		else
> +			__builtin_ia32_fxsave64(&current->thread.fpu);
> +	}

nit: you could make all of these else if chains, and avoid the braces:

if (likely(...))
	...
else if (cpu_has(...))
	...
else
	...


> +void kernel_fpu_end(void)

same comments as above apply here.


>  void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
>  {
> +	preempt_disable();
>  	_sigio_handler(regs, irqs_suspended);
> +	preempt_enable();
> 

I may have to look at those time-travel bits here :)

Thanks,
johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
