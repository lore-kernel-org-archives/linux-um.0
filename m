Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xp6T-0000Mb-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 07:40:53 -0700
Received: from pluto.nixia.no ([195.159.42.3])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19xp6R-0005tF-QY
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Sep 2003 07:40:52 -0700
Message-ID: <26858.193.212.97.12.1063369835.squirrel@pluto.nixia.no>
Subject: Re: [uml-devel] Re: pthreads?
From: stian@nixia.no
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 12 Sep 2003 14:30:35 +0200 (CEST)
To: user-mode-linux-devel@lists.sourceforge.net

> fre 2003-09-12 klockan 11.07 skrev Geert Uytterhoeven:
>
>> GdkRgb is nice for displaying pictures, without having to care about X
server
>> visuals, etc. I.e. I need to write less code.  And I want a few buttons to
>> control the fbdev behavior.
>>
>> BTW, it's libX11 that needs libpthread...
>
> What about running the X11 stuff in a helper and using mmap to map the
framebuffer data in both the UML and the helper process?

I think this might be the way to go, and some socket or pipe for doing
change-mode stuff


Stian




This mail has been scanned for known viruses on an open, Linux-based mailsystem
developed by http://Knowledge-Network.no and http://Nixia.no.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
