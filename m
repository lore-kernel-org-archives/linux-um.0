Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5412CC55171
	for <linux-um@archiver.kernel.org>; Sat,  1 Aug 2026 01:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EvogDc+M75b9b3TPBdsSj8jbjbVAHwKKv/rtp15v1+s=; b=KWoIZ/9GH5wgc3wRBITzpLzc4Z
	t8h64Ie2+K8b/FQnpnxNiM8KwNzNGm9joSZtNa71B8hMIEJKakCdZ9YVylHxBNSH69WDvzqHQIHdQ
	NSWhJCAhVb9wpccHMqXXsx/JJocEey0Q9edGpnS3gTak9f+5zFjPagBQyVLupisrSa80U8Fbhx85/
	dXEe8RNDGclJkEYYln7cn/yEFDWZOrhC6zLqnwaDQzMAnhXetSjZPuxt5K3yZwVbv4jrqI+tiBlX5
	whUzORysg6oEmc9eOevL3c+BIr30CnN0c5/ewGHsOk3J0hDRmM4T+2620/lTOrDk7yJM0kq7xHeuT
	1RDuvPbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpyi8-0000000DoHg-43S3;
	Sat, 01 Aug 2026 01:40:24 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpyi6-0000000DoHa-16IS
	for linux-um@lists.infradead.org;
	Sat, 01 Aug 2026 01:40:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 563A160A5D;
	Sat,  1 Aug 2026 01:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618491F00ACF;
	Sat,  1 Aug 2026 01:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785548421;
	bh=EvogDc+M75b9b3TPBdsSj8jbjbVAHwKKv/rtp15v1+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HmQjKhzn/ZdYh8Sui5um9Q0RA+TgaAE2s/ZXntGsD2jWVfbxEbloW8/EeZsMdPxHa
	 hQ+JaxgkEWH53qtXb//z683yN7qaCdD6PID52wlEZqEVKxS8ZpFZ9ITzk5YgQLzL+7
	 EBpXuUgYnDP8Q1W+DLkVxH2WfxWVJEHLgJoWzK+pQyELTnEh8zcz+3iX5cEGuHHMKS
	 DM1TlQxApWKmZp4uN8sdVsxDqzrkXyeaAR8dWmyPRyMK7eFzrvXZ2hYRZCkIZhVj11
	 9k+B9dZEgH4gPOvjNJ0G8iRBViCl2cBItlf7mhsKdXL5+QO9BtDuhi5zNWmGrvvdLy
	 mwJso9j4l2Agg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Rae Moar <raemoar63@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH stable 6.18 0/2] Kunit backports for older systems
Date: Fri, 31 Jul 2026 21:40:10 -0400
Message-ID: <20260731211008.stable-0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730190329.3388222-1-florian.fainelli@broadcom.com>
References: <20260730190329.3388222-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Thu, Jul 30, 2026 at 12:03:27PM -0700, Florian Fainelli wrote:
> David Gow (1):
>   kunit: tool: Terminate kernel under test on SIGINT
>
> Shuvam Pandey (1):
>   kunit: tool: skip stty when stdin is not a tty

Both of these are already queued for 6.18 as plain cherry-picks, so
there's nothing to do here - no need to respin. Thanks!

-- 
Thanks,
Sasha

