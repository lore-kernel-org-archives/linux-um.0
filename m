Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EczWb-0008U2-NF for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 22:15:05 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EczWZ-0000dR-7D
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 22:15:05 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Getting the x86-64 rollup patch to work on my x86
	laptop.
References: <200511161100.31053.rob@landley.net>
	<200511171651.33764.rob@landley.net>
	<20051118031257.GA14537@ccure.user-mode-linux.org>
In-Reply-To: <20051118031257.GA14537@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511180014.49772.rob@landley.net>
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
Date: Fri, 18 Nov 2005 00:14:49 -0600
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Thursday 17 November 2005 21:12, Jeff Dike wrote:
> On Thu, Nov 17, 2005 at 04:51:33PM -0600, Rob Landley wrote:
> > find . -name asm
> > ./include/asm
> > ./include2/asm
> >
> > ls -l include/asm include2/asm
> > lrwxrwxrwx  1 landley landley 72 2005-11-17 16:46 include2/asm
> > ->
> > /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/include/asm-um
> > lrwxrwxrwx  1 landley landley  6 2005-11-17 16:46 include/asm -> asm-um
> >
> > ls -l include/asm/arch include2/asm/arch
> > ls: include2/asm/arch: No such file or directory
> > lrwxrwxrwx  1 landley landley 74 2005-11-17 16:46 include/asm/arch
> > ->
> > /home/landley/newbuild/firmware-build/tmpdir/linux-2.6.14/include/asm-i38
> >6
>
> This all looks the same as I have here, except for the asm-i386 thing,
> which I don't think matters.  ldt.h seems to be at the center of this,
> so can you check the following:

Oops.

I grabbed your thursday patches tarball (overwriting the one I had), and the 
result is a mess.  Your very first patch goes:

uml-reuse-i386-cpu-optim-fix.patch
patching file arch/um/Kconfig
Reversed (or previously applied) patch detected!  Assume -R? [n]   

And whether I tell it it's reversed or to skip it, the result is failed hunks 
and more reversed patches later on.

Here's my apply script:

#!/bin/sh

rm -rf linux-2.6.14 &&
tar xvjf ../sources/packages/linux-2.6.14.tar.bz2 &&
cd linux-2.6.14 &&
(bzcat ../../sources/packages/patch-2.6.15-rc1.bz2 | exit 1) | patch -p1 &&
tar xvf ~/patches.tar &&
for i in `cat patches/series`
do
  echo $i
  patch -p1 -i patches/$i
done

Is the problem on my end, or is your tarball horked?

I'll dig around and see if I still have a copy of wednesday's, which at least 
applied...

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
