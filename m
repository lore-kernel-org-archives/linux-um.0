Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ArQ2w-0001un-Lr
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 15:15:02 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1ArQ1Y-0006Sx-KM
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 15:13:36 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] /dev/anon without /dev/anon ?
Message-ID: <20040212234034.GA4320@ccure.user-mode-linux.org>
References: <1076598155.20064.12.camel@wopr.tektonic.net> <01ee01c3f1a9$06424800$0600a8c0@objexcel> <20040212215154.GC4168@ccure.user-mode-linux.org> <024601c3f1b0$41648270$0600a8c0@objexcel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <024601c3f1b0$41648270$0600a8c0@objexcel>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 12 Feb 2004 18:40:34 -0500
To: Peter <support@rimuhosting.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Feb 13, 2004 at 10:28:14AM +1300, Peter wrote:
> Is there anyway I can disable /dev/anon without rebuilding the kernel. rm /dev/anon?

That'll work.  I chmod 600 /dev/anon, but it works out the same.

				Jeff



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
