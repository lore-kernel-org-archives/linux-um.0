Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpUq1-00059A-2f for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Jan 2005 09:02:17 -0800
Received: from pool-151-203-218-166.bos.east.verizon.net ([151.203.218.166]
	helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CpUpz-0002iI-O4
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Jan 2005 09:02:16 -0800
Message-Id: <200501141924.j0EJONnV003234@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Thu, 13 Jan 2005 22:00:56 +0100."
	<20050113210056.465BEBAB5@zion> 
References: <20050113210056.465BEBAB5@zion> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [patch 04/11] uml: refuse to run without skas if no
	tt mode in
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
Date: Fri, 14 Jan 2005 14:24:23 -0500
To: blaisorblade_spam@yahoo.it
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Is it my imagination, or did you put the definition of can_do_skas under 
#ifdef UML_CONFIG_MODE_SKAS and failed to do the same for the call?

				Jeff



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
