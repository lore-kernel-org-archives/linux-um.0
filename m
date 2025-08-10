Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8451C87FCF
	for <linux-um@archiver.kernel.org>; Sun, 10 Aug 2025 04:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0fgAIJfjOAMkD0Mb7Qr9ANhRFOd7/k4gDrAS8zFFIbc=; b=0oPSEpwsOAomkqpOFMTvjAQbR9
	FTHweLrd8W7Pvje+EO6CxumgX0RKwdoCRVBr/4g9hj14StQOIvjmoBDVA7Z4g0HxpUWBQXOAGXDe0
	stBGD6RoF3zYXMamvVgXeGupQshHn6tczo+0lkwWyzw/+3CLQmYR6YBvL6ktkWr/Ww4ZaIRPmCuN9
	Of0vjb0uZWJb8klwixYn7nGJpo4vhzTxkcVBjpxdMvb4R6grkJqLGLxGn1QsSG3AP2K6e1y8aHSgM
	R24x4PfCd+vMJdEgFU7jyGAOTwl4jcyO9nYKMOKyqs96S67XURhZQ7nyrvi6qzBrzbBuoq9fq/dRD
	9Hb++JGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukxlB-00000005FiD-1QjI;
	Sun, 10 Aug 2025 04:34:17 +0000
Received: from out-183.mta0.migadu.com ([91.218.175.183])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ukxl9-00000005Fh3-1UgD
	for linux-um@lists.infradead.org;
	Sun, 10 Aug 2025 04:34:16 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754800433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0fgAIJfjOAMkD0Mb7Qr9ANhRFOd7/k4gDrAS8zFFIbc=;
	b=w+V9x+PRRzC8ieyGtoDYJLAWiNEwE48DpIS76QpOBhgWDpa0csnXHRiUlZj6Ypbj2kKv3r
	16JiatnLvcmFAitS3ufI3wyDwixLibdA4FB2hjVBB/ECBUe7B2sK3K23xwcEELwPFsjLqF
	XqjJKOz1erySFVdOZq4qx1PwfEP6lnk=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: johannes@sipsolutions.net
Cc: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: Re: [PATCH 9/9] um: Add initial SMP support
Date: Sun, 10 Aug 2025 12:33:34 +0800
Message-Id: <20250810043334.530444-1-tiwei.bie@linux.dev>
In-Reply-To: <20250730041838.1821401-1-tiwei.bie@linux.dev>
References: <20250730041838.1821401-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250809_213415_533011_CC72096E 
X-CRM114-Status: GOOD (  11.04  )
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

On Wed, 30 Jul 2025 12:18:38 +0800, Tiwei Bie wrote:
> On Tue, 29 Jul 2025 17:37:24 +0200, Johannes Berg wrote:
[...]
> > 
> > IOW, I think you've stumbled across an inconsistency in the generic
> > files, and hence we should fix that, rather than having each
> > architecture paper over it.
> 
> That does make sense. I will prepare a patch for that. Thanks!

Hmm, this issue might be a bit tricky to resolve.. The root cause
is that smp_cond_load_relaxed() provided by asm/barrier.h relies
on cpu_relax() [1][2], but the corresponding header isn't included.
The reason why it's not included might be that asm/processor.h
includes too many dependencies, which prevents barrier.h from
including it. I haven't come up with an ideal way to address it
yet. Fortunately, smp_cond_load_relaxed() is a macro, so cpu_relax()
is needed only when smp_cond_load_relaxed() is invoked inside a
function (i.e., when it's expanded during preprocessing).

As for this series, I realized that I should implement spinlock in
$SUBARCH (i.e., in a $SUBARCH native way, which won't require the
above workaround anymore), similar to how atomic and barrier are
implemented. I'll take that approach in the next version.

Thanks again for the review!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/asm-generic/barrier.h?h=v6.16#n253
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/um/asm/barrier.h?h=v6.16#n27

Regards,
Tiwei

