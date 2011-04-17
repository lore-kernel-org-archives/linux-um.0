Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <walch.martin@web.de>) id 1QBWAZ-0001ND-Nm
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 17 Apr 2011 17:53:59 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QBWAY-0003XQ-8U for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 17 Apr 2011 17:53:59 +0000
From: Martin Walch <walch.martin@web.de>
Date: Sun, 17 Apr 2011 19:52:19 +0200
References: <201104161604.18054.walch.martin@web.de>
	<BANLkTike7MH5NEQ06CZj9ae2b2q4fWehMQ@mail.gmail.com>
In-Reply-To: <BANLkTike7MH5NEQ06CZj9ae2b2q4fWehMQ@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201104171952.19782.walch.martin@web.de>
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
Subject: Re: [uml-devel] Linux Kernel Bug #32812 "ARCH=um,
	SUBARCH=i386: linking failure"
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

> Can you please test the attached patch?
> Don't forget to apply http://git.kernel.org/linus/084189a in case you're
> not using Linus' tree.

Works fine. At least make successfully creates a uml binary and I can create, 
mount and unmount an xfs file system. Creating and deleting a file also works 
fine.

I did not do any intensive testing as I am not going to use it now anyway, as 
hostfs has become the better choice. (Actually, I had already decided against 
xfs before reporting the bug.)

> BTW: Please configure your kernel for a CPU newer than i486,
> Pentium Pro would be a good choice. :-)

I never intended to actually use an i486 comaptible build. I will be using 
"Opteron/Athlon64/Hammer/K8". However, I wonder if there are any problems 
using i486 besides performance loss. Will this break things?

-- 

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

