Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1Wrt8i-0005H8-Pm
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jun 2014 18:08:48 +0000
Received: from mout.gmx.net ([212.227.15.18])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wrt8h-0006qS-Al
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Jun 2014 18:08:48 +0000
Message-ID: <538E0F27.908@gmx.de>
Date: Tue, 03 Jun 2014 20:08:39 +0200
From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
MIME-Version: 1.0
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
Subject: [uml-devel] /sys/fs/cgroup/openrc/???/tasks sometimes missing
To: cgroups@vger.kernel.org
Cc: gentoo-dev@lists.gentoo.org, UML devel <user-mode-linux-devel@lists.sourceforge.net>

If I boot a 32 bit stable Gentoo Linux as a user mode linux guest with current kernels (host is a 32 bit stable Gentoo too), then I do observe sometimes during the boot process error messages from the init system of Gentoo (OpenRC) like the following (for subsystem rngd in this example) :

 * Starting haveged ...                                                                                               [ ok ]
/lib/rc/sh/rc-cgroup.sh: line 87: /sys/fs/cgroup/openrc/rngd/tasks: No such file or directory
 * Starting rngd ...                                                                                                  [ ok ]

And indeed, that directory is missing. A restart of the appropriate service however creates those entries. The Gentoo bug entry https://bugs.gentoo.org/show_bug.cgi?id=489386 tells me :

"It's known race in cgroups, I'm going to address this issue on one of the following weekends. The problem is that issue is not reproducible on my systems."

but  that's all since 5 months. Now I'm wondering if this just happens for an UML guest and who knows how to fix it ?

-- 
Toralf


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their 
applications. Written by three acclaimed leaders in the field, 
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

