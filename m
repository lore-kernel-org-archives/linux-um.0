Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BFBC43217
	for <linux-um@archiver.kernel.org>; Thu,  1 Dec 2022 10:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4LBV8ej52cRrLoU76Fo9KaPpbGLPHNOm+fLvWPvSqBk=; b=lJv6fubLKb9Euu
	u9rzFSg9+U9y880mB50mI/KlvsyM2Euij4E+Btp8HBB9DwW0DRTR7MUr5aIJ5aaw3ZMU3N7p12/Q4
	u7hX1xJWCK/Mh2I/0NzdyTqL+7rJGuSGdiqzpem0jdobp7wyuKv3kuDgOK5B/ujcoHAn2XCEf/zPr
	ubKQGWZ3TsS1TUwwVaH8D7xE/jk3XfYOlBpUyNA1kWZiJoqLw55W3CcJqgMG+VWZyvE2BFCWbNECv
	waaX31BVwcPh4XZlupFST+LiyQYUfPNO8dhaXTAeN1T+AcM2CaU/Xd6c4nBnt/O9gloBM6AUFmSN4
	J4LRWjbim3RcaqNNMaQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0gYT-006cCV-LI; Thu, 01 Dec 2022 10:12:33 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0gYQ-006c9t-SD
	for linux-um@lists.infradead.org; Thu, 01 Dec 2022 10:12:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 4E8DEB81E4E;
	Thu,  1 Dec 2022 10:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678E6C433C1;
	Thu,  1 Dec 2022 10:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669889548;
	bh=84mbUFlPHlzj3D5sBUAYJJUyYWewmr2dNPatZ/juvE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ie8d7vzMdjmqxqCLS3Nm/+1gyn7AVoCWrZMptGVXiGptbqiV79Q6OhKqrXkZeodbG
	 KbECWJG9tl8wufYzhfvM5AY7Q3nlyIcEI5Mx7qOF4TofoYiLSJT/iQfTbQGtm7zo/w
	 nrzsM6JfFer5WCuFHrdcjdiP8bkLPD2FzSHGwBvsoO0fczAV9aN4/IY84Xzojw9JIt
	 CLpUwfI0edbrBOadCGDkvsZZxHdUBUp4c5r3/WrwmqPINkYAzEYkeNreZSxG5eukLR
	 s9AyPWkZ1lX1Wf0FYXKv0odcxHccjicJTw51ZhLuuefwFwA4iO6/7Lo2As/lbDGUEF
	 FGo0sHw6QNtDg==
Date: Thu, 1 Dec 2022 12:12:23 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 1/2 v2] IB/qib: don't use qib_wc_x86_64 for UML
Message-ID: <Y4h+B7vEvkgbMbZ7@unreal>
References: <20221130200945.24459-1-rdunlap@infradead.org>
 <Y4hyPPzyQiI3i9jh@unreal>
 <9fdd6581efb75511f3259ca663cd1afaee4ae4ac.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9fdd6581efb75511f3259ca663cd1afaee4ae4ac.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221201_021231_074972_E276AD2A 
X-CRM114-Status: GOOD (  17.40  )
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

On Thu, Dec 01, 2022 at 10:28:18AM +0100, Johannes Berg wrote:
> On Thu, 2022-12-01 at 11:22 +0200, Leon Romanovsky wrote:
> > 
> > > +++ b/drivers/infiniband/hw/qib/Kconfig
> > > @@ -3,6 +3,7 @@ config INFINIBAND_QIB
> > >  	tristate "Intel PCIe HCA support"
> > >  	depends on 64BIT && INFINIBAND_RDMAVT
> > >  	depends on PCI
> > > +	depends on !UML
> > 
> > I would advocate to add this line to whole drivers/infiniband.
> > None of RDMA code makes sense for UML.
> > 
> 
> You could argue that one might want to eventually use kunit for some
> bits and pieces in there, so it'd make sense to be able to build the
> parts that _can_ be built, but I have no idea :)

But now, we don't have anyone in RDMA who uses kunit. Once it will be
needed, he/she will extend drivers/infiniband to support it.

Thanks

> 
> johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
