Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IrcAA-0006hl-0W for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Nov 2007 08:29:26 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IrcA7-0004o2-AO
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Nov 2007 08:29:25 -0800
Date: Mon, 12 Nov 2007 11:29:15 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071112162915.GA6862@c2.user-mode-linux.org>
References: <20071102022749.GB8583@swingline.cs.wisc.edu>
	<20071102155131.GB5760@c2.user-mode-linux.org>
	<20071102162239.GA13481@swingline.cs.wisc.edu>
	<20071105171213.GA7296@c2.user-mode-linux.org>
	<20071111194711.GA16100@swingline.cs.wisc.edu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071111194711.GA16100@swingline.cs.wisc.edu>
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

On Sun, Nov 11, 2007 at 01:47:16PM -0600, Erik Paulson wrote:
> Good news - this doesn't happen with 2.6.24-rc2. defconfig builds with
> a CFLAGS on the commandline

We seem to have cleared up the x86/kbuild breakage for now.

> Unfortunately, VDE still doesn't compile - the CFLAGS aren't being passed 
> along to arch/um/drivers:

Yeah, it's not obvious why - I need to look into this.

> make linux ARCH=um CFLAGS=-I/scratch/epaulson/vde/include LDFLAGS=-L/scratch/epaulson/vde/lib V=1

BTW, I misspelled LDFLAGS - you'll have to use LFLAGS until I fix this.

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
