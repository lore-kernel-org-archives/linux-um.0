Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CEACAC592
	for <linux-um@archiver.kernel.org>; Fri, 19 Sep 2025 09:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ko5AkknG3Ii2DJQfIqOZTszM7x9Fr2zaNmiIAC+x8lU=; b=veI68g7bvptYtzRIpYoNeUgxrs
	toDaaQZy1hTPKX6vf5oKfIiJhSL8aTavrXNc/qgIHABv5PnWFrOU0B6J3wOHJ+qO274v2O8ihl2yz
	ROyfLcgPgxMn+UWwSP8TYCeJob50xY5op6Ew4uNCJex8OlPQbDLmzCPNoOeODNq1O1syQ0iwHg9VB
	dAG0Cj8vWvXNWxxzKs/lWIgoKodY3TEs0Wn3EXhmGZZkb2iO1zLW2Ry5oK6+Dy230DIyQjpX65Dna
	7gF6o5EIY+iOJtSKQ/q+jBhUhdfToQyPtDPtS0dfxeCtUW9Hds5sffiBm0p76pujkleENChjqY3/q
	7SZ7bd7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzXeL-00000002QkY-17Zm;
	Fri, 19 Sep 2025 09:43:29 +0000
Received: from s3.sipsolutions.net ([168.119.38.16] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzXeI-00000002QkD-2DUL
	for linux-um@lists.infradead.org;
	Fri, 19 Sep 2025 09:43:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ko5AkknG3Ii2DJQfIqOZTszM7x9Fr2zaNmiIAC+x8lU=;
	t=1758275006; x=1759484606; b=lz8mzf+cHxVg01DeznAOqhqrxXUUl3O6uqUSYu9KjnP/ceK
	i4sMyvuiqBhJHXDDlwTBnBEmlx9gvYYsfl2w8sFNiqjNVnkiK8GeZMpSQYEcBFl7GSoxs3hlrrbj1
	zNv62lipENtfIsulUjST8VFMtnY4TH6N7+wZ0FYQUBwzQYmFt+GxW398a4ZJXchmeD4yoSkWoMNAs
	dx6FPJ8E5qQ0b0Je0PHCrrGHyfEo4MvFJS+Z+Bvq2IYokh0/+0ANi3C8S8svCxe9ldByoTV6tUSz6
	ji/K+Nv0A2ak8hQ9XfxWbfjPvEMtGhjnB0+PMlt2ZRzPIjpG4uhheM/fIzowNWtg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uzXeE-0000000Fe5z-2pNA;
	Fri, 19 Sep 2025 11:43:23 +0200
Message-ID: <ae655664adfad625928311cdb48afa080e0f6c4d.camel@sipsolutions.net>
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU
 dependency to PCI driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com, 	linux-kernel@vger.kernel.org
Date: Fri, 19 Sep 2025 11:43:21 +0200
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
X-CRM114-CacheID: sfid-20250919_024326_564777_F16A5B1F 
X-CRM114-Status: UNSURE (   8.80  )
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
>=20
> My gut feeling is that UML_PCI_OVER_VIRTIO should depend on PCI but I
> don't know if that then doesn't end up in some kind of circular
> dependency.

No, that _is_ wrong, and it will end up in a circular dependency,
because for UML_PCI we currently do FORCE_PCI and then we have PCI and
HAVE_PCI and it all messes up ... Which is all correct right now.

That still seems reasonable (why give the choice of selecting PCI after
having selected VFIO/virtio PCI), but then with !MMU it can't work, so
the pieces there just need to depend on MMU.

johannes

