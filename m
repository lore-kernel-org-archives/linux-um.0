Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GCIKQ-00012x-AM for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Aug 2006 08:56:42 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GCIKN-0007bW-B6
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Aug 2006 08:56:42 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 13 Aug 2006 17:56:18 +0200
References: <BAY101-F3556FC13777163E2ABDF69E2490@phx.gbl>
In-Reply-To: <BAY101-F3556FC13777163E2ABDF69E2490@phx.gbl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608131756.18571.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [ link to patch] resurrecting the uml-hcd
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: James McMechan <james_mcmechan@hotmail.com>

On Sunday 13 August 2006 17:41, James McMechan wrote:
> >From: Blaisorblade <blaisorblade@yahoo.it>
> >To: user-mode-linux-devel@lists.sourceforge.net
> >CC: "James McMechan" <james_mcmechan@hotmail.com>,
> >linux-usb-devel@lists.sourceforge.net
> >Subject: Re: [uml-devel] [ link to patch] resurrecting the uml-hcd
> >Date: Sun, 13 Aug 2006 13:24:28 +0200

> No problem, I don't like it either, if the registration functions
> still worked I would have kept using the old ones and defered the
> platform update.

Don't worry, that's clear.

> this is the result of mad typeing to get the silly thing 
> working under 2.6.17
>
> it is not too hard to just delete the !PLATFORM sections but I will
> be needing them in 2.6.12 later so I had left them in
> the struct redefs and function arg changes don't seem to fit well
> into a header abstraction unless you want #RETURNVALUE1
> #ARGLIST1 and simliar oddness.
See the irqreturn_t definition - they suggest similar things indeed for 2.4 
compatibility (they suggest "add 
#if 2.4
#define irqreturn_t void
#define IRQ_HANDLED /**/
#endif
).

> If I understood you correctly my problem would be
> in .h
> #ifdef KERN2_6_17
> #define func old_func
> #else
> #define func new_func
> #endif
> and in .c
> #ifdef PLATFORM
> new_return new_func(new_arg)
> {}
> #else
> old_return old_func(old_arg)
> {}
> #endif
> since the new and old version won't compile due to
> renaming arguments and return values that don't exist
> in the other version I think I would just end up duplicating
> the code in a bigger ifdef.

I don't know the specific issue (i.e. how different are the two routines), my 
proposal was something like

#if LINUX_KERNEL_VERSION < ...
#define pci_init_driver pci_register_driver
#endif

or to have a micro-wrapper just for the changed thing. If the init is too 
different then ok - actually if you write with the #ifdef possibly when you 
merge you can remove it, and even if you keep it I don't think there will be 
too many objections.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
