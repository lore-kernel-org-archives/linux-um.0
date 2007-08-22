Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1INtD6-0005I6-HT for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Aug 2007 09:37:36 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1INtD5-0007nh-0l
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Aug 2007 09:37:36 -0700
Date: Wed, 22 Aug 2007 12:37:29 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070822163729.GB11022@c2.user-mode-linux.org>
References: <20070816162428.GA8128@c2.user-mode-linux.org>
	<20070816200455.GA14424@uranus.ravnborg.org>
	<20070816210508.GA10559@c2.user-mode-linux.org>
	<200708211905.59128.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200708211905.59128.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] UML - Add a .note.SuSE section
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Tue, Aug 21, 2007 at 07:05:53PM +0200, Blaisorblade wrote:
> It's not the first time we hit effects of such bugs, is it? 

I don't remember seeing this before.

> The .note.ABI-tag fix, time ago, may be about the same problem. 

Are you referring to
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=c35e584c087381aaa5f1ed40a28b978535c18fb2;hp=a5bd1786fb30abe663b904f6d79bba413e9ba883?
If so, I never understood that - it just came in saying "this fixes
static building", so I sent it along.  BTW, that commit was singled
out by git-bisect as "causing" this particular problem.

> Can you
> double-check all UML linker scripts for more instances of this bug?

I did, I have a patch, and it's been verified to fix the problem.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
