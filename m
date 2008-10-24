Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roman.yepishev@gmail.com>) id 1KtVll-0002JS-Cd
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Oct 2008 23:08:37 +0000
Received: from mail-gx0-f17.google.com ([209.85.217.17])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KtVlh-000243-4n for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Oct 2008 23:08:37 +0000
Received: by gxk10 with SMTP id 10so340957gxk.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 24 Oct 2008 16:08:31 -0700 (PDT)
Message-ID: <f39be10d0810241608i590d13f5p429c02558a1c26cf@mail.gmail.com>
Date: Sat, 25 Oct 2008 02:08:31 +0300
From: "Roman Yepishev" <roman.yepishev@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] UML crashes when built with _FORTIFY_SOURCE
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

Hello,

When UML kernel is built with _FORTIFY_SOURCE defined, then all
arguments for snprintf, printf etc. are checked by glibc.

mconsole_init defines file[256] which is used later to construct the
socket path.
file is then passed to os_create_unix_socket which in turn uses
sockaddr_un to describe the socket.
The problem happens when snprintf tries to fit file into sun_path
which is only 108 bytes long. The checks fail and kernel abort()s.

Temporary solution is to fix file declaration to be 108 or less bytes
but checks should be introduced when socket path is constructed.

The complete history of bug is here:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/284631

-- 
Regards,
Roman Yepishev

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
