Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF27CD98CE
	for <linux-um@archiver.kernel.org>; Fri, 12 Jun 2026 15:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TXy50/thz4PVQL4UBlbkqNt4vAqev8Z5e9GmH/S8x4k=; b=vzHutb0hn2ms0nJv0Qwsrlv2Ty
	+osDPioEcOUQXyfc6df1w1AHRyZnfHJKbz1ZtRRPrWwsy825Xt9zZZL1qt7PwNpTM+LaqyQSfZIpC
	tDJpwVP1q+cQKynwuISeeMkpg9w6rOKc95NpdmOldDSP1a/QmVvhfDNoR+P4wW/QLFZwLj0/fsAb5
	48yJ1fvnEsYV4WuKKu31KHVrdrY0As+IiU/BEGZj4j9PJjDWWRGsSyuuSntJ6ZZtXB8Xj3089tE4W
	i3dNRSGqg9w0Y0O+9pQVl9nOg65+Z2epiCIsnn26jHiRe131grGMa+A76VZXIOTkrZXm3ETl7ztUu
	gPnhmQ8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY4GO-0000000BCD2-3BZa;
	Fri, 12 Jun 2026 15:57:44 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY4GM-0000000BCCu-34Hf
	for linux-um@lists.infradead.org;
	Fri, 12 Jun 2026 15:57:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3B26D434B2;
	Fri, 12 Jun 2026 15:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1991F00A3A;
	Fri, 12 Jun 2026 15:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781279862;
	bh=TXy50/thz4PVQL4UBlbkqNt4vAqev8Z5e9GmH/S8x4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mWk6gWQq2JHzV+TBt3fss6o21OVMj5wMElvakO8Ef6RrL0R4clbvJ4iT0zGwqNb2J
	 PcWLzYCkVhGZBqg1Bvna4fEPxXIKGHlCSEpys68LG5qtLzEHddPqwOk9w/NJGW29Ob
	 XIkZhhZ3qce7LCI+yM44mwzGyNvSszlLIaCOmsMeJ8Yr346G2x5sjwP2CpQfd7RhRT
	 znLd91Z0id2rbRF1fJJVEGzA+aELv0in2f5vs/QhXNoK9KRr0kzvgaCk3mnKdG+q8I
	 jLlxcrxYBlq5Svf6JGzdf6Q2qHuT+e5ys+2E4sP8PDbJ26GYWZPyCIXWJm0YToLF5G
	 ybFpaD3V37Ybg==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wY4GJ-00000002OVZ-3iZp;
	Fri, 12 Jun 2026 17:57:39 +0200
Date: Fri, 12 Jun 2026 17:57:39 +0200
From: Johan Hovold <johan@kernel.org>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] um: virtio_uml: switch to dynamic root device
Message-ID: <aiwsczUnvyWS3dYL@hovoldconsulting.com>
References: <20260424103101.2616338-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424103101.2616338-1-johan@kernel.org>
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

On Fri, Apr 24, 2026 at 12:31:01PM +0200, Johan Hovold wrote:
> Driver core expects devices to be dynamically allocated and will, for
> example, complain loudly when no release function has been provided.
> 
> Use __root_device_register() to allocate and register the root device
> instead of open coding using a static device.
> 
> Note that root_device_register(), which also creates a link to the
> module, cannot be used as the device is registered when parsing the
> module parameters which happens before the module kobject has been
> set up.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Can this one be picked up now?

Johan

