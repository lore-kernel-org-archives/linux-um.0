Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BqNDi-000558-Qk for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jul 2004 19:34:06 -0700
Received: from w218.z064002068.nyc-ny.dsl.cnc.net ([64.2.68.218])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1BqNDi-0002zo-7d for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Jul 2004 19:34:06 -0700
From: Allen Chan <alydar@users.sourceforge.net>
References: <200407280315.08207.alydar@users.sourceforge.net>
	<200407281722.i6SHM6eh002963@ccure.user-mode-linux.org>
	<200407291430.18818.alydar@users.sourceforge.net>
In-Reply-To: <200407291430.18818.alydar@users.sourceforge.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407292234.04279.alydar@users.sourceforge.net>
Subject: [uml-devel] Re: Bug#260111: user-mode-linux: upgrade hangs at "NET4:
	Linux TCP/IP 1.0 for NET4.0 "
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
Date: Thu, 29 Jul 2004 22:34:01 -0400
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, 260111@bugs.debian.org

More details on the problem after some more investigation and 
testing... the specific function that was moved from chan_user.c to 
chan_kern.c that caused the problem is generic_console_write().  
Notice the isatty() calls.  They probably explain the earlier 
observation that piping or redirecting the stdout gets around the 
problem.

int generic_console_write(int fd, const char *buf, int n, void 
*unused)
{
        struct termios save, new;
        int err;

        if(isatty(fd)){
                tcgetattr(fd, &save);
                new = save;
                new.c_oflag |= OPOST;
                tcsetattr(fd, TCSAFLUSH, &new);
        }
        err = generic_write(fd, buf, n, NULL);
        if(isatty(fd)) tcsetattr(fd, TCSAFLUSH, &save);
        return(err);
}

Note also the output for chan_kern.c while the kernel is compiling:

gcc -D__KERNEL__ -I/home/alydar/play/kernel/linux-2.4.26/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common  -U__i386__ -Ui386 -DUM_FASTCALL -g -D__arch_um__ 
-DSUBARCH="i386" -D_LARGEFILE64_SOURCE 
-I/home/alydar/play/kernel/linux-2.4.26/arch/um/include 
-Derrno=kernel_errno 
-I/home/alydar/play/kernel/linux-2.4.26/arch/um/kernel/tt/include 
-I/home/alydar/play/kernel/linux-2.4.26/arch/um/kernel/skas/include    
-nostdinc -iwithprefix include -DKBUILD_BASENAME=chan_kern  -c -o 
chan_kern.o chan_kern.c
chan_kern.c: In function `generic_console_write':
chan_kern.c:121: warning: implicit declaration of function `isatty'
chan_kern.c:122: warning: implicit declaration of function `tcgetattr'
chan_kern.c:125: warning: implicit declaration of function `tcsetattr'


On Thursday 29 July 2004 02:30 pm, Allen Chan wrote:
>
> It turns out that the following changes caused the problem to show
> up:
>
> arch/um/drivers/chan_kern.c 1.39 Fri 07-16-2004 02:27 PM EDT jdike
> Exp +65 -0
>   Moved some non-userspace code from chan_user.c to chan_kern.c.
> arch/um/drivers/chan_user.c 1.33 Fri 07-16-2004 02:27 PM EDT jdike
> Exp +0 -64
>   Moved some non-userspace code from chan_user.c to chan_kern.c.
>


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
