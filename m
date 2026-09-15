Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35377C88E75
	for <linux-um@archiver.kernel.org>; Tue, 15 Sep 2026 12:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vonrQofTMqh1TZ5f0j9SBLxkepNFIrQaGLKCiSWoy/A=; b=bkrhF4AVPrQJhxoq2HNQwj9RcZ
	xCcjoy0O8ku0kBL2ei8JJOycHKLSL75pAMrcH8dwQmAwnr2hHpA7sDEz2OK1410rKts9F50NCqtMD
	3V/wXg2nKMjZ7YrWcxi5kcMzD41emWCpE2P94rf8q7nW+i9QhO5JdK87ODWHpBS1KeZM7B2QOdjjl
	ziM7/tzGvgPkiSiuyj/SKlkFZ+WZgOQLxgycOXAlta/iZ7+KkmMXlgcnBDgg8Sxu3+BpnKqCQGBVX
	Tbu4vHWlNIFtqsVYOpsMILZJjaVGfclPEntgcPE4Coz93Ya6kWw5bXD1+cd/hoOpljZk4q2sMiYOb
	Rgx6A0bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S9p-00000006TD4-19P0;
	Tue, 15 Sep 2026 12:21:05 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S9l-00000006TBE-471t;
	Tue, 15 Sep 2026 12:21:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B3D32414DE;
	Tue, 15 Sep 2026 12:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCFD1F00893;
	Tue, 15 Sep 2026 12:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474861;
	bh=vonrQofTMqh1TZ5f0j9SBLxkepNFIrQaGLKCiSWoy/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A/LXiHVzihnaMdFTMhS3rVKx/wDAkjfj2gDEj8DTAYNjfOe6DG+9Ca/cCtFyPhPE8
	 y77qZBSfSC9sS4k/RUcIcuvRnjcCwtLvS7YSZE1xN5GAlkblWsWACrRhYCN5wIFKor
	 zT8EpjnA5d63Lul165thqtWkMhkC99tbZwqRFOqKxO0tRQPj3pAlGire6kQh45O8b2
	 eS2NZ8W+DwDtB+jiWr5CwIe6sK7rjGmOKgcSbUdZiQO/XTHrxK9zTNOllt/wu/a1To
	 v55MzO0WPliGPDb7kJyu1DDpQ4ZeGJMNQLBjGR50wccFbjBl7QsDZheHlcTEqD3nHg
	 F55P5vgYAJ68w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 48/50] misc: fastrpc: install the dma-buf
 descriptor when the ioctl returns
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, sparclinux@vger.kernel.org, linux-csky@vger.kernel.org, linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, linux-alpha@vger.kernel.org, io-uring@vger.kernel.org, bpf@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-um@lists.infradead.org, linux-snps-arc@lists.infradead.org, kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Jan Kara" <jack@suse.cz>, linux-hexagon@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, "Eugenio Perez" <eperezma@redhat.com>, "Ingo
 Molnar" <mingo@redhat.com>, linux-mm@kvack.org, linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-openrisc@vger.kernel.org, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, virtualization@lists.linux.dev, "Jann
 Horn" <jannh@google.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "David
 Airlie" <airlied@redhat.com>, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-48-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-48-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:20:59 +0000
Message-Id: <20260915122059.CDCFD1F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D48


