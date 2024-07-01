Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FFDC3065A
	for <linux-um@archiver.kernel.org>; Mon,  1 Jul 2024 16:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ceWU3zU5pi+k1KsxEUoOgkJYmJvyXBQxu+KbCQ6sn6w=; b=U7Zp5czoYyTR5E5NEoiBMNvg3n
	sv3tue7HUiE0j+aS5EQJUiIVKBiEeyfeIqaKobARQ8SqxZR/2HDa9/5UjeFQSDXnAAP5vRucUoe0u
	hicT7pYR3CqIneUOzL6yv8eTplyQkW7EHA3i0yM9dKejR142xfdOP6J0nzkfDsDwUAPJ2dViaJb4s
	yFEHN9EoHKlGWPyf6nBR0tE9oeS3h6SLAwPyqOHuh31Zjp4zICTBAOtoCfV6Uv2yC7erCJrFw4VX5
	hEvimW61+VXuLbDLC9/O33T9h5F+h1pcX4Lc3k2unxotNvBu0uR4JrmqbsFw2BPATU+DiJA+P/O/u
	/8qTHpZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOJzx-000000048Ep-1hMg;
	Mon, 01 Jul 2024 16:35:25 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOJzu-000000048Du-0aDk
	for linux-um@lists.infradead.org;
	Mon, 01 Jul 2024 16:35:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ceWU3zU5pi+k1KsxEUoOgkJYmJvyXBQxu+KbCQ6sn6w=;
	t=1719851721; x=1721061321; b=w3MySXoQfz9wBgwoUJ6nGowvp6lT8XcryfslD2/y7nK28jV
	rjRS4KFGbkcvdZiZk29FuCIn4qo7WWstz7e3/Q/Slx/wH9lZcA6dMquybh0bR7qeaDzRuXOqjqeyw
	X07icfSdumafP4p3OIiflaL1xdTr1Enf+eK6ZMpG1pxMONdUCzix3XfrXPwcl/UK7LFON0qXb7qfM
	/MFp1zO9JjO9ooOumfKvrf7O4IY4nGX1JsWWHGplsLCIL3vQGqWSFsq4HWZL2ZoTi65fuEi349k6m
	LzzVXjv76I+tAFyigcgQSTbKZgPDj/ERY1jar/bynSk5uSMZ2UADbtJ9WlVcMGTg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOJzr-00000002nsS-0zYD;
	Mon, 01 Jul 2024 18:35:19 +0200
Message-ID: <c6056c4a2d1cb549ae2c0b010de912e8ff38ec8f.camel@sipsolutions.net>
Subject: Re: [PATCH v9] um: Enable preemption in UML
From: Johannes Berg <johannes@sipsolutions.net>
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: richard@nod.at
Date: Mon, 01 Jul 2024 18:35:18 +0200
In-Reply-To: <4137d6ba7d380fed13f8edc1147211b4511e8bfb.camel@sipsolutions.net>
References: <20240403062754.124752-1-anton.ivanov@cambridgegreys.com>
	 <6969757a8347ad5171a651fb668a28613b08176d.camel@sipsolutions.net>
	 <4137d6ba7d380fed13f8edc1147211b4511e8bfb.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_093522_206840_2A31F557 
X-CRM114-Status: UNSURE (   6.80  )
X-CRM114-Notice: Please train this message.
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

On Mon, 2024-07-01 at 17:56 +0200, Johannes Berg wrote:
> Hmm. I also see a ton of this:
>=20
> BUG: sleeping function called from invalid context at kernel/locking/rwse=
m.c:1525
> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 538, name: chan-sw=
itch.sh
> preempt_count: 2, expected: 0
> RCU nest depth: 0, expected: 0
> no locks held by chan-switch.sh/538.
> irq event stamp: 0
> hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> hardirqs last disabled at (0): [<000000006004b961>] copy_process+0xbb7/0x=
2790
> softirqs last  enabled at (0): [<000000006004b961>] copy_process+0xbb7/0x=
2790
> softirqs last disabled at (0): [<0000000000000000>] 0x0
> Preemption disabled at:
> [<0000000060084b04>] preempt_count_add+0x11f/0x126
> CPU: 0 PID: 538 Comm: chan-switch.sh Tainted: G        W  O       6.10.0-=
rc2 #11
> Stack:
>  714c7e40 605f2a9d 00000000 00000000
>  ffffff00 607d2edc 00000000 60db7a48
>  714c7e70 60620823 0000022c 606161d1
> Call Trace:
>  [<606161d1>] ? _printk+0x0/0x94
>  [<6002fa2f>] show_stack+0xfe/0x159
>  [<605f2a9d>] ? dump_stack_print_info+0xe1/0xf0
>  [<60620823>] dump_stack_lvl+0x77/0xbe
>  [<606161d1>] ? _printk+0x0/0x94
>  [<60084b04>] ? preempt_count_add+0x11f/0x126
>  [<60620884>] dump_stack+0x1a/0x1c
>  [<60085b82>] __might_resched+0x3b0/0x3d2
>  [<60085ca0>] __might_sleep+0xfc/0x107
>  [<60627212>] down_read+0x34/0x224
>  [<60032256>] force_flush_all+0x71/0x10d


Which is, however, addressed by my own patchset

https://patchwork.ozlabs.org/project/linux-um/list/?series=3D374492

though it doesn't apply completely cleanly any more.

johannes

