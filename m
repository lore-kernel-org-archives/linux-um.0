Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EJDXD-0007l5-O9	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 10:09:59 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EJDXC-0000Uv-23
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 10:09:59 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.13.2 + gcc 4.01 link error
References: <229e70f2050924085215707921@mail.gmail.com>
In-Reply-To: <229e70f2050924085215707921@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509241854.53536.blaisorblade@yahoo.it>
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
Date: Sat, 24 Sep 2005 18:54:53 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Etay Meiri <etay.meiri@gmail.com>

On Saturday 24 September 2005 17:52, Etay Meiri wrote:
> Hi,
>
> I'm trying to compile UML on FC4 using kernel source
> 2.6.13.2<http://2.6.13.2/> and gcc-4.0.1-4.fc4 and getting the following
> errors:
Disable CONFIG_HIGHMEM as a workaround (you likely don't need it), I'll fix it 
later.
>
> CC lib/string.o
> CC lib/vsprintf.o
> AR lib/lib.a
> CC [M] lib/crc-ccitt.o
> CC [M] lib/libcrc32c.o
> GEN .version
> CHK include/linux/compile.h
> dnsdomainname: Unknown host
> UPD include/linux/compile.h
> CC init/version.o
> LD init/built-in.o
> LD .tmp_vmlinux1

> arch/um/sys-i386/built-in.o(*ABS*+0xde77d105): In function `__crc_kunmap':
> : multiple definition of `__crc_kunmap'
>
> arch/um/sys-i386/built-in.o(*ABS*+0x26792e7): In function

> `__crc_kmap_atomic':
> : multiple definition of `__crc_kmap_atomic'
>
> arch/um/sys-i386/built-in.o(*ABS*+0x7d922e4a): In function
>
> `__crc_kmap_atomic_to_page':
> : multiple definition of `__crc_kmap_atomic_to_page'
>
> arch/um/sys-i386/built-in.o(*ABS*+0xf3c4062c): In function `__crc_kmap':
> : multiple definition of `__crc_kmap'
>
> collect2: ld returned 1 exit status
> KSYM .tmp_kallsyms1.S
> nm: '.tmp_vmlinux1': No such file
> No valid symbol.
> make: *** [.tmp_kallsyms1.S] Error 1
>
> Any idea?
>
> Thanks,
>
> --
> ------------------------------------------------------
> Etay Meiri
> etay.meiri@gmail.com

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
