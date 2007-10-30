Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ImvKQ-0004n3-8d for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Oct 2007 10:56:38 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ImvKO-0006UW-Oi
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Oct 2007 10:56:38 -0700
Date: Tue, 30 Oct 2007 13:56:28 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071030175628.GA9279@c2.user-mode-linux.org>
References: <20071030172849.GA8367@c2.user-mode-linux.org>
	<1193766046.24844.19.camel@localhost>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1193766046.24844.19.camel@localhost>
Subject: Re: [uml-devel] [PATCH 3/4] UML - Implement get_wchan
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
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Oct 30, 2007 at 10:40:46AM -0700, Joe Perches wrote:
> Perhaps instead of unsigned long?
> 
> bool skipped_ip;	//delayed initialization

Ooh, I forgot we had bool.  I'll fix that in a later patch.

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
