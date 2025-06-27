Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189EDC7EE2A
	for <linux-um@archiver.kernel.org>; Fri, 27 Jun 2025 04:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HEmRdnJW0NGZ1D2gRilBAOwDdv3atRmkBNztAjze2FE=; b=fQHLx5S96GwOWC5DnDXVGIWZOY
	Vov3CIWM0qaseBo8eWDiHUFPEP5EA4/ZIVIxVoWtwgy9AkkKos1Qf1hSHZdfYxaDRzMOvnmC6JV/Z
	aKQhC/HhLbQuozrxKN6ldfX0lNFRxfsNTg/ro8bH/gnkgJBtI8xHV2uNU6YGnPdGsDD9yBF4y9x1U
	MTLZV+X81mPaCe+seNxug2aXgQlC2QcEcnoIQFNpIDLk4gKAFqIoYj3X5cTCjOjf5IhxEiYAAlv/6
	eHWeshTs/a752FLIJd81Y1x9Z32q9+WG+voeWtRli8SO/COIg/7wFTlQYHnX3jdy+ycg1tDzaMrgD
	bdst4fLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV0mV-0000000DXzM-2ocN;
	Fri, 27 Jun 2025 04:33:43 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV0mS-0000000DXyh-1glE
	for linux-um@lists.infradead.org;
	Fri, 27 Jun 2025 04:33:41 +0000
Date: Fri, 27 Jun 2025 06:33:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750998818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HEmRdnJW0NGZ1D2gRilBAOwDdv3atRmkBNztAjze2FE=;
	b=CjUJaJMOAk9p0CjKNS4POUpyoA/oJ4ZXac007jYNKLoHih9TOtVHkksJ4ADayX1lHkWut/
	KATJlEXlHYXSlGQ+pDRLBykqHmKIrjyNOQnip4DmZZhszyaCgT94jA8Zbxx4p3WRNKHFhP
	ircE4dtvzjxg2K/GFFVHx46sKpATOfmMiFwJyoaRAnsd2C6jaIZFdaVFa217PgUbaze1a6
	Enm7n96NZv/Maj0esjK+TdxCevxcetHOXA19jMN6ywfUR6k69Nadi8nEl/AK1vwxE6BPMm
	ZxoKlpmoM58GThc39aUVghqy/yrhCRC97Bl0TCBQW8MqxUAM1xNa/pVRobRiEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750998818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HEmRdnJW0NGZ1D2gRilBAOwDdv3atRmkBNztAjze2FE=;
	b=LuQv5JUBFr+SMnz9ofvM+E8MpjdvzksvogUhOmyM/zGqGbEAidlDsgnGWtx+5qgJS0N+IW
	dj6SNumlbwcb9ODw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: kunit-dev@googlegroups.com, linux-um@lists.infradead.org, 
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [RFC 0/2] Experimental kunit test for signal context handling
Message-ID: <20250627062337-a67a262d-5957-42cf-8bc0-69388f4ae078@linutronix.de>
References: <20250626195714.2123694-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626195714.2123694-1-benjamin@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_213340_581161_5FBD691A 
X-CRM114-Status: GOOD (  23.67  )
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

Hi,

On Thu, Jun 26, 2025 at 09:57:12PM +0200, Benjamin Berg wrote:
> so I saw the UAPI testing framework patches and wondered whether I could
> hack up a kunit test for userspace signal mcontext handling. I already
> had some code, but never knew where to include it. Having it as a kunit
> test in this way seems nice as it makes running the test really simple.

Nice to hear that you find it useful.

> This is a very rough attempt with an extra patch to add sigaction
> support as that is needed by the test.
> 
> Note that this type of test could possibly be shared with the x86
> architecture (though UM does not support all features).

Can the expected feature detection be performed at runtime?
If so I would write the test as x86 kselftest in tools/testing/kselftests/x86/
and then also hook it up for kunit on UML and x86.
This gives you the advantages of all worlds.

For an example see [0]. That is still based on an old version of the framework,
so can't be used as-is. But you should get the idea.

> And, a 64 bit build might even want to include a second 32 bit binary.

Indeed, for compat binaries we'll probably want some sort of common pattern.
Unfortunately it's not as easy as building a second binary when CONFIG_COMPAT=y,
as some architectures have more than 2 supported ABIs. MIPS for example or x86_64
when counting x32.
Or maybe we can just pretend that those don't matter.
Something we can work on when the first series has been merged.

> So, I suppose
> one would ideally want the test to be in arch/x86/tests, with some way
> to pick up it up in arch/x86/um/tests.
> 
> Does this seem sensible in general?

It does.

> Benjamin

[0] https://git.kernel.org/pub/scm/linux/kernel/git/thomas.weissschuh/linux.git/commit/?h=kunit-kselftests-integration&id=14bf93f09eaa328a18e9190f46fa4ee697378617

> 
> Benjamin Berg (2):
>   tools/nolibc: add sigaction()
>   um: add a mcontext FP register handling test
> 
>  arch/x86/um/Makefile                     |   2 +
>  arch/x86/um/tests/Makefile               |  12 +++
>  arch/x86/um/tests/registers.c            |  22 +++++
>  arch/x86/um/tests/test-fp-save-restore.c | 118 +++++++++++++++++++++++
>  tools/include/nolibc/nolibc.h            |   3 +
>  tools/include/nolibc/signal.h            |  34 +++++++
>  6 files changed, 191 insertions(+)
>  create mode 100644 arch/x86/um/tests/Makefile
>  create mode 100644 arch/x86/um/tests/registers.c
>  create mode 100644 arch/x86/um/tests/test-fp-save-restore.c
> 
> -- 
> 2.50.0
> 

