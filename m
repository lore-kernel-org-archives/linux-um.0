Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPq7U-0002I8-8z for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 14:58:00 -0700
Received: from pop.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BPq7T-0001Yw-LB for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 14:57:59 -0700
Message-ID: <03cc01c43c5a$ff8891c0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.44.0405172232390.25764-100000@filer.marasystems.com>
Subject: Re: [uml-devel] CVS not updated?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Tue, 18 May 2004 00:04:59 +0200
To: Henrik Nordstrom <uml@henrik.marasystems.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

> Was not aware of this one.. I was using the SourceForge CVS tree for some
> reason. The www.user-mode-linux.org tree looks MUCH better, in fact in a 
> very good shape.
no wonder - if there are 2 trees and none of it is marked obsolete - quite confusing ;)
what about placing a file "OBSOLETE_PLZ_READ.TXT" in the root of that tree ?
that file could contain a link to the "official" CVS/Bitkeeper/Whatelse uml-trees.

> our local modifications cleanly separated into individual patches and an
> alternate build model based on the official patches instead of CVS which
> probably is a more suitable build model for our production kernels anyway. 
yep.

btw:
http://sourceforge.net/tracker/?group_id=429&atid=100429
could probably need some maintenance. i would like to offer cleaning out obsolete 
entries - but i have no access. jeff - is it possible to get access?

regards
roland


----- Original Message ----- 
From: "Henrik Nordstrom" <uml@henrik.marasystems.com>
To: "roland" <for_spam@gmx.de>
Cc: <user-mode-linux-devel@lists.sourceforge.net>; "Jeff Dike" <jdike@addtoit.com>
Sent: Monday, May 17, 2004 11:14 PM
Subject: Re: [uml-devel] CVS not updated?


> On Mon, 17 May 2004, roland wrote:
> 
> > when i look at:
> > http://www.user-mode-linux.org/cvs/linux/
> > there are log entries "updated to 2.4.26".
> 
> Was not aware of this one.. I was using the SourceForge CVS tree for some
> reason. The www.user-mode-linux.org tree looks MUCH better, in fact in a 
> very good shape.
> 
> Ah, well. All explained and good ;-)
> 
> But there still was something good out of this excercise. We now have all
> our local modifications cleanly separated into individual patches and an
> alternate build model based on the official patches instead of CVS which
> probably is a more suitable build model for our production kernels anyway.  
> But the direct CVS model I have been using up to now is extremely handy
> when working/patching on uml..
> 
> In case someone is interested our UML patch repository can be found at 
> http://marasystems.com/download/uml/. 
> 
> Regards
> Henrik
> 


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
