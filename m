Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQ85a-0002Xu-FW for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 10:09:14 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BQ85Z-00077E-NF
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 10:09:13 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] 2.4.24-2 UML problems with hostfs ClearCase mounts
Message-ID: <20040518175447.GA29114@ccure.user-mode-linux.org>
References: <Pine.LNX.4.44.0405180141460.28239-100000@filer.marasystems.com>
	<40AA2F06.6020607@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40AA2F06.6020607@nortelnetworks.com>
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
Date: Tue, 18 May 2004 13:54:47 -0400
To: Joe Marzot <gmarzot@nortelnetworks.com>
Cc: Henrik Nordstrom <uml@hno.marasystems.com>, user-mode-linux-devel@lists.sourceforge.net

On Tue, May 18, 2004 at 11:43:02AM -0400, Joe Marzot wrote:
> Thank you so much for the reply - For the most part existing hostfs 
> support has been fine for me (I need the sync behaviour).

Enough people do that I will add a synchronous option which restores the
old behavior.

> I do have loads of cores if anyone is interested since I hacked the 
> panic code to abort() as I was not catching these intermittent crashes 
> very often.

For starters, backtraces would be good.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
