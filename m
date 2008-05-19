Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jy7te-00056f-Kv for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 May 2008 09:07:35 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jy7tS-0004OG-15
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 May 2008 09:07:27 -0700
Date: Mon, 19 May 2008 12:06:52 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080519160652.GA17500@c2.user-mode-linux.org>
References: <804dabb00805180206wc937036x8e50336967f78ee3@mail.gmail.com>
	<20080518140121.GA5635@c2.user-mode-linux.org>
	<804dabb00805180830s6abedeb1o39b592f235fe5319@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <804dabb00805180830s6abedeb1o39b592f235fe5319@mail.gmail.com>
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

On Sun, May 18, 2008 at 11:30:13PM +0800, Peter Teoh wrote:
> Thank you Jeff.....what distros are u on?   I think my machine(s) may
> have some problem...or possibly the distros itself...
> following your steps EXACTLY (thank you for the elaborate explanation
> :-)) I got the following in my FC5, FC6 and FC7 machines:

These all say the same thing:

> *** You have not yet configured your kernel!
> *** (missing kernel .config file)
> ***
> *** Please run some configurator (e.g. "make oldconfig" or
> *** "make menuconfig" or "make xconfig").
> ***

Given that you're running defconfig, it's bizarre that it's
complaining about a missing .config.  The only thing I can think of
which could cause this is some Kbuild running something and getting a
non-standard tool that you have earlier in your search path than the
standard one.

Since it's complaining about the lack of a .config, try
      cp arch/um/defconfig uml/.config
and try the defconfig again.

> Ok...in conclusion:   I need to install FC9 now.....

This has nothing to do with your distro, since FC5 through FC7 all say
the same thing.  Also, if UML didn't build on all of them, I'd think
someone would have noticed by now.

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
