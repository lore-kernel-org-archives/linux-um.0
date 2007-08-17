Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IM2Hv-0004kW-Iz for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Aug 2007 06:54:55 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IM2Hu-00008b-4o
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Aug 2007 06:54:55 -0700
Date: Fri, 17 Aug 2007 09:54:46 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070817135446.GA5725@c2.user-mode-linux.org>
References: <20070815235825.GB17004@redhat.com>
	<1187224811.5906.55.camel@localhost>
	<20070816145210.GD6670@c2.user-mode-linux.org>
	<alpine.LFD.0.999.0708171208060.3666@enigma.security.iitk.ac.in>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0708171208060.3666@enigma.security.iitk.ac.in>
Subject: Re: [uml-devel] [PATCH] hostfs: Remove pointless if statement
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
To: Satyam Sharma <satyam@infradead.org>
Cc: Joe Perches <joe@perches.com>, Linux Kernel <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Fri, Aug 17, 2007 at 12:24:23PM +0530, Satyam Sharma wrote:
> We normally use "comments" for that, not dead code that a compiler
> then elids ;-)

I'd argue that comments are for when you can't make the code
self-explanatory.

> [PATCH] hostfs: Remove pointless if statement
> 
> And replace with comment saying we don't handle ctime.
> Also some codingstyle while I was there.

I'll forward this upstream.

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
