Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FUX1C-0007xV-5u for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Apr 2006 15:43:58 -0700
Received: from mail.scgiservices.com ([198.107.3.67])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FUX1B-0003Jb-4H
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Apr 2006 15:43:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.scgiservices.com (Postfix) with ESMTP id A397A3C508
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 14 Apr 2006 15:43:55 -0700 (PDT)
Received: from mail.scgiservices.com ([127.0.0.1])
	by localhost (mail [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 15401-03 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 14 Apr 2006 15:43:54 -0700 (PDT)
Received: from SCG2 (c-67-160-154-69.hsd1.or.comcast.net [67.160.154.69])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.scgiservices.com (Postfix) with ESMTP id BDBE83C4FB
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 14 Apr 2006 15:43:54 -0700 (PDT)
From: "Anthony Brock" <brocka@sterlingcgi.com>
Message-ID: <OJEEKGNKKDLJIEPBEJMIIEPCCAAA.brocka@sterlingcgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] TLS, Debian and 2.6.16.5
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
Date: Fri, 14 Apr 2006 15:43:51 -0700
To: user-mode-linux-devel@lists.sourceforge.net

I'm in the process of setting up a new Debian box that needs a decent source
of entropy. So, I have downloaded and installed a relatively new UML kernel:

www:/usr/share/doc/rng-tools# uname -a
Linux www.myserver.com 2.6.16.5 #1 Fri Apr 14 11:44:51 PDT 2006 i686
GNU/Linux

I then downloaded and installed the rng-tools package. Unfortunately, this
software segments everything I try to use it. However, when I rename
/lib/tls to /lib/tls.disabled the issue disappears. Are the TLS patches for
UML included in this kernel? If not, is there a stable set of patches to add
it?

Tony



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
