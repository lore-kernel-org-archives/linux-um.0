Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1284ACAC58E
	for <linux-um@archiver.kernel.org>; Fri, 12 Sep 2025 01:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MMiBSaInF+hhMFgiKTpM6CvmtWD3eEqrpblFLp2j2fs=; b=uBg87yrPISL3uj80ZRLjdUFe/l
	6GkE7g52nd6V3E71OYgDVouKlLEEvDu2ITE0oFAf1b6zMy1UdbHQkT1BdFyUjKbez1TH4kH4zOKoz
	DD3difm7XZZn3C7Rkd+0ZXrt5nQgSutnxXL5Il7gm00wKdyZaArlOd7IyX6ZZQuDT5/NPoaJOr82c
	8QrUgLMv+PzLf3dIPsFJ7QMhiVkshnlUloGC7e9zz2kEKpy9gtVg2t6WzEN8W7Xj+QkAvLCiOG+TH
	noJgNIJAQeGuWO4CMslI3Bzo6IXmmYaT1196J8WkdN/cqa/NRNAkHMS86cyg8HQHs9c05FipNsx++
	PRAc1XzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uws8w-00000006CWy-1XQW;
	Fri, 12 Sep 2025 01:00:02 +0000
Received: from out-183.mta1.migadu.com ([2001:41d0:203:375::b7])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uws8t-00000006CUy-1nZb
	for linux-um@lists.infradead.org;
	Fri, 12 Sep 2025 01:00:00 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757638796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MMiBSaInF+hhMFgiKTpM6CvmtWD3eEqrpblFLp2j2fs=;
	b=mcRztRBQaFMlOm2orlCvPRojMiGJk0l7CngY10PlmoXqmkf6djqozSfCHOrXhPNhalswQD
	2EQBwYE4tHjCcFxNmjBXt5NF5wVUH56J5v6oE2zYgsMOKpIOO3sYK1UYKBAtNFKX0snY8N
	2bTMHsqNeYrIwrX5ydgmQQrwlmsAkJ0=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: johannes@sipsolutions.net
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH v2 05/10] um: Determine sleep based on need_resched()
Date: Fri, 12 Sep 2025 08:59:32 +0800
Message-Id: <20250912005932.2568228-1-tiwei.bie@linux.dev>
In-Reply-To: <579899d18d5aa4422f970d28e19dc363c9ed218a.camel@sipsolutions.net>
References: <579899d18d5aa4422f970d28e19dc363c9ed218a.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_175959_605467_AAB42417 
X-CRM114-Status: GOOD (  18.00  )
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

On Thu, 11 Sep 2025 08:59:57 +0200, Johannes Berg wrote:
> On Thu, 2025-09-11 at 12:39 +0800, Tiwei Bie wrote:
> > On Wed, 10 Sep 2025 14:10:37 +0200, Johannes Berg wrote:
> > > On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > > > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > > > 
> > > > With SMP and NO_HZ enabled, the CPU may still need to sleep even
> > > > if the timer is disarmed. Switch to deciding whether to sleep based
> > > > on pending resched. This is a preparation for adding SMP support.
> > > 
> > > What's the rationale for need_resched()? Is that somehow defined for
> > > this? Is it what other architectures use? I guess I'm just not entirely
> > > sure what it means.
> > 
> > Here is a relevant document:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/scheduler/sched-arch.rst?h=v6.17-rc5#n37
> > 
> > There is a similar check on x86:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/process.c?h=v6.17-rc5#n916
> 
> Ah cool, thanks for the pointers. Though "1." part there is a bit
> confusing, I guess I'll send a patch to reword it :)
> 
> FWIW I already applied a few patches, but I'll take another look,
> hopefully today.

Thanks for the review! :)

Regards,
Tiwei

