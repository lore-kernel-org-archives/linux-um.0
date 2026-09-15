Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82D2C88E75
	for <linux-um@archiver.kernel.org>; Tue, 15 Sep 2026 12:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dTvFOp6vSGe4AZsCgKO980b0BeYwtUxBQL5x62d5jw8=; b=IZeO59dY3rNgOmcTS+9NGm1CWX
	APwWLcHmxXEdkdEmxQ43icA22uMI6pJ6y2JwiXr3uOtK0lAMt+eDbiStt8DvFGDw60uB/9FCy5z8+
	LgV9cuz6Tpu/DmQXLXSBXfOEw2kQngx7rKOtxcnuRVEkoKMoBC1Djq3/q+g3wXwA+C31kJDO+PXX0
	SdGmRGRTw1KO+T+5pgFVIkQRCv0d3bKHa+m8YPuIen4vmI0fEwqTNhVCW8dP3QGxEByVwN17t89nB
	BnNoH4VM2g2Vo5O4GmnAEeuralO2Yc+jfl7bkeVSMqvzy2vVmZiV8KCEh3VmJQPnLzc4FsYBp1ryX
	GejI0xYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S1H-00000006Q4w-1NSQ;
	Tue, 15 Sep 2026 12:12:15 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S1F-00000006Q3S-2uTU;
	Tue, 15 Sep 2026 12:12:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5A19240523;
	Tue, 15 Sep 2026 12:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7195B1F000FF;
	Tue, 15 Sep 2026 12:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474333;
	bh=dTvFOp6vSGe4AZsCgKO980b0BeYwtUxBQL5x62d5jw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EFlkG4klTh9q0ksv7M1hSJKTTDQQe7H5iyO2zHATvBU+UXti67y8RU1/odOq/zhGR
	 VYQ/UthUrZvWy+XndwZ77DKsyT/9Ri6pFxYRhTSWuJI+DH+4yLpyuhu8mAIrHMk8t/
	 6kDv1q8AwhLZ6F1rb+P8f3KP0PwnSljmvJWSc46nWvAQt32cRvhQ+HBCxLIdV4HK1y
	 DBbf6pk3x8FN6xy4faUytIL4oO+ojk8F8MkK5f1LgG4gC4ZmwrIhyHU1W79T6CKby7
	 mQNMHJsClSUixl8DuKxj7EGI22mNfTcwiHmk42y9GBCpJ9M/rUqbu9RbXfhHzUFMg4
	 vNY+QKqLhGlQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 38/50] perf: stop putting the event descriptor
 back on failure
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, kexec@lists.infradead.org, linux-um@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-snps-arc@lists.infradead.org, io-uring@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, "David
 Airlie" <airlied@redhat.com>, "Ingo Molnar" <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-hyperv@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-alpha@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, kvm@vger.kernel.org, bpf@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-hexagon@vger.kernel.org, linux-mm@kvack.org, virtualization@lists.linux.dev, "Jann
 Horn" <jannh@google.com>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-38-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-38-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:12:11 +0000
Message-Id: <20260915121211.7195B1F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D38


