Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPXXD-0003yi-L9 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 18:39:35 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CPXXC-0002VO-8G
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 18:39:35 -0800
Message-Id: <200411040451.iA44pJ5G012816@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Thu, 04 Nov 2004 00:17:35 +0100."
	<20041103231735.8C1E955C79@zion.localdomain> 
References: <20041103231735.8C1E955C79@zion.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [patch 09/20] uml: use SIG_IGN for empty sighandler
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
Date: Wed, 03 Nov 2004 23:51:19 -0500
To: blaisorblade_spam@yahoo.it, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org

blaisorblade_spam@yahoo.it said:
> Avoid creating a dummy no-op procedure instead of using SIG_IGN. 

Andrew, can you hold off on this one?  I did that on purpose, and as soon
as I remember why, I'll know whether this patch is good :-)

The other patches are OK by me.  Consider them acked.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
