Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKosR-0000Vf-HG for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 19:09:59 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CKosP-0000BV-4D
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 19:09:59 -0700
Message-Id: <200410220319.i9M3JSFL007319@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Wed, 20 Oct 2004 19:40:54 PDT."
	<20041021024054.GA17968@taniwha.stupidest.org> 
References: <20041021024054.GA17968@taniwha.stupidest.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [PATCH] UML: INITRAMFS_SOURCE noise/build fix
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
Date: Thu, 21 Oct 2004 23:19:28 -0400
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

cw@f00f.org said:
> Trivial patch (copy & yank) so UML builds don't generate a warning
> from linux/usr/Makefile:gen_cmd_list when CONFIG_INITRAMFS_SOURCE
> isn't defined (maybe the Makefile shouldn't require
> CONFIG_INITRAMFS_SOURCE to be set?). 

Applied, thanks.

I hadn't got around to figuring out what that error was about.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
