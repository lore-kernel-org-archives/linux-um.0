Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AX3xD-0006Dv-Co
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 11:36:59 -0800
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AX3xC-0000xM-N7
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 11:36:58 -0800
Message-ID: <003701c3c59e$ef91a4b0$0200000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.58.0312171735540.8123@earth> <20031217174901.GA6709@ccure.user-mode-linux.org> <Pine.LNX.4.58.0312171924290.12482@earth>  <Pine.LNX.4.58.0312172249020.19508@earth>  <200312180146.hBI1k1kS008213@ccure.user-mode-linux.org> <Pine.LNX.4.58.0312181036220.31295@earth> <Pine.LNX.4.58.0312181122070.32554@earth> <Pine.LNX.4.58.0312181209230.1327@earth> <Pine.LNX.4.58.0312181253460.2378@earth> <Pine.LNX.4.58.0312181514140.7622@earth> <04cc01c3c583$eafe5530$0200000a@schlepptopp> <3FE1F7BC.3080402@darkman.de>
Subject: Re: [uml-devel] [UML patch] fixes for !CONFIG_PROC_MM, 2.6.0
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Thu, 18 Dec 2003 20:41:24 +0100
To: Sven 'Darkman' Michels <sven@darkman.de>, UML devel list <user-mode-linux-devel@lists.sourceforge.net>

hi sven, 
do you use skas or tt mode? 
i use skas - and the kernel works for me.

regards
roland




----- Original Message ----- 
From: "Sven 'Darkman' Michels" <sven@darkman.de>
To: "UML devel list" <user-mode-linux-devel@lists.sourceforge.net>
Sent: Thursday, December 18, 2003 7:53 PM
Subject: Re: [uml-devel] [UML patch] fixes for !CONFIG_PROC_MM, 2.6.0


> roland wrote:
> > hi!
> > i need the following additional patch (see below) to sucessfully compile uml on a suse9 box.
> > another candidate for your patchset, ingo? 
> > (or should we blame gcc 3.1.1 ?)
> 
> did you get the kernel running? I was able to compile on 9.0 but
> the kernel immedially segfaults after mounting /dev (its like
> a deadlock loop where it segfaults endless). I copied the
> sourcetree to another box (8.1) and compiled it there, works.
> Even with newer gcc's etc. the uml runs just fine, only compiled
> on 9.0 doesn't work.
> 
> 
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
> 


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
