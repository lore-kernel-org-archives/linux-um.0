Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <nicolas.boullis@ecp.fr>) id 1KsexL-0007p3-MB
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Oct 2008 14:45:03 +0000
Received: from jaguar.ecp.fr ([138.195.33.9])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KsexF-0007U9-Ow for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Oct 2008 14:45:03 +0000
Received: from localhost (localhost [127.0.0.1])
	by jaguar.ecp.fr (Postfix) with ESMTP id 6B66968010
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 22 Oct 2008 16:44:55 +0200 (CEST)
Received: from jaguar.ecp.fr ([127.0.0.1])
	by localhost (jaguar [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 24602-08
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 22 Oct 2008 16:44:55 +0200 (CEST)
Received: from [138.195.30.9] (kheops.system.ecp.fr [138.195.30.9])
	by jaguar.ecp.fr (Postfix) with ESMTP id 4BD0A68002
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 22 Oct 2008 16:44:55 +0200 (CEST)
Message-ID: <48FF3C66.20509@ecp.fr>
Date: Wed, 22 Oct 2008 16:44:54 +0200
From: Nicolas Boullis <nicolas.boullis@ecp.fr>
MIME-Version: 1.0
Subject: [uml-devel] I/O Performance
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

Sorry for insisting, but I think it would be nice if things could be
improved before linux 2.6.28.

When COW is not used, the performance is very bad because multiples I/O
are performed when one would be enough. Steve VanDeBogart's "ubd does
multiple io's when one will suffice" patch look clean and solves the
problem.

Performing parallel I/O also much improves the performance (at least
with ubd=sync), but my patch is certainly not clean enough for
inclusion. Jeff, you told me you had such a patch; would you like me tou
give it a try?


Cheers,

Nicolas Boullis

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
