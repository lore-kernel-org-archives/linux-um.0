Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1493AC25B74
	for <linux-um@archiver.kernel.org>; Thu, 30 May 2024 20:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=72TYEp9qG+JFxDJOhc8vL98i94kXdGccHRpnAQFkti8=; b=Jffj2q2M+8tw9zg1CqyGEHT61n
	KVE5TXNKx2g2LIdM4v7FdxDbVthoW5cJd93nd6wXmsFPXYz4vLbLEcxRaxH/qxfsWVm+kIflUQHwy
	3JQf2j6lnktypqZ4WvfedXZmHLkyBAUyd2Ws1xTvYMwW+jemQV2AzZkhbNe+OaO4tzNXhRlTlH8Sb
	cn/i+3No9rX1ImnVVgbWxrdQQ9ud+J3HS7ouOYVFpk1669T+ydGJJco+9Jyqf+z8TdZKoBDZSTZjH
	UciaftwTyzgxTbZMIOue+QElM4di4en8QDkYnz+KBzFrg9fN6HUT/kZOfRRffXSMFTyssYxiWemT/
	CuOQNeMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCm5U-00000008ImM-21tb;
	Thu, 30 May 2024 20:09:24 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCm5R-00000008Ill-2Uur
	for linux-um@lists.infradead.org;
	Thu, 30 May 2024 20:09:23 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Vqy5F1Q97zlgMVW;
	Thu, 30 May 2024 20:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717099757; x=1719691758; bh=72TYEp9qG+JFxDJOhc8vL98i
	94kXdGccHRpnAQFkti8=; b=nQibsLkJj+e718qU89zq/w3b+Xj7bZcJX1t4S5Ib
	6Y2TqQaSrn/m9KkYDg8nG47BrzEZi5y6e/fkqJH0jKclSqaBOiW4YJTNeGb1Sp0q
	ZkAl4cqRGtJ9BhVg3y0q9c8DIYnTeW34UN3c12ZZq8UlXTpwStkplQ+/oORhUCu1
	CTLLln6gMBNxvppMEcu/G6wtlrVMp25vVLoBMfI4CsCDWdrrCAO59XEhKrT6cbhE
	Cef818A+XIhDPVWZrIoeq54kVP/vsyNbked97rhR5i8C7RP7qmtB77Ne3Id9P9eD
	p014OI2YgEP5j/ozLgrC3mtdb8oHumiTveZFFAH+BafSnw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id AYBsZ1kn-wfP; Thu, 30 May 2024 20:09:17 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Vqy5720mhzlgMVV;
	Thu, 30 May 2024 20:09:14 +0000 (UTC)
Message-ID: <12bdbf52-d97c-4c47-8e8b-bfc10bbdc985@acm.org>
Date: Thu, 30 May 2024 13:09:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] block: add special APIs for run-time disabling of
 discard and friends
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, Josef Bacik
 <josef@toxicpanda.com>, Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 linux-um@lists.infradead.org, linux-block@vger.kernel.org,
 nbd@other.debian.org, ceph-devel@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org
References: <20240529050507.1392041-1-hch@lst.de>
 <20240529050507.1392041-13-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240529050507.1392041-13-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_130921_674261_4C114B17 
X-CRM114-Status: UNSURE (   9.36  )
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

On 5/28/24 22:04, Christoph Hellwig wrote:
> A few drivers optimistically try to support discard, write zeroes and
> secure erase and disable the features from the I/O completion handler
> if the hardware can't support them.  This disable can't be done using
> the atomic queue limits API because the I/O completion handlers can't
> take sleeping locks or freezer the queue.  Keep the existing clearing
> of the relevant field to zero, but replace the old blk_queue_max_*
> APIs with new disable APIs that force the value to 0.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


