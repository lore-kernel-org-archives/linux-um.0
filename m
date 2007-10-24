Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Iki4T-0005MH-FB for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Oct 2007 08:23:01 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Iki4S-0006jR-Fi
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Oct 2007 08:23:01 -0700
Date: Wed, 24 Oct 2007 11:22:40 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071024152240.GA7733@c2.user-mode-linux.org>
References: <200710111754.46854.rob@landley.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200710111754.46854.rob@landley.net>
Subject: Re: [uml-devel] User Mode Linux still doesn't build in 2.6.23-final.
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
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Oct 11, 2007 at 05:54:46PM -0500, Rob Landley wrote:
> Guess what?  I still need this patch to build the final 2.6.23, months later.
> 
> I know it may not be the right fix, but the build breaks for me without this 
> patch. The .config that breaks is attached.  ARCH=um.

Can I get a Signed-off-by: on that?

It's not the right fix - the base of the problem is in swap.h, which
has this comment: 
	/* only sparc can not include linux/pagemap.h in this file
	 * so leave page_cache_release and release_pages undeclared... */

I poked around a bit for a sparc cross-toolchain, didn't find one, so
I couldn't see what exactly the problem was.

So, I'll take this fix.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
