Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I5916-0002wa-Pi for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Jul 2007 16:39:44 -0700
Received: from mailout2-7.pacific.net.au ([61.8.2.230]
	helo=mailout2.pacific.net.au)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I5915-00074N-Ar
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 Jul 2007 16:39:44 -0700
Received: from mailproxy2.pacific.net.au (mailproxy2.pacific.net.au
	[61.8.2.163])
	by mailout2.pacific.net.au (Postfix) with ESMTP id 62FB4B000A
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon,  2 Jul 2007 09:39:30 +1000 (EST)
Received: from deepthought.Elpro.local (ppp2609.dsl.pacific.net.au
	[203.143.249.9])
	by mailproxy2.pacific.net.au (Postfix) with ESMTP id 8199027412
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon,  2 Jul 2007 09:39:40 +1000 (EST)
MIME-Version: 1.0
Content-class: urn:content-classes:message
Date: Mon, 2 Jul 2007 09:38:58 +1000
Message-ID: <7EDC24AB1ED682439657D3B7790609D39ABEB3@deepthought.Elpro.local>
In-Reply-To: <4667CA21.80506@nagafix.co.uk>
References: <7EDC24AB1ED682439657D3B7790609D39825E6@deepthought.Elpro.local>
	<4667CA21.80506@nagafix.co.uk>
From: "Andrew Sinclair" <Andrew.Sinclair@elprotech.com>
Subject: [uml-devel] Problems with dynamic linking applications for UML
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Hello everyone,

I am using uClinux. When I statically link the user applications for
UML, everything works fine. I find that if I dynamically link user
applications, my UML halts after mounting the filesystem. 

If I statically link Busybox only, and dynamically the remaining user
applications I receive a "Floating point exception" when I try to run
them from a Busybox shell. 

Dynamic linking application source works ok for our target ARM based
hardware, just not UML. I must be missing a key setting when I build for
UML. Can anyone help?

Kind Regards,

Andrew Sinclair






-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
