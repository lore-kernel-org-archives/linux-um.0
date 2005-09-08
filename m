Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EDQbX-0006U7-VA	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Sep 2005 10:54:31 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EDQbV-0001gt-La
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Sep 2005 10:54:32 -0700
Subject: Re: [uml-devel] hppfs file descriptor leak?
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <200509052235.49983.blaisorblade@yahoo.it>
References: <1083601512.6946.6.camel@dan>
	 <200509052235.49983.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1126202032.16426.6.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Thu, 08 Sep 2005 18:53:52 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Dan Eaton <Dan.Eaton@rlx.com>

> Antoine, have you a clue why you never hit that? It's there both in 2.4 and 
> 2.6.
That's because I haven't used it lately, I made sure it worked - but did
not push it, I am still struggling to figure out which libraries need to
be included in the chroot - especially with pcap: building as a 32-bit
app on a 64-bit host was kind of difficult.

I am hoping to get more time to play with this in the next few weeks and
I will keep you posted.

Antoine



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
