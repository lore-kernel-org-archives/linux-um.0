Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9a5x-0000l3-S5
 for linux-um@lists.infradead.org; Sun, 15 Sep 2019 19:22:03 +0000
Received: by mail-wm1-x341.google.com with SMTP id r17so5762771wme.0
 for <linux-um@lists.infradead.org>; Sun, 15 Sep 2019 12:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190911125122.20772-1-johannes@sipsolutions.net>
 <2b6ac17c16113892e27e82df9802264ef934d4d8.camel@sipsolutions.net>
 <3ccfa0c9-7b5c-6135-693e-a9700dfdd19f@kot-begemot.co.uk>
 <9e8e9db8-eafb-9132-21a2-762ea09b501a@kot-begemot.co.uk>
 <69bf4022f3c6b7af20b2188673d3c0563c340f5e.camel@sipsolutions.net>
In-Reply-To: <69bf4022f3c6b7af20b2188673d3c0563c340f5e.camel@sipsolutions.net>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 15 Sep 2019 21:21:46 +0200
Message-ID: <CAFLxGvypG+CN2+groNOnkx0OYmzPOd-du2YwThHh9i6zD2tdNA@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] um: virtio support
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Anton Ivanov <anton.ivanov@kot-begemot.co.uk>

On Fri, Sep 13, 2019 at 10:16 AM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Fri, 2019-09-13 at 09:14 +0100, Anton Ivanov wrote:
>
> > It does not build as is at the moment, you need to add
> >
> > EXPORT_SYMBOL(uml_reserved);
> >
> > to ./kernel/um_arch.c
> >
> > I could not find that anywhere in the patch series so it is probably
> > lingering in your tree from somewhere else.
>
> Oh, no, but I've been using it built-in rather than as a module, sorry.

This can be fixed after -rc1.

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

