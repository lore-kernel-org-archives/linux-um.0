Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BTzOU-00036v-W3 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 May 2004 01:40:42 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BTzOU-000640-8d for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 May 2004 01:40:42 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] No of ubd
In-Reply-To: <200405282347.43766.leen.meyer@home.nl>
Message-ID: <Pine.LNX.4.44.0405291038140.9729-100000@filer.marasystems.com>
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
Date: Sat, 29 May 2004 10:40:37 +0200 (CEST)
To: Leendert Meyer <leen.meyer@home.nl>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, 28 May 2004, Leendert Meyer wrote:

> I know how to use fdisk. But I need a bit of guidance here. Given *any* 
> partitionsize, what are the appropriate values? Is there a formula for that?

You just need to set some geometry on the disk.. Linux does not care 
what..  The only important matter is that the geometry should add upp to 
the size of your disk (in 512 byte sectors).

> And *before* I can partition the disk, are there even more data to fill in?

Nope.

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
