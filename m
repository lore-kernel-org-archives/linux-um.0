Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <richard.weinberger@gmail.com>) id 1QBXk2-0001wR-Ex
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 17 Apr 2011 19:34:42 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1QBXk1-0003Df-MI
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 17 Apr 2011 19:34:42 +0000
Received: by iye7 with SMTP id 7so4807713iye.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 17 Apr 2011 12:34:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201104171952.19782.walch.martin@web.de>
References: <201104161604.18054.walch.martin@web.de>
	<BANLkTike7MH5NEQ06CZj9ae2b2q4fWehMQ@mail.gmail.com>
	<201104171952.19782.walch.martin@web.de>
Date: Sun, 17 Apr 2011 21:34:36 +0200
Message-ID: <BANLkTiniOGL4_Hu3wt9odTaZWM761ojs8w@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
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
To: Martin Walch <walch.martin@web.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Apr 17, 2011 at 7:52 PM, Martin Walch <walch.martin@web.de> wrote:
>> Can you please test the attached patch?
>> Don't forget to apply http://git.kernel.org/linus/084189a in case you're
>> not using Linus' tree.
>
> Works fine. At least make successfully creates a uml binary and I can create,
> mount and unmount an xfs file system. Creating and deleting a file also works
> fine.

Fine.

> I never intended to actually use an i486 comaptible build. I will be using
> "Opteron/Athlon64/Hammer/K8". However, I wonder if there are any problems
> using i486 besides performance loss. Will this break things?

XFS needs atomic 64 bit operations. To emulate them on 32 bit systems we need
the cmpxchg8b instruction.
Old CPUs don't offer this instruction. So we would have to emulate
cmpxchg8b too.
For now UML does not have a cmpxchg8b emulation because this would be
quite hacky
to realize it in pure user mode.

--
Thanks,
//richard

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

