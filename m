Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFE6C98313
	for <linux-um@archiver.kernel.org>; Sat, 17 Jan 2026 07:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fdpvBhQBOChk8ARM449+Wm7H/W77F2DePeTntsLCc48=; b=CTjayb9KpSXI2juIpwOVlMTNcm
	F9aFL4eaHfG8YpVJQoyLZpx1AVWET1y+I+2zbEUK2c4DpCYdJCaUWXJZy/LEV6xegVwR3lpNP1547
	XzdPsPGvzUiniYml3FTDv/gKkF2I5rIkL89iykqFS55G2xiDOqgIDJRLxs+UlSzDGqdkJJQjLEFlp
	mLYElOoz+dI7PIGIGDxqrXQCXzQ0uUif7Bsd6Nepz9+qZyHDhY3M7LhiokUCdBeslRjyh8s6WqZic
	XNSbMAedkD9SNzIYuWl1jqrfYc7R+nB6fooKLuJC7cMI8nS18/v2LyMD48LARM/R/S6LZ9BxnGEJ7
	1xUBs3pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vh15X-0000000FNTn-1vch;
	Sat, 17 Jan 2026 07:51:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vh15T-0000000FNTS-3haZ
	for linux-um@lists.infradead.org;
	Sat, 17 Jan 2026 07:51:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768636269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fdpvBhQBOChk8ARM449+Wm7H/W77F2DePeTntsLCc48=;
	b=dOGu93zcothgjDg3tOxXOI3NyBzd5NLFF8WeoEpH8FAizOfePhrQjxP5MmVpKMPBjm4KWY
	Y6YxDrypeVwvA6K1dBuPKcJWXsgWPFwarFMDMYrfQ7R3RC0AmT0EihbRoWLvoLMi4LpdmA
	NHpF0pWIUqxxUtcPHMkuNTiw2rO0N58=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-r9exbGOMPpe339aV_PTw6w-1; Sat,
 17 Jan 2026 02:51:05 -0500
X-MC-Unique: r9exbGOMPpe339aV_PTw6w-1
X-Mimecast-MFC-AGG-ID: r9exbGOMPpe339aV_PTw6w_1768636263
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 750DA1956096;
	Sat, 17 Jan 2026 07:51:01 +0000 (UTC)
Received: from fedora (unknown [10.72.116.198])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4067E3001DBA;
	Sat, 17 Jan 2026 07:50:51 +0000 (UTC)
Date: Sat, 17 Jan 2026 15:50:45 +0800
From: Ming Lei <ming.lei@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: Re: arch/um/drivers/ubd_kern.c:780:13: warning: stack frame size
 (2152) exceeds limit (2048) in 'ubd_device_release'
Message-ID: <aWs_VTjkaD5yHB-o@fedora>
References: <202601171315.t7AOGOhS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202601171315.t7AOGOhS-lkp@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260116_235112_012684_4741CC86 
X-CRM114-Status: UNSURE (   8.42  )
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

On Sat, Jan 17, 2026 at 02:00:56PM +0800, kernel test robot wrote:
> Hi Ming,
> 
> FYI, the error/warning still remains.

Hello,

`arch/um/drivers/ubd_kern.c` is maintained by UML subsystem:

ming@fedora:~/git/linux$ ./scripts/get_maintainer.pl arch/um/drivers/ubd_kern.c
Richard Weinberger <richard@nod.at> (maintainer:USER-MODE LINUX (UML))
Anton Ivanov <anton.ivanov@cambridgegreys.com> (maintainer:USER-MODE LINUX (UML))
Johannes Berg <johannes@sipsolutions.net> (maintainer:USER-MODE LINUX (UML),commit_signer:2/3=67%)
...
linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML))
linux-kernel@vger.kernel.org (open list)


Thanks, 
Ming


