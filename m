Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CoXxK-0006OR-Jp for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Jan 2005 18:09:54 -0800
Received: from sourceware.org ([12.107.209.250])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CoXxI-0002c2-Lg for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Jan 2005 18:09:54 -0800
Message-ID: <20050112020943.3374.qmail@sourceware.org>
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
Date: 12 Jan 2005 02:09:43 -0000
To: user-mode-linux-devel@lists.sourceforge.net


------- Additional Comments From blaisorblade_spam at yahoo dot it  2005-01-12 02:09 -------
I'll test it against an updated glibc if and when I'll have time, but anyway I 
have no reason to doubt on you.

And sorry a lot... I didn't want to "rumble", just to be complete. Detailed 
excuses follow, feel free to skip them.

1) I feared that fixing it looked too ugly and too controversial (for the 
complexity added to a syscall wrapper, like I said)...

I didn't actually verify that it was on the latest glibc... I tested a 2.3.4 
snapshot (20040808) which is the one I run.

but I cc'ed you a patch for UML talking about it some time ago and got no 
answer.

(I tested it against glibc-2.3.4.20040808 (a glibc snapshot used in Gentoo, 
which is the latest "stable" glibc in Gentoo). And I didn't find any bug report 
about this *here*, so I thought it wasn't fixed).

-- 


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
