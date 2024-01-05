Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800C6C3DA6E
	for <linux-um@archiver.kernel.org>; Fri,  5 Jan 2024 08:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TZQ3khfsKLf+AmeAaE2I1LPoTpEix5mNeFyVVHSxfZc=; b=h4ViAaOSJdoUcRzHMwkW+Rawk9
	UMd5lXctMQc21Bjtsszk8J6wouVakQLWdNs31dn9Uq+11LAM3X6Q6AL4Yaaav++eiSE+ymzLZndwb
	IfYMsGDp0PDe7xV2FPydKYlb/cLiwGfaZm4i3vzwNF6MhOqX2GbFcT28j+LgojhuKHRbg2NP4tYnl
	63vV566Fy2mf2ra7apvuEG3F/9483cGW4zsYfG3smlOkxQaXqn2ghB3oV3Dk/G9hEz7jB5WruvJoE
	DUa2pNb39TX7o5Ltnh4f9aJMiQ34IbiUUc6p+4cxzkjIxY+z1xqHhiDnC6/P5qQ1BQBCwKh6jia2I
	mbQrIDuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLfma-00GHYz-22;
	Fri, 05 Jan 2024 08:42:24 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLfmY-00GHXN-0f
	for linux-um@lists.infradead.org;
	Fri, 05 Jan 2024 08:42:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TZQ3khfsKLf+AmeAaE2I1LPoTpEix5mNeFyVVHSxfZc=;
	t=1704444139; x=1705653739; b=mEVvTvyn6/eGZodcXHtYKj+0OufWQ/9pOIVXxqbIxCxp4Mo
	+xOWxQUjaCPgPJ1dqKZfGnhXDiGVr6zHQhlPuCqqOpLeT8RwinInXvR+7yjZRKm9zmH+NxJrsH42I
	xzh3B2FxVvPlt0QFYTOQkjP4nDTXXNYhMifFtUr/wKzZS3s1cyL4c4Z0pMgnqgNlNDwF4rT3w5/Sd
	LfKaVfCrNrxthTHKQYDPVbIdRjrUWMrtSML0kxJFc167OWtrBmLGHaZtCLDC1Oa5wQAOmys7I9mtY
	PyUhrP9yBIXub5gMF2FlHca5EH+l+ICCD4I9e5Fqsr+5j4OlE5lxJkk6NmpN8SQw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rLfmP-00000005vmz-2A4u;
	Fri, 05 Jan 2024 09:42:14 +0100
Message-ID: <1c098c26132b60ebebc46a39e8b7827a29e3a166.camel@sipsolutions.net>
Subject: Re: [PATCH] um: vector: fix return value check in vector_legacy_rx
From: Johannes Berg <johannes@sipsolutions.net>
To: Richard Weinberger <richard.weinberger@gmail.com>, Ma Ke
	 <make_ruc2021@163.com>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com, xiangyang3@huawei.com, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 05 Jan 2024 09:42:12 +0100
In-Reply-To: <CAFLxGvytpwjXM0bdLrxt0itfEBPqJSmuM6otB7dTBmsTaAAPgw@mail.gmail.com>
References: <20231006122717.3984017-1-make_ruc2021@163.com>
	 <CAFLxGvytpwjXM0bdLrxt0itfEBPqJSmuM6otB7dTBmsTaAAPgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_004222_240788_2C168FA6 
X-CRM114-Status: GOOD (  16.89  )
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

On Thu, 2024-01-04 at 22:05 +0100, Richard Weinberger wrote:
> On Fri, Oct 6, 2023 at 2:28=E2=80=AFPM Ma Ke <make_ruc2021@163.com> wrote=
:
> >=20
> > In vector_legacy_rx, to avoid an unexpected result returned by
> > pskb_trim, we should check the return value of pskb_trim().
> >=20
> > Signed-off-by: Ma Ke <make_ruc2021@163.com>
> > ---
> >  arch/um/drivers/vector_kern.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_ker=
n.c
> > index 131b7cb29576..822a8c0cdcc1 100644
> > --- a/arch/um/drivers/vector_kern.c
> > +++ b/arch/um/drivers/vector_kern.c
> > @@ -890,7 +890,8 @@ static int vector_legacy_rx(struct vector_private *=
vp)
> >                                         skb->ip_summed =3D CHECKSUM_UNN=
ECESSARY;
> >                                 }
> >                         }
> > -                       pskb_trim(skb, pkt_len - vp->rx_header_size);
> > +                       if (pskb_trim(skb, pkt_len - vp->rx_header_size=
))
> > +                               return 0;
>=20
> I think this adds a memory leak. Also, can pskb_trim() really fail in
> this scenario?
> The function controls skb creation and knows all lengths.
>=20
We had pretty much the exact same discussion in the other patch ...

https://patchwork.ozlabs.org/project/linux-um/patch/20231007005104.3994678-=
1-make_ruc2021@163.com/


No point arguing with people who care about static checkers only, I
guess. This person here never even came back to respond to the comments,
my take is they're throwing patches over the wall they didn't think
about, just to see what sticks.

johannes

