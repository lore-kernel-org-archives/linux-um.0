Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bubgk-0004Cv-IS for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Aug 2004 11:49:34 -0700
Received: from w218.z064002068.nyc-ny.dsl.cnc.net ([64.2.68.218])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1Bubgj-0005yB-V0 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Aug 2004 11:49:34 -0700
From: Allen Chan <alydar@users.sourceforge.net>
Subject: Re: [uml-devel] Testing needed for terminal handling patches
References: <200408100515.i7A5FUQW027590@ccure.user-mode-linux.org>
In-Reply-To: <200408100515.i7A5FUQW027590@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408101449.23807.alydar@users.sourceforge.net>
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
Date: Tue, 10 Aug 2004 14:49:23 -0400
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

I got a number of errors compiling the kernel with the new patches.   
The log of the compile at the point of the first three errors are as 
follows:

-----------------
gcc   -Wall -Wstrict-prototypes -Wno-trigraphs -O2 
-fno-strict-aliasing -fno-common -U__i386__ -Ui386 -DUM_FASTCALL -g 
-D__arch_um__ -DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE  
-I/home/alydar/play/kernel/linux-2.4.26/arch/um/include 
-I/home/alydar/play/kernel/linux-2.4.26/arch/um/kernel/tt/include 
-I/home/alydar/play/kernel/linux-2.4.26/arch/um/kernel/skas/include 
-D_GNU_SOURCE -c -o process.o process.c
process.c: In function `handle_trap':
process.c:64: warning: use of conditional expressions as lvalues is 
deprecated
process.c:80: error: parse error before "while"
...
-----------------
gcc   -Wall -Wstrict-prototypes -Wno-trigraphs -O2 
-fno-strict-aliasing -fno-common -U__i386__ -Ui386 -DUM_FASTCALL -g 
-D__arch_um__ -DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE  
-I/home/alydar/play/kernel/linux-2.4.26/arch/um/include 
-I/home/alydar/play/kernel/linux-2.4.26/arch/um/kernel/tt/include 
-I/home/alydar/play/kernel/linux-2.4.26/arch/um/kernel/skas/include 
-D_GNU_SOURCE -c -o sigio_user.o sigio_user.c
sigio_user.c: In function `check_one_sigio':
sigio_user.c:72: error: too few arguments to function `__raw'
...
-----------------
gcc   -Wall -Wstrict-prototypes -Wno-trigraphs -O2 
-fno-strict-aliasing -fno-common -U__i386__ -Ui386 -DUM_FASTCALL -g 
-D__arch_um__ -DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE  
-I/home/alydar/play/kernel/linux-2.4.26/arch/um/include 
-I/home/alydar/play/kernel/linux-2.4.26/arch/um/kernel/tt/include 
-I/home/alydar/play/kernel/linux-2.4.26/arch/um/kernel/skas/include 
-D_GNU_SOURCE -c -o user_util.o user_util.c
user_util.c:122:29: macro "raw" passed 2 arguments, but takes just 1
...
-----------------


I was able to fix the typo on the first one by modifying line 80 of 
arch/um/kernel/skas/process.c to:
    CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
from:
    err = CATCH_EINTR(waitpid(pid, &status, WUNTRACED));

However, it is not clear to me how the raw() and __raw() functions and 
macros were intended to be handled on the other errors.  I have a 
strange suspicion that the two "raw" patches posted on the 
incremental patches site are incomplete.


On Tuesday 10 August 2004 01:15 am, Jeff Dike wrote:
> I've posted a set of patches that fiddle with UML's handling of
> terminal modes to
> http://user-mode-linux.sourceforge.net/patches.html
>
> I'd like people to try them out and report bad experiences,
> especially if you saw the 'netdevice 0' hang or stairstepping
> output during boot.  They are the catch-eintr, bb-raw, and
> clean-raw patches.


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
