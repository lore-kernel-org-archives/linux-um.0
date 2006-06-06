Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fo9F7-0002hh-H8 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jun 2006 18:23:25 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fo9F7-0001MU-Ad for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jun 2006 18:23:25 -0700
Received: from ug-out-1314.google.com ([66.249.92.173])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fo9F7-0004Qk-1l
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jun 2006 18:23:25 -0700
Received: by ug-out-1314.google.com with SMTP id m2so577402ugc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 07 Jun 2006 18:23:23 -0700 (PDT)
Message-ID: <835bb2cb0606060553q6402b169p19e9b37bdec5fa16@mail.gmail.com>
Date: Tue, 6 Jun 2006 17:53:08 +0500
From: "Murali Nagaraj" <muralin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] linux-2.6.16 build broken?
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
To: user-mode-linux-devel@lists.sourceforge.net

hi,

i am new to this list, and i am not sure if this is the
place for such postings.

trying to build uml on i386 and it seems to be
broken. yup, made sure that the .config i generated
is correct (defconfig, ARCH=um etc)

~ muralin

<snip>
  CC      arch/um/os-Linux/sys-i386/registers.o
arch/um/os-Linux/sys-i386/registers.c: In function 'get_thread_regs':
arch/um/os-Linux/sys-i386/registers.c:137: error: 'JB_PC' undeclared
(first use in this function)
arch/um/os-Linux/sys-i386/registers.c:137: error: (Each undeclared
identifier is reported only once
arch/um/os-Linux/sys-i386/registers.c:137: error: for each function it
appears in.)
arch/um/os-Linux/sys-i386/registers.c:138: error: 'JB_SP' undeclared
(first use in this function)
arch/um/os-Linux/sys-i386/registers.c:139: error: 'JB_BP' undeclared
(first use in this function)
make[2]: *** [arch/um/os-Linux/sys-i386/registers.o] Error 1
make[1]: *** [arch/um/os-Linux/sys-i386] Error 2
make: *** [arch/um/os-Linux] Error 2
<snip>


_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
