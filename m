Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DA7C25B75
	for <linux-um@archiver.kernel.org>; Wed, 29 May 2024 21:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wVUy7o3bXf/noy6YSu0RsfBfkRiwLQrgb5cMP2Pa7q8=; b=w8A4g2uk5JFuEAlUaDm+f+YWDT
	Db3cm9x+l1vwtOh5EZKyZpLhoUUvWl6QUl2UsyUpQTWT6rjcN/voJ7uOsiG0Uv7j8UyioFaqiEVud
	s5t22a9ZsVieVA5rKbw5pTZbHZQlGAaOt/HleYx6o+suSZJ2uKks2ol9RssHnK/6uHUs+nJVWkTgJ
	AesuEyPiNlsfNO12WQD1X1S2SjAmUVlT3qVMffRNw0rA8aMBXtbpcn8Gq9aSkf0IT6pDzXwFYzAvS
	YPtOAHDG2gX4hBJ1JqR1fN0d0tnzKr+94sk6sr6Mk5MdUyTX/rw+kSAvZrvohueoRCAFtTJ94FihN
	KVPseDtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCQaK-00000005Wpw-2dK1;
	Wed, 29 May 2024 21:11:48 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCQaG-00000005Wny-2i6R
	for linux-um@lists.infradead.org;
	Wed, 29 May 2024 21:11:47 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VqMWZ58Ltz6Cnk97;
	Wed, 29 May 2024 21:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717017094; x=1719609095; bh=wVUy7o3bXf/noy6YSu0RsfBf
	kRiwLQrgb5cMP2Pa7q8=; b=QFjHmHY3/zEesfTR56+Y2SAfx/9kF8USAaPfodaa
	1NlbISeQtFhMQo5eKeT71tNXYkxOsczf07HR2Jg7kDECPZHbMqyg4jYdehcmpc6U
	pDScRpKKu8Rjyhm7pbf60HZtmxriYQ66+aBloWTpP6m/aGYjU5d8dR4eSVUqQ/OA
	xYtc6lzNLpfolCh3T1Mfx+tpCeFXkuhAlul/aC6d93xzuIXsbbqvGhKw9HLqQ8Hv
	yZpoz1hZaaNwZnzsSClMVINGA6pWnoN6MCYirTHscroKGo27eDVHIhGrEeOJHh7Z
	7W5OQwUFrkBQjwlsjPeC4wUGmMgkfdxis25NEBJvc3gvXQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MByd4wIRut8R; Wed, 29 May 2024 21:11:34 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VqMWR0L4Mz6Cnk95;
	Wed, 29 May 2024 21:11:30 +0000 (UTC)
Message-ID: <7828c48b-2a37-4033-a634-7a4fad4f94fd@acm.org>
Date: Wed, 29 May 2024 14:11:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] sd: factor out a sd_discard_mode helper
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
 <20240529050507.1392041-8-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240529050507.1392041-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_141144_742103_8193BB00 
X-CRM114-Status: UNSURE (   6.54  )
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
> Split the logic to pick the right discard mode into a little helper
> to prepare for further changes.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

