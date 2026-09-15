Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E766AC88E7F
	for <linux-um@archiver.kernel.org>; Tue, 15 Sep 2026 12:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sF9YfaIJizyBPu4rwmr1ugFHciRiaj3rpWpmWnplm2o=; b=Xixj4W2TL6ddya7QU0wJzGkzIg
	As4mzIKpXm0948/0KHs5xQ//7HDxcASUYBapyAh1lQBOwxad57laC/g+IhW7iyBmNXVVT1Xc0cw6j
	9fn8ys3O72Wrsas2PGqV1Pd17qHN36OxmJT2ptmkKwMTgRsIulXijlam/vvq6d7IkFw00jYXYbQjm
	jBuYHfbwom6U8GF8OMjoeRCGADqqjsTBTFGQwO38la3qc921d0zBrE96Wt6LPxrTThvaz43eSxhfM
	07vQeTAjNRk+wMDYyZogN2h+TAlw2ZgscJeRZ+KtDyN+ViG0Msb49Clbale3cbcZrSZpv3FgvjQwo
	R/j/2qtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S3h-00000006R0q-1EJC;
	Tue, 15 Sep 2026 12:14:45 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S3f-00000006Qza-0xnM;
	Tue, 15 Sep 2026 12:14:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A7309602C4;
	Tue, 15 Sep 2026 12:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908681F00893;
	Tue, 15 Sep 2026 12:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474482;
	bh=sF9YfaIJizyBPu4rwmr1ugFHciRiaj3rpWpmWnplm2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o0i1edZoSZwfTDuavjm0jvg5VQXWhP0dWUGKIGTr8VBvqx0/C7n4xowvx9OTeZtCR
	 qz/PxHeE5NmuntDwErr/shj/5CjD5MPN3WutZ8jsJiT4+HZ7bYopL8U2z/U+F471Uc
	 sa15k+HBxjI1ws8oZIZWAKZYm3G/E31Ge9otNWzoXAUQ+Ib0yP/MS1/m8rv3aFEZmu
	 VV2JzWkAUzQkLxzgSbSwLB7ttoPZ88S25QNgaYCRv63tBmcFXoL6Vo+uFNON8iAfJn
	 gV8IlZbIRL7RHxvrFsH/t67nJiWg9k/SjrxxaMsoIiK6BszJu6OO6xdUylYjAEyJcP
	 HyYV4oBdSfuLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 43/50] drm/amdgpu: stop unwinding the fence
 descriptor by hand
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, "Jens Axboe" <axboe@kernel.dk>, dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, "David
 Airlie" <airlied@redhat.com>, linux-arm-msm@vger.kernel.org, linux-csky@vger.kernel.org, linux-gpio@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-alpha@vger.kernel.org, "Jan Kara" <jack@suse.cz>, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, io-uring@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, kexec@lists.infradead.org, "Ingo
 Molnar" <mingo@redhat.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, sparclinux@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, "Oleg
 Nesterov" <oleg@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, linux-mips@vger.kernel.org, linux-sh@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-hyperv@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-43-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-43-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:14:40 +0000
Message-Id: <20260915121440.908681F00893@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

> Rely on the fd exit path machinery.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D43


