Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CoXCw-0002TK-S3 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Jan 2005 17:21:58 -0800
Received: from sourceware.org ([12.107.209.250])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CoXCw-0003ye-4a for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Jan 2005 17:21:58 -0800
Message-ID: <20050112012157.18489.qmail@sourceware.org>
From: "blaisorblade_spam at yahoo dot it"
	<sourceware-bugzilla@sources.redhat.com>
In-Reply-To: <20050112011749.651.blaisorblade_spam@yahoo.it>
References: <20050112011749.651.blaisorblade_spam@yahoo.it>
Reply-To: sourceware-bugzilla@sources.redhat.com
Subject: [uml-devel] [Bug nptl/651] The getpid() cache (and TLS) is not
	invalidated after clone() calls
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
Date: 12 Jan 2005 01:21:57 -0000
To: user-mode-linux-devel@lists.sourceforge.net



-- 
           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |user-mode-linux-devel at
                   |                            |lists dot sourceforge dot
                   |                            |net


http://sources.redhat.com/bugzilla/show_bug.cgi?id=651

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
