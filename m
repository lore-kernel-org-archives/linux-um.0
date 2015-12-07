Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stian@nixia.no>) id 1a5qGl-00023f-30
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Dec 2015 07:31:35 +0000
Received: from [195.159.66.51] (helo=ramslauken.nlc.no)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a5qGj-0003P0-Kd for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Dec 2015 07:31:35 +0000
Received: from mail.nlc.no (ramslauken.nlc.no [195.159.66.51])
	(Authenticated sender: stian@nixia.no)
	by ramslauken.nlc.no (Postfix) with ESMTPA id 21FDB1D1E23
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon,  7 Dec 2015 08:24:08 +0100 (CET)
MIME-Version: 1.0
Date: Mon, 07 Dec 2015 08:24:08 +0100
From: stian@nixia.no
In-Reply-To: <56645576.3050807@oracle.com>
References: <56645576.3050807@oracle.com>
Message-ID: <be1558525adc02a338df071b9ae9a732@nixia.no>
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
>
> [    1.880000] winch_thread : TIOCSCTTY failed on fd 1 err = 1
>

I suspect subprocess.check_call() uses pipes and not pty/tty when 
creating this process. Same problem probably happens if do you something 
like

cat /dev/null | path/to/vmlinux mem=2048M rootfstype=hostfs rw 
init=/bin/bash 2>&1 >log



Stian

------------------------------------------------------------------------------
Go from Idea to Many App Stores Faster with Intel(R) XDK
Give your users amazing mobile app experiences with Intel(R) XDK.
Use one codebase in this all-in-one HTML5 development environment.
Design, debug & build mobile apps & 2D/3D high-impact games for multiple OSs.
http://pubads.g.doubleclick.net/gampad/clk?id=254741911&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

