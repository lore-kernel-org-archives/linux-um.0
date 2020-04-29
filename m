Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTsK5-0005aN-G9
 for linux-um@lists.infradead.org; Wed, 29 Apr 2020 19:24:46 +0000
Received: by mail-qt1-x844.google.com with SMTP id x12so2892220qts.9
 for <linux-um@lists.infradead.org>; Wed, 29 Apr 2020 12:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200415095152.85794f817f97.I289cb72f130c19e850d70eacca9e68eb84832600@changeid>
 <b7157cb3-ee7d-ac91-c755-ace63d617460@kot-begemot.co.uk>
In-Reply-To: <b7157cb3-ee7d-ac91-c755-ace63d617460@kot-begemot.co.uk>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 29 Apr 2020 21:24:31 +0200
Message-ID: <CAFLxGvyY22Pt8gfsujOTi=aLv1L8=kEOGo_18Hscs_rowKmSGw@mail.gmail.com>
Subject: Re: [PATCH] um: syscall.c: include <asm/unistd.h>
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-um <linux-um@lists.infradead.org>, Johannes Berg <johannes.berg@intel.com>

On Wed, Apr 15, 2020 at 11:39 AM Anton Ivanov
<anton.ivanov@kot-begemot.co.uk> wrote:
>
>
>
> On 15/04/2020 08:51, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >
> > Without CONFIG_SECCOMP, we don't get this include recursively
> > through the existing includes, thus failing the build on not
> > having __NR_syscall_max defined. Add the necessary include to
> > fix this.
> >
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > ---
> >   arch/um/kernel/skas/syscall.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
> > index 0a12d5a09217..3d91f89fd852 100644
> > --- a/arch/um/kernel/skas/syscall.c
> > +++ b/arch/um/kernel/skas/syscall.c
> > @@ -11,6 +11,7 @@
> >   #include <sysdep/ptrace_user.h>
> >   #include <sysdep/syscalls.h>
> >   #include <linux/time-internal.h>
> > +#include <asm/unistd.h>
> >
> >   void handle_syscall(struct uml_pt_regs *r)
> >   {
> >
>
> Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>
> --
> Anton R. Ivanov
> https://www.kot-begemot.co.uk/
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um

Applied, thanks!

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

