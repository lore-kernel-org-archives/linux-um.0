Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I9P9u-0005Jb-Ht for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 10:42:28 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I9P9q-0005K1-UP
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 10:42:24 -0700
Message-ID: <4697B944.6030203@nagafix.co.uk>
Date: Fri, 13 Jul 2007 18:41:24 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <46975CD0.5020709@nagafix.co.uk> <46976A09.9070906@nagafix.co.uk>
	<20070713155723.GA7468@c2.user-mode-linux.org>
In-Reply-To: <20070713155723.GA7468@c2.user-mode-linux.org>
Subject: Re: [uml-devel] ARCH=um SUBARCH=i386 breakage?
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> On Fri, Jul 13, 2007 at 01:03:21PM +0100, Antoine Martin wrote:
>   
>> I had updated the kernel headers and these include files have been removed.
>> Until UML uses some other trick, this works for me for the 64-bit build:
>>
>> cp /usr/src/linux-2.6.22.1/include/asm/user.h /usr/include/asm/user.h
>> cp /usr/src/linux-2.6.22.1/include/asm/page.h /usr/include/asm/page.h
>> cp /usr/src/linux-2.6.22.1/include/linux/const.h /usr/include/linux/const.h
>>     
>
> asm/user,h looks like a problem.  The only other way I see to get the
> size of the FP registers is elf_fpregset_t and elf_fpxregset_t in
> asm/elf.h, which is exported.  However, those are defined in terms of
> user_i387_struct and user_fxsr_struct in user.h, and it gets them with
>
> 	#include <asm/user.h>
>
> So, we seem to have a situation where an exported header includes a
> non-exported one, or the include is filtered out and we have a type
> with an unknown size.
>
> Could you check this there by seeing if something like this builds
> (with user.h removed):
>
> #include <asm/elf.h>
>
> int main(void){
> 	printf("%d %d\n", sizeof(elf_fpregset_t), sizeof(elf_fpxregset_t));
>   
My kernel headers are also missing elf.h, so this doesn't work either...

It is included in page.h:

  CC      arch/um/sys-i386/user-offsets.s
In file included from /usr/include/asm/user.h:5,
                 from arch/um/sys-i386/user-offsets.c:7:
/usr/include/asm/page.h:4:25: error: linux/const.h: No such file or 
directory
arch/um/sys-i386/user-offsets.c: In function 'foo':
arch/um/sys-i386/user-offsets.c:52: error: invalid application of 
'sizeof' to incomplete type 'struct user_fxsr_struct'
make[1]: *** [arch/um/sys-i386/user-offsets.s] Error 1
make: *** [arch/um/sys-i386/user-offsets.s] Error 2

> Can you get rid of page.h and const.h (you'll have to leave user.h
> unfortunately) again and try the patch below?  It builds for me on
> both i386 and x86_64.
>   
I get the same error as above because user.h includes  asm/page.h
I tried removing the include from user.h, but then I get:
  CC      arch/um/sys-i386/user-offsets.s
arch/um/sys-i386/user-offsets.c: In function 'foo':
arch/um/sys-i386/user-offsets.c:52: error: invalid application of 
'sizeof' to incomplete type 'struct user_fxsr_struct'
make[1]: *** [arch/um/sys-i386/user-offsets.s] Error 1
make: *** [arch/um/sys-i386/user-offsets.s] Error 2


Antoine


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
