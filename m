Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CQ9yP-0001P4-Bd for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Nov 2004 11:42:13 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CQ9yO-0003KE-B8 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Nov 2004 11:42:13 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] __wrap_malloc compile error without CONFIG_MODE_TT
References: <418AEC78.2010502@rimuhosting.com>
In-Reply-To: <418AEC78.2010502@rimuhosting.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411052042.22095.blaisorblade_spam@yahoo.it>
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
Date: Fri, 5 Nov 2004 20:42:21 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Peter <peter.repliesignored@rimuhosting.com>

On Friday 05 November 2004 03:59, Peter wrote:
> Hi.  I just compiled 2.6.9 + uml-2.6.9-bb1.patch.bz2 and got a compile
> error with CONFIG_MODE_TT turned off.  Posting here in case it is of
> interest to anyone.
This is the one you can fix with a make clean (yes, already seen with other 
versions, and I checked the error messages).

And no, UML does not pick up config option changes well - if you change them 
and don't do a make clean, you get to keep both pieces. Or better, some files 
are not recompiled - for instance, all ones ending in _user.c (in fact, it 
gives an undefined reference from trap_user.c). main.c also falls in this 
category.

Yes, it's a bug, but fixing it is complex, and requires a lot of engineering. 
I'm at work on this, but it will take time to be fixed.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
