Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB35C25B7E
	for <linux-um@archiver.kernel.org>; Thu, 30 May 2024 19:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BLwZbOo2VuEjeawIOT3dZywpLeD1IzBghu5o+yp6hiA=; b=FBXz4/RhvKXVi4MAmZvVe+Xy7d
	h8WuWqwmk9WD9dZ6EyYn29PJ55OBRroS5FQdPC5KELKnKrP9aFEeoNBEym4MAuiYHbbTYAL5nFPif
	XdSpLpFSfpkxPVUJxUUUwIO5NDYsSzVbcQWpwGzZL7bLp7s0T70xNMolTJGtiCp5wK3CKkLTdF8o/
	YV7/FOiL0YUdnLcDkEN7uwSIL9y8ovoN8UQvKylT055Wne7v+BODD0uBer77yUti7HozZBE4BBIt+
	6XEAYNsag1GMX3+FDiTI6VbD7X7ZUsgfmnM6tDdn44W5ph7ZfHfj65LujEY2pXOZnRUVf1FR6eS6B
	oFNpvTBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sClnr-00000008H5t-0cox;
	Thu, 30 May 2024 19:51:11 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sClno-00000008H5R-1JKK
	for linux-um@lists.infradead.org;
	Thu, 30 May 2024 19:51:09 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VqxhD06zdz6Cnk9V;
	Thu, 30 May 2024 19:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717098663; x=1719690664; bh=BLwZbOo2VuEjeawIOT3dZywp
	LeD1IzBghu5o+yp6hiA=; b=BMa7rd7XppGue5oaVmK2KHUY3MIK85AfzEEn+EKp
	bcNLOjbFEai52dS82B0yhSPKs5RyqQXlGiN4QD+YUDbrcAZHAjNBuw86VOjnbcWc
	KpSflEQS63VRNlvjxLG6uywRVDTYgOMSrCxedOS87bGL09MYLZfeGA3T5ub8rgQI
	sS/meOXbeO/ZoOUiTMgwb/aGcVJUK8awiaLnzIKJ7y1nfc5R9zHMSdwMeuPfjcqP
	3xL2my5/vEmEuShKNLcDV1pHPpTg6z1N0uk5Ah0GFOd0IfgaFouOWdGCAH9KTqO3
	3vxrR40G8smQRaSEyQHqccCit4O/AMIRLYUJfU2LODky0g==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id x4rVbmHKH9zP; Thu, 30 May 2024 19:51:03 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Vqxh56rNhz6Cnk9T;
	Thu, 30 May 2024 19:51:01 +0000 (UTC)
Message-ID: <391fad91-7a65-4b2d-aa5d-58a5bc341d5f@acm.org>
Date: Thu, 30 May 2024 12:51:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] sd: add a sd_disable_write_same helper
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
 <20240529050507.1392041-6-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240529050507.1392041-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_125108_613404_2945F871 
X-CRM114-Status: UNSURE (   8.21  )
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
> Add helper to disable WRITE SAME when it is not supported and use it
> instead of sd_config_write_same in the I/O completion handler.  This
> avoids touching more fields than required in the I/O completion handler
> and  prepares for converting sd to use the atomic queue limits API.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


