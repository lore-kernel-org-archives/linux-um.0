Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1455C43217
	for <linux-um@archiver.kernel.org>; Thu,  1 Dec 2022 09:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+ChpDQEFpIFZbPrn4vmMQ/2Rpo0YAf36jJ2W6StSUDg=; b=mUXBKdQkGSDooU
	ppqauKBlPQN/bSgzyxbiHJwLrntiiwZbWudTBOwhlxPKmZC9zvH9XYlNe+UoZRKb5EBHZAaPcrtuo
	DYnQYJT2A3k1dfwit73Xev2WIzc9hf3BzGzuHMBhZ4YUHcotDDQEQe4GpObrpUrfjEHaN6qjS8Bhs
	HiE12zuG3zsYGtNBBaakTAzCYJh/SFEHxKIzKH0iSVLXmiiOBFeyoGgQqAp+xaSK87k9bUL6xU0Cf
	O7OVNNaETdDbb/8qpvXx0QLX9YX2CNJRFm9a8qGAFJa83PhEGTSrXD139PXNmL1ioAGB0QpO/4rWS
	zp3w9Ayjwtchf7gD7K4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0fs8-006MWN-Co; Thu, 01 Dec 2022 09:28:48 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0fs3-006MTO-KA
	for linux-um@lists.infradead.org; Thu, 01 Dec 2022 09:28:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bjlickyhTxl1d4xNXaIojFEZJXJX16jZsh7QD+vtX3U=;
	t=1669886923; x=1671096523; b=bYpe4oCsn11vJcZIdk2WGlBxm1o/1NSP+bgstjkCmBXSEcJ
	MWt3HT66MIUobTQa3gdJQvhZSpaspEf3YeLtCsuehXG/DksAVtP1Ux8n9Haxc62uzraOaSPW6puRD
	qv5k0FuMJ+dUo/Knb/FicTrCQ5Mpn4KmXWzPlpdd3BnI5obRBMBzG+UIJnFQe8B9ZPKFzmZRUUA2P
	qluGVmW0msMjmUgXNZIeK5Iamr/ufU6t6/qicCG/wc8IzWo1HRnNetg9RISrpKZFUzRIRbhwOjrBs
	ni8eMHZbGOfVXGpA5GUIJMUqCbMT9mQjOa+HyI1CSnregZd1jf7ULxHPR2x+uZXA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1p0fre-00E0NW-3D;
	Thu, 01 Dec 2022 10:28:19 +0100
Message-ID: <9fdd6581efb75511f3259ca663cd1afaee4ae4ac.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2 v2] IB/qib: don't use qib_wc_x86_64 for UML
From: Johannes Berg <johannes@sipsolutions.net>
To: Leon Romanovsky <leon@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>, Dennis
 Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Date: Thu, 01 Dec 2022 10:28:18 +0100
In-Reply-To: <Y4hyPPzyQiI3i9jh@unreal>
References: <20221130200945.24459-1-rdunlap@infradead.org>
	 <Y4hyPPzyQiI3i9jh@unreal>
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221201_012843_730445_13B9F539 
X-CRM114-Status: UNSURE (   9.49  )
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

On Thu, 2022-12-01 at 11:22 +0200, Leon Romanovsky wrote:
> 
> > +++ b/drivers/infiniband/hw/qib/Kconfig
> > @@ -3,6 +3,7 @@ config INFINIBAND_QIB
> >  	tristate "Intel PCIe HCA support"
> >  	depends on 64BIT && INFINIBAND_RDMAVT
> >  	depends on PCI
> > +	depends on !UML
> 
> I would advocate to add this line to whole drivers/infiniband.
> None of RDMA code makes sense for UML.
> 

You could argue that one might want to eventually use kunit for some
bits and pieces in there, so it'd make sense to be able to build the
parts that _can_ be built, but I have no idea :)

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
