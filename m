Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA44CE7D1E
	for <linux-um@archiver.kernel.org>; Tue,  1 Oct 2024 12:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wVmIzLHrlB9vbqZZ4IHk4yXT9OkBR1Nuo7JXvIjOmAQ=; b=t9CJ8WIlrC72yWGOieJOuchR4I
	SOSKV6oyqdgBM6/QJMl5goTL7/b1pLtGoFyyB6H86Wk1qdx1M0zQjjk/NwYa5AwCkp5lrvjze+RP2
	vocrsxzW3s1zdXUwbI/R+MigcutHewxL1CuYVSOhe2jCNpeBg2VHJCCx38UcPN2iUplzFkUIhFxUs
	I/ehD4sRgXJ+y1Z+s6GEJSi+leHgyW5rG4ihn3ffwpZFdQ02K17VTuEnmfyS+8fywni5dskq8vgIb
	K0QVV0UJCj3aT7IxJ3+sSjNVAj7mzz0rwci0qSjjc4Qtr0tompIljyhSnd24SFW3KqFHtX+9ZmmUL
	NP3M7ArQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svcQ4-00000002pzh-0XbM;
	Tue, 01 Oct 2024 12:56:00 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svcO7-00000002poV-2PjC;
	Tue, 01 Oct 2024 12:53:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=wVmIzLHrlB9vbqZZ4IHk4yXT9OkBR1Nuo7JXvIjOmAQ=; b=guQIcUArPolpO87WGpUbkDcWZC
	7zSCS6051l8rb1rdHjdKtB/qaqjhVyOqZZl7qwejJnAMs0GSNeQX+qK+iAW3XOEuwFhskmPt2o71Y
	NVbhLohVW5s0hTaApJ/bQQ9wP9LXbSKLXGeTbybGxEyxIM4/qoZkpagPnzBWh2byP+1sF5yfWwwIl
	vKGoyWbRkbM88hG0B3NFRCphMrKF7DqGnlBcKJwlVOSbPeSE9ooRuVm8YgXJGzBS04us5pTPK8SwS
	M733e4JZwEnY4DH2hFkixPWe4FUAoW7IAoEidi9Ld4IW+QY4GZTuWMcCfTbzcrkDYWKnTxdDiHWF+
	xC3Fo/SA==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svcO4-000000034E4-1cSq;
	Tue, 01 Oct 2024 12:53:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wVmIzLHrlB9vbqZZ4IHk4yXT9OkBR1Nuo7JXvIjOmAQ=;
	t=1727787233; x=1728996833; b=ljgSNU9hbScqUjcf+KgXG62PzZeUMvjbBv+nl8BWdgv6Tmw
	ucBZRV3CMVm+nlyqKnZhWSP5l3r8iuZt1tN8t3TWI31NU33AJkh+jbIJdT+LBLMF/xpnhMmvcVWTc
	VpSX9pOLRScgBCoJe18dCliHcN/b1Q7NXOwxPOqLCnW2P94ZRgW0fsED1nU15VgEhFcHJzzM+fsDX
	8YjDYyzDaVFCkbwIAodum60LXJd+O4e4GX5X9AtKc5jJq6D5xuWD0x9Q9rMC3xgNdTZLXah8N9KwX
	CTe13V5KAPcTrA3qFtd0pTRqxnw1kKaYhVQJbkIGCZkIcw3WEwWdpfH78YneB68A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1svcNg-0000000Elbd-23z1;
	Tue, 01 Oct 2024 14:53:32 +0200
Message-ID: <168acf1cc03e2a7f4a918210ab2a05ee845ce247.camel@sipsolutions.net>
Subject: Re: [PATCH v7 09/10] um: Add dummy implementation for IO
 memcpy/memset
From: Johannes Berg <johannes@sipsolutions.net>
To: Julian Vetter <jvetter@kalrayinc.com>, Arnd Bergmann <arnd@arndb.de>, 
 Russell King <linux@armlinux.org.uk>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,  Guo Ren
 <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>,  Andrew Morton <akpm@linux-foundation.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
  Matt Turner <mattst88@gmail.com>, "James E . J . Bottomley"
 <James.Bottomley@hansenpartnership.com>,  Helge Deller <deller@gmx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,  Richard
 Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, Yann Sionneau
	 <ysionneau@kalrayinc.com>
Date: Tue, 01 Oct 2024 14:53:31 +0200
In-Reply-To: <20240930132321.2785718-10-jvetter@kalrayinc.com>
References: <20240930132321.2785718-1-jvetter@kalrayinc.com>
	 <20240930132321.2785718-10-jvetter@kalrayinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241001_135356_562741_E2A76BDB 
X-CRM114-Status: GOOD (  11.28  )
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

On Mon, 2024-09-30 at 15:23 +0200, Julian Vetter wrote:
> The um arch is the only architecture that sets the config 'NO_IOMEM',
> yet drivers that use IO memory can be selected. In order to make these
> drivers happy we add a dummy implementation for memcpy_{from,to}io and
> memset_io functions.

Maybe I'm just not understanding this series, but how does this work
with lib/logic_iomem.c?

You're adding these inlines unconditionally, so if this included
logic_io.h, you should get symbol conflicts?

Also not sure these functions should/need to do anything at all, there's
no IO memory on ARCH=3Dum in case of not having logic_io.h. Maybe even
BUG_ON() or something? It can't be reachable (under correct drivers)
since ioremap() always returns NULL (without logic_iomem).

I think Arnd also said that other architectures might want to use
logic_iomem, though I don't see any now.

johannes

