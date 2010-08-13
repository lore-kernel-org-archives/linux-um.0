Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <j.vimal@gmail.com>) id 1OjoV0-0005tl-3A
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Aug 2010 07:16:18 +0000
Received: from mail-qy0-f182.google.com ([209.85.216.182])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OjoUz-0001vr-7X for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Aug 2010 07:16:18 +0000
Received: by mail-qy0-f182.google.com with SMTP id 32so2951511qyk.13
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 13 Aug 2010 00:16:17 -0700 (PDT)
MIME-Version: 1.0
From: Vimal <j.vimal@gmail.com>
Date: Fri, 13 Aug 2010 00:15:55 -0700
Message-ID: <AANLkTim_1MzoDRGJpV92FRcNx8HcoHzjAqn+fWEX9SAm@mail.gmail.com>
Subject: [uml-devel] UML time dilation
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

Hi,

I wish to make time appear slower to applications running inside UML.
I came across this post:
http://www.mail-archive.com/user-mode-linux-user@lists.sourceforge.net/msg03984.html

But it looks like UML now uses hrtimers (setitimer, getitimer).  I
have configured a tickless kernel.

I tried dilating the time by library interposition and LD_PRELOADing a
module that modifies the following system calls:

- getitimer (gets the stored timer, returns T / dilation)
- setitimer (sets a new timer for T * dilation)
- nanosleep (sleeps for T * dilation)
- gtod: gettimeofday (returns T / dilation)

But some applications still have the correct knowledge of time.
Applications that use gtod still know the "real" time (though I
modified gtod), though "sleep 1" (which uses nanosleep), sleeps for 2
seconds.

Am I doing something wrong?

Thanks,
-- 
Vimal

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

