Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQalF-0001qW-Dl for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 16:46:09 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BQalE-0000Tn-Ui
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 16:46:09 -0700
Message-Id: <200405200032.i4K0W7Dt002066@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Native drivers for UML 
In-Reply-To: Your message of "Tue, 18 May 2004 13:49:40 EDT."
	<Pine.LNX.4.60.0405181335300.4190@stclair.eecs.umich.edu> 
References: <Pine.LNX.4.60.0405181335300.4190@stclair.eecs.umich.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Wed, 19 May 2004 20:32:07 -0400
To: George Washington Dunlap III <dunlapg@umich.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net

dunlapg@umich.edu said:
> I'm looking into doing (host) device driver debugging w/ UML.  I'd
> seen  some references to it in different places, but nothing with any
> solid  leads.  Is anyone still doing this?  Are there any old patches /
>  example  device drivers out there?

There was a VPCI driver by Jon Smirl which allowed UML to drive physical
devices.  However, it's not being maintained, as far as I know.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
