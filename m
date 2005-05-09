Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVBJX-00013N-11	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 09:41:03 -0700
Received: from www.scgiservices.com ([198.107.3.66] helo=www.sterlingcgi.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DVBJU-0004DT-Hz	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 09:41:02 -0700
Message-ID: <20050509094050.lmdi6vnoex8g4g84@www.scgiservices.com>
From: Anthony Brock <brocka@sterlingcgi.com>
Subject: Re: [uml-devel] Kernel panic with 2.6.11.6
References: <s2788296.000@ORANGE.OUS.EDU>
	<20050507031500.GE14445@ccure.user-mode-linux.org>
In-Reply-To: <20050507031500.GE14445@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
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
Date: Mon,  9 May 2005 09:40:50 -0700
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

First, I would appreciate it if someone can remind me of where to download the
'-mm' tree.

Second, I downloaded at attempted to compile 2.6.12-rc4. Unfortunately, I'm
unable to compile it due to the following error:

   HOSTCC  scripts/kallsyms
   HOSTCC  scripts/bin2c
   CC      init/main.o
In file included from arch/um/include/um_uaccess.h:17,
                  from include/asm/uaccess.h:33,
                  from include/asm/unistd.h:11,
                  from include/linux/unistd.h:9,
                  from init/main.c:46:
/srv/work/linux-2.6.12-rc4/arch/um/kernel/skas/include/uaccess-skas.h: In
function `verify_area_skas':
/srv/work/linux-2.6.12-rc4/arch/um/kernel/skas/include/uaccess-skas.h:24: 
error:
`FIXADDR_USER_START' undeclared (first use in this function)
/srv/work/linux-2.6.12-rc4/arch/um/kernel/skas/include/uaccess-skas.h:24: 
error:
(Each undeclared identifier is reported only once
/srv/work/linux-2.6.12-rc4/arch/um/kernel/skas/include/uaccess-skas.h:24: 
error:
for each function it appears in.)
/srv/work/linux-2.6.12-rc4/arch/um/kernel/skas/include/uaccess-skas.h:24: 
error:
`FIXADDR_USER_END' undeclared (first use in this function)
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2

Pointers are appreciated! In the mean time, I'll see if I can figure out a
work-around.

Tony


Quoting Jeff Dike <jdike@addtoit.com>:
> On Wed, May 04, 2005 at 08:06:22AM -0700, Anthony Brock wrote:
>> Okay, I've now recompiled the host kernel to include debugging 
>> information. I now get the following:
>>
>> myserver:~#
>> Program received signal SIGSEGV, Segmentation fault.
>> chan_interrupt (chans=0x4013a3cc, task=0x4013a3fc, tty=0xbc1c000, 
>> irq=2) at arch/um/drivers/chan_kern.c:535
>
> Can you see if you can make it happen with current -mm or current 2.6.12-rc?
>
> Not that I think it's fixed there, but those are the trees I have handy, and
> the line numbers will make a lot more sense to me then.
>
> 				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
