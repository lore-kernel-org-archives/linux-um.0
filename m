Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQbRb-0003cg-O9
 for linux-um@lists.infradead.org; Thu, 08 Oct 2020 19:19:16 +0000
Received: by mail-lj1-x243.google.com with SMTP id h20so6959010lji.9
 for <linux-um@lists.infradead.org>; Thu, 08 Oct 2020 12:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601960644.git.thehajime@gmail.com>
 <7a39c85a38658227d3daf6443babb7733d1a1ff4.1601960644.git.thehajime@gmail.com>
 <27868819-fbd7-9eec-0520-d2fb9b6bf4a6@cambridgegreys.com>
 <6d8dd929722e419894824a07792ac8c5b2659de9.camel@sipsolutions.net>
 <3f0aab8f38971360240e1e04bd6b90a8dcadec86.camel@sipsolutions.net>
 <2f3c3a54-7d68-6dc9-a65a-37fb4599b194@cambridgegreys.com>
 <m2zh4w517g.wl-thehajime@gmail.com>
In-Reply-To: <m2zh4w517g.wl-thehajime@gmail.com>
From: Octavian Purdila <tavi.purdila@gmail.com>
Date: Thu, 8 Oct 2020 22:19:03 +0300
Message-ID: <CAMoF9u3cGYDj8dmZfu559n2HcOPGc_twXk=z32mavO9hPufkFg@mail.gmail.com>
Subject: Re: [RFC v7 18/21] um: host: add utilities functions
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Richard Weinberger <richard@nod.at>, jdike@addtoit.com, linux-um <linux-um@lists.infradead.org>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library <linux-kernel-library@freelists.org>, Johannes Berg <johannes@sipsolutions.net>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Thu, Oct 8, 2020 at 3:52 PM Hajime Tazaki <thehajime@gmail.com> wrote:
>
>
> On Thu, 08 Oct 2020 00:10:23 +0900,
> Anton Ivanov wrote:
> >
> >
> > On 07/10/2020 16:03, Johannes Berg wrote:
> > > On Wed, 2020-10-07 at 17:02 +0200, Johannes Berg wrote:
> > >> On Wed, 2020-10-07 at 15:53 +0100, Anton Ivanov wrote:
> > >>> These are actually different on different architectures. These look
> > >>> like the x86 values.
>
> Those variables are based on tools/um/include/lkl/asm-generic/errno.h,
> which is generated from include/uapi/asm-generic/errno.h, which LKL
> kernel eats for its values.
>
> This is the part of patch 12/21.
>
> > >>> IMHO a kernel strerror() would be the right way of dealing with this
> > >>> in the long term (i understand that we cannot call the platform one,
> > >>> because it may be different from the internal Linux errors). It will
> > >>> be useful in a lot of other places.
> > >>>
> > >>> If we leave it as is, we need to make this arch specific at some
> > >>> point.
>
> So, this particular code does not contain arch specific part I
> believe.
> # Tavi, correct me if I'm wrong.
>

I think Anton was saying that we should do it properly with C99 to
avoid potential issues with changes in configuration and I agree that
is the way to go.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

