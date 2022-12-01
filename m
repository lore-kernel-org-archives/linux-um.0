Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A62C4321E
	for <linux-um@archiver.kernel.org>; Thu,  1 Dec 2022 17:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SKOPRUvclTI8Ccmsz5ebmTLiQ+DeSg1FX/hukbo1MHg=; b=ZGkrUjVzv214jY
	2tuj/4n+pWdPQxiT8B0IIpCb2R89u82TxPsnmmVj0XEA6CJEcSSBkwqtDnEWHcOn3xNFSZG0TCmyV
	k+ehatzwxNzd3x+eU/OjwgygtIeVVdy4Ps9HmJUZHrRsDspgGK3WKW2w5LFSTSWAoWu1DBxC4PHk9
	dxvFlu00GymamB+orUDpPhAvSr6lvY8qs2Mh3hGU7u1MV9piUQljTWA1rG7Sn1S4Q5i6JcZYPX8YN
	8TyCNs+7sxljX5oHGQ1+91dQqvKv1RNxZTmMh988SBP80XdpgUbo1kv+BhLoygMoKPjEpSAdO51Uw
	l9zCbXis6pS+Wq7ZZGSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0n9u-008tsm-Pd; Thu, 01 Dec 2022 17:15:38 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0n9n-008toA-1W; Thu, 01 Dec 2022 17:15:31 +0000
Date: Thu, 1 Dec 2022 09:15:31 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 1/2 v2] IB/qib: don't use qib_wc_x86_64 for UML
Message-ID: <Y4jhMwCox6RGI5FM@infradead.org>
References: <20221130200945.24459-1-rdunlap@infradead.org>
 <Y4hyPPzyQiI3i9jh@unreal>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y4hyPPzyQiI3i9jh@unreal>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Thu, Dec 01, 2022 at 11:22:04AM +0200, Leon Romanovsky wrote:
> I would advocate to add this line to whole drivers/infiniband.
> None of RDMA code makes sense for UML.

software iWarp and RoCE absolutely make sense on UML.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
