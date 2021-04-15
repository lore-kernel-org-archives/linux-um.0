Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conssluserg-01.nifty.com ([210.131.2.80])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWw4J-008KOi-UE
 for linux-um@lists.infradead.org; Thu, 15 Apr 2021 07:05:41 +0000
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id 13F75MRV022978
 for <linux-um@lists.infradead.org>; Thu, 15 Apr 2021 16:05:23 +0900
Received: by mail-pl1-f182.google.com with SMTP id t22so11211181ply.1
 for <linux-um@lists.infradead.org>; Thu, 15 Apr 2021 00:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210414192657.17764-1-rdunlap@infradead.org>
 <CAK7LNARSK2YspYvKkUKTp-aG2nqKnvdMr7B_6Am-u1-mt2XBNg@mail.gmail.com>
 <c3d41808-111c-c4dd-43fb-459ae56fc9ab@infradead.org>
In-Reply-To: <c3d41808-111c-c4dd-43fb-459ae56fc9ab@infradead.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 15 Apr 2021 16:04:44 +0900
Message-ID: <CAK7LNAS2C1drA+v9q-mYHAbO3+4zjEdF_SJkBDtCXRExLX9u6w@mail.gmail.com>
Subject: Re: [PATCH] uml: fix W=1 missing-include-dirs warnings
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
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michal Marek <michal.lkml@markovi.net>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org

On Thu, Apr 15, 2021 at 4:02 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 4/14/21 11:52 PM, Masahiro Yamada wrote:
> > On Thu, Apr 15, 2021 at 4:27 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> Currently when using "W=1" with UML builds, there are over 700 warnings
> >> like so:
> >>
> >>   CC      arch/um/drivers/stderr_console.o
> >> cc1: warning: ./arch/um/include/uapi: No such file or directory [-Wmissing-include-dirs]
> >>
> >> but arch/um/ does not have include/uapi/ at all, so don't
> >> include arch/um/include/uapi/ in USERINCLUDE for UML.
>
>
> >> Option 4: simply mkdir arch/um/include/uapi
> >>         That's what I did first, just as a test, and it works.
> >
> >
> > I like Option 4.
> >
> > But, you cannot do "mkdir -p arch/um/include/uapi" at build-time
> > because the build system should not touch the source tree(, which
> > might be read-only)
> > for O= building.
> >
> > How about adding
> >
> >   arch/um/include/uapi/asm/Kbuild,
> >
> > which is just having a SPDX one-liner?
>
> Wow!  :)
> That's what Al Viro suggested also.
> I'll submit that patch later today (Thursday my time).
>
> thanks.
> --
> ~Randy
>


BTW, after fixing this UML problem,
can we move -Wmissing-include-dirs to the top Makefile?

Is there any other source of -Wmissing-include-dirs
warnings?





-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

