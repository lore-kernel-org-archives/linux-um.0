Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdIPP-0008RJ-Us for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Nov 2005 18:24:55 -0800
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EdIPK-0007b8-U3
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Nov 2005 18:24:55 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: merge status
References: <20051109133558.513facef.akpm@osdl.org>
	<200511180851.38683.blaisorblade@yahoo.it>
	<200511180241.33265.rob@landley.net>
In-Reply-To: <200511180241.33265.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511190333.36876.blaisorblade@yahoo.it>
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
Date: Sat, 19 Nov 2005 03:33:36 +0100
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Friday 18 November 2005 09:41, Rob Landley wrote:
> On Friday 18 November 2005 01:51, Blaisorblade wrote:
> > On Friday 18 November 2005 08:17, Rob Landley wrote:
> > > On Friday 18 November 2005 01:08, Blaisorblade wrote:
> > > > On Wednesday 16 November 2005 14:36, Rob Landley wrote:
> > > > > Linus said this:
> >
> > Btw, where does this quote come from?

Thanks for the pointers...

> The problem is (as the discussion brought up), Andrew's tree integrates
> many things.  If you want to test _just_ one subsystem, there's usually a
> tree you can go to to get just -linus plus the new subsystem.

> > Also, fixups tend to have less needs for testing - and they're often
> > backported to -bs.

> "backported"?  So is -bs more stable than mainline?  I thought it was your
> development tree...

No, it stands for "Blaisorblade stable". When you see a -bb release, _that_ is 
for development (in recent times, I used it only for skas0 backport).

Btw, there is even a FAQ on the site... ("Frequently" could be called a joke 
probably, but during first months people were clearly showing my site was 
impossible to understand).

> > Also, I don't tend to merge big patches without first checking.

> Testing -mm (except for fun) doesn't work for me because too much other
> stuff is in there and if something breaks I don't know what it is.

Same reason for which I don't use it :-(


> When absolutely necessary, yes.  In theory Jeff's tree works for Jeff so
> i'm trying to get it to work for me _without_ fixing it myself.  (Instead I
> bug _him_. :)  But I'm on a wildly different distro (ubuntu on x86 and PLD
> on x86-64) and things like maszur's headers or the /lib64 thing I haven't
> got much choice to patch myself.

Btw, why hasn't maszur went to post patches to kernel headers to make them 
includable from userspace instead of merging kernel changes into his headers 
(which is much more work)? Kernel headers, notwithstanding with what Linus 
can say, _do_ use __KERNEL__ and are not sanitized enough (PTRACE_SETOPTIONS 
from 2.6 headers produces a binary not working on 2.4 hosts - you must switch 
to OLDSETOPTIONS).

> I try not to _keep_ these patches.  You'll notice I post them here in hopes
> mainline fixes the problem (whether my fix or a different one).

Hmm... ok, we've different needs - had I done that I wouldn't have got my 
patches merged in many cases (partially because Jeff knows I have my tree and 
I can merge things myself - he merges my patches adaptively).

> > And IMHO you shouldn't feel so shy  about fixing such compile problems
> > (no complaining!) I don't expect you to debug the stub problems, but the
> > rest should be easier to work with.

> I fixed the header #include problem myself once I understood that Jeff had
> never used Mazur's headers.  He took my patch for that.

> The /lib64 thing I have no _clue_ how the linker stage of the linux kernel
> works (it has a linker script to tell ld what to do, and does black magic
> with elf segments so it can put stuff into the init segment and make a
> module export list and...  Ummm..  Eek.)  I know my patch there is wrong
> (it breaks x86), figuring out what to do about that is a todo item..

Ok, done in the other mail.

> The recent breakage I saw with patches.tar was too much damage for Jeff
> _not_ to have seen, so it was either some kind of compiler version problem
> where my patches were likely to break _his_ system, or else I didn't
> understand what was going on.  (And #2 was the case: once I found out it
> was the 0 length files, I could fix that.  I didn't expect 0 length files
> screwing up the #include search paths.

No, we have something like 

include/asm-um/elf.h: 
	ln -s elf-$(SUBARCH).h include/asm-um/elf.h

and make considers the target built when the file exists.

> The #include search paths are 
> confusing, I'm still a bit fuzzy on the difference between include and
> include2, actually...)
Just look at them on a built tree.... 

$ ls -l $OUT/include
total 6
lrwxrwxrwx    1 paolo paolo    6 18 nov 09:06 asm -> asm-um
drwxr-xr-x    2 paolo paolo  328 18 nov 09:06 asm-um
drwxr-xr-x  119 paolo paolo 5744 18 nov 09:06 config
drwxr-xr-x    2 paolo paolo  144 19 nov 03:13 linux

$ ls -l $OUT/include2
total 0
lrwxrwxrwx  1 paolo paolo 59 19 nov 03:13 asm 
-> /home/paolo/Admin/kernel/6/VCS/linux-2.6.git/include/asm-um

As you see, in include there are directories for generated files; Kbuild 
creates include2 to generate the normal asm symlink in it, pointing to the 
original asm-$(ARCH).

There is a distinction between the "asm" directory for normal headers and the 
"asm" directory for build-generated headers.

Ah, for all the rest -I$(srctree)/include is also used, but as you can't 
create $(srctree)/include/asm, <asm/header.h> will not be found on it, even 
if header.h is not build-generated.

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
