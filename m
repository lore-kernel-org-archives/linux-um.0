Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JOhun-0003AY-BW for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Feb 2008 15:18:21 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JOhuk-0005Sy-Oc
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Feb 2008 15:18:20 -0800
Date: Mon, 11 Feb 2008 18:18:12 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080211231812.GC10369@c2.user-mode-linux.org>
References: <47AF5930.5080907@gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47AF5930.5080907@gmail.com>
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

On Sun, Feb 10, 2008 at 09:06:08PM +0100, Jiri Olsa wrote:
> Hi,
> 
> I have problem with last Linus' git tree:
> 
> scripts/kconfig/conf -s arch/um/Kconfig
>   SYMLINK arch/um/include/kern_constants.h
>   SYMLINK arch/um/include/sysdep
>   CHK     arch/um/include/uml-config.h
>   UPD     arch/um/include/uml-config.h
>   CC      arch/um/sys-i386/user-offsets.s
> In file included from /usr/include/asm/ptrace.h:5,
>                  from arch/um/sys-i386/user-offsets.c:7:
> /usr/include/asm/ptrace-abi.h:92: error: expected specifier-qualifier-list before 'u32'

This looks like a bug in your headers.  ptrace-abi includes
<asm/types.h>, apparently to get the likes of u32, but they're not
there.

> arch/um/sys-i386/user-offsets.c: In function 'foo':
> arch/um/sys-i386/user-offsets.c:20: error: 'struct sigcontext' has
> no member named 'eip'

This is a bit of a problem.  You installed new headers, which have the
'e' removed from the register names, but I can't just change UML
because that will break compilation on current hosts with existing
headers.

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
