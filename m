Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EcsvT-0007R3-Lr for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 15:12:19 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EcsvT-0001G2-4D
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 15:12:19 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Getting the x86-64 rollup patch to work on my x86
	laptop.
References: <200511161100.31053.rob@landley.net>
	<20051117184038.GB7062@ccure.user-mode-linux.org>
	<200511171651.33764.rob@landley.net>
In-Reply-To: <200511171651.33764.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511171712.08582.rob@landley.net>
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
Date: Thu, 17 Nov 2005 17:12:08 -0600
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Thursday 17 November 2005 16:51, Rob Landley wrote:

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
> ->
> /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/include/asm-i386
>
> I have no idea what the difference between include and include2 is, but
> it's there on the straight -rc1 that built, so I'm assuming it's
> intentional.

By the way: for some reason, the asm-i386 directory contains an "asm-i386" 
symlink pointing to itself:

ls 
-l /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/include/asm-i386/asm-i386
lrwxrwxrwx  1 landley landley 75 2005-11-17 
17:08 /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/include/asm-i386/asm-i386 
-> /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/include/asm-i386/

Useful data point?

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
