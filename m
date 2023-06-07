Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C9DC77B7A
	for <linux-um@archiver.kernel.org>; Wed,  7 Jun 2023 09:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=13ZUI4T7T53NQeZTEoJC00YvPLzln0eYUuc0lHg7eN0=; b=lqakQQgR6oVJZE
	Gomjq+1Ki0HtXchFPHOtLmO7JKo+w6tlGgs3b3koJa7+jckOjEt2QovRNji0tdJyh+uZ0ruEgSgD4
	qLvDBsDRw4/Y/sgz+27IlEsaoLGQGaYgB58aqWN7PrFDNXRrXjNR7rZPpE82Dez6gbzh9nMU61pE5
	vY5zg5gxrA56Z8CmGPk4BBuSsb6wbj2FrqtAUlB2aQzFXyuZ+vdflLVN2/FtyeZzR+qszwnZs3cA1
	2jhRncf0iLFmuTfsoRgaWVv7gWViuHJK6EeC1XozZPNnOtAxveYH+8XW9b9vNwWpFYYpJBvGSxpDw
	30u0eXyEBWnenpbOKwIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6p5C-0059H7-2m;
	Wed, 07 Jun 2023 09:03:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6p58-0059Df-0h;
	Wed, 07 Jun 2023 09:03:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BB1906333B;
	Wed,  7 Jun 2023 09:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E80DC4339B;
	Wed,  7 Jun 2023 09:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686128633;
	bh=Xf/4P91dRygUOBcu7Gf2FM/yIcNpKmxg81kLyQ/xABI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IN6GC1DPfELHi6cX+5K0wKVVtYJ3DXedGhjwgRx699RBFbnd08dZETxrlqxzpLWKC
	 ekLoBpbWyqE6gmBLFLtkaZYgr6+AIeoZpKwDTwgdWG99m14V2UqWKfwBTtVvgUBRu+
	 0e6TBWMLJuIbAlRNYxIXjylaMD7QGrfKMwVXHWPcJnjd57/ddsdyM/BmkOIIfzhzqD
	 30g5q2KZ4YvHf7cCwWG4eQIpdKajUy1CEU/O6AmKN2EBhjjDNdUAUDLCZCHrmIXgZM
	 kwBNuzs8INbYR7r2R62ZE/viyZfDvNDpkswXSRvBH+lz4n+zQ2vNlfy8TcF9REK4vz
	 k5N5wSWsZUJNw==
Date: Wed, 7 Jun 2023 11:03:45 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Phillip Potter <phil@philpotter.co.uk>, Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
	linux-block@vger.kernel.org, linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 27/31] block: remove unused fmode_t arguments from ioctl
 handlers
Message-ID: <20230607-umgewandelt-fabelhaft-5f3c72318a9a@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-28-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230606073950.225178-28-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_020354_308469_CF02734B 
X-CRM114-Status: GOOD (  10.74  )
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

On Tue, Jun 06, 2023 at 09:39:46AM +0200, Christoph Hellwig wrote:
> A few ioctl handlers have fmode_t arguments that are entirely unused,
> remove them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
