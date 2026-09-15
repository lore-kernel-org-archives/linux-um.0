Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB91C88E53
	for <linux-um@archiver.kernel.org>; Tue, 15 Sep 2026 12:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xCl8jNs77PZZdSIvmzClNS4N5YJKQYnamGutVTepnCk=; b=GcUqXGv0ER7dYeBbd35xYP6YEU
	4hIY6jbW+Ss7VyFd+mKaTvoGO7QinPuHgjMnXH633gdJlH0I+Ufd2keDJ90NRvV3pFsX3e++I4ZSh
	RsY8a/+MXO1rbaeY4tXV8xbffHjppwWj0/MAGajbgVwcsqwB+nvTN2q+e8KlvroNMJD8DMMgQN0JD
	5KK+MpVG6YTCA/ky4G8t1gkAy/sZMlbZs5K0ab8uEKFly+Cm0cE8F2qfYteLdgyGMFE2/jdVOVS5Y
	h9p2OUpVPwqMwnrpMqc+X5MKUYIymWnJjAis23GDj0ZbeN03Jn/A+lMsjxo0elAODDIB2BBzRJVRd
	JgZwpBWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S4o-00000006RnR-42PJ;
	Tue, 15 Sep 2026 12:15:54 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S4j-00000006RkI-3yuN;
	Tue, 15 Sep 2026 12:15:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4C1CB60261;
	Tue, 15 Sep 2026 12:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D50C1F00893;
	Tue, 15 Sep 2026 12:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474549;
	bh=xCl8jNs77PZZdSIvmzClNS4N5YJKQYnamGutVTepnCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ngAb15T/yAkTwE1+YE6SOVKj8Rli4aHVUkDtOhNqgXnslknQomnBjXDhGUUHHgw5c
	 t1KNN6ZH3zr5Gtf1iBmlLvi1+EedRg6qAtTNkQ7kQMdZyxrotp61A/kxMP1IsoWP3Q
	 0HPEwAzkXmBRniukPUCUyctzd9pxcukzIZA+ewzHxw/boCKe1Jar8qJFg1/aKtu5I/
	 dpLp1T084yx8feJuPVTuB36srOvPtJerVeDd4qv1zFiywDAW7LoZnflX7kr4TjuMev
	 HM37MdMxXfwNOlWakuuKYP5RXCJcKz7vv76rj0gWBeGPIn4OJc58aAB53O2zHvFgkb
	 1XTJ0zBTt12SA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 40/50] KVM: stop putting descriptors back on
 failure
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-alpha@vger.kernel.org, bpf@vger.kernel.org, kexec@lists.infradead.org, dri-devel@lists.freedesktop.org, "David
 Airlie" <airlied@redhat.com>, "Ingo Molnar" <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-hyperv@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, "Peter Zijlstra" <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-m68k@lists.linux-m68k.org, "Jann Horn" <jannh@google.com>, "Oleg
 Nesterov" <oleg@redhat.com>, linux-openrisc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, kvm@vger.kernel.org, "Jan Kara" <jack@suse.cz>, io-uring@vger.kernel.org, linux-arm-msm@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-fsdevel@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org, virtualization@lists.linux.dev, linux-mips@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-40-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-40-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:15:47 +0000
Message-Id: <20260915121547.9D50C1F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D40


