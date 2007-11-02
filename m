Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1InyoK-0002IW-HS for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Nov 2007 08:51:52 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1InyoH-0003kr-RD
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Nov 2007 08:51:52 -0700
Date: Fri, 2 Nov 2007 11:51:31 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071102155131.GB5760@c2.user-mode-linux.org>
References: <20071102022749.GB8583@swingline.cs.wisc.edu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071102022749.GB8583@swingline.cs.wisc.edu>
Subject: Re: [uml-devel] building 2.6.24-rc1 with VDE in a non-standard
	location?
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
To: Erik Paulson <epaulson@cs.wisc.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Nov 01, 2007 at 09:27:49PM -0500, Erik Paulson wrote:
> I'm trying to build UML with VDE support turned on. However, I don't
> have root on my host machine, so when I installed VDE I put it in a 
> non-standard location. 
> 
> How do you pass extra -L and -I flags to the kernel build process? I
> tried adding
> 
> make linux ARCH=um CFLAGS=-I/path/to/my/vde/include 
> with no go, and I tried adding the include path to
> HOSTCFLAGS in the top level Makefile rules, but that also didn't
> work.

How recent a kernel tree are you playing with?  This patch seems to do
what you want for CFLAGS -
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=52bcc3308ae3344266f55bf98a22c1ac0201eda7

It's been in mainline since 10/15.  I think we'd need to do something
similar for LFLAGS since the rest of the kernel doesn't care so much
about libraries.

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
