Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F423CD3431
	for <linux-um@archiver.kernel.org>; Wed,  4 Sep 2024 13:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iSPVVeBjMRlj7n1AdDLiYOURvyyuDgx/JqQu1fk8o9M=; b=u1HYUgi8pCbPAfbQ9Nrv7mog+A
	RUhckLIxiUTRciiPLHv4096S7MO2v7FIMo6hFtWrTFouJ6Vjg1iIFcDPypng3EI6VrPg5sfGiD+N3
	V6k+CTCcx+8wkHLPIK6vLdCmH5x6gSogfH5qSt/nhr496hxOxJ6Rv4N3Q5R0BMbsW3uUElB1j0/lC
	ohyMatK7Qu9zQwusJrRTuzbGoUzdHV/KsGRnfLGCXzJ+paEMy69BlSy6CBAjNN/RRnu+K5l/AQ849
	QUUIMe1aUUGmHPvrlJYtMvGA1/peFBRkyPYWjMFq0KQj30Sd50KWHivSXDFNP4WbxZ+ZYlM9r1Wkv
	hq6zS4mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slqVG-00000004eZI-3GoB;
	Wed, 04 Sep 2024 13:56:58 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slqVD-00000004eX1-37vo
	for linux-um@lists.infradead.org;
	Wed, 04 Sep 2024 13:56:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iSPVVeBjMRlj7n1AdDLiYOURvyyuDgx/JqQu1fk8o9M=;
	t=1725458213; x=1726667813; b=Fjy1mbAiCWIX/PNib8C+X0RyGPFpWQxShOiUmYNhaLLb6pl
	D6d9T5kvwWQuVqMrMV1I2euATAVmGUk7IlUtAB4iNm0QQcO+KJbrpx7qW3Gr63ZsCp8GnZmqVvq50
	lW354xL2xI3MQRXPvnBMEUntBLdIQqGDlrOg/80vEbV6kxDgmVbjIADihIkEZ0zSP8YhvVPr72vaH
	kwH0zwuHOR50eyuvy8lyqHJGM7kkXZ4nrG5Zqwyw/yVmwOKpRMrUV+XY/1HTEO9PPMAuZhFCxLvIc
	Oqg56wbGpynv7KD8X30JWZTYDNVoJD1atKNDgbyXZGw/2+9b4J2OwBambgf/346g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1slqV1-00000004vJp-1fJS;
	Wed, 04 Sep 2024 15:56:43 +0200
Message-ID: <942a2aa5fc93f6dc1bc88b3b25e59b044a7a425f.camel@sipsolutions.net>
Subject: Re: [PATCH] um: kunit: resolve missing prototypes warning
From: Johannes Berg <johannes@sipsolutions.net>
To: Gabriele Monaco <gmonaco@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>,  Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>,  linux-um@lists.infradead.org
Date: Wed, 04 Sep 2024 15:56:42 +0200
In-Reply-To: <20240904135019.200756-1-gmonaco@redhat.com>
References: <20240904135019.200756-1-gmonaco@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_065655_802236_20F324FD 
X-CRM114-Status: GOOD (  16.84  )
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

On Wed, 2024-09-04 at 15:50 +0200, Gabriele Monaco wrote:
> While building for KUnit with default settings, the build is generating
> the following compilation warnings.
>=20
> ```
> $ make ARCH=3Dum O=3D.kunit --jobs=3D16
> ../lib/iomap.c:156:5: warning: no previous prototype for
> =E2=80=98ioread64_lo_hi=E2=80=99 [-Wmissing-prototypes]
>   156 | u64 ioread64_lo_hi(const void __iomem *addr)
>       |     ^~~~~~~~~~~~~~
> [...]
> ```
>=20
> The warning happens because the prototypes are defined in
> `asm-generic/iomap.h` only when `readq` and `writeq` are defined.
> For UM, those function get some default definitions but are currently
> defined _after_ the prototypes for `ioread64*`/`iowrite64*` functions.
> Moving the inclusion of `asm-generic/iomap.h` fixes it.
>=20
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  include/asm-generic/io.h | 8 ++++----

I get that you have this on kunit on ARCH=3Dum, but that makes it neither
a kunit nor a um patch :)

Arnd had originally wanted to fix this another way, but that got
dropped. I don't know if this fix is right, though I can see that it
works. I have the same workaround in my tree, but I'm really not
convinced that it doesn't have side-effects on other architectures.

johannes

