Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AY7aB-0003kh-4A
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 09:41:35 -0800
Received: from tektonic.net
	([69.56.241.195] helo=unix.easyadmin ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AY7aA-0004fF-Mz
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 09:41:34 -0800
Subject: Re: [uml-devel] uml-patch-2.4.23-1
From: Matt Ayres <matta@tektonic.net>
In-Reply-To: <20031219212840.GA8203@ccure.user-mode-linux.org>
References: <20031219212840.GA8203@ccure.user-mode-linux.org>
Content-Type: text/plain
Message-Id: <1072028491.7434.19.camel@wopr.tektonic.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Sun, 21 Dec 2003 12:41:32 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Has there been any confirmation that the ubd-mmap bug is indeed fixed in
this release?

On Fri, 2003-12-19 at 16:28, Jeff Dike wrote:
> This patch updates UML to 2.4.23.  The only change required by 2.4.23 was
> the ELF_PLAT_INIT that other people saw and fixed.
> 
> In other changes, there are a couple bug fixes that I would like confirmation
> of -
> 	the COW bitmap overrun bug which caused UML hangs for some people
> 	the ubd-mmap file corruption bug
> 
> So, if you were seeing either, can you try this patch and let me know one
> way or the other if they are gone?
> 
> There were also some compilation fixes, a new export, and host_hz is now
> 64 bits.
> 
> 				Jeff
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
-- 
Matt Ayres <matta@tektonic.net>
TekTonic



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
