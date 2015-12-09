Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stian@nixia.no>) id 1a6aqZ-0004fR-S0
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Dec 2015 09:15:39 +0000
Received: from [195.159.66.51] (helo=ramslauken.nlc.no)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a6aqY-0002ca-BV for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Dec 2015 09:15:39 +0000
Received: from mail.nlc.no (ramslauken.nlc.no [195.159.66.51])
	(Authenticated sender: stian@nixia.no)
	by ramslauken.nlc.no (Postfix) with ESMTPA id 7A8CE1D3385
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed,  9 Dec 2015 10:08:11 +0100 (CET)
MIME-Version: 1.0
Date: Wed, 09 Dec 2015 10:08:11 +0100
From: stian@nixia.no
In-Reply-To: <56645576.3050807@oracle.com>
References: <56645576.3050807@oracle.com>
Message-ID: <728d530df51b5c058f69312bbcac2018@nixia.no>
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
Subject: Re: [uml-devel] uml instance crashes when started from script
To: user-mode-linux-devel@lists.sourceforge.net

Den 2015-12-06 16:34, skrev Vegard Nossum:
> Hi,
>
> I've been running into some odd crashes when starting my UML instance
> from Python. This is my script:
>
> import subprocess
> subprocess.check_call(['path/to/vmlinux', 'mem=2048M',
> 'rootfstype=hostfs', 'rw', 'init=/bin/bash'])

Can you please share your kernel config file?

Stian

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

