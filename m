Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqPPl-0000fw-Tq
 for linux-um@lists.infradead.org; Tue, 30 Jun 2020 23:11:46 +0000
Received: by mail-wr1-x441.google.com with SMTP id b6so21788186wrs.11
 for <linux-um@lists.infradead.org>; Tue, 30 Jun 2020 16:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200624212319.403689-1-ignat@cloudflare.com>
 <CAFd5g47asdiBPdkQjTQ3-+Rwn+cE-pp1CcB41aV=bvvBZw2ePg@mail.gmail.com>
In-Reply-To: <CAFd5g47asdiBPdkQjTQ3-+Rwn+cE-pp1CcB41aV=bvvBZw2ePg@mail.gmail.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Wed, 1 Jul 2020 00:11:31 +0100
Message-ID: <CALrw=nGOnz0St1j6fyMJWeZicdBjsbXA54A==3XUigN7kMAXQA@mail.gmail.com>
Subject: Re: [RFC PATCH] Revert "um: Make CONFIG_STATIC_LINK actually static"
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
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Tue, Jun 30, 2020 at 11:47 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Wed, Jun 24, 2020 at 2:23 PM Ignat Korchagin <ignat@cloudflare.com> wrote:
> >
> > This reverts commit 3363179385629c1804ea846f4e72608c2201a81e.
> >
> > This change is too restrictive. I've been running UML statically linked kernel
> >  with UML_NET_VECTOR networking in a docker "FROM: scratch" container just fine.
> > As long as we don't reference network peers by hostname and use only IP
> > addresses, NSS is not needed, so not used. In other words, it is possible to
> > have statically linked UML and UML_NET_VECTOR (and other networking types) and
> > use it, although with some restrictions, so let's not disable it.
> >
> > Additionally, it should be at least theoretically possible to use another libc
> > (like musl, bionic etc) for static linking. I was able with some hacks to
> > compile UML against musl, although the executable segfaults for now. But this
> > option prevents even the research to be done.
>
> The reason that we removed support for static linking when these
> networking options are enabled is because gcc doesn't support loading
> NSS when statically linked, which consequently breaks allyesconfig for
> UML under gcc. That is still the case with your revert.

Yes, sure. But I'm not only "researching", but using UML as a "router"
in one of my dev setups. 3363179385629c1804ea846f4e72608c2201a81e
mentions UML_NET_VECTOR incompatibility (and some other networking
options), which I had enabled and actually my whole dev networking is
based around UML_NET_VECTOR: I have two interfaces - one in raw mode
and one doing ipsec. All this was running in an empty "FROM: scratch"
container and obviously linked statically.

If the static linking breaks some other config options in allyesconfig
- that's another story, but I wanted to point out that config options
mentioned in the commit message worked just fine (if not trying to
resolve hostnames). In other words: if you don't resolve - glibc will
not try to load NSS. glibc-nss is a known problem and I would assume
most people trying to do static linking are aware of this - that is,
if they choose this path they are willing to live with the
consequences. That's why completely disabling the possibility sounds
too restrictive for me.

> I fully support the goal behind what you are trying to do. However, I
> do not want to see this patch accepted unless it is accompanied by an
> alternative change that still allows UML to compile under
> allyesconfig.

If I succeed linking it to musl (or other non-glibc lib), would that be enough?

> You said that in the current state, researching a solution is
> possible? Can you not research a solution with your patch applied to
> your own branch?


As a side note: I tried to revert this patch and statically link 5.7
UML with glibc, but the binary still segfaults on start, so I would
assume it is not related to my previous attempts linking with musl.

Regards,
Ignat

>
> Cheers

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

