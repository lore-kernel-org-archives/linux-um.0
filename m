Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFZ22-0002gc-Q2 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 10:00:02 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFZ21-0001Et-P0
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 10:00:02 -0800
Date: Thu, 17 Jan 2008 12:59:51 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080117175951.GB4385@c2.user-mode-linux.org>
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
	<20080117132108.GC2693@hacking>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080117132108.GC2693@hacking>
Subject: Re: [uml-devel] [-mm Patch] UML: fix a building error
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
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Jan 17, 2008 at 09:21:08PM +0800, WANG Cong wrote:
> Building uml failed in current -mm tree. ;(
> 
> The below patch fixes this building error:
> ...
> include/asm/arch/system.h:8:22: error: asm/nops.h: No such file or directory
> ...
> 
> Cc: Jeff Dike <jdike@addtoit.com>
> Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

ACK

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
