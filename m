Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ez2e3-0005FS-ME for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 18:01:55 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ez2e1-0008Q2-At
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 18:01:55 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060118025354.GA13825@ccure.user-mode-linux.org>
References: <20060117235659.14622.18544.stgit@zion.home.lan>
	<20060118001920.14622.79573.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118001920.14622.79573.stgit@zion.home.lan>
Subject: [uml-devel] Re: [PATCH 1/9] uml: avoid sysfs warning on hot-unplug
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
Date: Tue, 17 Jan 2006 21:53:54 -0500
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Jan 18, 2006 at 01:19:21AM +0100, Paolo 'Blaisorblade' Giarrusso wrote:
> Done by Jeff around January for ubd only, later lost, then restored in his tree
> - however I'm merging it now since there's no reason to leave this here.

The original was dinged by hch for covering over a problem without really
fixing it.

We need to think about this one some more.

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
