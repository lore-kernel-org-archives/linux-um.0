Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jy7zE-0005r8-0m for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 May 2008 09:13:20 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jy7z6-00074i-JR
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 May 2008 09:13:19 -0700
Date: Mon, 19 May 2008 12:12:30 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080519161230.GB17500@c2.user-mode-linux.org>
References: <200805031518.11029.rob@landley.net>
	<20080509152217.GF10169@c2.user-mode-linux.org>
	<200805171408.51880.rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200805171408.51880.rob@landley.net>
Subject: Re: [uml-devel] [PATCH] make quiet suppress
	parse_chan_pair	boot?messages
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
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, May 17, 2008 at 02:08:51PM -0500, Rob Landley wrote:
> Do I have to do anything to follow up, or is it queued to go
> upstream? 

It's queued for mainline.

> (I can  
> redo the printk() with pr_warning(), it's just the original didn't and I 
> didn't change it...)

I made the pr_warning change.

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
