Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zKaD-0006VK-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 16 Sep 2003 11:29:49 -0700
Received: from [66.119.9.202] (helo=jeev.omaja.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19zKaC-0002MI-MB
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Sep 2003 11:29:48 -0700
From: "Matthew R. Scott" <user-mode-linux-devel@goldenspud.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309161329.39725.user-mode-linux-devel@goldenspud.com>
Subject: [uml-devel] compile error with 2.4.22-uml4 and 2.4.23-pre4-djc2-4um
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 16 Sep 2003 13:29:39 -0500
To: user-mode-linux-devel@lists.sourceforge.net


With both of these patches I am getting the following error during compile:

gcc-2.95   -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -march=pentium -O3 -pipe -fomit-frame-pointer -U__i386__ -Ui386 
-DUM_FASTCALL -g -D__arch_um__ -DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE  -I/
home/gldnspud/uml/build/buildkernel-build/linux/arch/um/include -I/home/
gldnspud/uml/build/buildkernel-build/linux/arch/um/kernel/tt/include -I/home/
gldnspud/uml/build/buildkernel-build/linux/arch/um/kernel/skas/include 
-D_GNU_SOURCE -c -o umid.o umid.c
In file included from umid.c:18:
/home/gldnspud/uml/build/buildkernel-build/linux/arch/um/include/os.h:41: 
warning: no semicolon at end of struct or union
/home/gldnspud/uml/build/buildkernel-build/linux/arch/um/include/os.h:41: 
parse error before `.'
/home/gldnspud/uml/build/buildkernel-build/linux/arch/um/include/os.h:42: 
parse error before `.'
/home/gldnspud/uml/build/buildkernel-build/linux/arch/um/include/os.h:43: 
parse error before `.'
make[4]: *** [umid.o] Error 1
make[4]: Leaving directory `/home/gldnspud/uml/build/buildkernel-build/linux/
arch/um/kernel'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory `/home/gldnspud/uml/build/buildkernel-build/linux/
arch/um/kernel'
make[2]: *** [_dir_arch/um/kernel] Error 2
make[2]: Leaving directory `/home/gldnspud/uml/build/buildkernel-build/linux'
make[1]: *** [buildkernel-build-stamp] Error 2
make[1]: Leaving directory `/home/gldnspud/uml/build'
make: *** [build-stamp] Error 2

When I look at line 41, 42, and 43 in arch/um/include/os.h though, there 
doesn't seem to be any sort of problems.  Those lines are in the middle of a 
perfectly valid-looking struct.


-- 
Matthew R. Scott
OMAjA / http://www.omaja.com/



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
