Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JKK6b-0002FO-Fh for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Jan 2008 13:04:25 -0800
Received: from w12a.httpserveur.net ([67.15.80.77]
	helo=websiteout12.httpserveur.net)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1JKK6a-0008JL-17
	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 30 Jan 2008 13:04:25 -0800
Message-ID: <47A0E650.6090705@club-internet.fr>
Date: Wed, 30 Jan 2008 22:04:16 +0100
From: clowncoder <vincent-perrier@club-internet.fr>
MIME-Version: 1.0
Subject: [uml-devel] uml and firefox
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
To: User-mode-linux-devel@lists.sourceforge.net, User-mode-linux-user@lists.sourceforge.net

Hello,
I get a strange behaviour as far as isolation is concerned between an 
uml machine
and the host, my uml machine is isolated from any network,
if firefox is already running in the host, running firefox in the uml 
machine creates
an instance of firefox that is not isolated: the browser can browse the net.
if firefox is not already running in the host, then the firefox in the 
uml reacts normaly,
that is, it cannot get to the network.
What can be the cause of this or did I dream it?
Regards
Vincent Perrier

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
