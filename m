Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB97C4345F
	for <linux-um@archiver.kernel.org>; Mon,  6 May 2024 07:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=NwAFaUGeERGfVhf1LwMM8/HQyZ
	Owm8vxgB37rP1sfNGfmQhpwJGOZMIlfdxv2dwsK1pU+yqNzsMg4dv6osr4K2t2gOczvrjiOpafmsO
	524hKPfXuAWdVWnKL1ojQUTB/oDJAGN7MGh/1NZUjbZHcZvK+pqzoWlR7zyRDVg1fTIPBaoZZl3GX
	VUabcU23+L0mbzEbPL1v6VHutlWwTwGrVM8gUgeZVSigS9MWTn9M76+w3ejxCrFFH93aclFwt3Jcd
	+oPARg1gARYJS6KfNz3b8TKJJxoVz+kkPKL/dgU3Tczo9Ttz4HZ0g5eGIJ85ptQv8HyBfZ80rmp5j
	K3G1gawA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3sRA-00000006On8-1qAd;
	Mon, 06 May 2024 07:07:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3sR8-00000006Ol0-2baK
	for linux-um@lists.infradead.org;
	Mon, 06 May 2024 07:06:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 70EB9227A87; Mon,  6 May 2024 09:06:49 +0200 (CEST)
Date: Mon, 6 May 2024 09:06:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: linux@treblig.org
Cc: richard@nod.at, hch@lst.de, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubd: Remove unused mutex 'ubd_mutex'
Message-ID: <20240506070648.GA6506@lst.de>
References: <20240505001508.255096-1-linux@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505001508.255096-1-linux@treblig.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240506_000658_820006_347E41FD 
X-CRM114-Status: UNSURE (   7.42  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

