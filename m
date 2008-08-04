Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQ7u1-0007Gh-5w for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Aug 2008 14:47:41 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KQ7tx-00036f-Mo
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Aug 2008 14:47:41 -0700
Date: Mon, 4 Aug 2008 17:47:31 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080804214731.GA18697@c2.user-mode-linux.org>
References: <48970AEC.6020503@meduna.org>
	<20080804203319.GA14732@c2.user-mode-linux.org>
	<48976DB8.3020001@meduna.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48976DB8.3020001@meduna.org>
Subject: Re: [uml-devel] sysconf(_SC_NPROCESSORS_CONF) returning zero
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Stanislav Meduna <stano@meduna.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Aug 04, 2008 at 10:59:36PM +0200, Stanislav Meduna wrote:
> Hmmm... so I have cpu0 similar to yours. What version
> of UML and libc do you have?

UML 2.6.26 and an older libc:

% ls -l /lib/libc.so.6
lrwxrwxrwx 1 root root 11 Jun  2  2007 /lib/libc.so.6 -> libc-2.5.so

Looking through libc at

http://www.google.com/codesearch?hl=en&q=file:\.c%24+\"/stat\"+package:http://su-se.lunar-linux.org/lunar/mirrors/glibc-2.3.3-cvs-20040708.tar.bz2+show:m1O9RV1wlw4:qbkros5194A:MbxD3_8dUHU&sa=N&cd=1&ct=rc&cs_p=http://su-se.lunar-linux.org/lunar/mirrors/glibc-2.3.3-cvs-20040708.tar.bz2&cs_f=glibc-2.3.3-cvs-20040708/sysdeps/unix/sysv/linux/getsysstats.c

I see it counting cpu<n> lines in /proc/stat, which is what I'm
seeing.  It will also look at /proc/cpuinfo.  Can you strace your
version and see if it's looking there at all?

	     	       	  Jeff


-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
