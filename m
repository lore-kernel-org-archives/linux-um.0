Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HTDkd-0005in-Bc for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Mar 2007 02:01:59 -0700
Received: from cirse.extra.cea.fr ([132.166.172.102])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HTDkb-0003gC-Lm
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Mar 2007 02:01:59 -0700
Received: from nephilia.intra.cea.fr (nephilia.intra.cea.fr [132.166.88.33])
	by cirse.extra.cea.fr (8.13.8/8.13.4/CEAnet-Internet.7.0) with ESMTP id
	l2J91ibm011537 for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 19 Mar 2007 10:01:44 +0100 (MET)
Received: from muguet.saclay.cea.fr (muguet.saclay.cea.fr [132.166.192.6])
	by nephilia.intra.cea.fr (8.13.8/8.13.8) with ESMTP id l2J91iEo019514
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 19 Mar 2007 10:01:44 +0100 (envelope-from jc.lafoucriere@cea.fr)
Received: from zia.bruyeres.cea.fr (esteban.dam.intra.cea.fr [132.165.76.10])
	by muguet.saclay.cea.fr (8.13.8/8.13.4/CEAnet-internes.7.0) with
	SMTP id l2J91hDF023822
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 19 Mar 2007 10:01:43 +0100 (MET)
Message-ID: <45FE5141.3030007@cea.fr>
Date: Mon, 19 Mar 2007 10:00:49 +0100
From: Jacques-Charles Lafoucriere <jc.lafoucriere@cea.fr>
MIME-Version: 1.0
Subject: [uml-devel] 2.6.18 UML machine on FC6 host
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I am trying to build and run a UML 2.6.18 machine on a FC6 host. 
(2.6.18-1.2798)
I have tried many patches from the list and was not able to be successful
(hang after VFS: Mounted root (ext3 filesystem) readonly.)
Does the host need a special patch to run recent UML kernel or is it 
only an issue in the UML machine ?

JCL

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
