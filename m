Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JuUQs-0000Ag-68 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 May 2008 08:22:50 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JuUQj-0006hB-2Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 May 2008 08:22:44 -0700
Date: Fri, 9 May 2008 11:22:17 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080509152217.GF10169@c2.user-mode-linux.org>
References: <200805031518.11029.rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200805031518.11029.rob@landley.net>
Subject: Re: [uml-devel] [PATCH] make quiet suppress parse_chan_pair
	boot	messages
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
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Sat, May 03, 2008 at 03:18:10PM -0500, Rob Landley wrote:
> I usually use UML as a better fakeroot, meaning I run it with a command line
> like "rootfstype=hostfs rw quiet init=/path/to/some_shell_script.sh".  In this
> context, filling the screen with parse_chan_pair error messages which don't
> actually hurt anything defeats the purpose of "quiet".
> 
> The patch turns several KERN_ERR into KERN_WARNING.  While I was there, I
> merged the redundant printk() statements into a function, and added one "else"
> after a test-for-null that did a printk but didn't do a continue.

Looks reasonable.

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
