Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFeYb-00007Z-CL for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2004 12:35:53 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BFeYa-0002du-P2
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2004 12:35:53 -0700
Message-Id: <200404192015.i3JKFrsP025251@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Thoughts on HUMFS and metadata 
In-Reply-To: Your message of "Mon, 19 Apr 2004 20:42:14 +0200."
	<46FEF20C-9231-11D8-8B4A-000A95CD704C@kungfoocoder.org> 
References: <8D87591F-91D6-11D8-8B4A-000A95CD704C@kungfoocoder.org>
	<200404191858.i3JIwFsP024786@ccure.user-mode-linux.org>
	<46FEF20C-9231-11D8-8B4A-000A95CD704C@kungfoocoder.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Mon, 19 Apr 2004 16:15:52 -0400
To: Paul Wagland <paul@kungfoocoder.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

paul@kungfoocoder.org said:
> Umm, is that actually valid? For example, a normal user cannot read a
> file with "000" permissions, however root can. However, if the
> permissions are stored on the file, then a "000" file cannot even be
> read be root.

Ummm, good point.  That needs fixing, as well as the fact that hard links aren't
supported correctly.

> Surely it also makes sense if it is stored in a database? I am not
> sure  how else this information can be stored otherwise?

Are you talking about extending the normal unix permissions through humfs,
or supporting this stuff on filesystems that have it?

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
