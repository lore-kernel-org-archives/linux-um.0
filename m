Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AMqfF-0000bp-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 20 Nov 2003 07:24:13 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=0)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AMqea-00028Y-94
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 20 Nov 2003 07:23:32 -0800
Subject: Re: [uml-devel] skas3-related crash of the week
References: <877k1w85vh.fsf@amaterasu.srvr.nix>
	<3FBBD9CA.2010303@vgertech.com> <3FBCA6DA.7020407@vgertech.com>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <3FBCA6DA.7020407@vgertech.com> (Nuno Silva's message of "Thu,
 20 Nov 2003 11:34:50 +0000")
Message-ID: <87r8033vyo.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Thu, 20 Nov 2003 15:23:27 +0000
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, 20 Nov 2003, Nuno Silva stated:
> I've found a log with the error, it's a bit different from yours:
> 
> Kernel panic: save_registers - saving registers failed, errno = 3

That's ESRCH, `No such process'. Looks like the user process
died :(

> Kernel panic: switch_mm_skas - PTRACE_SWITCH_MM failed, errno = 3

Manipulating the memory mappings of a process that no longer exists is
kind of hard...

-- 
`Me, I want exploding spaceships and pulverized worlds and clashes of
 billion-year-old empires *and* competently written sentences.'
                                                    --- Matt Austern


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
