Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EydND-0007WJ-RU for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 15:02:51 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EydNC-00068z-9n
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 15:02:51 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] 2.6.15-rc1 Badness in handle_page_fault
Message-ID: <20060116235450.GB14064@ccure.user-mode-linux.org>
References: <1137444603.8036.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137444603.8036.2.camel@localhost>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 16 Jan 2006 18:54:50 -0500
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

On Mon, Jan 16, 2006 at 08:50:03PM +0000, Antoine Martin wrote:
> Found these in a guest running 2.6.15-rc1.
> Note sure this is relevant anymore, but here it is anyway:
> 
> [45512066.140000] Badness in handle_page_fault at
> arch/um/kernel/trap_kern.c:101

> [45512066.830000] load_TLS(O_FORCE) in fork_handler returned -2

These are fixed.

		Jeff


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
