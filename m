Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BKiNp-0003CN-Vf for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 May 2004 11:41:41 -0700
Received: from www.tuxrocks.com ([64.62.190.123] helo=tuxrocks.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BKiNL-0007P6-Nh
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 May 2004 11:41:11 -0700
Received: from tuxrocks.com (localhost.localdomain [127.0.0.1])
	by tuxrocks.com (8.12.8/8.12.8) with ESMTP id i43IfAfI020206
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 3 May 2004 12:41:10 -0600
Received: from localhost (frank@localhost)
	by tuxrocks.com (8.12.8/8.12.8/Submit) with ESMTP id i43IfAmE020203
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 3 May 2004 12:41:10 -0600
From: Frank Sorenson <frank@tuxrocks.com>
Subject: Re: [uml-devel] UML kernel panic
In-Reply-To: <Pine.LNX.4.44.0405031054190.18483-100000@tuxrocks.com>
Message-ID: <Pine.LNX.4.44.0405031139490.18483-100000@tuxrocks.com>
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
Date: Mon, 3 May 2004 12:41:10 -0600 (MDT)
To: user-mode-linux-devel@lists.sourceforge.net

On Mon, 3 May 2004, Frank Sorenson wrote:
<snip>
> The odd thing is that often (not always), the system appears to hang after
> "Launching Java(TM) 2 Runtime Environment...", until I ssh into the UML.  
> When I hit enter after typing the root password, the panic occurs.  The 
> rest of the time, ssh works just fine.

Okay, it's not ssh.  Once the system gets into the odd state (appears to 
hang), the panic occurs when the first process is created (ls, ps, ssh 
forking, etc.).  Prior to this time, though, everything seems okay.

Idling while waiting for me to create a new process:
http://sco.tuxrocks.com/uml/trace14.txt

As soon as a new process is created (well, as soon as the system _tries_ 
to create a new process), it seems to panic:
http://sco.tuxrocks.com/uml/trace13.txt
http://sco.tuxrocks.com/uml/trace15.txt


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
