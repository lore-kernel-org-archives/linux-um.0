Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IuLfW-000835-1y for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Nov 2007 21:29:06 -0800
Received: from ro-out-1112.google.com ([72.14.202.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IuLfS-00017O-Mu
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Nov 2007 21:29:05 -0800
Received: by ro-out-1112.google.com with SMTP id o35so2088186rog
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 19 Nov 2007 21:29:01 -0800 (PST)
Date: Tue, 20 Nov 2007 13:26:25 +0800
From: WANG Cong <xiyou.wangcong@gmail.com>
Message-ID: <20071120052625.GF2472@hacking>
References: <20071119190224.GA7723@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071119190224.GA7723@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] Keep UML Kconfig in sync with x86
Reply-To: WANG Cong <xiyou.wangcong@gmail.com>
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
To: Jeff Dike <jdike@addtoit.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Mon, Nov 19, 2007 at 02:02:24PM -0500, Jeff Dike wrote:
>Fix a 2.6.24-rc3 UML build breakage introduced by commit
>1032c0ba9da5c5b53173ad2dcf8b2a2da78f8b17 - it introduces X86_32, with
>many things which UML needs depending on it.
>
>This patch adds definitions of X86_32 and RWSEM_XCHGADD_ALGORITHM to
>the UML/i386 Kconfig.
>
>Signed-off-by: Jeff Dike <jdike@linux.intel.com>

Tested-by: WANG Cong <xiyou.wangcong@gmail.com>

Thanks, Jeff. With this and that patch[1], uml building works fine. ;)

[1] http://lkml.org/lkml/2007/11/15/231


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
