Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpFxA-0002QA-FW for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 17:08:40 -0800
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CpFxA-00037q-2L for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 17:08:40 -0800
Message-ID: <001401c4f9d5$c03c3ce0$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <001901c4f9ca$f72825d0$0201a8c0@hawk>
	<200501140150.08487.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.10-um, /proc/stat is missing information
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
Date: Thu, 13 Jan 2005 19:09:50 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

> Try retesting after applying update-process-times.patch (the one for the crash 
> you were seeing): that patch was not merged by maintainers in mainline, 
> though IIRC it was sent in the right time frame (maybe because they weren't 
> marked as urgent, or because they were a lot of patches, which is also 
> possible).

# cat /proc/stat 
cpu  93 0 0 0 0 4129 0
cpu0 93 0 0 0 0 4129 0
intr 17406 6535 0 90 0 10414 309 0 0 0 0 1 57 0 0
ctxt 20120
btime 1105664741
processes 1564
procs_running 1
procs_blocked 0

Looks like that was the fix.  And I see it went in with 2.6.10-mm1.

Thanks BB,
-Chris


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
