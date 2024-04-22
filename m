Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BA7C4345F
	for <linux-um@archiver.kernel.org>; Mon, 22 Apr 2024 02:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lUVfmPNzghB31xCKQJm1CnKV3Pw3sruHDpz+wZRxOhg=; b=Rf/CPJX/v+Djlz2ckVe5vnHXDn
	MtVAHzvkingGHlnlHEtt2DUYXh1WdL1tHfI6AqXSLV98J28PSdon3xczKRqn1GAFNEObEo6r0m1dO
	8OZaJPIhDqCwtwS8NznkHX/frZLoX5tTWNqco6V5Jc4pDqNihpaHbswAtbCV24bex34A3BPhwNulY
	2s7hzd85us/fmsIU+Ux4B63d7XBPDf3hD+8yZVWUUBI6YOgH3QfIUNxqT+66Dbyf4RUZN5VSawKcS
	odTebw4FP9sLGg7aSJQhCOZg5XM6hJKCH8hD6XDUXIe1z1axPBVYvV1/hiV/guWT8U9/f2a7staEl
	JmKzvcng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryjXB-0000000BmBR-0NQl;
	Mon, 22 Apr 2024 02:35:57 +0000
Received: from out0-197.mail.aliyun.com ([140.205.0.197])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryjX6-0000000Bm9z-3uUy
	for linux-um@lists.infradead.org;
	Mon, 22 Apr 2024 02:35:55 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047192;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---.XICFcii_1713753336;
Received: from 30.230.85.101(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XICFcii_1713753336)
          by smtp.aliyun-inc.com;
          Mon, 22 Apr 2024 10:35:43 +0800
Message-ID: <e213cf20-bf70-4e53-a5f2-5ec88cfa6ff5@antgroup.com>
Date: Mon, 22 Apr 2024 10:35:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Rework stub syscall and page table handling
To: benjamin@sipsolutions.net, linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
References: <20240418092327.860135-1-benjamin@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <20240418092327.860135-1-benjamin@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240421_193553_335964_CB2CC1E8 
X-CRM114-Status: UNSURE (   4.21  )
X-CRM114-Notice: Please train this message.
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

Hello Benjamin,

On 4/18/24 5:23 PM, benjamin@sipsolutions.net wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> This patchset reworks the stub syscall handling and also redos how page
> table updates are tracked and synchronized. Some of this originated in
> the SECCOMP patchset, but it became clear that these refactorings make
> sense independently as they result in a considerably fewer page faults.

I saw your SECCOMP patchset. It's pretty cool! Just wondering if you're about
to post a new version soon. :)

PS. Just FYI, gVisor also implemented a SECCOMP based platform which is
also very interesting:

https://gvisor.dev/blog/2023/04/28/systrap-release/
https://github.com/google/gvisor/tree/master/pkg/sentry/platform/systrap

Regards,
Tiwei

