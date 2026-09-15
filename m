Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE0CC88E7F
	for <linux-um@archiver.kernel.org>; Tue, 15 Sep 2026 12:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TgpDOnocVQOLMc3/AlRq1UjktGK6C7Gyd90Kux4DYfA=; b=FNEeGYmqT3MZ8yn8uyVFpZSFUj
	G9cM7gikT6cVbKo82czbwo4xvLj2k+FBoDA6DXZT/TIdYSeKpDR72KP60NAMtvrbkIJr4IP4/72Gc
	zlhMPpmYTO7NfE0TTsfE55JgIjKZ77C/Smq6REUUPFWDE3pNzKiDhcA4b/qyJzq5b63KboXxnuuwm
	woEGxsnx5VcOAGMX5tSzOFnYrazBDmlphgXcx9waW/eXuSrHodgFQq7cadnB3b4C68hFMI0Qp1Ulb
	IeMjfN5pjgRq4i1a4C/QAbIDTwHwHrbeB4Fw/PR5qhjSeVcBuEbfXbKOVOYyg+3n3IpVmRqBuScbB
	3N2nY15A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S3n-00000006R6M-3HcE;
	Tue, 15 Sep 2026 12:14:51 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S3m-00000006R47-1bOq;
	Tue, 15 Sep 2026 12:14:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CA279409F5;
	Tue, 15 Sep 2026 12:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FAA1F0089A;
	Tue, 15 Sep 2026 12:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474489;
	bh=TgpDOnocVQOLMc3/AlRq1UjktGK6C7Gyd90Kux4DYfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pfnv0gbxXYPBW5ngDM1BPQQHDBEH64eQbCNBA7As7XQllaOVs9srOJocJTcOpC3XT
	 +tBSuUVsDjYLtskj1H/KnGHu64fvB/LKvoto8b/1C9TdPBUb2FGeqlDDsZw5ByIwHO
	 MoEzV8EHl67XJeuYV9ENqBOJt0ffAddHj7kVNT421bYVifya9Ag8OwSLhtmCFhxFob
	 paeFeWYGLzS3PmbOQNjlBr1q4j6FJm9IcULTM3aAnjn6WlDhkszRFKzaVJthzwN/5c
	 3uEdtqnuazTttbQPlVN1FAd3DR097y8tCWsB+WVkEH5KLWo19PePTQx30oDVv1BsOi
	 I4VTuIqYdWUzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 39/50] seccomp: stop putting the listener
 descriptor back on failure
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-arm-msm@vger.kernel.org, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-gpio@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org, linux-sh@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linuxppc-dev@lists.ozlabs.org, "Oleg
 Nesterov" <oleg@redhat.com>, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Jan
 Kara" <jack@suse.cz>, "Peter Zijlstra" <peterz@infradead.org>, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, "Jens
 Axboe" <axboe@kernel.dk>, "Jann Horn" <jannh@google.com>, linux-openrisc@vger.kernel.org, linux-um@lists.infradead.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-parisc@vger.kernel.org, "David Airlie" <airlied@redhat.com>, linux-mm@kvack.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-hyperv@vger.kernel.org, linux-csky@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-39-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-39-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:14:47 +0000
Message-Id: <20260915121447.E1FAA1F0089A@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D39


