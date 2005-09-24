Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EJDqk-0000D2-Iv	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 10:30:10 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EJDqi-0000VL-6y
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 10:30:10 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] 2.6.13.2 + gcc 4.01 link error
Message-ID: <20050924172259.GA5398@ccure.user-mode-linux.org>
References: <229e70f2050924085215707921@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <229e70f2050924085215707921@mail.gmail.com>
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
Date: Sat, 24 Sep 2005 13:22:59 -0400
To: Etay Meiri <etay.meiri@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Sep 24, 2005 at 06:52:46PM +0300, Etay Meiri wrote:
> arch/um/sys-i386/built-in.o(*ABS*+0xde77d105): In function `__crc_kunmap':
> : multiple definition of `__crc_kunmap'
> arch/um/sys-i386/built-in.o(*ABS*+0x26792e7): In function
> `__crc_kmap_atomic':
> : multiple definition of `__crc_kmap_atomic'
> arch/um/sys-i386/built-in.o(*ABS*+0x7d922e4a): In function
> `__crc_kmap_atomic_to_page':
> : multiple definition of `__crc_kmap_atomic_to_page'
> arch/um/sys-i386/built-in.o(*ABS*+0xf3c4062c): In function `__crc_kmap':
> : multiple definition of `__crc_kmap'
> collect2: ld returned 1 exit status
> KSYM .tmp_kallsyms1.S
> nm: '.tmp_vmlinux1': No such file
> No valid symbol.
> make: *** [.tmp_kallsyms1.S] Error 1

This is a bogus config.  Fix by
	make mrproper
	make mrproper ARCH=um
	make defconfig ARCH=um
	make ARCH=um

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
