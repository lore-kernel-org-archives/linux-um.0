Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3eI7-0005Yq-OP	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:30:03 -0700
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net
	([216.27.180.168] helo=sunset.davemloft.net ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1E3eI7-0003no-JW
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:30:03 -0700
Message-Id: <20050812.112954.115910063.davem@davemloft.net>
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200508122033.06385.blaisorblade@yahoo.it>
References: <200508122033.06385.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [RFC] [patch 0/39] remap_file_pages protection
	support, try 2
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
Date: Fri, 12 Aug 2005 11:29:54 -0700 (PDT)
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, mingo@elte.hu, linux-kernel@vger.kernel.org, jdike@addtoit.com, bstroesser@fujitsu-siemens.com, user-mode-linux-devel@lists.sourceforge.net


Please do not BOMB linux-kernel with 39 patches in one
go, that will kill the list server.

Try to consolidate your patch groups into smaller pieces,
like so about 10 or 15 at a time.  And send any that remain
on some later date.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
