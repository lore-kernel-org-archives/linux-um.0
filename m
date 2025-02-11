Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8C2C0219E
	for <linux-um@archiver.kernel.org>; Tue, 11 Feb 2025 07:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H1VXqZ9lKzRZadC9U5vq7bvgRxGL6+7Trovsrml9/kQ=; b=TEPqlDAZQ67AkZbB53lT4zP2cR
	uwdN4BnKT7W8wJfOcsWRS+qa1N39hFJOF7HILn9JjOcp/ruqzAOAxM1Za1rkxxR7KCG3/gX19re2w
	r9yH9oJNX0svKs0hrdwagjRoOv8YF8f8iR3K5dH2zF0vBKuNu9svrqLvlyITaz48ZE/XJVvQh8bvV
	j9NBd0ILZfWURA6zm3XlPYEpCu8Kw0LkD3qka9aLA8xoPj0n+Vt6Y+xsV4hc32daneO8ooc25E1g+
	M5mH5w1ZplbiPBcqFai8k2YfqJrdJlZh4aDi2DQ65EtpsPOymkhUc1TQPRE7/+8TKCcGqk0jXZc4D
	cBJRzegA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thkJd-00000002maV-44uC;
	Tue, 11 Feb 2025 07:04:17 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thkJb-00000002ma9-2QxA
	for linux-um@lists.infradead.org;
	Tue, 11 Feb 2025 07:04:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3252AA401F5;
	Tue, 11 Feb 2025 07:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40338C4CEDD;
	Tue, 11 Feb 2025 07:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739257454;
	bh=ispQSxpSJ6PQTb5p81umW3SK6UvzxW/oSGK2MzXk3IA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B4SZB6RFiRZZwZ/QoiHowoLw1B3Ab2rGCF6gtZS6Sw3kAMFIpvd+PRX2c0wVrq86x
	 +Xb6mK9wzjfkuAklOGaSyzFwRp/s/oeBLtuvuEDgrHEtc92hHzzU7Iq3Py8EntNkO5
	 9OQDjuwPwmgkKwtYOG6zcaXZtbULwBKFH2SNXe13bV0Q5QGUUlIteYM5c4h3lGPyEt
	 vG3cUHxb/18HctNpSjywrKcQO2chiqXzDR6UXe4Bru5GEAhMgqBYLxVFhGIE9d1flv
	 1U0JdWtwqpymv43MH80YU70zh76U4u/+3ixxWBnPN8fS9ODO4vJc2Laqrd9QkEa7XZ
	 qh8gafpi2GK5w==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Benjamin Berg <benjamin@sipsolutions.net>,
	linux-um@lists.infradead.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH] um: add back support for FXSAVE registers
Date: Mon, 10 Feb 2025 23:04:11 -0800
Message-Id: <20250211070411.6235-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107210758.80762-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_230415_680261_4DDBAE33 
X-CRM114-Status: GOOD (  17.04  )
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

On Tue,  7 Jan 2025 13:07:58 -0800 SeongJae Park <sj@kernel.org> wrote:

> Hello,
> 
> On Wed, 4 Dec 2024 08:48:27 +0100 Benjamin Berg <benjamin@sipsolutions.net> wrote:
> 
> > From: Benjamin Berg <benjamin.berg@intel.com>
> > 
> > It was reported that qemu may not enable the XSTATE CPU extension, which
> > is a requirement after commit 3f17fed21491 ("um: switch to regset API
> > and depend on XSTATE"). Add a fallback to use FXSAVE (FP registers on
> > x86_64 and XFP on i386) which is just a shorter version of the same
> > data. The only difference is that the XSTATE magic should not be set in
> > the signal frame.
> > 
> > Note that this still drops support for the older i386 FP register layout
> > as supporting this would require more backward compatibility to build a
> > correct signal frame.
> > 
> > Fixes: 3f17fed21491 ("um: switch to regset API and depend on XSTATE")
> > Reported-by: SeongJae Park <sj@kernel.org>
> > Closes: https://lore.kernel.org/r/20241203070218.240797-1-sj@kernel.org
> > Tested-by: SeongJae Park <sj@kernel.org>
> > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> 
> Seems this patch is not yet merged into uml/next or uml/fixes.  May I ask the
> timeline or blockers for this patch?

A gentle reminder. :)


Thanks,
SJ

[...]

