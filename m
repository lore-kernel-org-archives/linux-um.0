Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdJN5-0002GM-I9 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Nov 2005 19:26:35 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EdJN4-0001FF-28
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Nov 2005 19:26:35 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: merge status
References: <20051109133558.513facef.akpm@osdl.org>
	<200511180241.33265.rob@landley.net>
	<200511190333.36876.blaisorblade@yahoo.it>
In-Reply-To: <200511190333.36876.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511182126.22095.rob@landley.net>
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
Date: Fri, 18 Nov 2005 21:26:21 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Friday 18 November 2005 20:33, Blaisorblade wrote:
> > When absolutely necessary, yes.  In theory Jeff's tree works for Jeff so
> > i'm trying to get it to work for me _without_ fixing it myself.  (Instead
> > I bug _him_. :)  But I'm on a wildly different distro (ubuntu on x86 and
> > PLD on x86-64) and things like maszur's headers or the /lib64 thing I
> > haven't got much choice to patch myself.
>
> Btw, why hasn't maszur went to post patches to kernel headers to make them
> includable from userspace instead of merging kernel changes into his
> headers (which is much more work)?

For the same reason the glibc guys don't ship a patch against the kernel 
headers but ship cleaned upkernel headers.  It's much smaller and simpler, 
and the patch would break with every single release.  Besides, the patch 
isn't what we need to build libc, the cleaned up headers are.  It would add 
an unnecessary level of indirection and _never_ get merged into the main 
kernel?

Did I say never?  Yes, I did.  I take it you missed the periodic flamewars on 
this issue?  The kernel guys _actively_ don't care about userspace headers:
http://seclists.org/lists/linux-kernel/2003/Aug/5229.html

You read that right: stable userspace includable kernel headers were bumped to 
2.7, which ain't happening.  That was 2003.  Here's Linus Torvalds in 2004 
shooting down the next stab at it:
http://lwn.net/Articles/113349/

And my salvo in that discussion:
http://www.ussg.iu.edu/hypermail/linux/kernel/0412.0/0866.html

Mazur participated in this and got his head handed to him by Linus Torvalds.  
Random example of the exchange here:
http://www.ussg.iu.edu/hypermail/linux/kernel/0411.3/1708.html

The kernel developers will sort of agree in theory that userspace needs to 
somehow know about the kernel API, but every single specific proposal ever 
brought up to clean up the kernel headers so userspace can more easily 
include them _always_ gets shot down because this work is not necessary to 
compile the linux kernel itself, and is therefore unnecessary churn from 
kernel developers' point of view.  (Userspace be damned.)

> Kernel headers, notwithstanding with 
> what Linus can say, _do_ use __KERNEL__ and are not sanitized enough
> (PTRACE_SETOPTIONS from 2.6 headers produces a binary not working on 2.4
> hosts - you must switch to OLDSETOPTIONS).

A periodic feature of the recurring flamewar is the proposal to remove all 
#ifdef __KERNEL__ notations from the kernel headers.  Here's an example from 
2001...

http://www.ussg.iu.edu/hypermail/linux/kernel/0107.2/0480.html

How serious they are about it varies from year to year...

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
