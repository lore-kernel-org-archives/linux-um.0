Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Conqk-0002fY-RZ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 11:08:10 -0800
Received: from pompone.cs.ucsb.edu ([128.111.45.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1Conqe-0004uS-KU
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 11:08:07 -0800
Received: from crow.cs.ucsb.edu ([128.111.45.80])
	by pompone.cs.ucsb.edu with smtp (Exim 3.35 #1 (Debian))
	id 1Conqb-0003Jy-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 12 Jan 2005 11:08:01 -0800
From: Daniel Nurmi <nurmi@pompone.cs.ucsb.edu>
Message-ID: <20050112190802.GE13602@crow.cs.ucsb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] process creep on host FC2, UML 2.4.27
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
Date: Wed, 12 Jan 2005 11:08:02 -0800
To: user-mode-linux-devel@lists.sourceforge.net

Greetings,

We're currently running a course using UML to do some kernel
developement but have run into a confusing snag.  Our host machines
are pretty much stock Fedora (FC2) boxes running kernel
2.6.9-1.6_FC2smp and our UML kernels are 2.4.27 (clean kernel source,
2.4.27uml patch).  

When we start a process under UML, a corresponding kernel thread is
started on the host (which is normal and to be expected) but when the
process under UML exits the corresponding host thread does not exit
(which is not expected).  After a short time, of course, the host is
swamped with thousands of processes, all of which exit cleanly when
the UML is halted or killed.  

I cannot replicate this behaviour on a clean 2.6.7, 2.6.7 SMP, or
2.6.8 SMP kernel (on other systems) and our admin tells us that this
problem did not exist on these same machines running FC1.  

If anyone has any input about a cause or fix to this issue, I would be
greatly appreciative!

Thanks,
-Dan Nurmi


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
