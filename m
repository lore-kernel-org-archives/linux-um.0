Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34686CAC5A9
	for <linux-um@archiver.kernel.org>; Fri, 19 Sep 2025 09:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PoICDzH2/VRmvGDHWLmPf6AlqNG0CMWG+Nk9x/31v0A=; b=msRVnGTEBLQGVLraSGA+4Omaa2
	CP/3DSf9ZjJdXHVHh49ueJRQ3uBjWXx5YxaGd5gvONmtLk7tMSfrNNyrd2aKTD5sHf4EC7lZ0+dJ4
	ykcfav8IGGYLwspzkBh5agDn8VrTLqWiyqW9bta4yjIEv9oLoN+lYCb81Q4xCc7OFTuH3FUFbIWaT
	hqRygSs1/3LmaOEgQeG0y6BzfSdsFAc68XDXS40Aec0RuZcY0qviVpdWFORhcpb6qY4Q3WUfMTfI3
	lDXIr1OmznVYg0jtVMFyS7K11EgENSU/UOqiinfeyBDYDsOfsbXvohIkOPY3/e1xWBWFSenl85pP3
	LztSWhGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzXZm-00000002Q2u-43GR;
	Fri, 19 Sep 2025 09:38:46 +0000
Received: from s3.sipsolutions.net ([168.119.38.16] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzXZk-00000002Q0G-2iAv
	for linux-um@lists.infradead.org;
	Fri, 19 Sep 2025 09:38:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PoICDzH2/VRmvGDHWLmPf6AlqNG0CMWG+Nk9x/31v0A=;
	t=1758274724; x=1759484324; b=azmcg1QL1OP2eTrK4DZc/WEfjGaLPZGScrxedh+Kv56KWmj
	7qbWDENygg4jqm/fjuuDwWtCp9S44DJkav79Yc5UGzajnPUsGG4WKdzhZWu0gmpEBTkZrmOmO7cvc
	xMh0jhejJsNnS5REqQ2C7aW38diB4bGf3H6159HjAnRNZGdzL7JgAhKawDC/ZVmTQKeKVaCtYm2wn
	Snw5naKmxrVBK2rur1SCVjBlLq85iVWkE/du21n5QiMqpyVvbQGpnX+x+/g13j6RYtTzPnEDY1514
	0YCtEt9E48Hyc6llIex8Lbl0o8B1592OpAUQJcG3/vvpCy/lka/k7MG3tZ8ICdsQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uzXZh-0000000FdhH-3S1z;
	Fri, 19 Sep 2025 11:38:42 +0200
Message-ID: <78c173c1f5f61430ef33e22559e3d1539db36395.camel@sipsolutions.net>
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU
 dependency to PCI driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com, 	linux-kernel@vger.kernel.org
Date: Fri, 19 Sep 2025 11:38:40 +0200
In-Reply-To: <da39f51b76cca54e5304064f7e34a8863442605d.camel@sipsolutions.net>
References: <cover.1758181109.git.thehajime@gmail.com>
			<4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
			<a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
			<m28qib8g1r.wl-thehajime@gmail.com>
			<6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
		 <m27bxu949d.wl-thehajime@gmail.com>
	 (sfid-20250919_113237_926194_6AC3D71B) <da39f51b76cca54e5304064f7e34a8863442605d.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250919_023844_685634_DB53AA67 
X-CRM114-Status: UNSURE (   6.73  )
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

On Fri, 2025-09-19 at 11:38 +0200, Johannes Berg wrote:
> My gut feeling is that UML_PCI_OVER_VIRTIO should depend on PCI but I
> don't know if that then doesn't end up in some kind of circular
> dependency.

And all the discussion is also true for UML_PCI_OVER_VFIO which also
selects UML_PCI.

johannes

