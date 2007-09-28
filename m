Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbL8C-00053W-Jg for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 12:04:08 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IbL89-0003ZQ-NF
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Sep 2007 12:04:08 -0700
Date: Fri, 28 Sep 2007 15:03:54 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070928190354.GA9000@c2.user-mode-linux.org>
References: <20070928154314.GA7185@c2.user-mode-linux.org>
	<20070928112634.0bef9525.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070928112634.0bef9525.akpm@linux-foundation.org>
Subject: Re: [uml-devel] [PATCH] UML - Fix locking in skb alloction failure fix
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Fri, Sep 28, 2007 at 11:26:34AM -0700, Andrew Morton wrote:
> Doesn't this assume that the arch is only ever uniprocessor, which I
> don't think is true on i386 UML??

It is for now, and when that changes, I haven't decided if and when
interrupts will be received on multiple CPUs.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
