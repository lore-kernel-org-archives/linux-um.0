Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ErVm2-0003cx-Pm for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Dec 2005 23:31:02 -0800
Received: from courier.cs.helsinki.fi ([128.214.9.1] helo=mail.cs.helsinki.fi)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ErVm1-0007HA-NF
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Dec 2005 23:31:03 -0800
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
Subject: Re: [uml-devel] Re: Ho ho ho.. Linux 2.6.15-rc7
In-Reply-To: <200512272009.40980.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.58.0512280928580.23899@sbz-30.cs.Helsinki.FI>
References: <20051227124500.CA66633495@sc8-sf-spam1.sourceforge.net>
	<1135705691.3719.13.camel@localhost.localdomain>
	<200512272009.40980.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
Date: Wed, 28 Dec 2005 09:30:36 +0200 (EET)
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Antoine Martin <antoine@nagafix.co.uk>, Jeff Dike <jdike@addtoit.com>

On Tue, 27 Dec 2005, Blaisorblade wrote:
> Please test the attached patch, worksForMe now.

Works for me too. Thanks!

On Tue, 27 Dec 2005, Blaisorblade wrote:
> > Are you sure that you are using a raw 2.6.15-rc7?
>
> He has disabled SKAS, which is causing this - however the breakage doesn't 
> seem new into 2.6.15-rc7.

It used to compile somewhere around 2.6.15-rc5 or so, I think.

			Pekka


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
