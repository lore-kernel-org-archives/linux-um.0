Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AVGOJ-0000Lx-Cs
	for User-mode-linux-devel@lists.sourceforge.net; Sat, 13 Dec 2003 12:29:31 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AVGOH-0008IK-He
	for User-mode-linux-devel@lists.sourceforge.net; Sat, 13 Dec 2003 12:29:29 -0800
Message-Id: <200312132044.hBDKi5rL003033@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] linux-2.4.23 
In-Reply-To: Your message of "Fri, 12 Dec 2003 23:11:11 +0100."
             <20031212221111.671FF3BCB7@home.petschge.de> 
References: <200312121917.05059.petschge@gmx.de> <Pine.LNX.4.44.0312122212001.19407-100000@filer.marasystems.com>  <20031212221111.671FF3BCB7@home.petschge.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 13 Dec 2003 15:44:05 -0500
To: "Patrick \"Petschge\" Kilian" <petschge@web.de>
Cc: User-mode-linux-devel@lists.sourceforge.net

petschge@web.de said:
> Does anybody know why there isn't a official uml_patch-2.4.23-uml1?  

I do.

It's because I haven't had any time to put it together.  Just fix the 
ELF_PLAT_INIT thing, and you'll have pretty much what I'd release anyway.

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
