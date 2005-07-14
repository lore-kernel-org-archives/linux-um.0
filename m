Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dt8GW-0001Av-J4	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2005 11:16:56 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx1.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1Dt8GW-0005zT-2V
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Jul 2005 11:16:56 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Am I doing something wrong with -skas0?
References: <200507122346.40320.rob@landley.net>
	<200507132102.46910.rob@landley.net>
	<20050714123720.GA25689@ccure.user-mode-linux.org>
In-Reply-To: <20050714123720.GA25689@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507141316.38969.rob@landley.net>
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
Date: Thu, 14 Jul 2005 13:16:38 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thursday 14 July 2005 07:37, Jeff Dike wrote:
> On Wed, Jul 13, 2005 at 09:02:46PM -0500, Rob Landley wrote:
> > There's only one pid, the ./linux process gdb fired off.
>
> No, there's the pid that's being ptraced, and I need the maps for it.
>
> > The breakpoint you
> > mentioned was accepted (it said breakpoint set and gave me an address),
> > but it was never reached.
>
> Then put a while(1) ; just before the panic and kill -INT uml-pid when it
> freezes.  That will get you a gdb prompt where you need it.
>
>     Jeff

Bodo's patch seems to have fixed the problem (albeit in a way that reveals 
ubuntu is using thread-local storage, so I can't use it anyway).

But just in case this helps, I added the for loop, and here's the maps for the 
second pid:

landley@driftwood:/proc/8793$ cat maps
08000000-08048000 rw-s 00000000 03:05 4921999    /tmp/vm_file-oxis26 (deleted)
08048000-08132000 rwxp 00000000 03:05 
2801042    /home/landley/linux-2.6.12.2/linux
08132000-08165000 rw-p 08132000 00:00 0
08165000-081b0000 rw-s 00165000 03:05 4921999    /tmp/vm_file-oxis26 (deleted)
081b0000-081b1000 rwxs 001b0000 03:05 4921999    /tmp/vm_file-oxis26 (deleted)
081b1000-0b000000 rw-s 001b1000 03:05 4921999    /tmp/vm_file-oxis26 (deleted)
b7eb7000-b7eb9000 rw-p b7eb7000 00:00 0
b7eb9000-b7fdb000 r-xp 00000000 03:05 
2371242    /lib/tls/i686/cmov/libc-2.3.2.so
b7fdb000-b7fe4000 rw-p 00121000 03:05 
2371242    /lib/tls/i686/cmov/libc-2.3.2.so
b7fe4000-b7fe6000 rw-p b7fe4000 00:00 0
b7fe6000-b7fe8000 r-xp 00000000 03:05 
2371260    /lib/tls/i686/cmov/libutil-2.3.2.so
b7fe8000-b7fe9000 rw-p 00001000 03:05 
2371260    /lib/tls/i686/cmov/libutil-2.3.2.so
b7fe9000-b7feb000 rw-p b7fe9000 00:00 0
b7feb000-b8000000 r-xp 00000000 03:05 2371080    /lib/ld-2.3.2.so
b8000000-b8001000 rw-p 00015000 03:05 2371080    /lib/ld-2.3.2.so
bffeb000-c0000000 rwxp bffeb000 00:00 0
ffffe000-fffff000 ---p 00000000 00:00 0




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
