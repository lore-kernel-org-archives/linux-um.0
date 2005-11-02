Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EXQPr-0002bV-BG for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Nov 2005 13:45:07 -0800
Received: from bay101-f4.bay101.hotmail.com ([64.4.56.14] helo=hotmail.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EXQPo-0005Zp-MH
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Nov 2005 13:45:07 -0800
Message-ID: <BAY101-F4507935C4D38603757606B66E0@phx.gbl>
In-Reply-To: <200510092142.33332.blaisorblade@yahoo.it>
From: "Kai Tan" <mineown@hotmail.com>
Subject: Re: [uml-devel] Uml left showstopper bugs for 2.6.14
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
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
Date: Wed, 02 Nov 2005 21:44:17 +0000
To: blaisorblade@yahoo.it, user-mode-linux-devel@lists.sourceforge.net
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org

I tried the first patch, got the following error:

Kernel panic - not syncing: copy_context_skas0 : failed to wait for 
SIGUSR1/SIGTRAP, pid = 7182, n = 7182, errno = 0, status = 0xb7f

I got the same error even after applying the second patch.

My run command is the following:

linux stderr=1 ubd0=../../root_fs.rh-7.2-full.pristine.20020312

>From: Blaisorblade <blaisorblade@yahoo.it>
>To: user-mode-linux-devel@lists.sourceforge.net
>CC: Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, 
>"Kai Tan" <mineown@hotmail.com>
>Subject: Re: [uml-devel] Uml left showstopper bugs for 2.6.14
>Date: Sun, 9 Oct 2005 21:42:32 +0200
>
>Kai - go to the end, there are patches for your SKAS0 problem.
>
>On Sunday 09 October 2005 21:18, Blaisorblade wrote:
> > Here's a short and updated list of showstoppers for 2.6.14 release, from
> > the UML point of view.
>
> > 2) Someone broke endianness of COW driver macros in a header cleanup. I
> > have fixes.
>Just sent them.
> > 3) SKAS0 is broken on amd64 hosts, when frame pointers are disabled. 
>Jeff
> > has the fix, waiting end of testing.
>
> > 4) SKAS0 is broken with GCC 3.2.3, and potentially other GCC releases -
> > look at arch/um/include/sysdep-i386/stub.h: stub_syscall*() to see how. 
>I
> > have two fixes, choosing the safer one (it's all just simply reusing 
>code
> > from <asm/unistd.h>).
>Jeff, I've attached patches for this. Also found another problematic piece 
>of
>code, in stub-segv (same bad idea).
>
>The patch for that changes a bit more things that strictly needed - 
>complain
>if that's a problem for merging in 2.6.14.
>
>Kai Tan, the order of the patches is:
>
>uml-fix-misassembling-skas0-stub
>uml-fix-misassembling-skas0-stub-segv
>
>Note that the second is a bit less tested, so if both together cause 
>problems,
>try with only the first one.
>
>And remember to add "skas0" to the cmd line, to force UML to run in SKAS0
>mode.
>--
>Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
>Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 
>215621894)
>http://www.user-mode-linux.org/~blaisorblade


><< uml-fix-misassembling-skas0-stub >>


><< uml-fix-misassembling-skas0-stub-segv >>




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
