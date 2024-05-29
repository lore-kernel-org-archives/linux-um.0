Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D6CC27C54
	for <linux-um@archiver.kernel.org>; Wed, 29 May 2024 08:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gv8hjZuJFHEojgLmproo8VGIlQnyyBePMkT+k15zz5o=; b=qeRc61ZoV/1IM99H5QrBrQU2wZ
	6vFqqL3Kq2AN0c697oj00hWRVqKFYF6awNOkiI3K/+3XT0Vl8oC2ZRCxb53BEKGEYdZ0jLpQlAYyo
	hJIJgsydDTG3ezROjW3dn+k8it7tmEEe+x0otFnpKWdv0ZbxDgHiOAw0r0hFyIrDEHwdn6QhkD6iZ
	64xGdAH6XVyour3jDbK4Wkv62uYKBbjV/fkSDGMxSuaO15J2XFsxr6Ny04MSoZ157ygmMFlZbqrAT
	aQVhTYZcIP2P/dlji9AgsecuYyiRrB5GQqqY07faPhsi0gPeWKNKn4f2eakiDpcXQZyW8R4BhEQ/k
	WZ5y81CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCESX-00000003K3I-2Irb;
	Wed, 29 May 2024 08:14:57 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCESU-00000003K1g-0c5v
	for linux-um@lists.infradead.org;
	Wed, 29 May 2024 08:14:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 55AC2626B5;
	Wed, 29 May 2024 08:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B98BC2BD10;
	Wed, 29 May 2024 08:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716970493;
	bh=807aMJTkC1p+AoxUwaQMdhMlZoRzxAswKTa2dL4juDQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UxzQFdZDojD5zpNCznqhTAYgdt/u91jAQBq4urzSctjoQNdJc95kx61nCycDlwl+Q
	 1JAZAr2BWpd8fVSOv1QtVb8WnA/H3q5yZ/J6rV5BrOS0h/5R7SBN4XhluIsMA1bnkC
	 ZgxW77pqNTlnmVDHqOWJDaloGp+tPXvK5/dfQKe4x5GXGHc718XUnBvEf6dq9tu658
	 4RCg8AKM8Yv0x+3AoBe6WqI19ZjEWYVxMLHJL8shoIDvIkL5J73b1/ED3qKdfnQSgN
	 6cjSWuxuKauqmy2HYUIA1sDs9N0HxdoZvZ2tKGZTyDH71GI3SCMxH44xQHHHqS1bMT
	 OeyWAOUjf5bLQ==
Message-ID: <87cbfdc6-4ba3-4a3c-9d80-24584fa38f27@kernel.org>
Date: Wed, 29 May 2024 17:14:50 +0900
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
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240529050507.1392041-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_011454_297909_B72CBBF0 
X-CRM114-Status: UNSURE (   6.70  )
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
> Split the logic to pick the right discard mode into a little helper
> to prepare for further changes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


