Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B6DKj-0005wG-Fd for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Mar 2004 10:42:33 -0800
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B6DKh-00069P-Ot for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 24 Mar 2004 10:42:31 -0800
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1B6DKf-0006YR-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 24 Mar 2004 19:42:29 +0100
Received: from pd9ee3ed8.dip.t-dialin.net ([217.238.62.216])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 24 Mar 2004 19:42:29 +0100
Received: from skoehler by pd9ee3ed8.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 24 Mar 2004 19:42:29 +0100
From: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
Message-ID: <c3skqj$st3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] [RFE] con=port
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
Date: Wed, 24 Mar 2004 19:39:09 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

it seem that one has to use con=port:<number> to have UML listening on a 
TCP/IP-port. UML also seems to bind to 0.0.0.0
I'd like UML to bind on 127.0.0.1 only and to bind the socket to a free 
port chosen by the TCP/IP-stack.

i would than do "con=port" and UML would bind each console to another 
TCP/IP-Port. I should than be abled to use mconsole to query which the 
port-number con1-9 are using.

Another point is, that "con1=port:9000" doesn't seem to work with a 
2.6.4-um1 kernel. I was abled to connect with telnet, but no matter 
which key i pressed, i saw nothing. In additon, the mconsole didn't 
work. I could attach mconsole to the UML, but any command blocked and 
never returned to the prompt again.

Another point would be security. Even if UML only binds to 127.0.0.1, 
the port is accessable by any user logged in. But i have no clever idea 
for that.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
