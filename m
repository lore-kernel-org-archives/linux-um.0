Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIfgb-0001u7-8M
 for linux-um@lists.infradead.org; Sun, 29 Mar 2020 21:41:42 +0000
Received: by mail-wm1-x344.google.com with SMTP id f74so8349517wmf.0
 for <linux-um@lists.infradead.org>; Sun, 29 Mar 2020 14:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <1584466534-13248-1-git-send-email-alan.maguire@oracle.com>
 <2295c218-74a6-d785-f4b1-2046ee91503a@cambridgegreys.com>
In-Reply-To: <2295c218-74a6-d785-f4b1-2046ee91503a@cambridgegreys.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 29 Mar 2020 23:41:28 +0200
Message-ID: <CAFLxGvypQCHnnuRi8RC15wL3yJ7yBJiUQGMHG8MRoPeNA6pAPA@mail.gmail.com>
Subject: Re: [PATCH] arch/um: falloc.h needs to be directly included for older
 libc
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Berg, Johannes" <johannes.berg@intel.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, erelx.geron@intel.com, alex.dewar@gmx.co.uk, Alan Maguire <alan.maguire@oracle.com>, Brendan Higgins <brendanhiggins@google.com>

On Fri, Mar 20, 2020 at 4:58 PM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
>
>
> On 17/03/2020 17:35, Alan Maguire wrote:
> > When building UML with glibc 2.17 installed, compilation
> > of arch/um/os-Linux/file.c fails due to failure to find
> > FALLOC_FL_PUNCH_HOLE and FALLOC_FL_KEEP_SIZE definitions.
> >
> > It appears that /usr/include/bits/fcntl-linux.h (indirectly
> > included by /usr/include/fcntl.h) does not include falloc.h
> > with an older glibc, whereas a more up-to-date version
> > does.
> >
> > Adding the direct include to file.c resolves the issue
> > and does not cause problems for more recent glibc.
> >
> > Fixes: 50109b5a03b4 ("um: Add support for DISCARD in the UBD Driver")
> > Cc: Brendan Higgins <brendanhiggins@google.com>
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >   arch/um/os-Linux/file.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
> > index fbda105..5c819f8 100644
> > --- a/arch/um/os-Linux/file.c
> > +++ b/arch/um/os-Linux/file.c
> > @@ -8,6 +8,7 @@
> >   #include <errno.h>
> >   #include <fcntl.h>
> >   #include <signal.h>
> > +#include <linux/falloc.h>
> >   #include <sys/ioctl.h>
> >   #include <sys/mount.h>
> >   #include <sys/socket.h>
> >
>
> Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Applied, thanks!

BTW: Anton & Brendan, thanks a lot for reviewing all these patches!

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

