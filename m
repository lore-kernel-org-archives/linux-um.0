Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRbrl-0000DE-GT for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Nov 2004 11:41:21 -0800
Received: from zcars04e.nortelnetworks.com ([47.129.242.56])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CRbri-0005NJ-I4 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Nov 2004 11:41:21 -0800
Message-ID: <41911D4F.5080606@nortelnetworks.com>
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
References: <200411052036.55541.blaisorblade_spam@yahoo.it>
	<200411091844.44218.blaisorblade_spam@yahoo.it>
	<200411092048.iA9Kmjg9004223@ccure.user-mode-linux.org>
	<200411092015.10544.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411092015.10544.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Synchronization primitives in UML
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
Date: Tue, 09 Nov 2004 13:41:03 -0600
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, cw@f00f.org

Blaisorblade wrote:

> Yes, I would like that, too, but futexes are 2.6 only, and probably also 
> NPTL-only (we are going to fix that, at least for SKAS mode), but faster than 
> anything else. Nothing apart this.

Actually, you can use raw futexes directly without needing any thread library. 
There is even some helper code available if you search around a bit.

Chris


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
