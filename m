Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IkJlA-0000Zh-1J for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Oct 2007 06:25:28 -0700
Received: from mailout.stusta.mhn.de ([141.84.69.5] helo=mailhub.stusta.mhn.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IkJl7-0000qK-CF
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Oct 2007 06:25:27 -0700
Date: Tue, 23 Oct 2007 15:25:01 +0200
From: Adrian Bunk <bunk@stusta.de>
Message-ID: <20071023132501.GT30533@stusta.de>
References: <20071022065943.GC10864@uranus.ravnborg.org>
	<20071022074823.GJ2998@hacking>
	<20071022113600.GA8181@ftp.linux.org.uk>
	<20071022122504.GL2998@hacking>
	<20071022124322.GB8181@ftp.linux.org.uk>
	<20071022124551.GA7438@elte.hu> <471D2ECC.6090209@goop.org>
	<20071022231927.GA30814@elte.hu> <471D389E.40609@goop.org>
	<20071023084546.GA17007@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071023084546.GA17007@elte.hu>
Subject: Re: [uml-devel] User Mode Linux still doesn't build in	2.6.23-final.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Paolo Giarrusso <p.giarrusso@gmail.com>, linux-kernel@vger.kernel.org, Nix <nix@esperi.org.uk>, Rob Landley <rob@landley.net>, Al Viro <viro@ftp.linux.org.uk>, WANG Cong <xiyou.wangcong@gmail.com>, Sam Ravnborg <sam@ravnborg.org>

On Tue, Oct 23, 2007 at 10:45:46AM +0200, Ingo Molnar wrote:
> 
> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> 
> > >> Should we re-add them for the function pointers in 
> > >> asm-x86/paravirt.h?
> > >
> > > yes, yes, yes. :-) It was a nightmare to sort it out in -rt (and 
> > > still is).
> > 
> > Do you have a patch to do this already?
> 
> yes, attached. Ack?
> 
> 	Ingo
> 
> ---------------------------->
> Subject: [patch] paravirt: mark assembly dependencies as fastcall
> From: Ingo Molnar <mingo@elte.hu>
> 
> the 'fastcall removal' changes to paravirt.c were over-eager: they
> removed fastcall annotations from functions that are (or might be)
> implemented in assembly. So if someone changes the compiler model,
> such as -pg which disables regparm, the kernel breaks in nasty ways.
> 
> so this patch adds back fastcall annotations. This serves as
> documentation for assembly calling-convention dependencies as
> well.
>...

I see a point in annotating all C code called from assembler code with 
either fastcall or asmlinkage, but how will these annotations be 
maintained?

Without anything giving at least a warning these annotations will simply 
bitrot.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
