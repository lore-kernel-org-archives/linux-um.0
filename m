Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hlo5M-0008SY-NJ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 May 2007 08:28:12 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hlo5L-0008Va-7Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 May 2007 08:28:12 -0700
Date: Wed, 9 May 2007 11:22:50 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070509152250.GA20515@c2.user-mode-linux.org>
References: <c28964800705090539x40642034u274711deba057a0f@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c28964800705090539x40642034u274711deba057a0f@mail.gmail.com>
Subject: Re: [uml-devel] Slow uml sessions
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Lakshminarasimhan Naveenam <lsimhan05@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, May 09, 2007 at 06:09:19PM +0530, Lakshminarasimhan Naveenam wrote:
> Hi,
>     When I run 2 uml sessions using netkit , kernel version is 2.6.18.5,
> the uml sessions become very slow. On the command prompt I keep getting this
> message:
> BUG: soft lockup detected on CPU#0!

I would recommend a newer UML.  I used to see these on a very regular
basis, but haven't in a long time.  I don't know whether it was the
host or UML since both have been upgraded multiple times.  UML has had
a number of performance improvements since 2.6.18, so this may help,
and will make your life more pleasant even if it didn't have anything
to do with the soft lockups.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
