Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BUVby-0003xc-5y for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 May 2004 12:04:46 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BUVbx-000237-FE for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 May 2004 12:04:45 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] No of ubd
In-Reply-To: <200405301521.i4UFLja13044@lifewood.com>
Message-ID: <Pine.LNX.4.44.0405302044290.27975-100000@filer.marasystems.com>
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
Date: Sun, 30 May 2004 21:04:15 +0200 (CEST)
To: Raymond Wong <raymond@lifewood.com>
Cc: uml@hno.marasystems.com, leen.meyer@home.nl, user-mode-linux-devel@lists.sourceforge.net

On Sun, 30 May 2004, Raymond Wong wrote:

> I have created 5 1G images and using LVM to consolidate them.  So I just
> want to see if there are ways to increase ubds without changing my
> original configuration.

You still have 3 more ubd devices available, and you can also consider
increasing the size of each ubd, similar to how you substitute one larger 
harddrive in place of a smaller one but without having to swap any 
hardware...

I think you can also safely increase the number of ubd devices to 16
without decreasing the number of supported partitions per device. Per
major there is 8 bits of device information and ubd only uses 4 for the
partition number which according to my numbers should allow for 4 bits of 
device number or 16 devices..  See the top of ubd_kern.c if you want to 
tune this balance.

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
