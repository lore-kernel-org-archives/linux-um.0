Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZnc3-0000BI-V1
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 26 Dec 2003 00:46:27 -0800
Received: from mx11.sac.fedex.com ([199.81.193.118])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AZnc3-00050b-J2
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 26 Dec 2003 00:46:27 -0800
Received: from inet03.prod.fedex.com (inet03.prod.fedex.com [199.81.10.43])
	by mx11.sac.fedex.com (8.12.6p2/8.12.3) with ESMTP id hBQ8kEJw031100
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 26 Dec 2003 02:46:14 -0600 (CST)
	(envelope-from jeff98@silk.corp.fedex.com)
From: Jeff Chua <jeff98@silk.corp.fedex.com>
Subject: Re: [uml-devel] UML build system: patch ready
In-Reply-To: <200312241943.37474.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.58.0312261606480.18690@boston.corp.fedex.com>
References: <200312241943.37474.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 26 Dec 2003 16:12:43 +0800 (SGT)
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>


On Wed, 24 Dec 2003, BlaisorBlade wrote:

> follow THE link and download all patches (not A-04-User_obj_makefiles.patch,
> which is old and broken). I was able to build the whole kernel with them all
> applied! There are still some special files that use their specific rules,
> but that should be no problem for now. Next I'll fix them, too and try to fix
> CONFIG_MODVERSIONS(which for now must be disabled).

arch/um/sys-i386/bugs.c ...
	//line 110
	struct modify_ldt_ldt_s ldt;

	//line 117
	err = modify_ldt(1, &ldt, sizeof(ldt));


It looks that modify_ldt_ldt_s is not defined anywhere and modify_ldt()
cannot be found.

I did these ...
	cd uml
	patch -p1 </tar/uml/uml-combo-2.6.0-A5
	patch -p1 </tar/uml/A-01-Fix_clean_mrproper.patch
	patch -p1 </tar/uml/A-02-Apply_altern-constants.patch
	patch -p1 </tar/uml/A-03-Module_support.patch

	and .config says "# CONFIG_MODVERSIONS is not set"

	Plain v2.6 compiles and boots ok.

Jeff.



gcc  -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -U__i386__ -Ui386 -D__arch_um__ -DSUBARCH=\"i386\"
-D_LARGEFILE64_SOURCE   -Iarch/um/include
-I/v6/src/260/uml/arch/um/kernel/skas/include -D_GNU_SOURCE -c -o
arch/um/sys-i386/bugs.o arch/um/sys-i386/bugs.c
In file included from /usr/include/linux/compiler.h:18,
                 from /usr/include/asm/sigcontext.h:4,
                 from /usr/include/bits/sigcontext.h:28,
                 from /usr/include/signal.h:307,
                 from /usr/include/sys/signal.h:1,
                 from arch/um/sys-i386/bugs.c:10:
/usr/include/linux/compiler-gcc2.h:15: warning: `__attribute_used__'
redefined
/usr/include/sys/cdefs.h:170: warning: this is the location of the
previous definition
arch/um/sys-i386/bugs.c: In function `disable_lcall':
arch/um/sys-i386/bugs.c:110: storage size of `ldt' isn't known
arch/um/sys-i386/bugs.c:117: warning: implicit declaration of function
`modify_ldt'
arch/um/sys-i386/bugs.c:110: warning: unused variable `ldt'



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
