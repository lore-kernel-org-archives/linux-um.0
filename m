Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B26CA1016
	for <linux-um@archiver.kernel.org>; Thu, 11 Sep 2025 04:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EHsKNkmYTmJBP9KB/YBLwA9+2JO6pQ+tShTIt6iAYVk=; b=pJcDOnClf2dhnEm4Yh1w9Cocoq
	dQVRJK5NCCRdLVUqkdHpemhxqNNiY/lRR7kjAGKfT3mO3f22OhV1X5Cd/lXNsUqWpwTEeMESREQXw
	dqsZ8bDAAO9yzAC+coiB/vo2r1RJDePR4gvzrdRx9AmfcZXRK8ECLkVLWqecnZrhWESoiVMQHWyUC
	5K5j5PaFih2RJWUqX23bSso9dF+MiMp5VLMVB8b4axrUqVeF6TdHMncOTbhQ9+sd9euB5OAEE+Dtk
	TMRYx4xediC3QzJnWUtKKj6r5uJQsNqAeHtrKQo9elyUv/rVGtWEiK4FTKWDqTjotjiatauZCuQM0
	begO2lyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwZ5z-00000000qTN-0JSp;
	Thu, 11 Sep 2025 04:39:43 +0000
Received: from out-174.mta0.migadu.com ([2001:41d0:1004:224b::ae])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwZ5x-00000000qRk-0lR2
	for linux-um@lists.infradead.org;
	Thu, 11 Sep 2025 04:39:42 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757565578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHsKNkmYTmJBP9KB/YBLwA9+2JO6pQ+tShTIt6iAYVk=;
	b=lhNU6ot5mzf5oOormW/Wo0BbD5jEljjFjAuoIcDK8kmgjlcqAFJjlaphvqe89aElNS1XOC
	Ux301Y1erFASvLfCC0xPzs5umBLTxORc+c3z/RjaRYqcsycRwFnpT0kprBRRu4KxHUq4Cx
	z9+C2fYw/OumvykKsT516wva/BiqxlI=
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
Date: Thu, 11 Sep 2025 12:39:18 +0800
Message-Id: <20250911043918.2950727-1-tiwei.bie@linux.dev>
In-Reply-To: <55cace5b8e1078bd04b4a1acb5df9faa6a83b6e8.camel@sipsolutions.net>
References: <55cace5b8e1078bd04b4a1acb5df9faa6a83b6e8.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250910_213941_358922_6F0F71AD 
X-CRM114-Status: GOOD (  10.30  )
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

On Wed, 10 Sep 2025 14:10:37 +0200, Johannes Berg wrote:
> On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > 
> > With SMP and NO_HZ enabled, the CPU may still need to sleep even
> > if the timer is disarmed. Switch to deciding whether to sleep based
> > on pending resched. This is a preparation for adding SMP support.
> 
> What's the rationale for need_resched()? Is that somehow defined for
> this? Is it what other architectures use? I guess I'm just not entirely
> sure what it means.

Here is a relevant document:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/scheduler/sched-arch.rst?h=v6.17-rc5#n37

There is a similar check on x86:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/process.c?h=v6.17-rc5#n916

Regards,
Tiwei

