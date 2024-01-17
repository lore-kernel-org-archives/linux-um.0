Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC80C47077
	for <linux-um@archiver.kernel.org>; Wed, 17 Jan 2024 01:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:To:Cc:From:Subject:
	References:In-Reply-To:Content-Transfer-Encoding:MIME-Version:Content-Type:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u7BlLrJyg8NJtw6cjGr372yJi8HU88SzdYtGR597Yxg=; b=JVDc9jSQ6+Y6kEI9LWnQHDsdi1
	M8Plx8nqVBlC++4ellx0gRJrp38TMnJJ5dcC/nPIby3coA+q2VSlPoMjejQN6e/CCrw89KO6uyf1p
	kf9S2BMtE27i2pM3H1yCVrUVU3YFQI3lGHxhVF0zOnzadqNQYmBhhVOw1Ip+hrMgSFI9w/LJ/S6HN
	MZ5YtYzd9FmUXQz1MmKwP0uH/qo5hDPzH2imJ0pJckKNRSZSJALMbls+YyaraU9pk5EsdOoMSzb8y
	T3fDk7oSnX6xvYqqJ3AlF4oSZt7MSiMoAM7Amr4NLgK/67ZjwvVIao+4fplQUbzz+lA90AJIaDttj
	rJSmb56Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPuiH-00E9Xp-2Z;
	Wed, 17 Jan 2024 01:27:29 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPuiD-00E9WU-23;
	Wed, 17 Jan 2024 01:27:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 1295FB80BFC;
	Wed, 17 Jan 2024 01:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5737EC433F1;
	Wed, 17 Jan 2024 01:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705454840;
	bh=u7BlLrJyg8NJtw6cjGr372yJi8HU88SzdYtGR597Yxg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=tC9n+TgGzJdYa9eJaNIrd6YETp5ouaQa3aG/Bsb5/+N9Ozvs5fVcYmBG3R+99pSr5
	 6MQ+zqdLWmYJkkihzT5Ht0YQGPz5jNQVXsC52lwEWb6veqPJK0PgKqtIJWkAAsas2A
	 ESvqojtCoN+ZsgPbnn0qdAQ83dvbZj1vzayHDMbAv4f8xzdUDnTPAV6JFSe5KGMIBP
	 yO1jM5cRt4kuCl/+A2j/at9+4Kir3CEfkwNnX9m9EDx8HO8gBIGEM6Xd8aoajnN5sB
	 GddFcKCgyWf5RXom2kEzyux5c/FbyuQ9jy3E+OHf8D8+0yBoSIBN3fGRnwpt7PN5gn
	 NyOU6rMIxL3Kw==
Message-ID: <434b21afe1899b1567f3617261594842.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZaZtbU9hre3YhZam@FVFF77S0Q05N>
References: <20240112200750.4062441-1-sboyd@kernel.org> <20240112200750.4062441-2-sboyd@kernel.org> <ZaZtbU9hre3YhZam@FVFF77S0Q05N>
Subject: Re: [PATCH 1/6] arm64: Unconditionally call unflatten_device_tree()
From: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Date: Tue, 16 Jan 2024 17:27:18 -0800
User-Agent: alot/0.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240116_172725_817721_C97D23F5 
X-CRM114-Status: GOOD (  11.99  )
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

Quoting Mark Rutland (2024-01-16 03:51:14)
> Hi Stephen,
>=20
> On Fri, Jan 12, 2024 at 12:07:44PM -0800, Stephen Boyd wrote:
> > Call this function unconditionally so that we can populate an empty DTB
> > on platforms that don't boot with a firmware provided or builtin DTB.
> > There's no harm in calling unflatten_device_tree() unconditionally.
>=20
> For better or worse, that's not true: there are systems the provide both =
a DTB
> *and* ACPI tables, and we must not consume both at the same time as those=
 can
> clash and cause all sorts of problems. In addition, we don't want people =
being
> "clever" and describing disparate portions of their system in ACPI and DT.
>=20
> It is a very deliberate choice to not unflatten the DTB when ACPI is in u=
se,
> and I don't think we want to reopen this can of worms.

Hmm ok. I missed this part. Can we knock out the initial_boot_params in
this case so that we don't unflatten a DTB when ACPI is in use?

