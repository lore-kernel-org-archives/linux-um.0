Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZTQj-0006Pz-Rs for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 06:54:45 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FZTQi-0007I1-Hc
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 06:54:46 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [RFC] PATCH 0/4 - Time virtualization
References: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org>
	<200604281333.41358.blaisorblade@yahoo.it>
	<20060428114823.GA3641@ccure.user-mode-linux.org>
In-Reply-To: <20060428114823.GA3641@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604281554.32665.blaisorblade@yahoo.it>
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
Date: Fri, 28 Apr 2006 15:54:31 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org

On Friday 28 April 2006 13:48, Jeff Dike wrote:
> On Fri, Apr 28, 2006 at 01:33:40PM +0200, Blaisorblade wrote:
> > > So, maybe it belongs in clone as a "backwards" flag similar to
> > > CLONE_NEWNS.

> > I must note that currently every (?) flag allowed for unshare is also
> > allowed for clone, so you need to do that anyway.

> Currently.  We are running out of CLONE_ bits - in mainline, there are
> three left, and two of them are likely to be used by CLONE_TIME and
> CLONE_UTSNAME (or whatever that turns out to be called).

> And why should there be any overlap between clone flags and unshare
> flags?  Isn't
> 	clone(CLONE_TIME);
> the same as
> 	clone();
> 	unshare(CLONE_TIME);
> ?

Now that unshare() exists, you're right, the current situation is just due to 
unshare() being an afterthought; the second form (clone() + unshare()) is 
actually more similar to the classical fork() API conceptually (i.e. you 
don't need a call with thousands of parameters to create a process, you can 
specify everything later).

So we get back to Eric's objection (which I haven't understood but that's my 
problem).

Additionally, if this flag ever goes into clone, it mustn't be named 
CLONE_TIME, but CLONE_NEWTIME (or CLONE_NEWUTS). And given CLONE_NEWNS, it's 
IMHO ok to have unshare(CLONE_NEWTIME) to mean "unshare time namespace", even 
if it's incoherent with unshare(CLONE_FS) - the incoherency already exists 
with CLONE_NEWNS.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
