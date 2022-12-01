Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36271C43217
	for <linux-um@archiver.kernel.org>; Thu,  1 Dec 2022 18:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pAo/bun32ptkxvpjUnbJRY6G7KKmNf9xAxpoPN2lL7g=; b=Zq3CQGaVMwpWDc
	YuxfxlSdDVw9VmQ5jf8xBWkmVjU8EMshWNWHbh15vmExCWiGcTPIH3l5Ghm0Ec+q0lmZtc4sVqxY0
	RHX+n5y4Ed2njEv53m0kYR2ejY6IqKTb7RUNDWRQ/HyoZNbi32WW5UYxVFMC5fR6d7ME9TWncwQzu
	I2ty6zc/AnCX7JcQarShJy+Euz01lQtt/DRurlGyfZ3ipdgKGOYkl0YN53K1kctasTNeLLsijB7RI
	+5fZCQ1YbhByPCFWGXHktQwHqMo1GJaUexJtgxAOq3sqhHlZg33dFLh3C4I6egsZNFQQ8GZpFEscI
	h1i9Y2Yyo0ndSfX4LEew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0nwX-009RO7-2I; Thu, 01 Dec 2022 18:05:53 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0nw9-009R3q-0E
	for linux-um@lists.infradead.org; Thu, 01 Dec 2022 18:05:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7D8A5620B0;
	Thu,  1 Dec 2022 18:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6332AC433D6;
	Thu,  1 Dec 2022 18:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669917927;
	bh=zLB1Nh9GGDyIWBvfvHJFIAPcZZ4kNqUaEGoqNwVteK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ljUvm6l4FHjwYPLmknS6tyH13hRQrpFwTMkv4wiqFLsK2UQJlhg0gBixPkZ9qGoL0
	 jiknIrw74IBNpZmoQQ6cSZg2HkrPzL/kN3a8vXuanT8Y+gyOo0nSbRrNb2X/hAHD1b
	 9W2pVkiwN1/V9RCyi57e5Ixo7NQ+/g4YxDpFrKUbO+hlwp+tCQyMQCIJn7RL2Fc6ze
	 M7SHCW0BsVm7NEEPkgWjwIfXm1t/7k/7xzVhI30gfKu1ZQmMQD2vTUbN2fZb7cLlaV
	 Bb3HkOWD4O55K9chhSUo+FlIocFIHA7Rz6EC6UmblQ8FniZRRyMrWYeqGaFLqiWped
	 oRhCqGL4VWiBA==
Date: Thu, 1 Dec 2022 20:05:23 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 1/2 v2] IB/qib: don't use qib_wc_x86_64 for UML
Message-ID: <Y4js47I/JjCXunzF@unreal>
References: <20221130200945.24459-1-rdunlap@infradead.org>
 <Y4hyPPzyQiI3i9jh@unreal>
 <Y4jhMwCox6RGI5FM@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y4jhMwCox6RGI5FM@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221201_100529_114658_3260A32F 
X-CRM114-Status: GOOD (  12.07  )
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

On Thu, Dec 01, 2022 at 09:15:31AM -0800, Christoph Hellwig wrote:
> On Thu, Dec 01, 2022 at 11:22:04AM +0200, Leon Romanovsky wrote:
> > I would advocate to add this line to whole drivers/infiniband.
> > None of RDMA code makes sense for UML.
> 
> software iWarp and RoCE absolutely make sense on UML.

Ok, to be more pedantic "none of RDMA HW code ...".
However does anybody use rxe or siw in UML?

Thanks

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
