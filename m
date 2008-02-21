Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JSJVZ-0005Th-Ao for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Feb 2008 14:03:18 -0800
Received: from w12a.httpserveur.net ([67.15.80.77]
	helo=websiteout12.httpserveur.net)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1JSJVV-0006tf-Oi
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Feb 2008 14:03:13 -0800
Message-ID: <47BDF50E.3070404@club-internet.fr>
Date: Thu, 21 Feb 2008 23:02:54 +0100
From: clowncoder <vincent-perrier@club-internet.fr>
MIME-Version: 1.0
References: <47B34BA0.30006@club-internet.fr>
	<20080214003853.GA15952@c2.user-mode-linux.org>
In-Reply-To: <20080214003853.GA15952@c2.user-mode-linux.org>
Subject: [uml-devel] Timeout in the select
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
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Hello,
At http://clownix.net, my new machine has the select timeout
problem, if you download it, the file 
/usr/src/clownix_liv_feb_2008/jeff_tst.c
in the virtual machine has a piece of software not behaving as
it should,  the 1 second timeout of the select is doubled.
Could you tell me if this is specific to my machine or if others
have the same problem.
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
