Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AwPNq-0007cO-5h for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Feb 2004 09:33:14 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AwP0P-0005X5-7d for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Feb 2004 09:09:01 -0800
From: M A Young <m.a.young@durham.ac.uk>
Subject: Re: [uml-devel] Kernel panic: VFS: Unable to mount root fs
In-Reply-To: <20040226152110.28526.qmail@webmail6.rediffmail.com>
Message-ID: <Pine.LNX.4.58.0402261719520.27308@vega.dur.ac.uk>
References: <20040226152110.28526.qmail@webmail6.rediffmail.com>
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
Date: Thu, 26 Feb 2004 17:23:13 +0000 (GMT)
To: Rahul Deshmukh <deshmukh_rs@rediffmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, 26 Feb 2004, Rahul Deshmukh wrote:

>I am facing the problem of "Kernel panic: VFS: Unable to mount root fs" I
>am not getting what is the solution for the problem.As I have gone
>through mailing as well got solution as to give root=/dev/ubd/0 . But
>that thing is also not working.

root=/dev/ubd/0 is for when you have devfs enabled. One of /dev/ubd0
/dev/ubda or 98:0 should work (assuming you do have a root image called
root_fs).

	Michael Young


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
