Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <menage@google.com>) id 1MEpYI-00040Y-O7
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Jun 2009 19:03:06 +0000
Received: from smtp-out.google.com ([216.239.45.13])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MEpYE-0005m6-2f
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Jun 2009 19:03:06 +0000
Received: from wpaz21.hot.corp.google.com (wpaz21.hot.corp.google.com
	[172.24.198.85]) by smtp-out.google.com with ESMTP id n5BJ2wul023899
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 11 Jun 2009 12:02:58 -0700
Received: from pxi9 (pxi9.prod.google.com [10.243.27.9])
	by wpaz21.hot.corp.google.com with ESMTP id n5BJ2uHP032153
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 11 Jun 2009 12:02:57 -0700
Received: by pxi9 with SMTP id 9so216587pxi.27
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 11 Jun 2009 12:02:56 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 11 Jun 2009 12:02:56 -0700
Message-ID: <6599ad830906111202u78bcf043nd0e6a54e7251d8d7@mail.gmail.com>
From: Paul Menage <menage@google.com>
Subject: [uml-devel] Building/runing UML in SMP mode
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
Cc: Benjamin Blum <bblum@google.com>

For a while now (since tt mode was dropped and skas mode became the
only option?)  it looks as though UML has been UP-only on x86-64. And
even though the configs appear to allow building SMP on x86-32, there
are things like the panic() call in kernel/smp.c:idle_thread() which
imply that it won't work too well in 32-bit mode either.

For testing cgroups/cpusets changes we'd find it useful to be able to
run UML in SMP mode. Is anyone working on this, or can point us at a
list of the major things that need to be done to make SMP UML
practical?

Thanks,

Paul

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

