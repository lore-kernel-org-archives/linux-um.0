Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EDNn9-0007tA-1x	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Sep 2005 07:54:19 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EDNn4-00022b-EY
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Sep 2005 07:54:19 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] hppfs file descriptor leak?
References: <1083601512.6946.6.camel@dan>
In-Reply-To: <1083601512.6946.6.camel@dan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509052235.49983.blaisorblade@yahoo.it>
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
Date: Mon, 5 Sep 2005 22:35:49 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Antoine Martin <antoine@nagafix.co.uk>
Cc: Dan Eaton <Dan.Eaton@rlx.com>

On Monday 03 May 2004 18:25, Dan Eaton wrote:
> I am attempting to track down an issue that I am seeing but I thought
> that I would ask if you have anyone has seen this or has any insight
> into the behavior in parallel to my troubleshooting.  I am using
> hppfs to spoof some /proc entries in the UML.  When I mount /proc
> with hppfs, however, the system only runs for a short while before
> the UML kernel process runs out of file descriptors (1024).  It seems
> that each access to /proc entries that I am spoofing from the host
> results in an open file that never gets closed.  I am looking at it
> via gdb but any insight that anyone has would be greatly appreciated.
Don't know if this is relevant for you any more (I guess not), but I think I 
found it, while working on other stuff.

There's almost no call to close() in hppfs code, and everything matches with 
your description. Every time a file is opened in hostfs, an host fd is 
allocated where appropriate (for each distinct call to open() in userspace, 
even if more calls refer to the same file), and it's leaked.

Antoine, have you a clue why you never hit that? It's there both in 2.4 and 
2.6.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
