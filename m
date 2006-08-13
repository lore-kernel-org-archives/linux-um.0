Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GCIOR-0001SD-9z for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Aug 2006 09:00:51 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GCIOP-0000k7-OJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Aug 2006 09:00:51 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 13 Aug 2006 18:00:37 +0200
References: <BAY101-F3556FC13777163E2ABDF69E2490@phx.gbl>
In-Reply-To: <BAY101-F3556FC13777163E2ABDF69E2490@phx.gbl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608131800.37555.blaisorblade@yahoo.it>
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

> It is a maze of calls and I have not been able to use breakpoints with gdb
> much less the module symbols
For module debugging a very recent mail explained the solution in detail.
For break panic, it never worked for me - the suggestion is to add a pause() 
call in a loop checking a variable, and to change the var only in gdb; since 
such a var would be optimized out, add a global function called nowhere which 
sets that var too (on the list a more involved solution was proposed to stop 
the optimization but this should work).

> I set the usual
>
> b sys_init_module
> b panic
>
> and on modprobe I just get
>
> [42949532.180000] Kernel panic - not syncing: Segfault with no mm
> [42949532.180000]  [42949532.180000]
> Program exited with code 01.
> (gdb)

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
