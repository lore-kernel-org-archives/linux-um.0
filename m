Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EoPwl-00082l-P6 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Dec 2005 10:41:19 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EoPwh-0006r7-Hp
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Dec 2005 10:41:19 -0800
Subject: Re: [uml-devel] skas3 (almost) works on amd64?
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <200512191723.19829.blaisorblade@yahoo.it>
References: <200504181134.53390.markc@renta.net>
	<1113844082.11747.33.camel@cobra>
	<1134932639.10491.78.camel@localhost.localdomain>
	<200512191723.19829.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1135017662.15991.136.camel@ant.internal>
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
Date: Mon, 19 Dec 2005 18:41:02 +0000
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

> And you saying "yes it works, I know this".
I can't remember! And I thought only my short term memory was bad... ;)

> SKAS64 support is implemented in the SKAS patch, but IIRC not in the guest 
> kernel - there are just a few things to fix up (for instance 
> using /proc/mm64), but I gave up as I hadn't found a solution to SKAS32-on-64 
> problems, and the changes were boring to do, and impossible to get right 
> without a testing possibility.
I suppose this isn't something I can help with?
That's a shame because I get the impression that skas3 is still much
faster than skas0... no hard figures though.

Antoine



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
