Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVPgA-0004YU-Pg for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 04:47:14 -0700
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]
	helo=tadamune.kami.home)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KVPg9-0004rg-FS
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 04:47:14 -0700
Date: Tue, 19 Aug 2008 20:47:04 +0900
From: Mattia Dongili <malattia@linux.it>
Message-ID: <20080819114704.GB7425@inferi.kami.home>
References: <20080813175125.19829.80844.reportbug@carrera.home.cobb.me.uk>
	<20080813221905.GA16104@inferi.kami.home>
	<200808140936.50696.graham@cobb.uk.net>
	<20080814113619.GA21758@inferi.kami.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080814113619.GA21758@inferi.kami.home>
Subject: [uml-devel] Bug#494995: user-mode-linux: static build fails with
	multiple	definition of `strrchr'
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: UML-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: 494995@bugs.debian.org, Graham Cobb <graham@cobb.uk.net>

Hi Jeff,

I received this bug report in the Debian BTS (submitter and bug Cc-ed).
The full bug report hisory is here:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=494995
and the .config from the submitter here:
http://bugs.debian.org/cgi-bin/bugreport.cgi?msg=25;filename=config.i386.gz;att=1;bug=494995

In short statically linking the uml kernel fails with the error below.
Any idea what may be wrong?

On Thu, Aug 14, 2008 at 08:36:19PM +0900, Mattia Dongili wrote:
> On Thu, Aug 14, 2008 at 09:36:49AM +0100, Graham Cobb wrote:
> > On Wednesday 13 August 2008 23:19:05 Mattia Dongili wrote:
> > > can you try building 2.6.26 from unstable?
> > 
> > Exactly the same problem:
> > 
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > /usr/lib/gcc/i486-linux-gnu/4.3.1/../../../../lib/libc.a(strrchr.o): In 
> > function `rindex':
> > (.text+0x0): multiple definition of `strrchr'
> > lib/lib.a(string.o):/home/cobb/share/qemu/my-uml-32/user-mode-linux-2.6.26-1um/linux-source-2.6.26/lib/string.c:304: 
> > first defined here
> > arch/um/drivers/built-in.o: In function `vde_open_real':
> > (.text+0x5023): warning: Using 'getgrnam' in statically linked applications 
> > requires at runtime the shared libraries from the glibc version used for 
> > linking
> > arch/um/drivers/built-in.o: In function `vde_open_real':
> > (.text+0x4caf): warning: Using 'getpwuid' in statically linked applications 
> > requires at runtime the shared libraries from the glibc version used for 
> > linking
> > collect2: ld returned 1 exit status
> >   KSYM    .tmp_kallsyms1.S
> > nm: '.tmp_vmlinux1': No such file
> > No valid symbol.
> > make[1]: *** [.tmp_kallsyms1.S] Error 1
> 
> Sorry I didn't ask for this before, but can you attach your .config?
> Also, are you using make-kpkg, or are you rebuilding the binary package
> from the source (i.e.: using dpkg-buildpackage)? Or are you just using
> plain make?
> 
> thanks
> -- 
> mattia
> :wq!
> 
> 
> 
> 

-- 
mattia
:wq!

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
