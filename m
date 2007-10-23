Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IkLP1-0003LP-0z for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Oct 2007 08:10:43 -0700
Received: from emailhub.stusta.mhn.de ([141.84.69.5]
	helo=mailhub.stusta.mhn.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IkLOz-0003bB-26
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Oct 2007 08:10:42 -0700
Date: Tue, 23 Oct 2007 17:11:00 +0200
From: Adrian Bunk <bunk@kernel.org>
Message-ID: <20071023151059.GU30533@stusta.de>
References: <471D2ECC.6090209@goop.org> <20071022231927.GA30814@elte.hu>
	<471D389E.40609@goop.org> <20071023084546.GA17007@elte.hu>
	<p73wste7zy5.fsf@bingen.suse.de> <20071023131009.GA32298@elte.hu>
	<p73sl427wvu.fsf@bingen.suse.de>
	<20071023142006.GA9961@elte.hu> <471E05C0.4010005@goop.org>
	<20071023144710.GA13785@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071023144710.GA13785@elte.hu>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Paolo Giarrusso <p.giarrusso@gmail.com>, linux-kernel@vger.kernel.org, Nix <nix@esperi.org.uk>, Andi Kleen <andi@firstfloor.org>, Rob Landley <rob@landley.net>, Al Viro <viro@ftp.linux.org.uk>, WANG Cong <xiyou.wangcong@gmail.com>, Sam Ravnborg <sam@ravnborg.org>

On Tue, Oct 23, 2007 at 04:47:10PM +0200, Ingo Molnar wrote:
> 
> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> 
> > Ingo Molnar wrote:
> > > * Andi Kleen <andi@firstfloor.org> wrote:
> > >
> > >   
> > >>>> You should rename it then to "asmcall" or something.
> > >>>>         
> > >>> if then that should be a separate renaming patch.
> > >>>       
> > >> Well you're asking for the ugly hacks for out of tree code.  [...]
> > >>     
> > >
> > > nice word-bending there. I'm asking for pre-existing annotations to 
> > > survive. It hurts you _nothing_ and it was a world of pain for us to 
> > > recover those lost annotations. Anyway, if Jeremy does not object to the 
> > > patch
> > 
> > I don't have any objections to the idea of the patch, but I'm still 
> > concerned about the practical aspects of it.  Maintaining these kinds 
> > of annotations is hard/fragile/etc when the compiler doesn't warn when 
> > you get it wrong, and only a very specific use-case will reveal the 
> > problem (and do so in a fairly obscure way).
> 
> it wont be any different from the situation before - we had no such 
> warnings there either. Anyway, this shouldnt really bother you as at the 
> moment it's only used for -rt. The issue is to keep something we had 
> before (but which was stupidly/carelessly removed). If it breaks we'll 
> fix it up.
>...

Until recently (read: before 2.6.20) fastcall had a semantics on i386
that resulted in compile errors if you got it wrong.

> 	Ingo

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
