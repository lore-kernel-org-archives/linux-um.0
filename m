Return-Path: <viro@ftp.linux.org.uk>
Date: Sat, 29 Sep 2012 21:43:14 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20120929204314.GK13973@ZenIV.linux.org.uk>
References: <1348938460-20919-1-git-send-email-geert@linux-m68k.org>
 <1348938460-20919-2-git-send-email-geert@linux-m68k.org>
 <1348949440.3294.2.camel@joe-AO722>
 <CAMuHMdWiDKV2=kbO8UGqZBETdrYExLRbaRFNnVTVRcWUs16OcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWiDKV2=kbO8UGqZBETdrYExLRbaRFNnVTVRcWUs16OcA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 2/4] arch/um/os-Linux: Drop UM_ prefix from printk()
 level specifiers
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Joe Perches <joe@perches.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, x86@kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sat, Sep 29, 2012 at 10:27:44PM +0200, Geert Uytterhoeven wrote:
> On Sat, Sep 29, 2012 at 10:10 PM, Joe Perches <joe@perches.com> wrote:
> >> @@ -88,7 +88,7 @@ static int do_aio(aio_context_t ctx, enum aio_type type, int fd, char *buf,
> >>               iocbp->aio_nbytes = sizeof(c);
> >>               break;
> >>       default:
> >> -             printk(UM_KERN_ERR "Bogus op in do_aio - %d\n", type);
> >> +             printk(KERN_ERR "Bogus op in do_aio - %d\n", type);
> >
> > Maybe a follow-on patch to convert these to pr_<level>?
> 
> That requires adding pr_<level> to arch/um/include/shared/user.h first.
> Or to avoid duplication, extracting the pr_<level> definitions from
> include/linux/printk.h to a new header file, and preincluding that one for
> the user part of UML, too.

Yecchhh....  Just how many of those pre-includes do you want to add?
Seriously, if we get enough of those, it might make more sense to take
them into a separate directory and add it to search paths, including
that for userland objects of uml.  If not, I'd rather copy them to
include/generated in arch/um/Makefile and explicitly #include <generated/foo.h>
them from user.h.  It's trivially doable and as long as we have relatively
few of those guys it's less PITA...

