Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyJ7k-0006CT-JX for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 15:16:28 -0800
Received: from zcars04f.nortelnetworks.com ([47.129.242.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AyIcp-00088x-Lw for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 14:44:31 -0800
Message-ID: <404512AF.1070309@nortelnetworks.com>
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
References: <4043B42A.10803@nortelnetworks.com>
	<200403020100.i2210dM9025649@ccure.user-mode-linux.org>
	<4044A368.8050406@nortelnetworks.com>
	<200403022054.i22KslWo003006@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: problems with UML, issues with includes
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
Date: Tue, 02 Mar 2004 18:03:11 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: User-mode-linux-devel <User-mode-linux-devel@lists.sourceforge.net>


Further update on the very strange behaviour I'm seeing.

I instrumented kfree() as mentioned before, and also instrumented 
activate_fd() to test after um_kmalloc() whether the result was already 
in the active_fds list.

I had assumed that I would see it being freed while still on the list, 
then being returned from malloc the next time around, causing a dupe.

However, what I actually saw was


new fd is same address as one already in active_fds
deleting address currently in active_fds


In other words, the um_kmalloc() was returning an address already in the 
active_fds list, *before* an address still in the list had been 
kfree()'d.  The kfree() that I see with an address in the list is the 
one from the out_unlock jump target in activeate_fd().

So somehow um_kmalloc() is returning duplicate addresses without an 
intervening call to kfree().

Any ideas?

Chris




-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
