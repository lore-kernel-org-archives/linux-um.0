Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BSjf9-0004l6-Oz for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 May 2004 14:40:43 -0700
Received: from smtp.wp.pl ([212.77.101.160])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BSjf9-00089r-4Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 May 2004 14:40:43 -0700
Received: from unknown (HELO [172.16.13.24]) (sikkh@[213.25.96.171])
	(envelope-sender <sikkh@wp.pl>)
	by smtp.wp.pl (wp-smtpd) with RC4-MD5 encrypted SMTP
	for <user-mode-linux-devel@lists.sourceforge.net>;
	25 May 2004 23:40:35 +0200
From: Piotr Neuman <sikkh@wp.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405252344.47585.sikkh@wp.pl>
Subject: [uml-devel] Humfs metadata api tdb backend
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
Date: Tue, 25 May 2004 23:44:47 +0200
To: user-mode-linux-devel@lists.sourceforge.net

One more thing: access mode support makes meta_fs backend incomaptible with 
the vanilla 2.6.26-1 one and Jeff Dike's humfsify.


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
