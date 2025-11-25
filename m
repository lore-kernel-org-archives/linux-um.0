Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CBECFD364
	for <linux-um@archiver.kernel.org>; Tue, 25 Nov 2025 07:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NHne8B71rhlo4JDZkWGouJWY6gpQg/ock03JEjHdivU=; b=GkzKbIrZHt+Z3oyOp43A1tzE6w
	jd9SpRccsSMGvtwGCnYLJSiP405hw00OZaxt6w8esczBug1gNDrptbc3NKXzE+0fAbEW0U/Mecklb
	33nyEwUVOfFklVUbP8OQe2GI42uLiMhDEy32rxeXs1E3uzyX6O5oIW3y1snBvmsiro02WIXyTkBsE
	mGZojoqO7cX5xnlJXAJqYlJbdMSQpeMx4icrx3eyTbHFsZL2wfSpT8AJB+Y5/nbhWmZW//DNy1Zj3
	1L5gzOldk9YoTyD8dmAEXxq+2IMzEBO5b+35VHSJB7tCkvJ9QZI3slxNs1qIlLq5Gpuhgrw0/7z2B
	HDqREwfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNnex-0000000CuSd-0hMD;
	Tue, 25 Nov 2025 07:40:23 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNnev-0000000CuRn-07q0
	for linux-um@lists.infradead.org;
	Tue, 25 Nov 2025 07:40:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NHne8B71rhlo4JDZkWGouJWY6gpQg/ock03JEjHdivU=;
	t=1764056420; x=1765266020; b=l67L1gWk/1tq+835IUqJxWPb07TdK77H9hDiBAQhrgqojyG
	QQV0Uk/NtkGBe3rZofD1XetARaFFhKSXAsFro11GpAEJShsAoRd/bdtu1jyO75ZctzKG84BBwA37q
	rcGLQAlwoNQkctc3p+H8ZdDrIpqseDKCXhfO0wgzrRZMMp245huYRjgBXGMMyRb8wE6HvM+v8+M4a
	ob6d2HYN2B/qdPScvpXtgbFMzY6tduZHnK0odsSsHztnAy3bBXsuUDsG9NXXTDD7CgcH+zY6YGUZt
	BAMBnaIDKEV1+YDS/G4mwLzC+1jlbOxJz+73opAst8W0PNEGDsNV7uWBiQTW0Teg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vNneq-0000000BNRi-1osg;
	Tue, 25 Nov 2025 08:40:16 +0100
Message-ID: <dedea008d546a2a29d3b604e9f4b0c0dec3ebac1.camel@sipsolutions.net>
Subject: Re: [PATCH] arch: um: Don't rename vmap to kernel_vmap
From: Johannes Berg <johannes@sipsolutions.net>
To: David Gow <davidgow@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Richard Weinberger	
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Miguel
 Ojeda	 <ojeda@kernel.org>, Paolo 'Blaisorblade' Giarrusso
 <blaisorblade@yahoo.it>,  Alice Ryhl <aliceryhl@google.com>,
 linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Date: Tue, 25 Nov 2025 08:40:15 +0100
In-Reply-To: <CABVgOSmAGahEaa71_fOT4Oo9Wg91X6rN+1_KgVVvVzmd4vuMCg@mail.gmail.com> (sfid-20251125_083645_823712_C74034DC)
References: <20251122083213.3996586-1-davidgow@google.com>
	 <CANiq72=MXHZ2XswxkfzLqUEPwriNy=_sxAQpOYoYW8iNgyuJ8Q@mail.gmail.com>
	 <bfb512e24f365695534313b375fc0c38d0a843b2.camel@sipsolutions.net>
	 <CABVgOSmAGahEaa71_fOT4Oo9Wg91X6rN+1_KgVVvVzmd4vuMCg@mail.gmail.com>
	 (sfid-20251125_083645_823712_C74034DC)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_234021_101973_104D522A 
X-CRM114-Status: GOOD (  13.79  )
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

On Tue, 2025-11-25 at 15:36 +0800, David Gow wrote:
> >=20
> > Or it's not that urgent because all this came up in -next now? I didn't
> > really see (or fully understand) all the build bug reports.
> >=20
>=20
> I'm happy for this to go in via any tree. (Worst-case, we could
> possibly take it via KUnit, though I'd rather not, as it's not really
> KUnit-related at all.)
>=20
> The issue has actually been around since probably 6.16 (c284d3e42338
> ("rust: drm: gem: Add GEM object abstraction")), but since it only
> applies to people building Rust graphics drivers against UML, which is
> not super common, it seems like it's only come up in randconfig builds
> so far.

Oh, interesting, OK. I guess then given that it's not super important
and how late we're in the game, I'll just throw it into the (relatively
small) pile we have for UML for -next. Given that we removed the pcap
driver in 6.11 (12b8e7e69aa7a) I guess we could even ask stable to take
it, but it's not even that important until someone wants to test the
rust DRM stuff in kunit or something :)

johannes

