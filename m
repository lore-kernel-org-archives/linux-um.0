Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CBar6-0007Ot-5i for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Sep 2004 08:22:28 -0700
Received: from ip-217-18-179-10.reverse.dsi.net ([217.18.179.10]
	helo=sindar.exse.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CBar5-0001oX-AW for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Sep 2004 08:22:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by sindar.exse.net (Postfix) with ESMTP id 13D37231B3
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 26 Sep 2004 17:22:23 +0200 (CEST)
Received: from sindar.exse.net ([127.0.0.1])
	by localhost (sindar [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 25525-39
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 26 Sep 2004 17:22:22 +0200 (CEST)
Received: from [10.0.6.6] (pD9F632E1.dip.t-dialin.net [217.246.50.225])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sindar.exse.net (Postfix) with ESMTP id 03D7223010
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 26 Sep 2004 17:22:21 +0200 (CEST)
Message-ID: <4156FACE.7040201@exse.net>
From: Sebastian <seb@exse.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] problem with uml
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
Date: Sun, 26 Sep 2004 17:22:22 +0000
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

with guest: 2.6.8.1 (latest uml patch + all the incremental patches) I 
got this, during "apt-get install something" :

ReiserFS: ubda: warning: vs-8115: get_num_ver: not directory item
ReiserFS: ubda: warning: vs-8115: get_num_ver: not directory item
ReiserFS: ubda: warning: vs-8115: get_num_ver: not directory item
ReiserFS: ubda: warning: vs-8115: get_num_ver: not directory item
ReiserFS: ubda: warning: vs-8115: get_num_ver: not directory item
ReiserFS: ubda: warning: vs-8115: get_num_ver: not directory item
ReiserFS: ubda: warning: vs-8115: get_num_ver: not directory item
ReiserFS: ubda: warning: vs-8115: get_num_ver: not directory item
Kernel panic: Kernel stack overflow


Should I debug this ? And when yes, how ?

/seb



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
