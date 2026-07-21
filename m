Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C07C4452D
	for <linux-um@archiver.kernel.org>; Tue, 21 Jul 2026 21:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t0EKOOTPC6Wcvspeiwbymff4lN9OcE6VC1ybxIJ2cwg=; b=3bqD3VUY9D4JQrPW8jFzrMxCsN
	SUE+AA8CmLs8QSeLgO++PWocWxIoRGdwKaKxdpjYcMqOn52Rkw4uAYG2J8pPDrIu0rTnr34fPz1zp
	GBQ1L4IxHCGKgM1rk6d/bxH/LM0xQyZX9vxLh54g4WoeIDNGQHClUXJxBm7zsgMXl2gvjziEc1FJ4
	THbXDHZUAC3+IltHtz94DL286KQVpqineAblukGNQz1SeHX2FqaJk/OG5+5YJyiczJMIQxO0BCw80
	owWUuO5XkCsZQkdWYcF1wxbV0Yu6B+VXhVzMMXSx4bp+QGnoXO9lIlD+ecUzEtxHyAu3RtwIQTD4j
	W3p7/ZUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmIUF-0000000AUSw-0nSb;
	Tue, 21 Jul 2026 21:58:51 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmIUB-0000000AUSR-1xoP
	for linux-um@lists.infradead.org;
	Tue, 21 Jul 2026 21:58:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=t0EKOOTPC6Wcvspeiwbymff4lN9OcE6VC1ybxIJ2cwg=;
	t=1784671127; x=1785880727; b=fIzmCkUDK9uLUIB2qW1XSY/T1CsWOypl7rjUhrtZdsDgRHb
	+oSGMXj+Vi+w2md6yoTbflCamtzfJGoxg2p8sLyXPRCUOHRbVtgaB7wv0DQG2YeoQVBara01s8hqx
	lHUqqH+eSASGYCHiNAJiACedWpASUVXxsbHo9ImNJYna7Y/l0ZSctZFJ/lBCNmHrp7leTuU51tE6/
	RYdVq3qe+UnwiEIQB5Myafj5s8dntjwC+In/f926OZ4iZ2TFxLwRGR1wOBSZzE1YCyw+tPvaJiUFv
	oJW29EYjqFlH70SbsKcxMxdnZ4I8Cdk9+lzFBIgvTUrydcZjZZpaFwTDXoChmj6g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wmIU2-00000002wLl-0Nc3;
	Tue, 21 Jul 2026 23:58:38 +0200
Message-ID: <743d1be771381c86c7f264810d88876976cc508f.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Allow multiple symbol definitions for GCOV builds
From: Johannes Berg <johannes@sipsolutions.net>
To: Alex Hung <alex.hung@amd.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: Bhawanpreet.Lakha@amd.com
Date: Tue, 21 Jul 2026 23:58:37 +0200
In-Reply-To: <20260708224006.3405038-1-alex.hung@amd.com>
References: <20260708224006.3405038-1-alex.hung@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_145847_793863_E37B3510 
X-CRM114-Status: UNSURE (   9.29  )
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

On Wed, 2026-07-08 at 16:40 -0600, Alex Hung wrote:
> GCOV-enabled UML builds link GCC's libgcov into the final vmlinux
> image. libgcov provides helper symbols such as mangle_path(), which
> collide with kernel symbols of the same name (for example the one in
> fs/seq_file.o). This makes the link fail:
>=20
>   ld: libgcov.a(_gcov.o): in function `mangle_path':
>   multiple definition of `mangle_path';
>   fs/seq_file.o: first defined here
>=20
> Pass --allow-multiple-definition to the linker when CONFIG_GCOV is set
> so the final UML link succeeds while keeping the kernel-provided
> definition.
>=20

I cannot see how that would possibly result in correct behaviour (beyond
being able to link)??

johannes

