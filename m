Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A4NE7-0007tR-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Tue, 30 Sep 2003 09:19:51 -0700
Received: from hannover-internet.com ([217.160.140.99])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A4NE6-000125-Dl
	for User-mode-linux-devel@lists.sourceforge.net; Tue, 30 Sep 2003 09:19:50 -0700
Received: from alex (dsl-082-082-155-071.arcor-ip.net [82.82.155.71])
	(authenticated bits=0)
	by hannover-internet.com (8.12.9/SQL-8.12.9-18/8.12.9/8.12.9) with ESMTP id h8UGLEwh010382
	for <User-mode-linux-devel@lists.sourceforge.net>; Tue, 30 Sep 2003 18:21:14 +0200
Message-ID: <014801c3876e$aa712540$6f01a8c0@alex>
From: "Alexander Newald" <alexander@newald.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Networking without tun/tap?
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 30 Sep 2003 18:19:46 +0200
To: User-mode-linux-devel@lists.sourceforge.net

Hello,

I like to install uml on a server running a 2.4.20 kernel but has no tun/tap
configured in. Module support is disabled. Is their any way to get virtual
networking running without rebooting the mashine? I have root access to the
server.

Thanks,

Alexander Newald



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
