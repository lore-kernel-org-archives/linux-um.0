Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD42CC4708D
	for <linux-um@archiver.kernel.org>; Sun,  4 Dec 2022 13:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-Id:Subject:
	References:In-Reply-To:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CuacR08dSJilqaxaUTsjQBW+QYMbrh9gED1gVV4wjps=; b=ZsXoFFoT6HdMYA
	vlarx3ZkIIckhIWTMExlJluLAXXTh5A2ESFdxuTZve5u4Iue0fVm/w2/RWi1s8rJypHpMOw8fbTbW
	j6BbkkIVYFQqPhrr87Gpjz5N0Q430/qS2kSkCB/l5y9UNaCnFA7RLrcdxrUPdrmNiEp0BMrUD3n3e
	OhJM2Z5caRcQhZVs9VJvnwZhmQHFWqtAaJA69IJp+H6N577CkaQnlvaMYNUMDUqq9DG6YlIbZZ05g
	ubPmX3zhMhb6pSqpJAbSyP8oBovXcDL51DlD6VPr/DYLs+lc1NikaJOjlodY3Z+ZaC0I0Xo7+zJzm
	MCRdzH7Se6tlh4ALVBTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1oy4-008Ci7-CF; Sun, 04 Dec 2022 13:23:40 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1oy1-008Cfw-EG
	for linux-um@lists.infradead.org; Sun, 04 Dec 2022 13:23:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id BFF6DB8092B;
	Sun,  4 Dec 2022 13:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD00C433D6;
	Sun,  4 Dec 2022 13:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670160214;
	bh=MgTQ8q6E94moHiSPp3pcN9AG9weUpTT6tPXfNB3DjXg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=s/YG8gsFRni1Nh1LCZkoIKTtY8hvwB2nORPEAx9GViiDkghnOKCKc8RC/doRodMtT
	 /66K3f2d+Pk144Cvv133R5yemIgStXC+rS8V2A8b3lprEAW6h0MGt32aeCGPNnsPDm
	 cF441iXVZFEN49kOR8/0vANSIqw6ITUKstzEJtN1D3S/Jb3mhBv7gRNmilAfHor1h7
	 YoPTdGR4doS3QjiGmHJnmDEXoPtC9spDMSRF/p54TZOmcFwcEyPcSjVw5FQ3XMNK9u
	 0MX6rPwv/+nVo7GPxoNnuSKFZkumcDzAclZ6Yu+GLRYvH6QlWbIueLqHP6dfb9OZj7
	 GIVkGlTaWLVrA==
From: Leon Romanovsky <leon@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@infradead.org>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>,
 Johannes Berg <johannes@sipsolutions.net>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org,
 linux-rdma@vger.kernel.org, Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
In-Reply-To: <20221202211940.29111-1-rdunlap@infradead.org>
References: <20221202211940.29111-1-rdunlap@infradead.org>
Subject: Re: [PATCH v2] infiniband: disable IB HW for UML
Message-Id: <167016020363.36226.13998271236937647073.b4-ty@kernel.org>
Date: Sun, 04 Dec 2022 15:23:23 +0200
MIME-Version: 1.0
X-Mailer: b4 0.11.0-dev-87e0e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221204_052337_646114_6132198A 
X-CRM114-Status: UNSURE (   7.25  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Fri, 2 Dec 2022 13:19:40 -0800, Randy Dunlap wrote:
> Disable all of drivers/infiniband/hw/ for UML builds until someone
> needs it and provides patches to support it.
> 
> This prevents build errors in hw/qib/qib_wc_x86_64.c.
> 
> 

Applied, thanks!

[1/1] infiniband: disable IB HW for UML
      https://git.kernel.org/rdma/rdma/c/323a74fc20f53c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
