Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wlk0-0002Ky-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 09:53:20 -0700
Received: from tailtiu.davidcoulson.net ([207.166.203.132] helo=mail.mx.davidcoulson.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19wljz-0004iZ-Po
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 09 Sep 2003 09:53:19 -0700
Message-ID: <3F5E057E.9030209@davidcoulson.net>
From: David Coulson <david@davidcoulson.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] Kernel panic: I/O op mismatch
References: <Pine.LNX.4.44.0309081936590.26334-100000@gradall.private.brainfood.com> <200309091310.h89DAt2J002539@ccure.karaya.com> <20030909164152.GB7799@alcor.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Tue, 09 Sep 2003 12:53:18 -0400
To: Matt Zimmerman <mdz@debian.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

Matt Zimmerman wrote:
> Likewise.  Adam can actually reproduce this with the exact same UML binary
> that I'm using (the one from my user-mode-linux .deb), but I can't reproduce
> it at all.  We're also both using Debian unstable (I think), so most other
> factors should be the same as well.  My host kernel is Debian's 2.4.21 with
> skas3 and device-mapper.


I'm 99% sure it's filesystem, rather than kernel, dependent. I gave Jeff 
a shell on one of my boxes, so we'll see what that turns up




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
