Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcDg3-0007Ij-9D for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Nov 2005 19:09:39 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EcDg2-0001GU-Ox
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Nov 2005 19:09:39 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] [PATCH] Ok, I build x86-64 -skas0,
	and it still segfaults.
References: <200511121936.41697.rob@landley.net>
	<200511131726.22036.rob@landley.net>
	<200511142040.55175.blaisorblade@yahoo.it>
In-Reply-To: <200511142040.55175.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511152109.26953.rob@landley.net>
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
Date: Tue, 15 Nov 2005 21:09:26 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Monday 14 November 2005 13:40, Blaisorblade wrote:
> is that RWSEM_GENERIC_SPINLOCK is the right thing for x86_64, but the i386
> Kconfig enables instead RWSEM_XCHGADD_ALGORITHM, which is wrong for x86_64.
> It compiles, was used at some time, but isn't really tested currently, and
> Andi Kleen is going to drop the code. So, indeed, your patch is wrong.

Not saying it's correct, just saying it was the smallest tweak that got me 
past the build break.  (For a little bit there I was editing the #includes by 
hand.)

> What the patch does is making sure that Kconfig.i386 is included for
> _i386_, not for any arch. And it fixes your problem.
>
> > > Is that _needed_ on your system? I ask because it always worked and
> > > it's highly host distro-dependant, I guess.
> >
> > Yes it's needed.  Otherwise:
> >   CC      init/version.o
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > /usr/bin/ld: warning: ld-linux-x86-64.so.2, needed by /lib64/libc.so.6,
> > not found (try using -rpath or -rpath-link)
> > collect2: ld returned 1 exit status
>
> Ok, it's your distro. On mine:
>
> # ls -l /lib
> lrwxrwxrwx  1 root root 5 30 lug 21:17 /lib -> lib64

It's the distro of the nice person who let me borrow their x86-64 machine.

Currently, the UML build seems to require that /lib be a symlink to /lib64.  
This is not the case on PLD, and occording to the Oct 31 post on uml-user 
it's not the case on CentOS either.  I don't know what other distros it's not 
the case for.

> Anyway, what it's doing could be correct enough to do... except we do the
> linking with GCC! So probably we could simply remove that -rlink altogether
> (though the documentation would say otherwise).

I'm all for better solutions.  I'm just saying what I needed to do to get it 
to build with what I had.

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
