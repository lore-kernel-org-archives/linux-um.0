Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BEssM-0003cC-GE for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Apr 2004 09:41:06 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BEssL-0004bp-OB for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Apr 2004 09:41:06 -0700
From: Henrik Nordstrom <uml@henrik.marasystems.com>
Subject: Re: [uml-devel] root password for root_fs_slack8.1 image?
In-Reply-To: <59953.192.168.0.23.1082173959.squirrel@hnsg.net>
Message-ID: <Pine.LNX.4.44.0404171838480.22016-100000@filer.marasystems.com>
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
Date: Sat, 17 Apr 2004 18:40:47 +0200 (CEST)
To: "Christopher J. Pace" <cpace@hnsg.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, 16 Apr 2004, Christopher J. Pace wrote:

> Does anyone happen to know the root password for this image?  It isn't
> root, none, slack, or anything else I could think of.  Please send to me
> personally, as I'm not subscribed to this list.  Thanks to all.

A simpler way to change the password than to mess around with loopback 
devices is to boot it with

  rw init=/bin/sh

then change the password to your liking and halt -f to shut down the 
rescue boot.

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
