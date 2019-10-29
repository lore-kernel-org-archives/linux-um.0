Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPIks-00068Y-Ek
 for linux-um@lists.infradead.org; Tue, 29 Oct 2019 04:05:15 +0000
Received: by mail-io1-xd43.google.com with SMTP id r144so13248074iod.8
 for <linux-um@lists.infradead.org>; Mon, 28 Oct 2019 21:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571798507.git.thehajime@gmail.com>
 <0b1464dd4904ee2b049fef624895ead3fe6aa555.1571798507.git.thehajime@gmail.com>
 <CAFLxGvzqPzZtUSzymWgnhGnr6qgcDe9ue6Q8ALMS-r_Y+KXVOw@mail.gmail.com>
 <m2a79mx6br.wl-thehajime@gmail.com>
In-Reply-To: <m2a79mx6br.wl-thehajime@gmail.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Tue, 29 Oct 2019 12:04:59 +0800
Message-ID: <CAJhGHyBy4ok+Sg7TyLaaksqEBDanmZgsk6ujRqXU1KFcu+DHZQ@mail.gmail.com>
Subject: Re: [RFC PATCH 03/47] lkl: architecture skeleton for Linux kernel
 library
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
To: Hajime Tazaki <thehajime@gmail.com>
Cc: levex@linux.com, mattator@gmail.com, cem@freebsd.org, richard.weinberger@gmail.com, staal1978@gmail.com, motomuman@gmail.com, linux-um@lists.infradead.org, retrage01@gmail.com, petrosagg@gmail.com, tavi.purdila@gmail.com, xiaoj@google.com, mark@stillwell.me, edisonmcastro@hotmail.com, pscollins@google.com, phh@phh.me, sigmaepsilon92@gmail.com, luca.dariz@gmail.com, liuyuan@google.com

Hello, Hajime

I can't get how UML&LKL is going to unify even I read
the cover-letter of the patchset. After quick glance, what I
understand is that the patchset just puts LKL under
arch/um/lkl rather than arch/lkl. It is still separated "arch" for me.

Could you put me in more detail of the plan to unify them please?

Thanks
Lai

On Sun, Oct 27, 2019 at 10:36 AM Hajime Tazaki <thehajime@gmail.com> wrote:
>
>
> # dropping two Cc's since those are not reachable..
>
> On Sat, 26 Oct 2019 06:40:05 +0900,
> Richard Weinberger wrote:
> >
> > On Wed, Oct 23, 2019 at 6:39 AM Hajime Tazaki <thehajime@gmail.com> wrote:
> > >
> > > From: Octavian Purdila <tavi.purdila@gmail.com>
> > > +LINUX KERNEL LIBRARY
> > > +M:     Octavian Purdila <octavian.purdila@intel.com>
> > > +M:     Hajime Tazaki <thehajime@gmail.com>
> > > +L:     linux-kernel-library@freelists.org
> > > +S:     Maintained
> > > +F:     arch/lkl/
> > > +F:     tools/lkl/
> > > +
> >
> > The arch/lkl path is outdated.
>
> Ah, should be updated.  We will fix it.
>
> > So, you and Octavian will maintain LKL?
>
> Yes.
>
> > Do you want to be sub maintainers of arch/um/lkl and send pull requests to me
> > or co-maintain the whole UML ecosystem together with me and Anton?
> >
> > I'm perfectly fine with both variants but tend to the latter one since
> > it is less overhead.
>
> I was not thinking well enough for the maintenance procedure;
> I agree that the latter case is better, but for the early
> stage of this integration, I think starting with the former
> (send pull-req from LKL to you/Anton) would be nice.
>
> LKL is now on github and utilizes several useful features
> (CI test at each pull request, issue tracking, wiki), and if
> possible I'd also like to migrate those tools, or make them
> available to UML because this makes easier maintenance for
> LKL.
>
> What do you think ?
>
> > In case you need your PGP keys signed, next week I'll be in Lyon at
> > OSS, ELCE, ...
>
> I won't be there, unfortunately..
>
> -- Hajime

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

