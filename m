Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AMoP6-0003WA-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 20 Nov 2003 04:59:24 -0800
Received: from mx13.sac.fedex.com ([199.81.197.53])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AMoOW-0008As-8h
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 20 Nov 2003 04:58:48 -0800
Received: from mail-e1000-2.prod.fedex.com (inet04.prod.fedex.com [199.81.10.44])
	by mx13.sac.fedex.com (8.12.6p2/8.12.3) with SMTP id hAKCwZ4T095275
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 20 Nov 2003 06:58:35 -0600 (CST)
	(envelope-from jeff98@silk.corp.fedex.com)
From: Jeff Chua <jeff98@silk.corp.fedex.com>
Subject: Re: [uml-devel] skas3-related crash of the week
In-Reply-To: <3FBCA6DA.7020407@vgertech.com>
Message-ID: <Pine.LNX.4.42.0311202055470.9771-100000@silk.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 20 Nov 2003 20:56:52 +0800 (SGT)
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: Nix <nix@esperi.org.uk>, UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>

try uml-patch-2.4.22-5. I couldn't get 2.4.22-6 to work yet.

Linux is 2.4.23-rc2.


Thanks,
Jeff
[ jchua@fedex.com ]

On Thu, 20 Nov 2003, Nuno Silva wrote:

>
>
> Nuno Silva wrote:
> > Hi!!
> >
> > Nix wrote:
> >
> >> Using unmodified 2.4.22-6. sshed in through the firewall on the UML
> >> instance, with tty logging enabled: typing exit on the last sshed-in
> >> console froze the box yielded this on the console before UML died:
> >>
> >> Kernel panic: switch_mm_skas - PTRACE_SWITCH_MM failed, errno = 9
> >>
> >> Kernel panic: switch_mm_skas - PTRACE_SWITCH_MM failed, errno = 9
> >>
>
> I've found a log with the error, it's a bit different from yours:
>
> Kernel panic: save_registers - saving registers failed, errno = 3
>
> Kernel panic: switch_mm_skas - PTRACE_SWITCH_MM failed, errno = 3
>
> In idle task - not syncing
>
> --------------------------------
>
>  From the screen(1) logs this was a few minutes after the boot and this
> UML should be mostly idle. I only have this log and no backtraces... not
>   very helpfull :(
>
> Regards,
> Nuno Silva
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
