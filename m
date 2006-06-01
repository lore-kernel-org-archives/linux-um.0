Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fm9zQ-0005kA-5j for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jun 2006 06:47:00 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fm9zO-00012y-Ev for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jun 2006 06:46:58 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Fm9zJ-00084s-Mk
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jun 2006 06:46:58 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 1 Jun 2006 21:07:46 +0200
References: <5d8380130605220711u536aa04aud8db4e4bbbb146e@mail.gmail.com>
In-Reply-To: <5d8380130605220711u536aa04aud8db4e4bbbb146e@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606012107.47130.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Problem in compiling without optimisations
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
Cc: Nikola Knezevic <laladelausanne@gmail.com>

On Monday 22 May 2006 16:11, Nikola Knezevic wrote:
> Hi all,
> When I change Makefile to have -O0 instead of -O2, this is what I get
> after make ARCH=um:

There are other spots where -O0 would lead to failure; search for -O0 on the 
ML, I remember that adding -finline and something else made it work (IIRC 
2.6.15 time), and this code was present.

>   CC      arch/um/kernel/skas/clone.o
> arch/um/include/sysdep/stub.h: In function 'remap_stack':
> arch/um/include/sysdep/stub.h:90: warning: asm operand 7 probably
> doesn't match constraints
> arch/um/include/sysdep/stub.h:90: error: impossible constraint in 'asm'
> make[2]: *** [arch/um/kernel/skas/clone.o] Error 1
> make[1]: *** [arch/um/kernel/skas] Error 2
> make: *** [arch/um/kernel] Error 2
>
> This is the culprit:
> static inline void remap_stack(int fd, unsigned long offset)
> {
>         __asm__ volatile ("movl %%eax,%%ebp ; movl %0,%%eax ; int $0x80 ;"
>                           "movl %7, %%ebx ; movl %%eax, (%%ebx)"
>
>                           : : "g" (STUB_MMAP_NR), "b"
>                           : : (UML_CONFIG_STUB_DATA),
>
>                             "c" (UM_KERN_PAGE_SIZE),
>                             "d" (PROT_READ | PROT_WRITE),
>                             "S" (MAP_FIXED | MAP_SHARED), "D" (fd),
>                             "a" (offset),
>                             "i" (&((struct stub_data *)
> UML_CONFIG_STUB_DATA)->err)
>
>                           : "memory");
>
> }

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 



_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
