Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BKuj6-0005Mv-Fu for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 May 2004 00:52:28 -0700
Received: from www.tuxrocks.com ([64.62.190.123] helo=tuxrocks.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BKuj6-0001ms-8P
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 May 2004 00:52:28 -0700
Received: from tuxrocks.com (localhost.localdomain [127.0.0.1])
	by tuxrocks.com (8.12.8/8.12.8) with ESMTP id i447qRmA005377
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 4 May 2004 01:52:27 -0600
Received: from localhost (frank@localhost)
	by tuxrocks.com (8.12.8/8.12.8/Submit) with ESMTP id i447qRHd005374
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 4 May 2004 01:52:27 -0600
From: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: [uml-devel] UML kernel panic 
In-Reply-To: <200405040215.i442FAml026592@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.44.0405040032180.3266-100000@tuxrocks.com>
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
Date: Tue, 4 May 2004 01:52:27 -0600 (MDT)
To: user-mode-linux-devel@lists.sourceforge.net

On Mon, 3 May 2004, Jeff Dike wrote:
> frank@tuxrocks.com said:
> > I'm getting a UML kernel panic whenever I run the j2eesdk (Java with
> > EJB - http://java.sun.com/j2ee/1.4/download.html#sdk) installer.  The
> > panic is  "Segfault with no mm". 
> 
> Can you disable CONFIG_GCOV and see if that makes the problem go away?  And
> mentioning that you had enabled it would have been a good idea.
> 
> This is still a bug, but I'd like to make sure that this is the cause.

I've tried it with and without CONFIG_GCOV, and didn't realize it was on 
currently.  Sorry about that.

Here are several gdb backtraces with CONFIG_GCOV off:
http://sco.tuxrocks.com/uml/trace17.txt [200K]
http://sco.tuxrocks.com/uml/trace18.txt [300K]

When I run the j2eesdk installer under strace, it detects an exception, 
and crashes the VM: http://sco.tuxrocks.com/uml/vm-crash1.txt
(it doesn't seem to panic the UML kernel, though)

The strace is (compressed): http://sco.tuxrocks.com/uml/strace1.txt.gz 
[1.9M]

Thanks for the help,

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
