Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174BAEB64DA
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 20:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j0c/bIcX71ShFzWq7nC1diCeyMGhxCGSI9Dvda3u7G0=; b=2nnUCYNmsPIoQ2
	5U9pJmwLGxxrT3Z0xDVezq6CaiDi+dO5uj5wXTrbJZkFj2bG2l36VL1tcwp/X7ItoLXEh3Bgf/jgF
	vVJ+0ozAtDBdkdYXbYj6jvjaB3PfdeK59Fj6JYV+z0qaKA/+mARK0OyFnwOxXD+2l/BBM9homoBBH
	G8OdYUJiq/qqA1rgjgQn+jmIb44P3pp7r96nQDm5vau4kNA1AlvecQz6myTHRU5g7txwSIje4iqlN
	rmNzTMlnqlGxV91668H41Qdq5Zs+LLYvmWr+058alyg3z5w+PK1ZCxTdCkXmi+KuMobm1IAmmtvM2
	znWfifC6GGtZ8b8b+CVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCQgx-001dKp-2D;
	Thu, 22 Jun 2023 20:14:07 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCQgv-001dJk-0a
	for linux-um@lists.infradead.org;
	Thu, 22 Jun 2023 20:14:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8PBCgS40c/IcomC8Z+WWenoy8idU3whdg1nPPRpmmTU=;
	t=1687464841; x=1688674441; b=H9Sank5CkmjkAq0SmYdefgmsUfG2fhv3zRPWHYXpjD2dof8
	VJi5edpc2v2KoIfqCxSwcO+voqWzJABinruzVIO4msMGHR/WOpE7x1glySPoL8wT7SgkoRjrKxAv2
	MgKgXI4MwD1hptb8+YJZUtZhZ18av5jApAKaptVorSZBTcfRrKbQip6ks7fqAaD0JwFoM1t7UwvKx
	YbZ6It3Qv75k4nFpQV3AyNAmEQJZ9q5RpkafBImAZ7NZEj3yPnD1S9BVxsH/n0HFQcnqam6X47s2P
	+lgwW3x0EWPdDZ9uGTSXRP+TpgCfebCCU0Hbx9aevH2Rgyfno5aAVSMibtLPOSHw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1qCQgn-00EtWV-2B;
	Thu, 22 Jun 2023 22:13:57 +0200
Message-ID: <69707b721698594f96899c050871bcbb3594a9a1.camel@sipsolutions.net>
Subject: Re: UML for arm64
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring
 <robh@kernel.org>,  Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Date: Thu, 22 Jun 2023 22:13:56 +0200
In-Reply-To: <dc5704a5d452f7432313170ed900975b2b72354f.camel@sipsolutions.net>
References: <20230622192247.GA2278576-robh@kernel.org>
	 <dc5704a5d452f7432313170ed900975b2b72354f.camel@sipsolutions.net>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_131405_234153_64748575 
X-CRM114-Status: GOOD (  14.73  )
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

On Thu, 2023-06-22 at 21:41 +0200, Johannes Berg wrote:
> On Thu, 2023-06-22 at 13:22 -0600, Rob Herring wrote:
> > I'm interested in getting UML working on Arm. Is anyone aware of any 
> > efforts to do this already?
> 
> Not me ... But yeah, agree that it seems likely to require some
> refactoring, even if _some_ degree of attempts were made to keep arch-
> specific things there ...
> 
> There might be a ton of arch-specific things in the ptrace code too

At least a lot of the register handling, but that will always be
somewhat architecture specific.

> ... , so perhaps it'd be easier to start with the seccomp-based model:
> 
> https://patchwork.ozlabs.org/project/linux-um/list/?series=329466
> 
> But that's not really done yet either.

Yes, though I have quite some updates locally that solve the security
issues (i.e. prevent host syscalls from userspace). So, it does need
rebasing and I am sure bugfixes, but I think it is getting into a
pretty good shape overall.

Either way, the old patchset will give you a good idea about how it all
works, the changes are mostly in the details. I am happy to push out a
new version sooner rather than later if it might help with any efforts
on your side.

Benjamin

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
