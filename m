Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70827C2BA15
	for <linux-um@archiver.kernel.org>; Mon, 17 Jun 2024 13:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cpEnzyvYl+YaVf9FbH6u/ZTNCFgglA8tqPD5TzNXa4g=; b=my1Uq1vKheIR+9eTiHwF3zzXfx
	dxKXc9tAHoGQjXXjnXDYI5DWqd7U582yYoL4dDn09gs6sd2+fc+fZbIQMG0hrv74ArcMFyBEwgpmG
	IVABvJgEMwdR8na/mleO9EnrgTjrWv/aU/HNrlcsGR8Zp3I2SDZbL6Eda1ZNd8h0O6vHOw61XN5o4
	511i+99AVFEy73Yh3i0RwnMCfS2J+eb8BtgIMonnrJabQZe8yzyF5AKPJgzultYhdchO72+Sfa/dj
	WGurN97LWPhJE0aLxVrluMtoyfIjqVBQb3EXNRkgZQGllJeKHyDhFAAbVaD4QAW0kOQBh1e3UP7qQ
	Ka33/3xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJCrs-0000000B1eP-3XiV;
	Mon, 17 Jun 2024 13:57:56 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJCrk-0000000B1ay-3upX
	for linux-um@lists.infradead.org;
	Mon, 17 Jun 2024 13:57:54 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cpEnzyvYl+YaVf9FbH6u/ZTNCFgglA8tqPD5TzNXa4g=;
	b=IRXQAY8i5u5H3G0pEHAgIlBooeneGbOUR0SHLVdD7vlW1S3L2eB9ph9FXzRVVrKWnZTE+G
	fhCunBPiXPk8ejBEHBEQ2uq0dJN7FXf04PifvhPZsK9B7qMHek7ABXDl8dg4RDbG3xsWKq
	h/eea0gbYTTFW7vlcIFBoUSlS0YRQa0CdOaWYO8ddcZHhG0USmcgDr3JIsMAbGs31d7E90
	vPSwYSgFqCxom/DKvX6jgmLY8n83UPV0EgbSsjd8fKjOi/X8V2xy8H4ACUpmDVWIvR66pJ
	NSbsN6Xu5k8ggMMtWVlfqwEPcnGODO+L0vY48V26wVG/Aqn6Z9Ne8WkqeNhsQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cpEnzyvYl+YaVf9FbH6u/ZTNCFgglA8tqPD5TzNXa4g=;
	b=HWmw9Z71jW4Ide4RbHzhgnJE9N2UmiLH3ab9yWM7XZcnwM82VMVdofO/Chd7raYj5Oo0Ou
	iOlD+/JFzznXBoBg==
To: Herve Codina <herve.codina@bootlin.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Herve Codina <herve.codina@bootlin.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Richard Weinberger <richard@nod.at>, Anton
 Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-um@lists.infradead.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 00/23] Introduce irq_domain_instanciate()
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
Date: Mon, 17 Jun 2024 15:57:44 +0200
Message-ID: <87msnju0x3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240617_065749_160914_1342AEE1 
X-CRM114-Status: GOOD (  17.51  )
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

Herve!

On Fri, Jun 14 2024 at 19:32, Herve Codina wrote:
> During the review, it was asked to rework the irq domain modification in
> order to avoid more wrappers and a new irq_domain_instanciate() function
> was proposed [2].
>
> Also a patch [3] sent by Maitti Vaittinen can benefit of this new
> irq_domain_instanciate() function. Even if Maitti's use case is not
> handle yet in this series, it should not be a big deal add support for
> it on top of this current series.
>
> So, this current series introduces this new irq_domain_instanciate()
> function and migrate existing wrappers and functions to this new
> function (patches 1 to 20).
>
> It then introduces the first driver that uses directly this new function
> with the init()/exit() hooks set: the Microchip LAN966x OIC driver
> (patches 21 to 23).
>
> Existing irqchip drivers are not converted yet to use this new API
> function in the same way as the LAN966x OIC driver does.
> I prefer to have this series accepted first to avoid doing and re-doing
> several times the same modifications on existing drivers depending on
> changes requested on this current series review.

I'm truly impressed by the quality of this patch set.

The only nitpicks I found was the formatting of the struct
initializers. I fixed them up for you this time. Keep up the good work!

The result can be found at:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core

Matti, can you please build your extensions on top of that?

Thanks,

        tglx


