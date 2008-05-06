Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JtUyE-00046P-No for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 May 2008 14:45:10 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JtUyD-0003kS-5p
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 May 2008 14:45:10 -0700
Date: Tue, 6 May 2008 17:44:35 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080506214435.GA12998@c2.user-mode-linux.org>
References: <20080425175613.GA11192@c2.user-mode-linux.org>
	<877iegcx11.fsf@hades.wkstn.nix>
	<20080429202924.GA13602@c2.user-mode-linux.org>
	<20080506134655.4cac1014.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080506134655.4cac1014.akpm@linux-foundation.org>
Subject: Re: [uml-devel] [PATCH 11/19] UML - Track and make up lost ticks
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
Cc: nix@esperi.org.uk, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tue, May 06, 2008 at 01:46:55PM -0700, Andrew Morton wrote:
> This fix was already present in your "[PATCH 4/19] UML - Random driver fixes".

Ah, so that's where it ended up.

> Perhaps we broke bisection?

No doubt.  Drop those two and I'll send fixed ones.

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
