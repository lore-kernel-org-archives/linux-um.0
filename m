Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C667C25B74
	for <linux-um@archiver.kernel.org>; Thu, 30 May 2024 19:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7QFmifQMChBXa8KST+DsqdnFEpu7aV4gNbQITRSzRXY=; b=caMW/cS+QWyHGIkw/b3XZ4YPgH
	4WXcNzyjZkmLc0IZ5ydA/efWVH0+kjYUdz5rhbqz4843uC/vbQYbPYHvCmdvk7oWJBiRgBVfn6/Cu
	KXVbg/RLQvpjjqbQ3ic1kxpw4fkhNFNQn3vuihYRKrAaQypjge+dSrf6mCjv4UoTb0F31GORu5SEN
	s/QAkh0PtJtckNZhH7VnayNjgpt29y+i3Op7de90Cfh1J8TvogOYwvZRYSO7qPlqCS7f0GXN1JGdB
	ICEPjjhI768LzmLthWVEQmY2AcfIENQf7S+5dITwxcknLIVFgOsVtReLKUy1oBTWwGe83oA62rg4U
	fPugKD8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sClnN-00000008H2X-0eIc;
	Thu, 30 May 2024 19:50:41 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sClnJ-00000008H1u-3MrL
	for linux-um@lists.infradead.org;
	Thu, 30 May 2024 19:50:39 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Vqxgd2Y61z6Cnk9V;
	Thu, 30 May 2024 19:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717098632; x=1719690633; bh=7QFmifQMChBXa8KST+DsqdnF
	Epu7aV4gNbQITRSzRXY=; b=WUjlX1PDIQyMgUb/0/yO+Fvzm6H2r3VbR/ytQbyG
	ja1ZtUlCegyS9BGCsSsID9x1/+kDjEs1NxZDIrjljFC2ZUpQ8nSD6H6RckeDAaV/
	8NybhiHj4Sye5m61h+RgA1L76P3LsN9DZgjtG7WVblDA+TCSZ/ARfrUBW1SRcvIq
	CUnB7FlcYqzV2NUiwaoz3LW53sA83Z9iucHomhpMAkPcCpOBKOEtiyurze8Qo3I0
	N3az9ReZGqTkXsyoXq0i+KzjVMS+igSHckcZ9ZyYDlURgNiKKLrMqPh/lqphOWEQ
	PLQr+L12hPXk4p6dZ8EbtkCXzU85zv+TAPmk7Obq/DjhLg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id NvbqtULo1Ahy; Thu, 30 May 2024 19:50:32 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VqxgW0TsNz6Cnk9T;
	Thu, 30 May 2024 19:50:30 +0000 (UTC)
Message-ID: <bb168ec3-b3e8-4e40-8f8c-eb0a1dd00f16@acm.org>
Date: Thu, 30 May 2024 12:50:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] sd: add a sd_disable_discard helper
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
 <20240529050507.1392041-5-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240529050507.1392041-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_125037_881104_F256B33A 
X-CRM114-Status: UNSURE (   8.16  )
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
> Add helper to disable discard when it is not supported and use it
> instead of sd_config_discard in the I/O completion handler.  This avoids
> touching more fields than required in the I/O completion handler and
> prepares for converting sd to use the atomic queue limits API.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


