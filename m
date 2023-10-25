Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B79C07545
	for <linux-um@archiver.kernel.org>; Wed, 25 Oct 2023 19:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NDUbwLC69HhvR9zYKOYdq7OIInbcBeF8+bkgsyZhtJc=; b=1DbArpghR++Vt0
	yxvnobpthwN8mdeJCOAHX5IqfY5HwJMqEmpmKURnzQNwwMpwrZ1S2LvKAm3kTPO6gXc8f0eocAubR
	7RyRzhmaKoYVlK4jf1plnTxwYmQQyAZ19FEw5rAGdUMl70j+URenb+R4k37mWoOeeID2x4sch9pw7
	sgHQt3AqmSZzo67g7RFalwzJpX3tJ0ZK4Aa9S2IfQqdN5w0D131NImXc8HZdQmdLCKxQjluY8rLRo
	swAT+pjibOV4eBHRKGpvs+JZFKiZIaWNtojk3q3jsPyysJRzbHgmPuQ9D/hQ8A8wowsa/IDdqu9jR
	S6q0lIJHInSoRFD4urGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvjv1-00CzR4-0y;
	Wed, 25 Oct 2023 19:51:55 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvjuy-00CzPa-1s
	for linux-um@lists.infradead.org;
	Wed, 25 Oct 2023 19:51:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rBV0nSZdE0vCEbKk3Yf9TUFnrefWidkNWcmqpKnwJq8=;
	t=1698263508; x=1699473108; b=cKnheZltyHYlbXpTY6bpbcyj8OR6t2VwPmSb4KH9y5QdSPq
	PmdBMLjlvqtxgTYVykyB3i9fbGnKX77ZcOyeAnyPDxm9gWYTNoJAI+X8l3VTu9eJMhOBpBvmrHjpt
	H9p6Q+HoW1DrqgSwgumUyjLoMrzK5VdQkkqbTqnREEgYOCjwMzyp86aiPXZ7gKwEV3+uSTaVUV+4r
	S6TU2NSyDM7Jrr8kgNPnFPk26Yb/eOi+SJw0wL63cLklFpvgYuZKuKunAgNJZ88hj6evGVx4YPOAm
	fbYvw/ryLKOkNEmo+iEIQ1M+4h/OJjdDeqVqhynFi7+9+SP45uEm/Z3ExpOxnjRA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qvjus-00000002hQU-1l3m;
	Wed, 25 Oct 2023 21:51:46 +0200
Message-ID: <a2f6e0cc8e498f72dfe1fcd5f2233ada8548a4d1.camel@sipsolutions.net>
Subject: Re: [PATCH] um: time-travel: fix time going backwards
From: Johannes Berg <johannes@sipsolutions.net>
To: Vincent Whitchurch <Vincent.Whitchurch@axis.com>, 
	"anton.ivanov@cambridgegreys.com"
	 <anton.ivanov@cambridgegreys.com>, "richard@nod.at" <richard@nod.at>
Cc: "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, kernel <kernel@axis.com>
Date: Wed, 25 Oct 2023 21:51:45 +0200
In-Reply-To: <cc7d340e4e06e42cd67b46bfa95da6129b0010cb.camel@axis.com>
References: <20231020-uml-time-backwards-v1-1-90b776fc6dfd@axis.com>
	 <4a75c40636be267163dc30b5a6a2442089628e57.camel@axis.com>
	 <4dbed8896c94a347dcb58b3a83792c52fdc1c04a.camel@sipsolutions.net>
	 <cc7d340e4e06e42cd67b46bfa95da6129b0010cb.camel@axis.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231025_125152_618188_E19290AE 
X-CRM114-Status: GOOD (  12.20  )
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

On Wed, 2023-10-25 at 11:55 +0000, Vincent Whitchurch wrote:
> On Mon, 2023-10-23 at 09:33 +0200, Johannes Berg wrote:
> > Do you have a specific workload that tends to reproduce this?
> 
> I've been seeing it when running roadtest, but it's easily reproducible
> without that by using the attached config and the following program as
> init.
> 
>   cp repro.config .config
>   make ARCH=um olddefconfig all
>   gcc -Wall -static -o repro repro.c
>   ./linux time-travel init=$PWD/repro rootfstype=hostfs
> 
> With the above commands I usually see the panic in a few seconds.  This
> is on an unmodified v6.6-rc7.
> 

Yes, I can reproduce it with your test, thanks. I'm on 6.4-rc still for
$reasons (6.5 we skipped during vacations, and 6.6 EEVDF scheduler broke
everything for hwsim tests in hostap), but this code didn't really
change anyway.

I'll poke at this.

(And I'm still amazed that anyone other than me even uses this stuff :P)

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
