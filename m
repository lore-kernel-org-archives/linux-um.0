Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF051C48BC4
	for <linux-um@archiver.kernel.org>; Thu, 15 Feb 2024 21:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:To:Cc:From:Subject:
	References:In-Reply-To:Content-Transfer-Encoding:MIME-Version:Content-Type:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W8FAYdoi1ZheQkPrRNKVraB559xRrkBih6/hUdhUKI0=; b=wLjG48X87rYVuACWDCxVaLfXBW
	oFsUTDRcDRULu54UMKwcxACZeBNssFUYMcOvV1hmEdlmVqvqZr586Xg4mM99L++4cqzobgJ6HvOcw
	MPUkDjrk0e5j5nO2ogYawBX8NSdv5Fx72RDXl9eLW1QTo6DkvFG2H/T/4gCplV3vF+8b/yp8ItjN5
	pJF8vvJg7GHKM7Cvx7bPgTGSugGtIXQ394UqPjTislW043cZQs367o0CUvfm69EY2po46KNGMAkKj
	LYRx/LM3zU/dpP7UZozYenlwUmmBeDCqEXT+8Uw8mCa9ItLtrz1cxdRyL6YBeWUGvYnDuG1LwRlwH
	WWqHv/uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rajjm-00000000Fmk-1Jm9;
	Thu, 15 Feb 2024 21:57:46 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rajjj-00000000FlS-26Bk;
	Thu, 15 Feb 2024 21:57:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 763F161E1B;
	Thu, 15 Feb 2024 21:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F234FC433C7;
	Thu, 15 Feb 2024 21:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708034262;
	bh=T7MZeg+yLjaU4BtqowdnnpbuIdHLYtXGFMcH9SwnC3o=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=HKqLNhPXnNKvbiW3EkbP1vnJu/P3vG86/ySfYdF3/dkJRvBlKdC16LT5mZItEadLZ
	 598aG+3ah3tkmZLOIrdMCA71Mv1dhqn/X9wN6XZE2PFnEQ6u9ytiCXPexNV6EfMqDL
	 +S/VfoHHM1M1sW6VN+xeXqAf7GACRVuBldgxHQqrhOn1ISIO28LWtV2GGCUmEB3zYg
	 LhUL9oistI6vrDdKAo/sunUbQYDUYBQ9qCuFzIPCyK9fbnmogWsbeD7/IbCkVRVYdg
	 ZDB69vXMxMVXPPwP5isAT3K/QDz1xP57NY8LETK4c19bJ9dWpvu+gdz4RikrKAAj9r
	 WXx8+d2ecNk+g==
Message-ID: <3e67766fa85be7dd865c5ec9dea1b53b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAL_JsqLrRXdPZ+u9XG960V7sXECBi5Ko7BYdreftYz-O=Hwieg@mail.gmail.com>
References: <20240202195909.3458162-1-sboyd@kernel.org> <20240202195909.3458162-8-sboyd@kernel.org> <CABVgOS=A8BQ6HHpBKFqg-N10ckk2XYavaS-MPXvZ0wenrVm=1g@mail.gmail.com> <89892ecd6b1b043db58258705c32b02b.sboyd@kernel.org> <CAMuHMdUuP5Ya2gU3V_ET=Ji_+yx+jr7eCch5uDJSqvQN9jJM3g@mail.gmail.com> <2185a3cc3152a0b9a94b0c64353bc9a1.sboyd@kernel.org> <CAL_JsqLrRXdPZ+u9XG960V7sXECBi5Ko7BYdreftYz-O=Hwieg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] of: Add KUnit test to confirm DTB is loaded
From: Stephen Boyd <sboyd@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>, Brendan Higgins <brendan.higgins@linux.dev>
To: Rob Herring <robh+dt@kernel.org>
Date: Thu, 15 Feb 2024 13:57:39 -0800
User-Agent: alot/0.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240215_135743_606903_DA5A5E40 
X-CRM114-Status: GOOD (  13.88  )
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

Quoting Rob Herring (2024-02-13 09:52:00)
> On Fri, Feb 9, 2024 at 8:59=E2=80=AFPM Stephen Boyd <sboyd@kernel.org> wr=
ote:
> >
> > ---8<---
> > diff --git a/init/main.c b/init/main.c
> > index e24b0780fdff..02f5cf8be6c1 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -97,6 +97,8 @@
> >  #include <linux/jump_label.h>
> >  #include <linux/kcsan.h>
> >  #include <linux/init_syscalls.h>
> > +#include <linux/of.h>
> > +#include <linux/of_fdt.h>
> >  #include <linux/stackdepot.h>
> >  #include <linux/randomize_kstack.h>
> >  #include <net/net_namespace.h>
> > @@ -895,6 +897,8 @@ void start_kernel(void)
> >         pr_notice("%s", linux_banner);
> >         early_security_init();
> >         setup_arch(&command_line);
> > +       if (!of_root)
>=20
> of_root is another thing I'd like to remove direct access to. That
> check could be inside unflatten_device_tree().

Ok.

>=20
> > +               unflatten_device_tree();
>=20
> That's back to what Frank had essentially and I wanted to avoid.

Alright, fair enough.

>=20
> I think I'd just disable the tests on the above arches and let them
> opt-in. I could be convinced otherwise though.
>=20

Kunit folks would prefer to skip tests when dependencies aren't
satisfied. The OF_UNITTEST config already depends on !SPARC so perhaps
it's simplest to have tests skip if OF_EARLY_FLATREE=3Dn. Then
OF_EARLY_FLATREE can be def_bool OF && !(SPARC || M68K || other arches).
The OF_UNITTEST config can depend on OF_EARLY_FLATREE instead of select
it then. This way new supporting architectures can remove themselves
from the def_bool line when they start calling unflatten_device_tree().

