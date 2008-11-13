Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <htmldeveloper@gmail.com>) id 1L0VrJ-00035c-4J
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Nov 2008 06:39:17 +0000
Received: from yx-out-1718.google.com ([74.125.44.158])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L0VrH-0002iV-Gg for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Nov 2008 06:39:17 +0000
Received: by yx-out-1718.google.com with SMTP id 3so324062yxi.82
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 12 Nov 2008 22:39:14 -0800 (PST)
Message-ID: <804dabb00811122239l352dbb5dta63dc3330b92bf5a@mail.gmail.com>
Date: Thu, 13 Nov 2008 14:39:13 +0800
From: "Peter Teoh" <htmldeveloper@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] query on STDERR output from UML tracing
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
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

As I used gdb to trace UML execution, only three lines were output to STDERR:

  - /proc/mm...not found: No such file or directory
  - PTRACE_FAULTINFO...not found
  - PTRACE_LDT...not found

What are these?   How to turn them on?   What is the implication of
not having these features?

-- 
Regards,
Peter Teoh

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
