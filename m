Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CE3ol-0007kk-V5 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Oct 2004 03:42:15 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CE3oe-0008HK-9g for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 03 Oct 2004 03:42:15 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] T-mode processes
In-Reply-To: <29246.1096763190@marajade.sandelman.ottawa.on.ca>
Message-ID: <Pine.LNX.4.61.0410031239090.13697@filer.marasystems.com>
References: <29246.1096763190@marajade.sandelman.ottawa.on.ca>
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
Date: Sun, 3 Oct 2004 12:41:37 +0200 (CEST)
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

On Sat, 2 Oct 2004, Michael Richardson wrote:

> So, this tells me that kill-9 can't kill a process which is being
> strace'ed. I really think that this is a bug.

It is the way it should be, even if somewhat confusing. Traced processes 
are special in many ways.


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
