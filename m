Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JqX9p-0004ao-Lc for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Apr 2008 10:28:53 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JqX9k-000757-IE
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Apr 2008 10:28:53 -0700
Date: Mon, 28 Apr 2008 13:28:40 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080428172840.GF9628@c2.user-mode-linux.org>
References: <20080415001628.1145.qmail@dev2.reno.12h>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080415001628.1145.qmail@dev2.reno.12h>
Subject: Re: [uml-devel] [PATCH] SKAS4 - Clean up command line disable	output
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
To: Ryan Finnie <ryan@finnie.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Apr 14, 2008 at 05:16:28PM -0700, Ryan Finnie wrote:
> The PTRACE_GETSIGINFO notice was missing a linefeed.  In addition, tab 
> and wrap each SKAS4 "disabled" message in parens so it doesn't break up 
> the indendation within the switch_mm check block.

Looks good, but I'm going to want a Signed-off-by from you on these...

      	    	    Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
