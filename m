Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQbmU-0006i6-FR
 for linux-um@lists.infradead.org; Thu, 08 Oct 2020 19:40:51 +0000
Message-ID: <43b15253faaaa96f5b874adbaf227d9927b00969.camel@sipsolutions.net>
Subject: Re: [RFC v7 12/21] um: nommu: system call interface and application
 API
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 08 Oct 2020 21:40:40 +0200
In-Reply-To: <CAMoF9u0m+qQzNS5mG90MiOVqgOPmbDKTs-p03PLKL0vyT_16fw@mail.gmail.com>
 (sfid-20201008_210323_970294_4B316DB6)
References: <cover.1601960644.git.thehajime@gmail.com>
 <03cee062a2841e3597ae181f1903d21394651f62.1601960644.git.thehajime@gmail.com>
 <8ff2e602fca71fb7244c178017959cc8d153fbfd.camel@sipsolutions.net>
 <CAMoF9u0m+qQzNS5mG90MiOVqgOPmbDKTs-p03PLKL0vyT_16fw@mail.gmail.com>
 (sfid-20201008_210323_970294_4B316DB6)
MIME-Version: 1.0
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
To: Octavian Purdila <tavi.purdila@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Richard Weinberger <richard@nod.at>, jdike@addtoit.com, linux-um <linux-um@lists.infradead.org>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library <linux-kernel-library@freelists.org>, Hajime Tazaki <thehajime@gmail.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Thu, 2020-10-08 at 22:03 +0300, Octavian Purdila wrote:
> On Wed, Oct 7, 2020 at 10:05 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> > On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> > > +++ b/arch/um/nommu/include/uapi/asm/syscalls.h
> > > @@ -0,0 +1,287 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > 
> > That doesn't really make sense - if you use LKL you're linking Linux, so
> > you can't use this "WITH Linux-syscall-note"?
> > 
> > > +#ifndef __UM_NOMMU_UAPI_SYSCALLS_H
> > > +#define __UM_NOMMU_UAPI_SYSCALLS_H
> > 
> > [snip]
> > 
> > This file really worries me, it includes half the world and (re)defines
> > the other half ... How is this ever going to be maintained?
> > 
> 
> There are not that many definitions here, just the ones that were
> never defined in uapi headers. And, AFAIK, new code that exposes
> structures and data types should always go  into uapi headers and not
> directly in glibc, etc. So once we fix the old stuff, it should be
> fine?

Yeah, not really sure. Not all of this is really old stuff, e.g. keyring
things were here I noticed.

But since it's userspace API I guess the changes of it breaking are
fairly small anyway, so maybe I just shouldn't worry about it :)

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

