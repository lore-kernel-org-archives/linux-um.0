Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATS07-0007Sv-VG
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 12:29:03 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1ATS05-0000Bt-Tc
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 12:29:02 -0800
Message-Id: <200312082042.hB8KgiAv029421@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] updating 2.6 to merge 2.4 changes(was: Re: bug in COW? - Re: [uml-user] uml 2.6.0-test9 crash) 
In-Reply-To: Your message of "Sun, 07 Dec 2003 11:53:33 +0100."
             <200312071153.33410.blaisorblade_spam@yahoo.it> 
References: <Pine.LNX.4.44.0312060951220.13277-100000@filer.marasystems.com>  <200312071153.33410.blaisorblade_spam@yahoo.it> 
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
Date: Mon, 08 Dec 2003 15:42:44 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> Do you think using a common code base and insulating the  different
> things inside the 2_5compat.h header(since you created it, I  suppose
> this was the meaning) would be a bad idea?

Yes, it was a very bad idea.  I will accept patches which get rid of 
2_5compat.h :-)

Insulation is nice, but, in reality, what happens is that the insulation
just becomes obfuscation, hiding what the code really is and making it harder
to maintain.

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
