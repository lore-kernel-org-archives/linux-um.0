Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BmLdf-0004Hd-71 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jul 2004 17:04:15 -0700
Received: from stateless.plumtree.co.nz ([202.89.35.97])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1BmLdb-0008VD-FL for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jul 2004 17:04:11 -0700
From: Nicholas Lee <nj.lee@plumtree.co.nz>
Subject: Re: [uml-devel] [Bug#260111: user-mode-linux: upgrade hangs at "NET4:
	Linux TCP/IP 1.0 for NET4.0"]
Message-ID: <20040719000403.GA23215@stateless>
References: <20040718184513.GP4090@mizar.alcor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040718184513.GP4090@mizar.alcor.net>
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
Date: Mon, 19 Jul 2004 12:04:03 +1200
To: Matt Zimmerman <mdz@debian.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, 260111-forwarded@bugs.debian.org, Brian McGroarty <brian@mcgroarty.net>


Have they tried with 2.4 host kernels?

There are some NTPL issues with UML.

See
http://sourceforge.net/mailarchive/message.php?msg_id=6991583

I know I had a similar problem with 2.6 host. Currently I'm running
debian/sid with 2.4-skas host.

I haven't retried 2.6 host kernel yet, due to unrelated issues. SATA
driver problem, causing my system to lockup. 

Nicholas


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
