Return-Path: <joe@perches.com>
Message-ID: <1400098041.30384.22.camel@joe-AO725>
From: Joe Perches <joe@perches.com>
Date: Wed, 14 May 2014 13:07:21 -0700
In-Reply-To: <5373C996.7000409@nod.at>
References: <cover.1399678795.git.joe@perches.com> <5373C996.7000409@nod.at>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/4] UserModeLinux: Message logging neatening
To: Richard Weinberger <richard@nod.at>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, 2014-05-14 at 21:52 +0200, Richard Weinberger wrote:
> Am 10.05.2014 01:43, schrieb Joe Perches:
> > Joe Perches (4):
> >   UserModeLinux: Convert UM_KERN_<LEVEL> to KERN_<LEVEL>
> >   UserModeLinux: Remove unused #defines of UM_KERN_<LEVEL>
> >   UserModeLinux: Use a more current logging style
> >   UserModeLinux: Convert printks to pr_<level>

> Thank you Joe!
> I'll queue your patches for 3.16.

(adding Geert to cc's)

Hi Richard.

Please queue only patches 1 and 2.

Patches 3 and 4 are currently defective.
These need a bit of rework to compile appropriately.

I'll do what Al suggested below one day soon.

from: https://lkml.org/lkml/2012/9/29/106

On Sat, Sep 29, 2012 at 10:43 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sat, Sep 29, 2012 at 10:27:44PM +0200, Geert Uytterhoeven wrote:
>> On Sat, Sep 29, 2012 at 10:10 PM, Joe Perches <joe@perches.com> wrote:
>> >> @@ -88,7 +88,7 @@ static int do_aio(aio_context_t ctx, enum aio_type type, int fd, char *buf,
>> >>               iocbp->aio_nbytes = sizeof(c);
>> >>               break;
>> >>       default:
>> >> -             printk(UM_KERN_ERR "Bogus op in do_aio - %d\n", type);
>> >> +             printk(KERN_ERR "Bogus op in do_aio - %d\n", type);
>> >
>> > Maybe a follow-on patch to convert these to pr_<level>?
>>
>> That requires adding pr_<level> to arch/um/include/shared/user.h first.
>> Or to avoid duplication, extracting the pr_<level> definitions from
>> include/linux/printk.h to a new header file, and preincluding that one for
>> the user part of UML, too.
>
> Yecchhh....  Just how many of those pre-includes do you want to add?
> Seriously, if we get enough of those, it might make more sense to take
> them into a separate directory and add it to search paths, including
> that for userland objects of uml.  If not, I'd rather copy them to
> include/generated in arch/um/Makefile and explicitly #include <generated/foo.h>
> them from user.h.  It's trivially doable and as long as we have relatively
> few of those guys it's less PITA...


