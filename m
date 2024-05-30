Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF407C25B74
	for <linux-um@archiver.kernel.org>; Thu, 30 May 2024 19:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1qawYRnNtHLyKkfk2KIuL7VwFij1fGlSBD1rE6Kec4k=; b=lJ3mzDYD4CscCXsNsPmco8dhAS
	7GMsf3CSuXhlHxjol5QJtjAwJMOqqYdbo1eveul48Q4HTxg9NLQiFUOac3d8Xy0/i2gKPbYtllDkL
	B4FkBALP340y+1DFh5U2hQ4OG7n2Iihr7pbBtWh+iro8Pfzaw4Qk+LpQ098ivQZadRT+uI/soCHLZ
	AF2v7+xX3K/S0yHZUGO8NsJh2ORdwir/k9Dm1CJo5EX7hqcHWQRAXb6+QDmhO+WjQIA83Ef68puRY
	/393MtA2meO/aMsn/pvCxTYfgAE8AXN87XVOjG1vSegMbLvBD99DoGqY/jOIBIJH1dpbGtx6VALC7
	P/bhTLQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sClhp-00000008GKb-2XXH;
	Thu, 30 May 2024 19:44:57 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sClhl-00000008GJG-46MN
	for linux-um@lists.infradead.org;
	Thu, 30 May 2024 19:44:55 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VqxY061N4zlgMVV;
	Thu, 30 May 2024 19:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717098288; x=1719690289; bh=1qawYRnNtHLyKkfk2KIuL7Vw
	Fij1fGlSBD1rE6Kec4k=; b=O+dyHa1DO+LxwuvN37caN3rc79Al5B59aVt872Yy
	myvPBRd3qJOpB/ssbZf9DD6jeQwG3oky5nPyGHmKtOjLfDnHlE+e3wVIfqzpWjOs
	6hfPZNndbOYIdhdiprqYgfQpwZxp2KIDZmAsJBYG5LuLkM6flrrsn+Z7CP3aCzDV
	pwN4+gbFQD4bp6z4s36qcFNV+1waUaRjvrfL+xtNhs1hivVR8LlUKLXvQ4CEJ/sF
	RymJznQ8+fPT5LcsiI4IQupBmhHjJpPce8ad1C01w5LQVIcRKBZRcPzwxcXH/hff
	wu+Gqo4QOptIYFBfw/rmjL36jeH02rPcp9YADbGYnOeaDg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id XhrHqHFE5lIy; Thu, 30 May 2024 19:44:48 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VqxXv0mMXzlgMVR;
	Thu, 30 May 2024 19:44:46 +0000 (UTC)
Message-ID: <2384c3c9-5629-4438-a87b-0e05e1b6f5cc@acm.org>
Date: Thu, 30 May 2024 12:44:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] ubd: untagle discard vs write zeroes not support
 handling
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
 <20240529050507.1392041-2-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240529050507.1392041-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_124454_121057_DC8D264C 
X-CRM114-Status: UNSURE (   8.94  )
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
> Discard and Write Zeroes are different operation and implemented
> by different fallocate opcodes for ubd.  If one fails the other one
> can work and vice versa.
> 
> Split the code to disable the operations in ubd_handler to only
> disable the operation that actually failed.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


