Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ed10O-00034w-AN for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 23:49:56 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Ed10M-0001AU-Ub
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 23:49:56 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Getting the x86-64 rollup patch to work on my x86
	laptop.
References: <200511161100.31053.rob@landley.net>
	<200511180826.53596.blaisorblade@yahoo.it>
	<200511180133.52547.rob@landley.net>
In-Reply-To: <200511180133.52547.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511180858.43760.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 18 Nov 2005 08:58:43 +0100
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Friday 18 November 2005 08:33, Rob Landley wrote:
> On Friday 18 November 2005 01:26, Blaisorblade wrote:
> > On Friday 18 November 2005 07:48, Rob Landley wrote:
> > > On Thursday 17 November 2005 21:12, Jeff Dike wrote:
> > > > On Thu, Nov 17, 2005 at 04:51:33PM -0600, Rob Landley wrote:
> > > > > find . -name asm

> > > >  asm-um/ldt.h contains a typedef of uml_ldt_t

> > > asm-um/ldt.h is a 0 byte file.

> > Damnit! Do rm on it and things will work (Makefiles will create a symlink
> > to ldt-$(SUBARCH) in its place). We had this problem in the past, and
> > exactly for a mis-formed patch with quilt.

> Should I delete all of them, then?

It shouldn't do any harm removing them... for headers like that the 0-length 
file prevents the creation of the symlink.

Also, I think that even when the patch is wrong (doesn't remove the file), 
applying it with quilt does the right thing.

> find . -size 0b
> ./arch/um/drivers/ubd_user.c
> ./arch/um/include/signal_user.h
.......
> ./fs/hostfs/Makefile
> ./fs/hostfs/hostfs.h
> ./fs/hostfs/hostfs_kern.c
> ./fs/hostfs/hostfs_user.c
> ./include/asm-um/ldt.h

JEEFF :-| ? Where are you? How should I hunt you ;-))) ?

> Let's see...

> find . -size 0b | xargs rm

> Oh that's a _much_ happier build.  It's got various warnings about iplicit
> declarations and unused variables but none of those big long chains of "in
> file included from" and the build made it all the way to the link stage
> before dying:

>   CC      lib/semaphore-sleepers.o
>   CC      lib/sha1.o
>   CC      lib/string.o
>   CC      lib/vsprintf.o
>   AR      lib/lib.a
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
>
> arch/um/sys-i386/built-in.o(.text+0x3b60): In function `load_TLS':
> : undefined reference to `indirect_set_thread_area'
>
> collect2: ld returned 1 exit status
>   KSYM    .tmp_kallsyms1.S
> nm: '.tmp_vmlinux1': No such file
> No valid symbol.
> make[2]: *** [.tmp_kallsyms1.S] Error 1
> make[1]: *** [_all] Error 2
> make: *** [all] Error 2
>
> This is progress!
Disable TT mode or play with such things IIRC - actually there's a proper fix 
along lines of "move #ifdef's inside sys-i386/tls.c to properly cater to 
dependencies" if you want.

This comes from the TLS patches btw...
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
