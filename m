Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DB9C83F1A
	for <linux-um@archiver.kernel.org>; Fri, 11 Jul 2025 06:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=44pCLGpLaIC4GmvuWhJV0PyvAaAXyESqQI2KW62Nrvo=; b=aPysS2INWjV+ag28z3iBsQUrd4
	fHfKjEXWsfaKBu3KOWD1xu7FU8Lft1YTU8gRiMIrDdwXvwK2sD4+ydDWgEvbfHAp+rAOmgiBaeYvr
	yKnAOrWczzI4aZcDONt1E51uwk9ZCJiNkli1QABDiD9iRQKscqc1o1at2g7dXEa81B7e0b5+Jpspl
	4Dh5qYtxWa2O5crsNVddZvnqy+ZIo/HH8sss+wV7zEWmcejgOIzzmoxJFam/cAIBau58N7+HY3o5B
	xcf2RbVDtuVkvli1izzlQN9z+3HShU+xDoIn6IA7TGaOJbE3mOW8nR/7+CMjUh6Jm016ucuDO2bZX
	5PhM3FyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua7ZV-0000000DtJH-2MRN;
	Fri, 11 Jul 2025 06:49:25 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ua7ZT-0000000DtIJ-0HYr
	for linux-um@lists.infradead.org;
	Fri, 11 Jul 2025 06:49:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=44pCLGpLaIC4GmvuWhJV0PyvAaAXyESqQI2KW62Nrvo=;
	t=1752216560; x=1753426160; b=HNAvI7e2ewxoBQujAW7bLO7x8dZ4T2V4928d1pE0UZnfJky
	nJcW4z0cRm61+BYrufpJhYJRHorBhTXDUChRgDQAmKh9HXlPVcgwqumDzJqS4hO49+qkGt+oIJYey
	33g6CoV8BwvcFmYcPvTkw01KYollP+ClnltU2GIlkvmcX0QrLfUwJEwR9Wxwb1g6rBJJlzleTDbBY
	M+4zTs2DTMcoUvCq1qZkOvIyDifTu49Twdipyvzhz2iESWc37ofKGpMqVCpvJGnCtp/rQAcxPCjHO
	lc1+oUoDMocr2I71i0mUxzNfV8bp5o3WQ5F9ILtanzf3MP5cmOkYtMZCginjza8w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ua7Z1-0000000FwWs-2LAn;
	Fri, 11 Jul 2025 08:48:57 +0200
Message-ID: <d88d15047569b57c7e7cd751670f56ffb4d5c1a8.camel@sipsolutions.net>
Subject: Re: [PATCH] kunit: Enable PCI on UML without triggering WARN()
From: Johannes Berg <johannes@sipsolutions.net>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,  Richard Weinberger	
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Date: Fri, 11 Jul 2025 08:48:45 +0200
In-Reply-To: <20250627-kunit-uml-pci-v1-1-a622fa445e58@linutronix.de>
References: <20250627-kunit-uml-pci-v1-1-a622fa445e58@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250710_234923_103715_969114F3 
X-CRM114-Status: GOOD (  12.87  )
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

On Fri, 2025-06-27 at 17:21 +0200, Thomas Wei=C3=9Fschuh wrote:
> Various KUnit tests require PCI infrastructure to work.
> All normal platforms enable PCI by default, but UML does not.
> Enabling PCI from .kunitconfig files is problematic as it would not be
> portable. So in commit 6fc3a8636a7b ("kunit: tool: Enable virtio/PCI by d=
efault on UML")
> PCI was enabled by way of CONFIG_UML_PCI_OVER_VIRTIO=3Dy.
> However CONFIG_UML_PCI_OVER_VIRTIO requires additional configuration of
> CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID or will otherwise trigger a WARN() i=
n
> virtio_pcidev_init(). However there is no one correct value for
> UML_PCI_OVER_VIRTIO_DEVICE_ID which could be used by default.
>=20
> This warning is confusing when debugging test failures.
>=20
> On the other hand, the functionality of CONFIG_UML_PCI_OVER_VIRTIO is not
> used at all, given that it is completely non-functional as indicated by
> the WARN() in question. Instead it is only used as a way to enable
> CONFIG_UML_PCI which itself is not directly configurable.
>=20
> Instead of going through CONFIG_UML_PCI_OVER_VIRTIO, introduce a custom
> configuration option which enables CONFIG_UML_PCI without triggering
> warnings or building dead code.

Alright, so looked like Thomas wanted this to not be merged via the UML
tree, which does make sense, so I've dropped it.

For the kunit tree then you can add:

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes

