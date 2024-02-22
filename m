Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F38C48BEB
	for <linux-um@archiver.kernel.org>; Thu, 22 Feb 2024 07:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FO7DUyvF6VRHyNg2amxq7/xwMvD8CtHch2mPz+ypuO8=; b=Y7372dd/HOgc96DU+jl1SzEKsY
	UP64crgBZSwTOYRkWTjrf8THlRbRm8bXRCKMqmwPQpQMU0V4wNyrsva8AAOjpWSOk9PIa/Wa26DHQ
	duiIa7i0LRz/bJ4rPe4bIugPnakbOhEjpV/Vg9LHWJCCJ+XaRUJ1+n1YYR73CtgOo7sAcQ4vJJgt+
	9yWFAXKkFqhZokARR8g1x4eWR1cf+8OmLjrp1C1NwZtwnaV+9/VgTsfxznIL0X5VJqMzCgY8iseIz
	pkt0Y3+yFYABsdnX1ucTnX0D8ohpS9baj/yFDDa86GyUYfbxG+1hn/vtqGUYW0fdRc61HEpOcZ6bx
	HhkK3QaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3RO-00000003ncy-2FEh;
	Thu, 22 Feb 2024 07:24:22 +0000
Received: from [2001:4bb8:19a:62b2:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3RK-00000003ncX-45UO;
	Thu, 22 Feb 2024 07:24:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-um@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: ubd cleanups
Date: Thu, 22 Feb 2024 08:24:10 +0100
Message-Id: <20240222072417.3773131-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi all,

this series cleans up the uml ubd drivers and gets rid of more blk_queue_*
calls.  It is a against Jens' for-6.9/block branch.

Diffstat:
 ubd_kern.c |  127 +++++++++++++++++++++----------------------------------------
 1 file changed, 44 insertions(+), 83 deletions(-)

