Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Adh81-0007gP-5d for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 18:39:33 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Adh80-0002PX-Ho
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 18:39:32 -0800
Message-Id: <200401060259.i062xAFI023142@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] user-mode linux stop at boot in fedora 
In-Reply-To: Your message of "Fri, 26 Dec 2003 17:51:37 +0100."
	<3FEC6719.907@online.no> 
References: <3FEC6719.907@online.no> 
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
Date: Mon, 05 Jan 2004 21:59:10 -0500
To: Knut J Bjuland <knutjbj@online.no>
Cc: user-mode-linux-devel@lists.sourceforge.net

knutjbj@online.no said:
> I have applyed patch from uml site for Fedora, but the boot process is
>  hanging with just after mounting ext2 image. I have use Debian-3.0r0
> and  redhat 6.2 image from user mode linux site.  My system is a pc
> with  Fedora 1 and lates 2.6 kernel from fedora develomment. Glibc
> 2.3.3-1 

> I'm tracing myself and I can't get out 

See usermodelinux.org for a patch which should fix this.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
