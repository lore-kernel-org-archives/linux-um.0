Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1qYN-0004FD-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 23 Sep 2003 10:02:19 -0700
Received: from web80606.mail.yahoo.com ([66.218.79.95])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A1qYM-00053T-Cd
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 23 Sep 2003 10:02:18 -0700
Message-ID: <20030923170127.8475.qmail@web80606.mail.yahoo.com>
From: james donald <svc5354@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] highmem support
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 23 Sep 2003 10:01:27 -0700 (PDT)
To: user-mode-linux-devel@lists.sourceforge.net

highmem support is current broken. although i am able
to compile with highmem support with
uml-patch-2.4.20-6 but i am getting kernel panic when
running with mem=2048M

any idea which was the last version with working
highmem support?

-james

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
