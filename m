Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C8BC4332F
	for <linux-um@archiver.kernel.org>; Mon,  6 Nov 2023 20:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4EKIVRGhWk3Y6QdTS6MPKrHtkGrWj956h1w7olzk36E=; b=Fm8CpRIxajkg2s
	5AGR5qQPhqDq6Aeon+GkUGL2FQKFmqEf8WSZCPWUMhUr7eVQUCk8ripghUNgqp5t4e1ZLsMZ8E78y
	dBlxIxFpaYRbR6yTikAZaZ8yBvhHgEFPe938xBsY/zJ2DXH2aIVjqBXQQH1n4DzWs+dWM6HyOTaA8
	XqhiFgBkG2M5s0gQ90tbSksfuQMoq6OnzgmSeca8ENoQP7O94oIMTK3Iy7Z0Q4ajaDdf7f+/dlOza
	VJowS1bf+ecUJn+0+lyi/hVXPhabFHSJTdT16tfmlgFFbfpbFfrHDSTtybPsIQ6ZylOnmMnjZnQni
	I/WMBA++XElvt+ZSpxvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r06Lu-00HVnx-2Q;
	Mon, 06 Nov 2023 20:37:42 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r06Ls-00HVnT-25
	for linux-um@bombadil.infradead.org;
	Mon, 06 Nov 2023 20:37:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=24fhNNjdQD0DOUx/lTA36cRmpPi1TTd90ssr+WknDj0=; b=EKdU8ZleS2bu65koPHdB64Se2I
	Jxuu99q4tfa5wPek6ch8nE8AcE13jR+2AM7jUuhkg7XcxIgCj4InjSXM/cbi/BrvKR6nsRqhh9kg5
	7AhjBdRLhtIQ2LcE+at+b3mfCWQd6jpooSvG5cISila1MQM5wL9PUZ5ydkTDSrpm7H7dNraKQl1WW
	q7Y8P8hiteiNhb9oiHeuobs5MP+fe9v4PlFEIewOJhXzbJ7/xIBKoYKca8zUCRQJSC1boJB2AtCQC
	zuUJcA2p46PUA4Vwl1OV9cq5jADl58qqmpJaWKnAl0hBtpqXQ5ZdPmLvq1Ew8AFTtm/VDzWiq2mvc
	XtEtBUnQ==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r06Lo-00AmZP-2d
	for linux-um@lists.infradead.org;
	Mon, 06 Nov 2023 20:37:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=24fhNNjdQD0DOUx/lTA36cRmpPi1TTd90ssr+WknDj0=;
	t=1699303056; x=1700512656; b=BhLYz/ERHU4I4RSsHeiFbyge/JbiZeUmheyPeGoRNGYQ4bJ
	kIDccbZcWUG1hJbviWVMH4GIvcoiHmMIgQZ25zdWjT6fZXY2iEslIqngsXxXqFYve3kCaOKizPDvr
	wRAVK0cViVOBNpZldFJ7izKV6sL485u5vt2U5+blU0rJjwXFlMCiZe6g0P2igZ5DakcDDvIkd8+Ce
	zretnavrcr1jLTtTrHymtNFijkFtvd3iHYC8cOz+4oa1VzyJDsXZm52NBOQj7Gu5NtEp39R166tqq
	9iXF1pbnlNQ1uotRNnoz7T8YOEzfCv7EtFvsBVoW2wD41OkB4eIOJJcKTeRRSOJg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r06Ln-0000000Ft6w-1J6q;
	Mon, 06 Nov 2023 21:37:35 +0100
Message-ID: <cca307b39687fe423f42a24f546539f019882788.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 08/11] um: Protect accesses to the timetravel event
 list
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Beichler <benjamin.beichler@uni-rostock.de>, Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Date: Mon, 06 Nov 2023 21:37:34 +0100
In-Reply-To: <20231103-bb-timetravel-patches-v1-8-e2c68efcf664@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
	 <20231103-bb-timetravel-patches-v1-8-e2c68efcf664@uni-rostock.de>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231106_203737_309862_341C6485 
X-CRM114-Status: GOOD (  14.95  )
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
> When the timetravel ext modus is used, accessing the timetravel event
> list can be interrupted by a message on the timetravel socket in the
> SIGIO signal handler. This interruption can potentially modify the event
> list, leading to race conditions that cause deadlocks in the timetravel
> protocol or disrupt the ordered nature of the list, triggering bugs.
> 
> Previously, the normal irq-save function did not intentionally block the
> timetravel handlers. However, the additional (un)block_signals_hard
> functions do block them. Therefore, these functions have been added at
> the appropriate places to address the issue.
> 
> It's worth noting that although the functions are named as blocking,
> they primarily defer the actual execution of the SIGIO handlers until
> the unblock call. If no signal was issued, this mainly results in a
> variable assignment and a memory barrier.


Ahh ... _now_ I'm starting to understand what you meant earlier wrt.
signals and blocking and it not doing anything ...


>  	local_irq_save(flags);
> +	block_signals_hard();
>  	list_for_each_entry(tmp, &time_travel_events, list) {

Yeah, indeed, signals are interrupts and we process them at a lower
level, so here our abstraction of disabling interrupts is leaky because
the signal can still happen to modify the list due to the
time_travel_add_irq_event() ...

Note I also have a race fix for signals_blocked_pending somewhere...
Need to find time to flush out more of our patches.

But yeah, I guess this makes sense.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
