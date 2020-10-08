Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQbCF-0001kj-Qi
 for linux-um@lists.infradead.org; Thu, 08 Oct 2020 19:03:24 +0000
Received: by mail-lj1-x243.google.com with SMTP id h20so6907722lji.9
 for <linux-um@lists.infradead.org>; Thu, 08 Oct 2020 12:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601960644.git.thehajime@gmail.com>
 <03cee062a2841e3597ae181f1903d21394651f62.1601960644.git.thehajime@gmail.com>
 <8ff2e602fca71fb7244c178017959cc8d153fbfd.camel@sipsolutions.net>
In-Reply-To: <8ff2e602fca71fb7244c178017959cc8d153fbfd.camel@sipsolutions.net>
From: Octavian Purdila <tavi.purdila@gmail.com>
Date: Thu, 8 Oct 2020 22:03:11 +0300
Message-ID: <CAMoF9u0m+qQzNS5mG90MiOVqgOPmbDKTs-p03PLKL0vyT_16fw@mail.gmail.com>
Subject: Re: [RFC v7 12/21] um: nommu: system call interface and application
 API
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

On Wed, Oct 7, 2020 at 10:05 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> >
> > +++ b/arch/um/nommu/include/uapi/asm/syscalls.h
> > @@ -0,0 +1,287 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>
> That doesn't really make sense - if you use LKL you're linking Linux, so
> you can't use this "WITH Linux-syscall-note"?
>
> > +#ifndef __UM_NOMMU_UAPI_SYSCALLS_H
> > +#define __UM_NOMMU_UAPI_SYSCALLS_H
>
> [snip]
>
> This file really worries me, it includes half the world and (re)defines
> the other half ... How is this ever going to be maintained?
>

There are not that many definitions here, just the ones that were
never defined in uapi headers. And, AFAIK, new code that exposes
structures and data types should always go  into uapi headers and not
directly in glibc, etc. So once we fix the old stuff, it should be
fine?

> > index 000000000000..ec7356c0dee9
> > --- /dev/null
> > +++ b/arch/um/scripts/headers_install.py
> > @@ -0,0 +1,197 @@
> > +#!/usr/bin/env python
>
> might want to make that explicitly 'python3', some newer distros (e.g.
> ubuntu 20.04) are now shipping without a 'python' by default.
>

Good point, will fix it in the next patch series.

> > +def has_lkl_prefix(w):
> > +  return w.startswith("lkl") or w.startswith("_lkl") or w.startswith("__lkl") \
> > +         or w.startswith("LKL") or w.startswith("_LKL") or w.startswith("__LKL")
>
>
> > +        content = re.sub(re.compile("(\/\*(\*(?!\/)|[^*])*\*\/)", re.S|re.M), " ", open(h).read())
> >
> > +    dir = os.path.dirname(h)
> > +    out_dir = args.path + "/" + re.sub("(" + srctree + "/arch/um/nommu/include/uapi/|arch/um/nommu/include/generated/uapi/|include/generated/uapi/|include/generated|" + install_hdr_path + "/include/)(.*)", "lkl/\\2", dir)
>
>
> you have some very long lines in places, I'm sure you could fix that
> (e.g. the last one by doing something with '|'.join([...]))
>

Thanks for pointing it out, we will fix it :)

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

