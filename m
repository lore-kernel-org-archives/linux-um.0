Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AN0tB-0007aj-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 20 Nov 2003 18:19:17 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AN0t8-0005it-SU
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 20 Nov 2003 18:19:15 -0800
Message-Id: <200311210228.hAL2Sv4L004167@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] skas3-related crash of the week 
In-Reply-To: Your message of "Thu, 20 Nov 2003 15:23:27 GMT."
             <87r8033vyo.fsf@amaterasu.srvr.nix> 
References: <877k1w85vh.fsf@amaterasu.srvr.nix> <3FBBD9CA.2010303@vgertech.com> <3FBCA6DA.7020407@vgertech.com>  <87r8033vyo.fsf@amaterasu.srvr.nix> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Thu, 20 Nov 2003 21:28:57 -0500
To: Nix <nix@esperi.org.uk>
Cc: Nuno Silva <nuno.silva@vgertech.com>, user-mode-linux-devel@lists.sourceforge.net

nix@esperi.org.uk said:
>  That's ESRCH, `No such process'. Looks like the user process died :( 

That also happens when the child isn't stopped.  There used to be races in
UML where it wouldn't make sure that a child had stopped (by returning from
wait with such an indication) and would start ptracing it.  This resulted
in sporadic -ESRCHs before I figured that out.  There may be some more of
these floating around.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
