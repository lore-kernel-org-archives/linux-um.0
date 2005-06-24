Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dlllq-0004oP-7W	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Jun 2005 03:50:50 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Dlllo-0000P5-Gy	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Jun 2005 03:50:50 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Linking  .tmp_vmlinuux1 fails with 2.6.12-mm1
References: <42BBA6F1.9080704@gmx.de>
In-Reply-To: <42BBA6F1.9080704@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506241255.46532.blaisorblade@yahoo.it>
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
Date: Fri, 24 Jun 2005 12:55:45 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Raphael Bossek <raphael.bossek@gmx.de>

On Friday 24 June 2005 08:23, Raphael Bossek wrote:
> Hi,
>
> after applying the TT_MODE build patch I run into the following problem
> with linux 2.6.12-mm1:
Does that happen with 2.6.12-current? Here it seems it doesn't; so I'll have 
to look into -mm only; otherwise I'll look at gcc-2.95 differences.

>    gcc-2.95 -Wp,-MD,init/.version.o.d  -nostdinc -isystem
> /usr/lib/gcc-lib/i386-linux/2.95.4/include -D__KERNEL__ -Iinclude  -Wall
> -Wstri
>     ld   -r -o init/built-in.o init/main.o init/version.o init/mounts.o
> init/initramfs.o init/calibrate.o
>          gcc-2.95 -static -Wl,--wrap,malloc -Wl,--wrap,free
> -Wl,--wrap,calloc -o .tmp_vmlinux1 -Wl,-T,arch/um/kernel/vmlinux.lds
> init/b
> arch/um/sys-i386/built-in.o(*ABS*+0x73c706fe): In function `__crc_kunmap':
> module.c: multiple definition of `__crc_kunmap'
> arch/um/sys-i386/built-in.o(*ABS*+0xe7c48b45): In function
> `__crc_kmap_atomic':
> module.c: multiple definition of `__crc_kmap_atomic'
> arch/um/sys-i386/built-in.o(*ABS*+0x1889f5f3): In function
> `__crc_kmap_atomic_to_page':
> module.c: multiple definition of `__crc_kmap_atomic_to_page'
> arch/um/sys-i386/built-in.o(*ABS*+0xd837acb7): In function `__crc_kmap':
> module.c: multiple definition of `__crc_kmap'
> collect2: ld returned 1 exit status
>
> --
> Raphael Bossek

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
