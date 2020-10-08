Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQaKU-0004Aw-6m
 for linux-um@lists.infradead.org; Thu, 08 Oct 2020 18:07:51 +0000
Received: by mail-lj1-x242.google.com with SMTP id y16so5590499ljk.1
 for <linux-um@lists.infradead.org>; Thu, 08 Oct 2020 11:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601960644.git.thehajime@gmail.com>
 <de40a235d95ad582dae11741e272a5cf300384f2.1601960644.git.thehajime@gmail.com>
 <486e080e64056189b5309bbcaec2ebf235d501a0.camel@sipsolutions.net>
In-Reply-To: <486e080e64056189b5309bbcaec2ebf235d501a0.camel@sipsolutions.net>
From: Octavian Purdila <tavi.purdila@gmail.com>
Date: Thu, 8 Oct 2020 21:07:38 +0300
Message-ID: <CAMoF9u3Kn8CXtzOHookc-hi3djZgPdMA+-j5DUSiR0B=KjVHRA@mail.gmail.com>
Subject: Re: [RFC v7 10/21] um: nommu: memory handling
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Richard Weinberger <richard@nod.at>, jdike@addtoit.com, linux-um <linux-um@lists.infradead.org>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library <linux-kernel-library@freelists.org>, Hajime Tazaki <thehajime@gmail.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Wed, Oct 7, 2020 at 6:47 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> >
> >   * These operations must be provided by a host library or by the application
> >   * itself.
> >   *
> > + * @mem_alloc - allocate memory
> > + * @mem_free - free memory
> > + *
>
> Actual kernel-doc would be nicer.
>

Thank you, we will make sure to use the proper kernel doc throughout
all patches for the next patch series

> > +     empty_zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> > +     memset((void *)empty_zero_page, 0, PAGE_SIZE);
> > +
> > +     {
> > +             unsigned long zones_size[MAX_NR_ZONES] = {0, };
>
> Hmm, what's with the extra scope?
>

Will clean it up in the next patch series, thank you.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

