Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B7QH5-0000ff-Sa for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Mar 2004 18:43:47 -0800
Received: from hoth.xs4all.nl ([213.84.241.98] helo=seven.hoth.xs4all.nl)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B7QH4-0002Rh-6R for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Mar 2004 18:43:46 -0800
Message-ID: <33583.192.168.1.9.1080441883.squirrel@hoth.xs4all.nl>
Subject: Re: [uml-devel] Kernel panic on UML linux
From: "Mark Hurenkamp" <Mark.Hurenkamp@xs4all.nl>
In-Reply-To: <Pine.LNX.4.44.0403280159130.24847-100000@filer.marasystems.com>
References: <33123.192.168.1.9.1080435284.squirrel@hoth.xs4all.nl>
	<Pine.LNX.4.44.0403280159130.24847-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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
Date: Sun, 28 Mar 2004 04:44:43 +0200 (CEST)
To: hno@marasystems.com
Cc: Mark.Hurenkamp@xs4all.nl, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

> On Sun, 28 Mar 2004, Mark Hurenkamp wrote:
> This is the same issue I reported a some week ago.. for now disable
> klogd  and things should work..

Many thanks!! Tthat did the trick, both the Suse 9.0 system, and the
Mandrake 8.2 system now work fine with UML.

Mark.





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
