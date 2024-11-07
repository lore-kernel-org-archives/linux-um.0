Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7BED5D682
	for <linux-um@archiver.kernel.org>; Thu,  7 Nov 2024 18:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xDFPWpt1ROkh4RBEKwk0+oAjBpf2QWb2FgYKqrytfTI=; b=Lp/6ER9SrDesGPNkT2Ny1avTcd
	Jn2kpmRCRyBKtJSMSNwUIfJa3Bh2fTZN+lC+JSBNpvYajLre0+26t3ePU+2Wa95mxT9UQ97QjfuJG
	JYxNXfs3qMAO7I3M2M8vOAw5uqYbNfk/JimSAuNjizAlKMINgDzJN6WM6tpnL+IAYaQRC7mghvdZU
	8qRPcNnMj+oXTvSLsR7NZ4lTzNIWJIBNatRvP1btu/ASF6Ec+q5FunIj+7T0JPkwsL8k74dqv9mVR
	2Cjltumsp3u9PL3GSeYhHMo7yfW6q9ZJwZ3NKYg/FHneWHTKvhF6gjlsEqCn6UgOAP6vE8b5Uih9o
	CAtOfrkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t973i-00000007v3H-1C9p;
	Thu, 07 Nov 2024 18:16:42 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t95tM-00000007kBN-3cKT
	for linux-um@lists.infradead.org;
	Thu, 07 Nov 2024 17:01:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=xDFPWpt1ROkh4RBEKwk0+oAjBpf2QWb2FgYKqrytfTI=;
	t=1730998915; x=1732208515; b=Rc6YNExMjRa1ZjGT3v2eMy6qkygI+sLZ0bzBQDmSwrD29EF
	LhRaAWLIbnEk1++u9HhyC6u0A6XEB2mVrkNUQ+6ye0UUbjKx4g5ZiVkMDuBd8llrHC48F2KAMGvhY
	yQfEw+5aEId49P9TuIzBwLrh+L6RdKZYUEF09CtS4YQZpSi2ZY2a/de1q1aIps7TmlKwQMkiXFSGj
	/at8Es/2K+0HUUT6UyByv8bdbJzmGmHBlfOWr7C0Gg14rRYvys3AxetDLd+8XHiKYpuQnwZX1NuB6
	I7mbX8pyBl9MKj3Yeo1PsZLUTXcDhvumdkLBB2CB0XYMkwhxJZmXPF7UDeONrobQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t95tH-0000000GVPb-37Pa;
	Thu, 07 Nov 2024 18:01:51 +0100
Message-ID: <0e6b8a0a5b5f84b0d2d04ce64042e9442f60c31c.camel@sipsolutions.net>
Subject: Re: [PATCH 2/4] um: virtio_uml: use smaller virtqueue sizes for
 VIRTIO_ID_SOUND
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
Date: Thu, 07 Nov 2024 18:01:51 +0100
In-Reply-To: <20241103212854.1436046-3-benjamin@sipsolutions.net>
References: <20241103212854.1436046-1-benjamin@sipsolutions.net>
	 <20241103212854.1436046-3-benjamin@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_090156_922758_8B22C7DC 
X-CRM114-Status: GOOD (  10.53  )
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

On Sun, 2024-11-03 at 22:28 +0100, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
>=20
> It appears that the different vhost device implementations use different
> sizes of the virtual queues. Add device specific limitations (for now,
> only for sound), to ensure that we do not get disconnected unexpectedly.

I'm not convinced this makes sense. If anything, it's a workaround for
some specific userspace, but ... do we care enough and not let them fix
it?

The protocol [1] basically says we decide on the size (see
VHOST_USER_SET_VRING_NUM) and the device doesn't even need to allocate
the memory, that's on us?

[1] https://qemu-project.gitlab.io/qemu/interop/vhost-user.html

So maybe let's see what they were thinking? I'm not sure it's important
enough right now to have this working to apply such a workaround without
some further discussion?

On PCI it seems that you can and should query the desired queue size
(see e.g. vp_modern_get_queue_size), but with vhost-user that doesn't
seem to be supported at all, so there isn't really a good thing we could
do in that sense.

johannes

