Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEZPT-0004Gl-BV for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Oct 2004 13:26:15 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CEZPR-0007ST-MY for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Oct 2004 13:26:15 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] T-mode processes
In-Reply-To: <200410042057.19226.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.61.0410042223180.483@filer.marasystems.com>
References: <29246.1096763190@marajade.sandelman.ottawa.on.ca>
	<200410031704.29051.blaisorblade_spam@yahoo.it>
	<29485.1096825447@marajade.sandelman.ottawa.on.ca>
	<200410042057.19226.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Mon, 4 Oct 2004 22:25:45 +0200 (CEST)
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Michael Richardson <mcr@sandelman.ottawa.on.ca>

On Mon, 4 Oct 2004, BlaisorBlade wrote:

> Actually, what I should do is to set the "mm->dumpable" flag to 1 inside
> mm/proc_mm.c (after mm_alloc(), it is 0). The situation is clear. However, to
> write a good patch, I want to study well the "mm->dumpable" flag use (when
> it's set, when not...) otherwise I could open a security hole (even because
> there are people using UML setuid to root, for the mlock() patch).

I don't think it is safe to set dumpable to 1 once it has become 0.

If you want to fix this you need to find secure ways to prevent it from 
becoming 0, or to add another parameter defining "security restricted" 
processes differently from dumpable.

Just some thoughts.

Regards
Henrik


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
