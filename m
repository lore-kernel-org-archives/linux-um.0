Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZZRQ-0007cl-LH for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 13:19:52 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FZZRQ-0007OO-JR for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 13:19:52 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FZZRJ-0006U7-TZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 13:19:49 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [RFC] PATCH 0/4 - Time virtualization
References: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org>
	<200604281554.32665.blaisorblade@yahoo.it>
	<20060428151543.GA7397@ccure.user-mode-linux.org>
In-Reply-To: <20060428151543.GA7397@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604282210.17956.blaisorblade@yahoo.it>
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
Date: Fri, 28 Apr 2006 22:10:17 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, JANAK DESAI <janak@us.ibm.com>

On Friday 28 April 2006 17:15, Jeff Dike wrote:
> On Fri, Apr 28, 2006 at 03:54:31PM +0200, Blaisorblade wrote:
> > Additionally, if this flag ever goes into clone, it mustn't be named
> > CLONE_TIME, but CLONE_NEWTIME (or CLONE_NEWUTS). And given CLONE_NEWNS,
> > it's IMHO ok to have unshare(CLONE_NEWTIME) to mean "unshare time
> > namespace", even if it's incoherent with unshare(CLONE_FS) - the
> > incoherency already exists with CLONE_NEWNS.

> I wonder if they should be CLONE_* at all.

I've wondered about this too. It makes some sense to renforce the relationship 
with clone, but when you read the call to unshare you must do you get 
nonsense. Like the above incoherence.

> Given that we are likely 
> to run out of free CLONE_* bits, unshare will have to reuse bits that
> don't have anything to do with sharing resources (CSIGNAL,
> CLONE_VFORK, etc), and it doesn't seem that nice to have two different
> CLONE_* flags with the same value, different meaning, only one of
> which can actually be used in clone.

> It seems better to use UNSHARE_*, with the current bits that are
> common to unshare and clone being defined the same, i.e.
> 	#define UNSHARE_VM CLONE_VM
I indeed agree with this. With 

cg log -r v2.6.16-rc1:v2.6.16 kernel/fork.c

We can see the people involved in commits for sys_unshare (there's little 
other work in there).
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
