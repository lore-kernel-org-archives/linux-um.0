Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <richard.weinberger@gmail.com>) id 1QBCOC-0004wr-5X
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 16 Apr 2011 20:46:44 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1QBCOB-0004KC-AN
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 16 Apr 2011 20:46:44 +0000
Received: by iye7 with SMTP id 7so4189331iye.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 16 Apr 2011 13:46:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BANLkTik1dT1zhp4peK=W5e0UC-CB0V1Jdw@mail.gmail.com>
References: <201104161604.18054.walch.martin@web.de>
	<BANLkTik1dT1zhp4peK=W5e0UC-CB0V1Jdw@mail.gmail.com>
Date: Sat, 16 Apr 2011 22:46:36 +0200
Message-ID: <BANLkTimh-AWE4hu3dA+L2kfGwXJ2rME39g@mail.gmail.com>
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

On Sat, Apr 16, 2011 at 5:09 PM, richard -rw- weinberger
<richard.weinberger@gmail.com> wrote:
> Hi Martin,
>
> On Sat, Apr 16, 2011 at 4:04 PM, Martin Walch <walch.martin@web.de> wrote:
>> Hello UML maintainers,
>>
>> I have run into a problem making a uml kernel for SUBARCH=i386 with support
>> for XFS. This looks like a regression. Can you please take a look at
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=32812
>
> The cmpxchg8b_emu issue is already known and fixed.
> See:
> http://git.kernel.org/linus/084189a
>
> For the atomic64_read_386 issue I've attached a patch.
> WARING: It's only compile time tested. :)
>
> Please apply both and retry.

Forget the patch.
We need something better.
I'm working on it.

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

