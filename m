Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JPLdl-0001SW-R1 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Feb 2008 09:43:26 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JPLdk-0005C5-AB
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Feb 2008 09:43:25 -0800
Date: Wed, 13 Feb 2008 12:43:18 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080213174318.GB12071@c2.user-mode-linux.org>
References: <47AF5930.5080907@gmail.com>
	<20080211231812.GC10369@c2.user-mode-linux.org>
	<47B20F0F.3050401@gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47B20F0F.3050401@gmail.com>
Subject: Re: [uml-devel] compile problem
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
To: Jiri Olsa <olsajiri@gmail.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Feb 12, 2008 at 10:26:39PM +0100, Jiri Olsa wrote:
> <asm/types.h> declares u32 only if there's __KERNEL__ defined, which is not case
> of UML compile.

And anything else that uses ptrace.

> Now when I know why my Linus' tree wont compile, I'd like to know why yours does :)

Because you have this header installed as your system ptrace-abi...

> (I used your patch regarding the foo function errors as well...)
> Maybe I have smth wrong with my headers, I use following symlinks:
> 
> /usr/include/linux -> $(kernel)/include/linux
> /usr/include/asm -> $(kernel)/include/asm-x86

This is the one - you're not supposed to do that any more.  No distro
has done this in probably 10 years.  You're supposed to use the
sanitized libc headers that come with your distro.

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
