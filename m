Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FgFeI-0000o5-5S for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 May 2006 23:36:46 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FgFeE-0001tx-Rg
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 May 2006 23:36:46 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [UML] Problems building and running 2.6.17-rc4 on
	x86-64ync-mailbox><next-undeleted><enter-command>set editor=vim
References: <20060514182541.GA4980@gmail.com>
	<20060516191244.GB6337@ccure.user-mode-linux.org>
	<20060517023942.GI9066@gmail.com>
In-Reply-To: <20060517023942.GI9066@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605170836.41009.blaisorblade@yahoo.it>
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
Date: Wed, 17 May 2006 08:36:40 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Alberto Bertogli <albertito@gmail.com>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On Wednesday 17 May 2006 04:39, Alberto Bertogli wrote:
> On Tue, May 16, 2006 at 03:12:44PM -0400, Jeff Dike wrote:
> > On Mon, May 15, 2006 at 12:29:58PM -0300, Alberto Bertogli wrote:
> > > Sure, here it is:
> > > (gdb) disas stub_segv_handler
> >
> > Sorry, I misread the error message and asked for the wrong thing.
> > Your UML is seeing a process segfault during a system call, before the
> > SIGTRAP expected at the end of the system call.  I don't know what's
> > happening there.
> >
> > Can you apply the following patch, which will just give you a register
> > dump of the process, and send me the output?
>
> Here it is. While the patch worked, it was for 2.6.16, and I'm using
> 2.6.17-rc4, I hope that's not a problem.

Guess not - I'll test this patch soon because I have the same problem, however 
are you running a 2.6.16 host?

If so, can you verify whether on a 2.6.15 host kernel the same binary runs 
fine (as is the case for me)?
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	
	
		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
