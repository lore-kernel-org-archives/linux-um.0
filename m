Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZHEi-0000mg-Rc for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 15:16:44 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CZHEe-0001t3-4d for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Nov 2004 15:16:44 -0800
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20041130152017.129e134c.akpm@osdl.org>
In-Reply-To: <20041130200845.2C5058BAFE@zion.localdomain>
References: <20041130200845.2C5058BAFE@zion.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [patch 1/2] Uml - first part rework of run_helper()
	and users.
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
Date: Tue, 30 Nov 2004 15:20:17 -0800
To: blaisorblade_spam@yahoo.it
Cc: jdike@addtoit.com, bstroesser@fujitsu-siemens.com, user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it wrote:
>
> Fixed a file descriptor leak in the network driver when changing an IP
> address.
> 
> Fixed the error handling in run_helper.
> 
> 
> Paolo notes:
> 
> Actually, this is part one of the change, the exact one extracted from Jeff
> Dike's incrementals tree before 2.6.9-rc big UML merge.
> 
> There is some changes must be done, so I'm also sending a second patch with
> this one, too. Separated for tracking purposes.
> 
> Don't send this pair of ones to Linus before Jeff ACK's it - just put into -mm for now.

That makes five UML patches which I have queued up pending confirmation:

hostfs-uml-set-sendfile-to-generic_file_sendfile.patch
hostfs-uml-add-some-other-pagecache-methods.patch
uml-terminal-cleanup.patch
uml-first-part-rework-of-run_helper-and-users.patch
uml-finish-fixing-run_helper-failure-path.patch

Could you gents please put heads together and tell me whether and when
these should go upstream?

Thanks.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
