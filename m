Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ILKgG-0000Ca-5F for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Aug 2007 08:21:08 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ILKgE-0003Ly-Iw
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 15 Aug 2007 08:21:08 -0700
Date: Wed, 15 Aug 2007 11:20:53 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070815152053.GB6889@c2.user-mode-linux.org>
References: <20070725143227.GO5115@pintsize>
	<20070725160700.GA7607@c2.user-mode-linux.org>
	<200708121254.10137.blaisorblade@yahoo.it>
	<20070812121019.GL23105@pintsize>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070812121019.GL23105@pintsize>
Subject: Re: [uml-devel] [RFC PATCH] vde network backend
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
To: Luca Bigliardi <shammash@artha.org>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Sun, Aug 12, 2007 at 02:10:19PM +0200, Luca Bigliardi wrote:
> Thank you, I'm attaching a new patch with proper changes.

What did you change?  BB was right to comment on my changelog, but I
don't see any examples of if( blah ) { anywhere in the vde code.

Since the main patch is in -mm, if you have changes, send incremental
patches, not updated full patches.

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
