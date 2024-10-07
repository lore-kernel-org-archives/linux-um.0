Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F259BCFB440
	for <linux-um@archiver.kernel.org>; Mon,  7 Oct 2024 08:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VxsmENQliA0ha+9UHH8CUYn0b71VDQoYtn36QSYVOrQ=; b=3tN4qbhlLu9pF7ccsfe6dEp3yy
	xhQOD0BOgu+18duHHFzs469BISagVWCELWhAlIRHmUMNAAS3LHJYcyVaM5RGjMyue6tsv80k0ZSkY
	X+pO4BFoAYuiDkLPnrH62oBgFFVE/wR0Akxb+X+STEf9mVTIIn9kHFaiO5ZtseWzJ4K3GuxV0vsJm
	yeP5od9VfbG3JsvszeeyGtp7qjktGhbvuN2NmNs32ogJC3aDQJZHZEp2muZReIF30y37I6Jlm8GQa
	vbTqMNWThxjJhGeuElYmR/336nyjpbw1xs4nEjzWcQ9jxIyebPFfgmfXOLOMj5ceiClV1WKlTrhHw
	BZyemv/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxj0A-00000001kQQ-1Aui;
	Mon, 07 Oct 2024 08:21:58 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxilT-00000001hMr-2jGw;
	Mon, 07 Oct 2024 08:06:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VxsmENQliA0ha+9UHH8CUYn0b71VDQoYtn36QSYVOrQ=;
	t=1728288405; x=1729498005; b=wZsH+ERrsukcrjiG6TDVMBGZmkNxwDOLUVWxAQ6DV8B+3iy
	eMedV4aMaMKNisuMTMpGbZsS/opxaZLxhvsikKNEmeJLoSU/MBXvyP7odTRl+ldg7xSeILRt8pD4B
	K+fn87UVGmSFkCvJgpVJtA0TIVfjJtvoOOjyIPxSMqlMiFnnybudYBW/hgvDtze4PKtf5+Y6jUj68
	H6vuX6jAsWVXtYbY+r0niJRwBhodOeEbNnNEzShBDWtR9IBwf9mD4n3DPOwrw4EfJjjf/P7B00cw7
	Iyssuki+ysE5JvRJGrOcv/fTUZ7dJKqg4D8OFcPxdOG3lpRg7gDXP76LQUONO6uQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sxikz-00000003EXo-1qzg;
	Mon, 07 Oct 2024 10:06:17 +0200
Message-ID: <529f8d49b048af53b6b7e82197fe487b687241b3.camel@sipsolutions.net>
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
Date: Mon, 07 Oct 2024 10:06:15 +0200
In-Reply-To: <54985915-be13-46ee-ad42-7dd5d9d245ac@kalrayinc.com>
References: <20240930132321.2785718-1-jvetter@kalrayinc.com>
	 <20240930132321.2785718-10-jvetter@kalrayinc.com>
	 <168acf1cc03e2a7f4a918210ab2a05ee845ce247.camel@sipsolutions.net>
	 <54985915-be13-46ee-ad42-7dd5d9d245ac@kalrayinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_010647_722987_D5E874D8 
X-CRM114-Status: GOOD (  21.30  )
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

On Mon, 2024-10-07 at 09:49 +0200, Julian Vetter wrote:
>=20
> > > The um arch is the only architecture that sets the config 'NO_IOMEM',

(you did note this, for the comment below)

> No, I think you're understanding the series correctly. It doesn't work.=
=20
> I will revert this.

OK.

> > You're adding these inlines unconditionally, so if this included
> > logic_io.h, you should get symbol conflicts?
> >=20
> > Also not sure these functions should/need to do anything at all, there'=
s
> > no IO memory on ARCH=3Dum in case of not having logic_io.h. Maybe even
> > BUG_ON() or something? It can't be reachable (under correct drivers)
> > since ioremap() always returns NULL (without logic_iomem).

> Thanks. You're right. I added this patch because there was a build robot=
=20
> on some mailinglist building a random config with 'ARCH=3Dum' and with=
=20
> some MTD drivers that actually use memcpy_fromio or memcpy_toio. These=
=20
> drivers are not guarded by a 'depends on HAS_IOMEM'. I thought I could=
=20
> simply fix it by adding stub functions to the um arch. Because I saw=20
> there are A LOT of drivers that use IO functions without being guarded=
=20
> by 'depends on HAS_IOMEM'. Not sure though, how to handle this case.

Right, well, as you noted above ARCH=3Dum is the only architecture that
has NO_IOMEM, so I suppose drivers are just broken. But e.g.
kernel/iomem.c is also only ever built if you have HAS_IOMEM, so devm_*
functions related to this are not available.

So I don't know. On the one hand, it feels correct to have NO_IOMEM and
HAS_IOMEM, on the other hand that's a bit of a fight against windmills?


What happens now though? Seems it should _already_ not build with
ARCH=3Dum and memcpy_*io() being used? No, I guess it picked up the asm-
generic version?

Hm. I'm almost thinking we should let such drivers not build, and then
see that they add appropriate HAS_IOMEM dependencies, but ... windmills?

johannes

