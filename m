Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <malattia@linux.it>) id 1SFvJq-0004X0-EP
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Apr 2012 22:38:18 +0000
Received: from ac250205.ppp.asahi-net.or.jp ([183.77.250.205]
	helo=smtp.kamineko.org)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SFvJp-0006Gk-AQ for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Apr 2012 22:38:18 +0000
Date: Fri, 6 Apr 2012 07:21:01 +0900
From: Mattia Dongili <malattia@linux.it>
Message-ID: <20120405222100.GA6372@kamineko.org>
References: <E1SEjI8-0007kU-RE@franck.debian.org> <4F7AFA9E.5020306@debian.org>
	<CAFLxGvwSVTnoaky43CvUHs8gKT5m5w81YcUw6DC_PTeN2DF+AA@mail.gmail.com>
	<4F7B53DC.1040602@debian.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F7B53DC.1040602@debian.org>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] UML static linking and embedded library
To: Ritesh Raj Sarraf <rrs@debian.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Apr 04, 2012 at 01:17:40AM +0530, Ritesh Raj Sarraf wrote:
> On Tuesday 03 April 2012 10:35 PM, richard -rw- weinberger wrote:
> > Solving the first issue is straight forward.
> > For the second one I've to think a bit why Jeff took the current
> > static linking approach.
> > 
> > Expect patches for both issues in 3.5. :-)
> 
> Thanks. Can you prepare the patch?
> 
> We are going to ship Debian 7 (Wheezy) with kernel v3.2. Based on what
> you prepare, I will backport it.

the rpath one should be as simple as the attached one but honestly I
kind of recall there was a reason for RPATH to be defined. Maybe that
reason is no longer valid though...

--- 
commit ea13ff7608ea92df6ffa41e1124e5d3e6d7984fb
Author: Mattia Dongili <malattia@linux.it>
Date:   Fri Apr 6 07:18:17 2012 +0900

    Remove unnecessary RPATH definition
    
    Signed-off-by: Mattia Dongili <malattia@linux.it>

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 55c0661..b836776 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -105,7 +105,6 @@ archheaders:
 archprepare: include/generated/user_constants.h
 
 LINK-$(CONFIG_LD_SCRIPT_STATIC) += -static
-LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib
 
 CFLAGS_NO_HARDENING := $(call cc-option, -fno-PIC,) $(call cc-option, -fno-pic,) \
 	$(call cc-option, -fno-stack-protector,) \
diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index 4be406a..8368350 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -47,9 +47,6 @@ KBUILD_CPPFLAGS += -m64
 ELF_ARCH := i386:x86-64
 ELF_FORMAT := elf64-x86-64
 
-# Not on all 64-bit distros /lib is a symlink to /lib64. PLD is an example.
-
-LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64
 LINK-y += -m64
 
 # Do unit-at-a-time unconditionally on x86_64, following the host
-- 
mattia
:wq!

------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

