Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC44C25B7C
	for <linux-um@archiver.kernel.org>; Wed, 29 May 2024 08:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tmorW89wVy0TqVci1X0dEC3lm+ETqY8c4f618REt8LM=; b=Zp7eXV9HZp7DIx6r8Cfvn3KhWS
	gdG7JP2pgVQEzeoezqwaeebINnO0hYKVth3BKsfqzBWcmHbqVVfz1eGb2rRCgfYmXWBDEnKiu41J/
	Kby65qau40IvIkBKonz6/Qe0qceaka5e+AADhIq7y4CWK5ZqkW8Ar+u0cBrWFKvYOt1zFrIyzDBcM
	C+JnOBe5nREnkaeyV7Pp7TV15WpEzdQlTiFpiB1smHItmQXkRcdD4tNCCLdhmZvkZtNdzAa6YZGM1
	g+dVF+jkT9mQrl/JG4lBRI3MQTBWQiTsSCJO7y4veZqxb07U1mJkWqqoaKphZUXQpQfiOnb6H0YF2
	Lyh+FX3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCEOh-00000003Iwi-3Vxe;
	Wed, 29 May 2024 08:10:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCEOZ-00000003IsL-0Nsq
	for linux-um@lists.infradead.org;
	Wed, 29 May 2024 08:10:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8CFE16280B;
	Wed, 29 May 2024 08:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485B6C2BD10;
	Wed, 29 May 2024 08:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716970250;
	bh=PgFyg9WLnPMWyhLQvcC3XtuqulgVK5WUqskSxNXqJas=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DZK1VEReps9AHETpZWUhqpsG+MI00Z0ABB6+gsyW4Gi/Z5H2wxRpGys0fUV/CkDBi
	 ekm5UCfe5kEy0dcpfusrq9SB9N1ZwavpRU82ufk8JfWE2lzM+/YXbDY2BXVIIMJY0E
	 T5zQzfJHsOYj5o65HP0rDO9kO+0LU/4axtrqsBUXTVh+zCLdt4IzBnkae9F0/64AST
	 gqMNnuwWzByDW5WKf7i4hE7fr6Q5anX+m2We3adJ81nyxudkw5rtlBVLP6JZkCEX3i
	 Pcy2SlsuFxqd5emx5tb3bXdTCobvVRykH3xWoY1UPtWqs2G9X7g/qXHlmyyZj0p92U
	 NdB9TJbaHuhIA==
Message-ID: <868a031d-a6f5-4f89-b0ee-f74f6ab38dbc@kernel.org>
Date: Wed, 29 May 2024 17:10:47 +0900
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
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240529050507.1392041-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_011051_219085_7D868D2A 
X-CRM114-Status: UNSURE (   8.45  )
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

On 5/29/24 14:04, Christoph Hellwig wrote:
> Add helper to disable discard when it is not supported and use it
> instead of sd_config_discard in the I/O completion handler.  This avoids
> touching more fields than required in the I/O completion handler and
> prepares for converting sd to use the atomic queue limits API.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


