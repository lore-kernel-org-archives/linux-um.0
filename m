Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Af61G-00007e-DK for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Jan 2004 15:26:22 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Af61F-0002Jn-Qe
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 Jan 2004 15:26:22 -0800
Message-Id: <200401092346.i09NkdS4003979@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: [kbuild-devel] Needed help for UML kbuild. 
In-Reply-To: Your message of "Thu, 08 Jan 2004 19:07:56 +0100."
	<200401081907.56198.blaisorblade_work@yahoo.it> 
References: <200312242019.23335.blaisorblade_work@yahoo.it>
	<200401072012.05007.blaisorblade_work@yahoo.it>
	<200401080019.i080JOtd008375@ccure.user-mode-linux.org>
	<200401081907.56198.blaisorblade_work@yahoo.it> 
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
Date: Fri, 09 Jan 2004 18:46:39 -0500
To: BlaisorBlade <blaisorblade_work@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_work@yahoo.it said:
> **So: would you merge this patch?** 
> If yes, can I be smart about files
> to just move? (Shipping a list of mv  commands would be ok?) Also, the
> *_user.c (+ the other user-objs) should go under under  os-Linux/
> {drivers, kernel, kernel/tt, kernel/skas} ..., right? 

I'd rather you look at the actual libc dependencies in the _user files and
add interfaces to os that let those dependencies be moved.  Then merge the
remaining code (which should be independent of both libc and kernel) into
the corresponding _kern files.  I want as little as possible under os.

> -the watchdogs (what are they?)

They watch the system and reboot it if it appears to hang.

> -cow (but why tristate? Maybe related to the standalone cow device, that I 
> have not understood).

Yeah, when I get the cow driver working, it makes sense for it to be modular.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
