Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2C0E7BD88
	for <linux-um@archiver.kernel.org>; Mon, 16 Feb 2026 10:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:
	To:Cc:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s++GKTifYI4iu9jXRVQDG9CSARMs+Qpgcl44EZ5MpV0=; b=ejD5tYV/Tdz2zHmouBAZvAeURv
	qp1Y77YMOJgMC2hvHQpLm1K0dhO6LpcuF85Oq1q+9/liJcIssey7SA8ThcHl9Z71cZUsx5cB+zuAh
	9HrlKW13olCmNpcG6D8qcQg+U4vcpjSZT/dskgGeNgQOOMNUSxT+KP5sCBRa5X/9oU1LUE/dSCiat
	8508bLkw3vfkqVGPWWqt2dwpZvu+ZO9nuhjnU3qpJRwkZMPHRZAclFXUpUxQzkeXa29E8vf7tTCp3
	GD7dQJb2+9wjKW49YC6FYGJMnMgeHpW7NpRLnj03hEWMUgSAJyhkgZTSCPQkjdYUi6M8A6xqFRWe9
	gkdFqeTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrvwU-00000006MG5-3s5K;
	Mon, 16 Feb 2026 10:35:02 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrvwT-00000006MFX-2ZyO
	for linux-um@lists.infradead.org;
	Mon, 16 Feb 2026 10:35:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A2F726011F;
	Mon, 16 Feb 2026 10:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C35BC116C6;
	Mon, 16 Feb 2026 10:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771238100;
	bh=/2BeNWAlYULFR5Q9wmcHGInhRij16LyccZTNcZ6eQgw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=m9AxuLzHIgr3xO9OFc2qdTDZdU9q3uDf7VT3t+O6Z2MFLcYsjVCEaRxBXyTHgAoDz
	 nGdjlC3S+0j1XDSWwTRFHYafAgAaoiwuJAUeryx9rD20VJYec2k3BBCu66ZNrUPddZ
	 ZKSrKZSa97bZ1oQQuT/xpiAPn+gPl6aY9KCmhT1lHb6t8VyPF+rB0KDIlnUWNqtQfg
	 5038nF//wM+5V7y98haM/upymMNLFoDp2DJZqb5vWXY3XJsoOm3ZBe2MfVMdR8mCFl
	 3lYP0VtMecMEzwkHvlnTjJU6D+4ThoR6bU55mrgIxX4PZJu0UMOn/1s1/QjO6AdrOv
	 oaUPjtV4X4d3w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Feb 2026 11:34:56 +0100
Message-Id: <DGGBI4DU4J4U.2JOBHL5IFUCTL@kernel.org>
Subject: Re: Mainline UML Rust stable io.rs unused imports
Cc: "David Gow" <davidgow@google.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Richard Weinberger"
 <richard@nod.at>, "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>, <driver-core@lists.linux.dev>,
 "linux-um" <linux-um@lists.infradead.org>, "rust-for-linux"
 <rust-for-linux@vger.kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <CANiq72khOYkt6t5zwMvSiyZvWWHMZuNCMERXu=7K=_5tT-8Pgg@mail.gmail.com>
In-Reply-To: <CANiq72khOYkt6t5zwMvSiyZvWWHMZuNCMERXu=7K=_5tT-8Pgg@mail.gmail.com>
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

On Sun Feb 15, 2026 at 1:47 PM CET, Miguel Ojeda wrote:
> Hi all,
>
> In mainline and next, for UML with Rust stable (but not with Rust
> minimum), I am seeing:

I think the problem is not UML specific, it is about define_read!() and
define_write!() being crate public, while the only user is PCI.

So, if CONFIG_PCI=3Dn, we get this warning.

I will send a fix soon.

Thanks for reporting!

- Danilo

>
>       RUSTC L rust/kernel.o - due to target missing
>     error: unused import: `define_read`
>        --> rust/kernel/io.rs:229:16
>         |
>     229 | pub(crate) use define_read;
>         |                ^^^^^^^^^^^
>         |
>         =3D note: `-D unused-imports` implied by `-D warnings`
>         =3D help: to override `-D warnings` add `#[allow(unused_imports)]=
`
>
>     error: unused import: `define_write`
>        --> rust/kernel/io.rs:262:16
>         |
>     262 | pub(crate) use define_write;
>         |                ^^^^^^^^^^^
>
> Cheers,
> Miguel


