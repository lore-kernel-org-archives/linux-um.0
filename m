Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BKeZJ-0002b6-3v for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 May 2004 07:37:17 -0700
Received: from www.tuxrocks.com ([64.62.190.123] helo=tuxrocks.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BKeZF-0007Ux-SJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 May 2004 07:37:13 -0700
From: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: [uml-devel] UML kernel panic
In-Reply-To: <005b01c42fc0$a48b37b0$2000000a@schlepptopp>
Message-ID: <Pine.LNX.4.44.0405022056100.9671-100000@tuxrocks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 3 May 2004 08:37:07 -0600 (MDT)
To: roland <for_spam@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, 1 May 2004, roland wrote:

> hi!
> yesterday in installed tomcat on a uml 2.6.4 with suse9 rootfs.
> tomcat needs jre1.4 and jdk1.4 rpm`s.
> all demo jsp`s and demo servlets run fine - so basically java works.
> are there any known uml java issues besides the ones reported by frank ?
> i would like to create an development environment for some programmers, 
> where everybody should have his own machine with his own tomcat - so 
> i`m a little bit unsure, if it is stable enough. 

This is very similar to the environment that I'm working on, which is a
java development environment for students to design and build "Enterprise"  
systems.  Other than this particular bug, I've found UML to be quite
stable.

Any ideas on what's causing UML kernel panics, and thoughts on how to fix
it would be greatly appreciated.  Can the UML kernel panics be caused by
host kernel or system problems, or is it likely a UML kernel problem, or
is there something else?

Thanks,

Frank
---------------------------------------------------------------------------
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
