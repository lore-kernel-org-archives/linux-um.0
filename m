Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWuh3-00034k-9K
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 01:43:41 -0800
Received: from mx1.elte.hu ([157.181.1.137])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AWuh2-0007b0-Tw
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 01:43:41 -0800
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [uml-devel] [bug] uml segfaults if forcing static link, 2.6.0-test11
In-Reply-To: <200312180146.hBI1k1kS008213@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.58.0312181036220.31295@earth>
References: <Pine.LNX.4.58.0312171735540.8123@earth>
 <20031217174901.GA6709@ccure.user-mode-linux.org> <Pine.LNX.4.58.0312171924290.12482@earth>
  <Pine.LNX.4.58.0312172249020.19508@earth>  <200312180146.hBI1k1kS008213@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Thu, 18 Dec 2003 10:42:38 +0100 (CET)
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net


On Wed, 17 Dec 2003, Jeff Dike wrote:

> > the attached .config produces an UML binary that segfaults much the
> > same way as before the ALIGN fixes. 
> 
> HAHAHA, there is justice in this world :-)
> 
> This one is your fault, I think.

i might be at fault for the FC1 problems :-) [*], but this one doesnt seem
to be my doing:

  $ uname -a
  Linux asia 2.6.0-test11 #1 Wed Dec 17 21:52:45 CET 2003 i686 i686 i386 
  $ ./linux
  Segmentation fault

i tried various other, non-Fedora kernels too, and it segfaults
everywhere.

	Ingo

[*] wrt. FC1, running "i386 ./linux" should solve all problems - no need
    to disable randomization. (this command reverts to the stock VM
    layout.) Alternatively, the UML build process could strip out the
    PT_GNU_STACK ELF section - that triggers the 'stock layout' too.


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
