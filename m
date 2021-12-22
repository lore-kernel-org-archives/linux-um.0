Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from smtp1.axis.com ([195.60.68.17])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzymy-009yBH-0w
 for linux-um@lists.infradead.org; Wed, 22 Dec 2021 10:24:05 +0000
Date: Wed, 22 Dec 2021 11:23:57 +0100
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH 0/2] Devicetree support for UML
Message-ID: <20211222102356.GA25135@axis.com>
References: <20211208151123.29313-1-vincent.whitchurch@axis.com>
 <342397676.191011.1640120120622.JavaMail.zimbra@nod.at>
 <c48f86ad5d31f7f0cfa08d895bb03a4d92a3ce26.camel@sipsolutions.net>
 <1446970217.191062.1640121183419.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1446970217.191062.1640121183419.JavaMail.zimbra@nod.at>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Richard Weinberger <richard@nod.at>
Cc: Johannes Berg <johannes@sipsolutions.net>, Jeff Dike <jdike@addtoit.com>, anton ivanov <anton.ivanov@cambridgegreys.com>, kernel <kernel@axis.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>

On Tue, Dec 21, 2021 at 10:13:03PM +0100, Richard Weinberger wrote:
> ----- Urspr=FCngliche Mail -----
> > Von: "Johannes Berg" <johannes@sipsolutions.net>
> > Gesendet: Dienstag, 21. Dezember 2021 21:56:50
> > On Tue, 2021-12-21 at 21:55 +0100, Richard Weinberger wrote:
> >> WARNING: unmet direct dependencies detected for OF_EARLY_FLATTREE
> >>   Depends on [n]: OF [=3Dn]
> >>   Selected by [y]:
> >>   - UML [=3Dy]
> >> =

> >> Please note that my UML config has CONFIG_OF=3Dn.
> >> =

> > Hm. So maybe that needs to be
> > =

> >	select OF_EARLY_FLATTREE if OF
> =

> Yeah, IIRC arm and mips use such a pattern too.  Vincent, what do you
> think?

Yes, that looks like the correct fix.  I've tested it and it works.  Do
you prefer to fix it up locally or should I repost?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

