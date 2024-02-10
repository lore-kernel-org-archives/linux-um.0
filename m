Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBBEC4829A
	for <linux-um@archiver.kernel.org>; Sat, 10 Feb 2024 12:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kV1dH9N0wl6dbAp2XFipJ67xCC7y7WlCPuruPIHVk6U=; b=xp9yU9eGUkaUi40GMWes855wGl
	wUAsUoYv74Y8PkiX3RcfB4i5sfUw9KnsmVeS22d0oPRTLsnV93ykh6XaMWVVYKq2w/3NbiIEX9JHp
	VjaDKH0LW0Nq49ote0KJquor6NjgRwQAnj2iHZphuxwdoKh9AIjf9aXpmyE3gggztUWerYDSv6VUx
	R+xc/BdyVbSj1+MQOMvVySdsR+GIfPLdsASSvZRuXXu9TqM+XOyup8yWQTS9H3W16jM6QLfiBhVo4
	W8ULYV02q0bvivl5Jp8ualj+yoeV/U8TYx0GdgkKeaNRe/keqGRcXOiMN62XESNts+DwhBVHFXl+C
	VPl19yuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYmZa-00000001d2P-1kyN;
	Sat, 10 Feb 2024 12:35:10 +0000
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYmZW-00000001d1g-3BPq
	for linux-um@lists.infradead.org;
	Sat, 10 Feb 2024 12:35:08 +0000
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-285-B9mkscCCOyeXmvwkut24cQ-1; Sat, 10 Feb 2024 12:35:02 +0000
X-MC-Unique: B9mkscCCOyeXmvwkut24cQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 10 Feb
 2024 12:34:41 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 10 Feb 2024 12:34:41 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kees Cook' <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>
CC: Andy Shevchenko <andy@kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, Richard Weinberger <richard@nod.at>,
	"Anton Ivanov" <anton.ivanov@cambridgegreys.com>, Johannes Berg
	<johannes@sipsolutions.net>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, "kernel
 test robot" <lkp@intel.com>, Nathan Chancellor <nathan@kernel.org>, "Azeem
 Shaikh" <azeemshaikh38@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-um@lists.infradead.org"
	<linux-um@lists.infradead.org>
Subject: RE: [PATCH v3 3/4] string: Allow 2-argument strscpy_pad()
Thread-Topic: [PATCH v3 3/4] string: Allow 2-argument strscpy_pad()
Thread-Index: AQHaWaavaD/gLIDMg0aBzFOj9pBKgrEDhhFw
Date: Sat, 10 Feb 2024 12:34:41 +0000
Message-ID: <d6710f82acfd4957a296601c420fba76@AcuMS.aculab.com>
References: <20240206142027.make.107-kees@kernel.org>
 <20240206142221.2208763-3-keescook@chromium.org>
 <20240207005151.lyrtgqd4wekolwe7@google.com> <202402070115.2C86687F@keescook>
In-Reply-To: <202402070115.2C86687F@keescook>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240210_043507_127465_C9C94F44 
X-CRM114-Status: GOOD (  18.73  )
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

From: Kees Cook
> Sent: 07 February 2024 09:19
>=20
> On Wed, Feb 07, 2024 at 12:51:51AM +0000, Justin Stitt wrote:
> > Hi,
> >
> > On Tue, Feb 06, 2024 at 06:22:18AM -0800, Kees Cook wrote:
> > > Similar to strscpy(), update strscpy_pad()'s 3rd argument to be
> > > optional when the destination is a compile-time known size array.
> >
> > This patch is diff'd against Patch 1/4 in this series, right? I wonder
> > why you split them up. If I hadn't literally just read that patch I
> > would be mildly confused.
> >
> > I suppose one reason may be that 1/4 is a standalone change with a high
> > percentage chance of landing whilst this overloading magic may not land
> > as easily?
>=20
> I viewed it as a distinct logical change. I could certainly combine
> them, but I think it's easier to review the conversion from function to
> macro without needing to consider anything else. No behavioral changes
> are expected, etc.

I wonder about the code-bloat from inlining strscpy_pad()?
Especially given the code that gcc is likely to generate
for string ops.

I strongly suspect that the end of strscpy() knows exactly
you many bytes weren't written (in the non-truncate path).
So maybe implement both strscpy() and strscp_pad() in terms
of an inline function that has a parameter that 'turns on'
padding.

That way you get a simple call site and still only one
implementation.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


