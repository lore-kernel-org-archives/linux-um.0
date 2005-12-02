Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ei0T9-0001bG-3w for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Dec 2005 18:16:15 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ei0T6-0005IH-Cs
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Dec 2005 18:16:15 -0800
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <20051202001358.GA12204@ccure.user-mode-linux.org>
References: <20051202001358.GA12204@ccure.user-mode-linux.org>
Content-Type: text/plain
Message-Id: <1133489716.14775.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Stop the insanity
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
Date: Fri, 02 Dec 2005 02:15:16 +0000
To: Jeff Dike <jdike@addtoit.com>
Cc: William Stearns <wstearns@pobox.com>, Blaisorblade <blaisorblade@yahoo.it>, Kai Tan <mineown@hotmail.com>, Rob Landley <rob@landley.net>, David Lang <dlang@invendra.net>, Joel Palmius <joel.palmius@miun.se>, Mihai Rusu <dizzy@roedu.net>, Michael Richardson <mcr@sandelman.ottawa.on.ca>, Jason Lunz <lunz@falooley.org>, Benjamin LaHaise <bcrl@kvack.org>, user-mode-linux-devel@lists.sourceforge.net

Hi Jeff,

Thanks for taking a stab at sorting out this gcc madness.
I had to apply it by hand on top of -rc3 (I then tried -rc4 too):
(but since no UML patches went into rc4 I guess it's just an offset
problem)

tar -jxf linux-2.6.14.tar.bz2
mv linux-2.6.14 linux-2.6.15-rc3-uml-x86
cd linux-2.6.15-rc3-uml-x86
bzcat ../patch-2.6.15-rc3.bz2 | patch -p1
patch -p1 --dry-run < ../stub-clone.patch
patching file arch/um/include/sysdep-i386/stub.h
Hunk #2 FAILED at 80.
1 out of 2 hunks FAILED -- saving rejects to file
arch/um/include/sysdep-i386/stub.h.rej
patching file arch/um/include/sysdep-x86_64/stub.h
Hunk #2 FAILED at 85.
1 out of 2 hunks FAILED -- saving rejects to file
arch/um/include/sysdep-x86_64/stub.h.rej
patching file arch/um/kernel/skas/clone.c
Hunk #1 FAILED at 18.
Hunk #2 FAILED at 34.
2 out of 2 hunks FAILED -- saving rejects to file
arch/um/kernel/skas/clone.c.rej

I can build the amd64 guest with both:
* gcc (GCC) 3.4.4 (Gentoo Hardened 3.4.4-r1, HTB-3.4.4-1.00,
ssp-3.4.4-1.0, pie-8.7.8)
* gcc (GCC) 4.0.2 20051125 (Red Hat 4.0.2-8)
But as reported yesterday, the GCC-3.4.4 compiled one stops very early
in the boot process.

Now for the SUBARCH=i386 build: using GCC 4.0.2 (FC4 as above) worked,
but using GCC 3.4.4 (Gentoo Hardened):

I get the same result for SUBARCH=i386 and native x86 builds:
* Native: gcc (GCC) 3.3.6 (Gentoo Hardened 3.3.6, HTB-3.3.6-1.00-r1,
ssp-3.3.6-1.0, pie-8.7.8)
* SUBARCH=i386: gcc (GCC) 3.4.4 (Gentoo Hardened 3.4.4-r1,
HTB-3.4.4-1.00, ssp-3.4.4-1.0, pie-8.7.8)

  CC      arch/um/kernel/skas/clone.o
arch/um/kernel/skas/clone.c: In function `stub_clone_handler':
arch/um/include/sysdep/stub.h:45: error: can't find a register in class
`BREG' while reloading `asm'
arch/um/include/sysdep/stub.h:66: error: can't find a register in class
`BREG' while reloading `asm'
arch/um/include/sysdep/stub.h:55: error: can't find a register in class
`BREG' while reloading `asm'
arch/um/include/sysdep/stub.h:90: error: can't find a register in class
`BREG' while reloading `asm'
make[2]: *** [arch/um/kernel/skas/clone.o] Error 1
make[1]: *** [arch/um/kernel/skas] Error 2
make: *** [arch/um/kernel] Error 2

(I used the files that worked on gcc4 to make sure I did not make a
mistake merging it)
I haven't booted into the GCC4 one, but there is no reason why it
wouldn't work.

Antoine



On Thu, 2005-12-01 at 19:13 -0500, Jeff Dike wrote:
> I'm sending this mail out to everyone that I can find who has had the UML
> stubs compiled in unexpected ways, resulting in crashing.
> 
> I'd like testing of the patch below on as many gcc versions as possible.  I
> think this patch avoids the fundamental issue which is behind this, namely
> gcc using the stack when we have just replaced it, behind gcc's back.  The 
> remapping and storage of the return value is hidden in a blob of asm, hopefully
> giving gcc no room for creativity.
> 
> The patch changes both i386 and x86_64 and I'd appreciate testing on both
> architectures.  It's against -rc3, but should go cleanly against -rc4 as well.
> 
> Please report back both successes and failures.
> 
> 				Jeff




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
