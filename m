Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1a6QCo-00036l-2V
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Dec 2015 21:53:54 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1a6QCn-0007gZ-6u
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Dec 2015 21:53:54 +0000
References: <56645576.3050807@oracle.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <56675169.204@nod.at>
Date: Tue, 8 Dec 2015 22:53:45 +0100
MIME-Version: 1.0
In-Reply-To: <56645576.3050807@oracle.com>
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
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Jeff Dike <jdike@addtoit.com>, stian@nixia.no, user-mode-linux-devel@lists.sourceforge.net

Hi!

Am 06.12.2015 um 16:34 schrieb Vegard Nossum:
> Hi,
> 
> I've been running into some odd crashes when starting my UML instance from Python. This is my script:
> 
> import subprocess
> subprocess.check_call(['path/to/vmlinux', 'mem=2048M', 'rootfstype=hostfs', 'rw', 'init=/bin/bash'])
> 
> This will crash 9 out of 10 times with various strange messages on the console:

Hmm, I cannot reproduce here on my laptop.
Stian, can you?

I wonder what could cause this.
A completely different terminal should not cause a crash.

*confused*,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

