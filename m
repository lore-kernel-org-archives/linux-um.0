Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPpRR-00020i-N2 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 14:14:33 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPpRQ-00072Q-Vq for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 17 May 2004 14:14:33 -0700
From: Henrik Nordstrom <uml@henrik.marasystems.com>
Subject: Re: [uml-devel] CVS not updated?
In-Reply-To: <029401c43c49$a97fca20$2000000a@schlepptopp>
Message-ID: <Pine.LNX.4.44.0405172232390.25764-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Mon, 17 May 2004 23:14:11 +0200 (CEST)
To: roland <for_spam@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Mon, 17 May 2004, roland wrote:

> when i look at:
> http://www.user-mode-linux.org/cvs/linux/
> there are log entries "updated to 2.4.26".

Was not aware of this one.. I was using the SourceForge CVS tree for some
reason. The www.user-mode-linux.org tree looks MUCH better, in fact in a 
very good shape.

Ah, well. All explained and good ;-)

But there still was something good out of this excercise. We now have all
our local modifications cleanly separated into individual patches and an
alternate build model based on the official patches instead of CVS which
probably is a more suitable build model for our production kernels anyway.  
But the direct CVS model I have been using up to now is extremely handy
when working/patching on uml..

In case someone is interested our UML patch repository can be found at 
http://marasystems.com/download/uml/. 

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
