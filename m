Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CF21G-0008MX-L0 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 19:59:10 -0700
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CF21C-00012X-4f for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Oct 2004 19:59:10 -0700
Received: from hawk (mothership.theshore.net [69.137.84.52])
	by www.theshore.net (8.12.9/8.9.1) with SMTP id i962x5Wh018817
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 5 Oct 2004 22:59:05 -0400
Message-ID: <000801c4ab51$313dc950$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <000b01c4ab44$9eb05aa0$0201a8c0@hawk>
Subject: Re: [uml-devel] Re: 2.4.27 + 2.4.26-3um - Kernel panic: handle_trap -
	failed to wait at end of syscall, errno = 4, status = 4479
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
Date: Tue, 5 Oct 2004 22:04:26 -0500
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Another tidbit of information...

A user of mind has two UMLs on two different hosts.  Both the UMLs are running Debian unstable.
This kernel on the 2.6.4 host doesn't work, while the other on a 2.6.7+sysemu box does.

-Chris



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
