Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fw4OE-0008Bt-MG for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 14:49:34 -0700
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fw4O8-0007Kp-U8
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jun 2006 14:49:31 -0700
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5TLnJhZ008924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 29 Jun 2006 17:49:19 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5TLnJBG258524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 29 Jun 2006 17:49:19 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5TLnJWC012421 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 29 Jun 2006 17:49:19 -0400
Date: Thu, 29 Jun 2006 14:49:24 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
Message-ID: <20060629214924.GJ4488@us.ibm.com>
References: <20060626220234.GG4223@us.ibm.com>
	<20060627183128.GA4488@us.ibm.com>
	<20060628004756.GC4488@us.ibm.com>
	<200606281213.21696.blaisorblade@yahoo.it>
	<20060629205626.GH4488@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20060629205626.GH4488@us.ibm.com>
Subject: Re: [uml-devel] [PATCH] Fix UML build on i386 Ubuntu Dapper
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

On 29.06.2006 [13:56:26 -0700], Nishanth Aravamudan wrote:
> On 28.06.2006 [12:13:21 +0200], Blaisorblade wrote:
> > On Wednesday 28 June 2006 02:47, Nishanth Aravamudan wrote:
> > > On 27.06.2006 [11:31:28 -0700], Nishanth Aravamudan wrote:
> > > > On 27.06.2006 [16:56:13 +0200], Blaisorblade wrote:
> > > > > On Tuesday 27 June 2006 00:02, Nishanth Aravamudan wrote:
> > > > > > Hi Jeff,
> > > > > >
> > > > > > I run an x86_64 kernel with i386 userspace (Ubuntu Dapper) and
> > > > > > decided to try out UML today. I found that UML wasn't quite
> > > > > > aware of biarch compilers (which Ubuntu i386 ships). A fix
> > > > > > similar to what was done for x86_64 should probably be
> > > > > > committed (see
> > > > > > http://marc.theaimsgroup.com/?l=linux-kernel&m=113425940204010&w=2).
> > > > >
> > > > > Ok, it seemed strange but I understand the stuff... that's very
> > > > > interesting as this is the setup I'd wished to have since ages.
> > > > > I'll switch to it ASAP...
> > > >
> > > > Indeed :)
> > > >
> > > > > > Without the FLAGS changes, the build will fail at a number of
> > > > > > places and without the LINK change, the final link will fail.
> > > > > >
> > > > > > Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> > > > >
> > > > > The first hunk (#undef i386) should be unnecessary given you
> > > > > specify -m64 (add it to CPPFLAGS too). Also it can/could be
> > > > > problematic for
> > >
> > > Hrm, I somehow overlooked the CPPFLAGS bit. Is it necessary? That
> > > wasn't changed for x86_64 and having not changed it for UML, it
> > > doesn't appear to have prevented the build from working on both
> > > x86_64 and i386 SUBARCHs here.
> > 
> > It shouldn't go in the general CPPFLAGS indeed.  I think that -m64 in
> > the preprocessor command used to build vmlinux.lds.S would be cleaner
> > than #undef i386... test it by preprocessing by hand and report, I'll
> > code the CPPFLAGS_vmlinux.lds.S = -m64 assignment (if it is exactly
> > this way) if it works.

<snip my e-mail sent before I saw Jeff had sent on the previous patch>

An incremental patch for Blaisorblade's idea follows. It builds
successfully here.

---

On top of the previous biarch changes for UML, this makes the
preprocessor changes a bit cleaner. Specify the 64-bit build in CPPFLAGS
on the x86_64 SUBARCH, rather than #undef'ing i386. Compile-tested with
i386 and x86_64 SUBARCHs.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

diff -urpN 2.6.17-dev2/arch/um/kernel/vmlinux.lds.S 2.6.17-dev/arch/um/kernel/vmlinux.lds.S
--- 2.6.17-dev2/arch/um/kernel/vmlinux.lds.S	2006-06-29 14:44:44.000000000 -0700
+++ 2.6.17-dev/arch/um/kernel/vmlinux.lds.S	2006-06-29 13:52:10.000000000 -0700
@@ -1,6 +1,4 @@
 #include <linux/config.h>
-/* in case the preprocessor is a 32bit one */
-#undef i386
 #ifdef CONFIG_LD_SCRIPT_STATIC
 #include "uml.lds.S"
 #else
diff -urpN 2.6.17-dev2/arch/um/Makefile-x86_64 2.6.17-dev/arch/um/Makefile-x86_64
--- 2.6.17-dev2/arch/um/Makefile-x86_64	2006-06-29 14:44:54.000000000 -0700
+++ 2.6.17-dev/arch/um/Makefile-x86_64	2006-06-29 13:47:22.000000000 -0700
@@ -11,6 +11,7 @@ USER_CFLAGS += -fno-builtin -m64
 CHECKFLAGS  += -m64
 AFLAGS += -m64
 LDFLAGS += -m elf_x86_64
+CPPFLAGS += -m64
 
 ELF_ARCH := i386:x86-64
 ELF_FORMAT := elf64-x86-64

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
