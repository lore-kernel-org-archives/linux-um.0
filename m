Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2092ECAC587
	for <linux-um@archiver.kernel.org>; Fri, 12 Sep 2025 00:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jq5/1lU7TdxI8VO7geJyzqTN6wUTtUvTydZaERif2Xw=; b=vpCaAQJoXyc8N5X6m6dqzKog4E
	2TKxpgsKhM/p2BZoxZje/MV3KyYo3EdMZXWdyg9ExcMIeKVEb+JJH8bcd32MoOIt9fJ0qC2WmFjky
	k0dMXd8HbDbbzSR8BUW/2jctdjMYn1J2Sk04bWYnALD3IiVs1iC3PBxnYjfWvKcGjMfRf0fDm7n0F
	2jNpXtOHlO7jDfZ64pLFVf9gdyThpPSG4Wis9PqbvXz0Feyt/Moo7KPeDX9OspFr0ThcoMbUz3nbe
	UM+ixas+eOC8eAlZzUP5Nj8dDNbZipB9njs0K01Xda1eB1f/yGV/nEDf8J5tiHwU3OMBIuoQ1Lkcm
	O+jUGcqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwrun-000000069SF-0iWH;
	Fri, 12 Sep 2025 00:45:25 +0000
Received: from out-186.mta0.migadu.com ([2001:41d0:1004:224b::ba])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwrul-000000069QM-0XzT
	for linux-um@lists.infradead.org;
	Fri, 12 Sep 2025 00:45:24 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757637920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jq5/1lU7TdxI8VO7geJyzqTN6wUTtUvTydZaERif2Xw=;
	b=LYYY9GLX5ATmIJlxmSEyP+zTgQk56leFjskNTLkoZ9ssAQlPQzEx7om2kO5FcIwwEFGk8s
	cKoXUz9odmJp9Zr2ZXyJjY4QJW1S0BP/k5CRRVCFr6thWG66t7Q6T7f+9LjfYQqcK5MzGb
	Qh3bo77aptae6xXLK1nT7pG7DiPLwEw=
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
Subject: Re: [PATCH v2 08/10] um: Add initial SMP support
Date: Fri, 12 Sep 2025 08:45:01 +0800
Message-Id: <20250912004501.2565976-1-tiwei.bie@linux.dev>
In-Reply-To: <03cb4661a6135a641c5a3779f2cb424356b8e345.camel@sipsolutions.net>
References: <03cb4661a6135a641c5a3779f2cb424356b8e345.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_174523_379622_A1CCB853 
X-CRM114-Status: GOOD (  16.51  )
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

On Thu, 11 Sep 2025 11:32:56 +0200, Johannes Berg wrote:
> On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> > From: Tiwei Bie <tiwei.btw@antgroup.com>
> > 
> > Add initial symmetric multi-processing (SMP) support to UML. With
> > this support enabled, users can tell UML to start multiple virtual
> > processors, each represented as a separate host thread.
> > 
> > In UML, kthreads and normal threads (when running in kernel mode)
> > can be scheduled and executed simultaneously on different virtual
> > processors. However, the userspace code of normal threads still
> > runs within their respective single-threaded stubs.
> > 
> > That is, SMP support is currently available both within the kernel
> > and across different processes, but still remains limited within
> > threads of the same process in userspace.
> 
> Another thing that isn't covered is anything relating to interrupt
> affinity, I guess? Is that automatically not working, or will it look
> like you can change things but that not do anything?
> 
> I don't think it's important now (though eventually I would actually
> like to have it for our simulations), but was just thinking about it.

Currently, our irq_chips haven't implemented the irq_set_affinity
method, so setting IRQ affinity is not supported at the moment, e.g.,
attempting to set affinity through /proc/irq/IRQ#/smp_affinity will
fail with EPERM. And yeah, we should support it eventually. :)

Regards,
Tiwei

