Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zjYK-0005rI-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 14:09:32 -0700
Received: from [216.127.35.139] (helo=mail.franklaub.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19zjYK-0002BO-1T
	for User-mode-linux-devel@lists.sourceforge.net; Wed, 17 Sep 2003 14:09:32 -0700
Message-ID: <00af01c37d5f$65ac1f50$6059a043@clicktosecure.com>
From: "Frank Laub" <fried@franklaub.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Compiling 2.4.22-4um
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
Date: Wed, 17 Sep 2003 13:57:42 -0700
To: User-mode-linux-devel@lists.sourceforge.net

I get the following error when trying to compile.

make[2]: Entering directory `/usr/src/uml-2.4.22-4um/arch/um/kernel'
gcc   -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno
-common -U__i386__ -Ui386 -DUM_FASTCALL -g -D__arch_um__ -DSUBARCH=\"i386\" 
-D_LARGEFILE64_SOURCE  -I/usr/src/uml-2.4.22-4um/arch/um/include -I/usr/src/
uml-2.4.22-4um/arch/um/kernel/tt/include -I/usr/src/uml-2.4.22-4um/arch/um/k
ernel/skas/include -D_GNU_SOURCE -c -o umid.o umid.c
In file included from umid.c:18:
/usr/src/uml-2.4.22-4um/arch/um/include/os.h:41: warning: no semicolon at
end of struct or union
/usr/src/uml-2.4.22-4um/arch/um/include/os.h:41: parse error before `.'
/usr/src/uml-2.4.22-4um/arch/um/include/os.h:42: parse error before `.'
/usr/src/uml-2.4.22-4um/arch/um/include/os.h:43: parse error before `.'
make[2]: *** [umid.o] Error 1
make[2]: Leaving directory `/usr/src/uml-2.4.22-4um/arch/um/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/uml-2.4.22-4um/arch/um/kernel'
make: *** [_dir_arch/um/kernel] Error 2

Looking at os.h doesn't appear to look like any problem.  I can send my
.config if need be.
Anyone have any hints?

TIA,
-Frank



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
