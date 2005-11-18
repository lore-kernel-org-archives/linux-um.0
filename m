Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcvrN-0000Ev-3r for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 18:20:17 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EcvrM-0001iS-MM
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 18:20:17 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Getting the x86-64 rollup patch to work on my x86
	laptop.
Message-ID: <20051118031257.GA14537@ccure.user-mode-linux.org>
References: <200511161100.31053.rob@landley.net>
	<200511161811.38823.rob@landley.net>
	<20051117184038.GB7062@ccure.user-mode-linux.org>
	<200511171651.33764.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511171651.33764.rob@landley.net>
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
Date: Thu, 17 Nov 2005 22:12:57 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Nov 17, 2005 at 04:51:33PM -0600, Rob Landley wrote:
> find . -name asm
> ./include/asm
> ./include2/asm
> 
> ls -l include/asm include2/asm
> lrwxrwxrwx  1 landley landley 72 2005-11-17 16:46 include2/asm 
> -> /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/include/asm-um
> lrwxrwxrwx  1 landley landley  6 2005-11-17 16:46 include/asm -> asm-um
> 
> ls -l include/asm/arch include2/asm/arch
> ls: include2/asm/arch: No such file or directory
> lrwxrwxrwx  1 landley landley 74 2005-11-17 16:46 include/asm/arch 
> -> /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/include/asm-i386

This all looks the same as I have here, except for the asm-i386 thing,
which I don't think matters.  ldt.h seems to be at the center of this,
so can you check the following:
	asm-i386/ldt.h contains a struct user_desc
	asm-um includes asm/arch/ldt.h

	asm-um/ldt.h contains a typedef of uml_ldt_t
	mmu-skas.h includes asm-um/ldt.h

Also, generate a .i for the C file that's being built and check that
the definitions are getting pulled in.  There may be an easier way to
do this, but I
	turn on V=1
	cd obj
	paste the gcc command into an xterm
	edit it as follows
		the -o -c foo.o is replaced by -E
		add > x.i at the end

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
