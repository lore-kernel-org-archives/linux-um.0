Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ieutx-00052C-Bv for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Oct 2007 08:52:13 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ieutw-0008Vz-OM
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Oct 2007 08:52:13 -0700
Date: Mon, 8 Oct 2007 11:52:07 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071008155207.GF5279@c2.user-mode-linux.org>
References: <001b01c80530$e56faf10$671e3d80@linux>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <001b01c80530$e56faf10$671e3d80@linux>
Subject: Re: [uml-devel] ask for advise
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
To: Min Yang <yangmin@cc.gatech.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Oct 02, 2007 at 04:14:53PM -0400, Min Yang wrote:
>     Does anyone know any reference on how to have data sharing among
> a host process and multiple guest UML instances? 

hostfs, nfs, ocfs, readonly ubd devices?

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
