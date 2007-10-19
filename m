Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Iisjv-0001aG-IB for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Oct 2007 07:22:15 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Iisjt-0002li-Pv
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Oct 2007 07:22:15 -0700
Date: Fri, 19 Oct 2007 10:17:00 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071019141700.GA5512@c2.user-mode-linux.org>
References: <ea9232d10710181350v1330e008w2b2cd436602025c5@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ea9232d10710181350v1330e008w2b2cd436602025c5@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] UML: Gprof needs frame pointers.
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
To: Magotari <magotari@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Oct 18, 2007 at 10:50:05PM +0200, Magotari wrote:
> This is a short Kconfig fix for a problem in User Mode Linux.
> Frame pointers are required for gprof support to work.

Looks good - I'll forward it on.

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
