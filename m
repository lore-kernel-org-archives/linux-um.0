Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stian@nixia.no>) id 1YVLwv-0008Dz-0z
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 15:20:01 +0000
Received: from [195.159.66.51] (helo=ramslauken.nlc.no)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YVLws-0002HB-NQ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 15:20:01 +0000
Received: from mail.nlc.no (ramslauken.nlc.no [195.159.66.51])
	(Authenticated sender: stian@nixia.no)
	by ramslauken.nlc.no (Postfix) with ESMTPA id A6ADA1D6788
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 10 Mar 2015 15:56:13 +0100 (CET)
MIME-Version: 1.0
Date: Tue, 10 Mar 2015 15:56:13 +0100
From: stian@nixia.no
In-Reply-To: <54FF0233.602@gmx.de>
References: <54FF0233.602@gmx.de>
Message-ID: <ada75b95e78f55a406718a9c604ad1b2@nixia.no>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] compile error after : make ARCH=um allmodconfig &&
 make ARCH=um linux
To: user-mode-linux-devel@lists.sourceforge.net

> is this already known ? :
>
>   CC      arch/um/drivers/vde_kern.o
>   CC      arch/um/drivers/vde_user.o
> arch/um/drivers/vde_user.c:8:24: fatal error: libvdeplug.h: No such
> file or directory
>  #include <libvdeplug.h>
>                         ^
> compilation terminated.
> scripts/Makefile.build:258: recipe for target
> 'arch/um/drivers/vde_user.o' failed
> make[1]: *** [arch/um/drivers/vde_user.o] Error 1
> Makefile:947: recipe for target 'arch/um/drivers' failed
> make: *** [arch/um/drivers] Error 2

A quick google search suggests that you are missing 
http://vde.sourceforge.net/ . Do you have this library with its 
developments-headers installed?


Stian Skjelstad

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

