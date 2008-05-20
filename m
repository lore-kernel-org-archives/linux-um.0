Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JyIyc-0003nJ-Fn for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 May 2008 20:57:26 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JyIyb-0003MO-1J
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 May 2008 20:57:26 -0700
Date: Mon, 19 May 2008 23:57:13 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080520035713.GA26295@c2.user-mode-linux.org>
References: <804dabb00805180206wc937036x8e50336967f78ee3@mail.gmail.com>
	<20080518140121.GA5635@c2.user-mode-linux.org>
	<804dabb00805180830s6abedeb1o39b592f235fe5319@mail.gmail.com>
	<20080519160652.GA17500@c2.user-mode-linux.org>
	<804dabb00805191906k1f8081e9u174f198e4cee3862@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <804dabb00805191906k1f8081e9u174f198e4cee3862@mail.gmail.com>
Subject: Re: [uml-devel] ?struct thread_struct? has no member named ?mode?
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Peter Teoh <htmldeveloper@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, May 20, 2008 at 10:06:16AM +0800, Peter Teoh wrote:
> Thank you for your stamina, I almost giving it up...now shall try again:

Are you doing the build on some minority filesystem?  An odd kernel?
Flaky hardware?  The reason I ask is that you have some very odd
things going on, not least this segfault:

>   CC      fs/libfs.o
> make[1]: *** [fs] Segmentation fault (core dumped)
> make: *** [sub-make] Error 2

You also seem to have repeated case of Kbuild expecting a file to
exist before it's been created:

>   CC      arch/um/kernel/skas/syscall.o

arch/um/kernel/skas/built-in.o should have been built in here...

>   LD      arch/um/kernel/built-in.o
> ld: arch/um/kernel/skas/built-in.o: No such file: No such file or
> directory

... but wasn't.

Something is very odd on your host.  It has nothing to do with Kbuild,
UML, or the distro, I think.

     	    	    Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
