Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2yvF-0002A7-1B for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Mar 2004 12:42:53 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1B2yvD-00066d-Bk
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Mar 2004 12:42:51 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] /dev/random oddity
Message-ID: <20040315211609.GA24577@ccure.user-mode-linux.org>
References: <20040313014957.GB13419@speedy.schwinge.homeip.net>
	<405309FE.6020603@darkman.de> <405324DB.3030404@lig.net>
	<20040314224008.GY28592@alcor.net>
	<20040315193708.GD23741@ccure.user-mode-linux.org>
	<Pine.LNX.4.58.0403151422320.13832@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403151422320.13832@gradall.private.brainfood.com>
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
Date: Mon, 15 Mar 2004 16:16:09 -0500
To: Adam Heath <adam@sonycom.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Mar 15, 2004 at 02:23:14PM -0600, Adam Heath wrote:
> It doesn't.

Figures.

> It'd be nice if there was a generic device mapper between UML and the host, so
> any device could be proxied, block or char.

Yeah, that would be a good plan.  Too bad about kbuild though.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
