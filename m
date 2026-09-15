Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2E3C88E7F
	for <linux-um@archiver.kernel.org>; Tue, 15 Sep 2026 12:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zfyJBviruOrXl2JCvdG1FvDmNuy7BpjW1g6Twwn8tGo=; b=FAODxlqNb3E8F/bQC4xRJhPehf
	ljoz9yzxDKpOO6QPhbYpwQUuquw+y5ChamGSrEGmRBL9FALWnJauAWVX38QivIplDbEbF2SCdaeB6
	OkdGLpNQhxRVp0+I+etRc5LDKd/tXRj3xv0LGyjJx7wi7KCKEL2KJevoQvA42TfAukKecHFfSBbPa
	EoaC7IBFODCjFJ67HSY4sAehuQhI7WUS3obGnu5fpImWDqCOauaJo47pAufdJBnUYM0hhSp2coNZc
	X/OLQDkd9/5NkjY7kqx1TO1/5KSETjyN/RJBWZOwQMMTEeFBara4xo/csQuzxPUX3u20oBACp9E9v
	QMR9hWkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S9v-00000006TI3-1FBQ;
	Tue, 15 Sep 2026 12:21:11 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S9t-00000006TFu-2ino;
	Tue, 15 Sep 2026 12:21:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 120A04381D;
	Tue, 15 Sep 2026 12:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373A11F00893;
	Tue, 15 Sep 2026 12:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474869;
	bh=zfyJBviruOrXl2JCvdG1FvDmNuy7BpjW1g6Twwn8tGo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gObKfAKFXTY0hrJS7QZn4qiNIiTIRIBlMSNnER3mXV89dBb57+qlUdDcC7JXNusYj
	 DN3AV6iDTkMMLCKiEUO0tLOW3BC8L8HfDFUz39G5Pai9HhjjNkui+WJehHBvCAlYI6
	 l1+furIrRu5FFpirKDF9oXFfJBGjua8Iyd0PslloNxEu3qlU5WfgMOvXrxDBbQLMUU
	 Hqf4H4ziX5u2zvxCwKkGT4L9W/w3y3hNNkeb0JCCYiu0nrv5MgfHg4dM1guzvKexB6
	 ypTSTOfhsabV+KeBEgLsJEWgU6XLC9cNbo4Q/j9aFrVeLGZ92YWgG0nY7ceyp4UFja
	 rQpYWXr+PJ5lQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 49/50] iommufd: stop putting descriptors back on
 failure
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-openrisc@vger.kernel.org, virtualization@lists.linux.dev, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, io-uring@vger.kernel.org, linux-csky@vger.kernel.org, kvm@vger.kernel.org, linux-sh@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, "Ingo Molnar" <mingo@redhat.com>, "Jann Horn" <jannh@google.com>, linux-kernel@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-mm@kvack.org, bpf@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, sparclinux@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxl?=
 =?utf-8?b?KQ==?= <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-m68k@lists.linux-m68k.org, linux-um@lists.infradead.org, "Oleg
 Nesterov" <oleg@redhat.com>, linux-snps-arc@lists.infradead.org, linux-hyperv@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-49-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-49-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:21:06 +0000
Message-Id: <20260915122107.373A11F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D49


