Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFiTu-0005Qd-MV for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2004 16:47:18 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BFiTu-0004T1-6C
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2004 16:47:18 -0700
Message-Id: <200404200027.i3K0RPsP026094@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Thoughts on HUMFS and metadata 
In-Reply-To: Your message of "Mon, 19 Apr 2004 23:13:55 +0200."
	<779EC3D7-9246-11D8-8B4A-000A95CD704C@wagland.net> 
References: <8D87591F-91D6-11D8-8B4A-000A95CD704C@kungfoocoder.org>
	<200404191858.i3JIwFsP024786@ccure.user-mode-linux.org>
	<46FEF20C-9231-11D8-8B4A-000A95CD704C@kungfoocoder.org>
	<200404192015.i3JKFrsP025251@ccure.user-mode-linux.org>
	<9ACD4310-923B-11D8-8B4A-000A95CD704C@kungfoocoder.org>
	<779EC3D7-9246-11D8-8B4A-000A95CD704C@wagland.net> 
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
Date: Mon, 19 Apr 2004 20:27:24 -0400
To: Paul Wagland <paul@wagland.net>
Cc: Paul Wagland <paul@kungfoocoder.org>, user-mode-linux-devel@lists.sourceforge.net

paul@wagland.net said:
> I am not sure what the file permissions have to do  with hard links?

Nothing, except it's one more thing that needs fixing.

>  ask why aren't hard links  supported correctly? 

See my latest diary entry for the gory details...
	http://user-mode-linux.sourceforge.net/diary.html

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
