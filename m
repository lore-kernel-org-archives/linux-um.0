Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FD2C43217
	for <linux-um@archiver.kernel.org>; Thu,  1 Dec 2022 09:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=DN9V1HnzoNOUN/GI8S3Z+56u/hJ7Vs0bv1A6iCNc8hM=; b=wcSoAqRYip5iCtSVTlMROu8cod
	0WIjUwY9RItHmdCltF7cWKIlqj8+2RpmRbhFrVqm4QBBrJpUnamuZhh05vvyJSf/Hc9gtzORABIqE
	AK582tXLoGvncBZ9vBaJxAZVemD/KZELUF9wwwVKZnFF2SSaSMPHO+7w4rfobGJxcmFTexUPBK2xp
	gH9B+ohiVZf/1zC80MsFuhIEu+g4ERBk3926nKgT3sSze/I644uQ/YTZT+Gk5ZG9CN9tvW2+bqn38
	f2aA5xoUhP8of2pBgGyNzp2STteNQiHVCjNKSvxX+SQe+BcclUTwrwEhIqNa4YPjkigJrwUkh38XM
	nFHpLZRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0frr-006MNM-Mz; Thu, 01 Dec 2022 09:28:31 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0fro-006MEH-2m
	for linux-um@lists.infradead.org; Thu, 01 Dec 2022 09:28:30 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 614FB636DD54;
	Thu,  1 Dec 2022 10:28:15 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id wy15M_caSQ6A; Thu,  1 Dec 2022 10:28:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1F60D636DD5A;
	Thu,  1 Dec 2022 10:28:15 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CL8-7XLNLvLL; Thu,  1 Dec 2022 10:28:15 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id F2E91636DD4F;
	Thu,  1 Dec 2022 10:28:14 +0100 (CET)
Date: Thu, 1 Dec 2022 10:28:14 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Leon Romanovsky <leon@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
	linux-rdma@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>
Message-ID: <1246601249.327108.1669886894894.JavaMail.zimbra@nod.at>
In-Reply-To: <Y4hyPPzyQiI3i9jh@unreal>
References: <20221130200945.24459-1-rdunlap@infradead.org> <Y4hyPPzyQiI3i9jh@unreal>
Subject: Re: [PATCH 1/2 v2] IB/qib: don't use qib_wc_x86_64 for UML
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: IB/qib: don't use qib_wc_x86_64 for UML
Thread-Index: f2COGTrJT+QspUCPV5hCPvg3sKp3dg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221201_012828_329679_F346EAD7 
X-CRM114-Status: UNSURE (   2.17  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IEkgd291bGQgYWR2b2NhdGUgdG8gYWRk
IHRoaXMgbGluZSB0byB3aG9sZSBkcml2ZXJzL2luZmluaWJhbmQuCj4gTm9uZSBvZiBSRE1BIGNv
ZGUgbWFrZXMgc2Vuc2UgZm9yIFVNTC4KClllcy4gTWFrZXMgc2Vuc2UuCgpUaGFua3MsCi8vcmlj
aGFyZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
