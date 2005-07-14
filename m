Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dt7z0-0000Aw-KA	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2005 10:58:50 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1Dt7yz-0001u5-Et
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2005 10:58:50 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Am I doing something wrong with -skas0?
References: <200507122346.40320.rob@landley.net>
	<200507131647.53822.rob@landley.net> <42D6459B.6080702@fujitsu-siemens.com>
In-Reply-To: <42D6459B.6080702@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507141258.18828.rob@landley.net>
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
Date: Thu, 14 Jul 2005 12:58:18 -0500
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Thursday 14 July 2005 05:59, Bodo Stroesser wrote:
> Hi Jeff,
>
> stub_segv_handler misses the "push ebp" at the beginning. As you
> do the normally corresponding "pop eax" explicitly, I think stack
> pointer is wrong on call of sigreturn.
>
> I have no idea, what makes happen this. Maybe it depends on compiler
> version?
>
>  Bodo

It's the current ("Hoary Hedgehog", I think) ubuntu/kbuntu gcc 3.3:

landley@driftwood:~/busybox_stable$ gcc -v
Reading specs from /usr/lib/gcc-lib/i486-linux/3.3.5/specs
Configured with: ../src/configure -v 
--enable-languages=c,c++,java,f77,pascal,objc,ada,treelang --prefix=/usr 
--mandir=/usr/share/man --infodir=/usr/share/info 
--with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared 
--with-system-zlib --enable-nls --without-included-gettext 
--enable-__cxa_atexit --enable-clocale=gnu --enable-debug 
--enable-java-gc=boehm --enable-java-awt=xlib --enable-objc-gc i486-linux
Thread model: posix
gcc version 3.3.5 (Debian 1:3.3.5-8ubuntu2)


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
