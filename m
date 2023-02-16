Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC96AC636CC
	for <linux-um@archiver.kernel.org>; Thu, 16 Feb 2023 22:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=fBhL4eN1R4FSzNFKVDsgXCHgXjDmRkAB6CUefNe3SUs=; b=fnu3nn1IFqwrryVx6GqC7NRhql
	0MOWlXOLE25L8X2fO7ao9/WsmGWMwtBQ3GCwMxRsDxoUaSwKQH0XOtwNKF5O16W/iR5yY/H+T4u/A
	hwjgzzBNyf2Fu8H0Kk8jmlbXeK2nUvWceNICOrCvGfS8XhtmRT0QtzzU6Thofzj6Dmp1ocHwczqtf
	OPqoTtFHJtZV+HrVDFVPr9SRHpCUup8118jXswuY1iV9IVOp5tSLRe0WNCyB4cVk2P1YA2rj/S1rY
	Lt3O7DsyM9FQOjaOkU6IWLA3UIfRHThSnh3qOrqFEpzF/pcNfpuhwBz5g6A5+BuYSmkf4R9SXZkAs
	dt/EFxqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSn9O-00C4DC-OO; Thu, 16 Feb 2023 22:54:50 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSn9L-00C4CG-3e
	for linux-um@lists.infradead.org; Thu, 16 Feb 2023 22:54:49 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 45B596399217;
	Thu, 16 Feb 2023 23:54:39 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Ls4AIdU_8dHV; Thu, 16 Feb 2023 23:54:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7183A6399235;
	Thu, 16 Feb 2023 23:54:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hz5raoBAzGXe; Thu, 16 Feb 2023 23:54:38 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 505F56399217;
	Thu, 16 Feb 2023 23:54:38 +0100 (CET)
Date: Thu, 16 Feb 2023 23:54:38 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
	Glenn Washburn <development@efficientek.com>, 
	Kieran Bingham <kbingham@kernel.org>, 
	linux-um <linux-um@lists.infradead.org>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <283287920.144364.1676588078240.JavaMail.zimbra@nod.at>
In-Reply-To: <20230216144001.e1a9dea15a6c4f93b7b8a442@linux-foundation.org>
References: <cover.1676532759.git.development@efficientek.com> <8a22d84e-5cf4-bf41-220e-dc5e48fb2fc3@siemens.com> <20230216144001.e1a9dea15a6c4f93b7b8a442@linux-foundation.org>
Subject: Re: [PATCH v2 0/2] GDB: Support getting current task struct in UML
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Support getting current task struct in UML
Thread-Index: I59TWds4xE37fTiVYiHV8XVDVK2xrw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230216_145447_339250_EB23AF9D 
X-CRM114-Status: UNSURE (   3.84  )
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIkFuZHJldyBNb3J0b24iIDxh
a3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPgo+IFRoYW5rcywgYnV0IEknbSBub3Qgc3Vic2NyaWJl
ZCB0byBsaW51eC11bSBhbmQgbXkgdXN1YWwKPiBnZXQtaXQtZnJvbS1sa21sIGRpZG4ndCB3b3Jr
Lgo+IAo+IENvdWxkIHdlIHBsZWFzZSBoYXZlIGEgcmVzZW5kLCB3aXRoIGEgY2MgdG8gbGludXgt
a2VybmVsPwoKWW91IGNhbiBhbHNvIGdldCB0aGUgcGF0Y2hlcyBpbiBtYm94IGZvcm1hdCBmcm9t
OgpodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbGludXgtdW0vbGlzdC8/c2Vy
aWVzPTM0MjIxMgoKVGhhbmtzLAovL3JpY2hhcmQKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtdW0K
