Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IO3cZ-00060q-LR for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Aug 2007 20:44:35 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IO3cY-0005jp-5r
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Aug 2007 20:44:35 -0700
Date: Wed, 22 Aug 2007 23:44:13 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070823034413.GB17185@c2.user-mode-linux.org>
References: <200708212148.05392.rob@landley.net>
	<200708221626.53510.rob@landley.net>
	<20070822213115.GB14287@c2.user-mode-linux.org>
	<200708222047.01962.rob@landley.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200708222047.01962.rob@landley.net>
Subject: Re: [uml-devel] UML doesn't build in 2.6.23-rc3.
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

On Wed, Aug 22, 2007 at 08:47:01PM -0500, Rob Landley wrote:
> Does that reproduce it for you?

Yup, but it's somewhat non-obvious why.  Anyway, it seems clear that
asm-generic/tlb.h is missing an include.

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
