Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3C5C4332F
	for <linux-um@archiver.kernel.org>; Mon,  6 Nov 2023 20:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TK1PYo+qxvBQKdjtBX1uy2TUmJpA3h9nVdVMrI5NBaw=; b=IFiK62L/jkYKY0
	43Bmp6EMwZkLRbCNWI9GGxzkbzGkTURqrn3aynySkgsJwu7IBEIPIvQANJrfe741VpEXMXmmrmsa9
	6fRQ+6VRTYaFTVCRHtCRNKZb7vFj08zFzAyyYO5mPuC06uqLWEGhPA5etqKLdT7LOD/8ft9/gbqfl
	TbD1X9s6lyS8AkkmgKwQvi0YdihBdtppvz9AxXrpTsh27/GVfYE5AcSaxZp2xWXtn9Y1d/eKnbO8v
	TM6t9QG0NwKsMigRnJBirPPv6a/5j3QAAuGvGNn2LwuH1tuKlNTZzLWskOgQwSillDUybvyvaZk3B
	VXsHv1HXoka4b0XVYMuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r06ZS-00HXdV-0V;
	Mon, 06 Nov 2023 20:51:42 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r06ZP-00HXcq-0v
	for linux-um@lists.infradead.org;
	Mon, 06 Nov 2023 20:51:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uLK65ceJK3bCckdX9aDs7YHY2njiZi0dv1icvHhYEqo=;
	t=1699303898; x=1700513498; b=czDN0Rq68l4MGJMd24E6Sey8kFR4atlRFoJ8pWzJ/VkGHZo
	k9nINHNurnZd6Rb0kvmE3xieVceJwOmxwIKHNZ68XXPAbJCvG1c4Kbqi3lhotYKDxX5ub60b9fgqy
	lDwve/UAQb5AEuFyoGMbUOaLHxXIQeygmQ0Lk6gLB8yswXJAZ+NmWPseT4pMz9wIRYStuGZTWRFlP
	1/d6uq0UAxT2BLRW4AFkAWEgaJaPcYHEH4AlGhkafEWVaucDABi+6LGqw6po59v9CjkI/pWlLQfIq
	/luBUqO2hOGbDZ4WLzaES2j8sTCn+V6iIf2qC5FzY0qjA7SnbPLK/heArXUprFDw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r06ZM-0000000FtXf-3ETF;
	Mon, 06 Nov 2023 21:51:37 +0100
Message-ID: <7daf6651289bd6b48e069f4d0dd7751244177a44.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 10/11] um: Delay timer_read only in possible busy
 loops in TT-mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Beichler <benjamin.beichler@uni-rostock.de>, Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Date: Mon, 06 Nov 2023 21:51:35 +0100
In-Reply-To: <20231103-bb-timetravel-patches-v1-10-e2c68efcf664@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
	 <20231103-bb-timetravel-patches-v1-10-e2c68efcf664@uni-rostock.de>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231106_125139_320626_006B1F7C 
X-CRM114-Status: GOOD (  12.15  )
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

On Fri, 2023-11-03 at 16:41 +0000, Benjamin Beichler wrote:
> This slows down external TT-mode as more simulation roundtrips are
> required, and it unnecessarily affects the determinism and accuracy of
> the simulation.

I still don't think this is really true, it doesn't really affect
determinism? It makes it ... different, sure, but not non-deterministic?



> +static const int suspicious_busy_loop_syscalls[] = {
> +	36, //sys_getitimer
> +	96, //sys_gettimeofday
> +	201, //sys_time
> +	224, //sys_timer_gettime
> +	228, //sys_clock_gettime
> +	287, //sys_timerfd_gettime
> +};

That's kind of awful. Surely we can use __NR_timer_gettime etc. here at
least?

> +static bool suspicious_busy_loop(void)
> +{
> +	int i;
> +	int syscall = syscall_get_nr(current, task_pt_regs(current));
> +
> +	for (i = 0; i < ARRAY_SIZE(suspicious_busy_loop_syscalls); i++) {
> +		if (suspicious_busy_loop_syscalls[i] == syscall)
> +			return true;
> +	}

Might also be faster to have a bitmap? But ... also kind of awkward I
guess.

I dunno. I'm not even sure what you're trying to achieve - apart from
"determinism" which seems odd or even wrong, and speed, which is
probably easier done with a better free-until and the shared memory
calendar we have been working on.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
