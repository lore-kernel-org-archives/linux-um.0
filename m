Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FXDXr-0002Ds-Tl for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Apr 2006 01:32:47 -0700
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FXDXq-0001ld-63
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Apr 2006 01:32:48 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [RFC] PATCH 3/4 - Time virtualization :
	PTRACE_SYSCALL_MASK
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
	<200604212016.36859.blaisorblade@yahoo.it>
	<20060422070610.GA9459@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20060422070610.GA9459@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604221032.40232.blaisorblade@yahoo.it>
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
Date: Sat, 22 Apr 2006 10:32:38 +0200
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On Saturday 22 April 2006 09:06, Heiko Carstens wrote:
> > For UML, instead, it's important to set that some peculiar syscalls are
> > not traced, that the mask is 1-extended and that errors are reported.
> >
> > So, I suggest a "flags" parameter for this. Sadly, we're using the
> > ptrace() syscall and there's no 5th argument normally, we could either
> > use it (IIRC some calls use the 5th regs indeed), or pass as "data" a
> > struct with flags and the mask.
> >
> > The flags could be:
> >
> > MASK_DEFAULT_TRACE (set the default to 1 for remaining bits)
> > MASK_DEFAULT_IGNORE (set the default to 0 for remaining bits)
> > MASK_STRICT_VERIFY (return -EINVAL for bits exceeding NR_syscalls and set
> > differently than the default).
> >
> > probably with a reasonable prefix to avoid namespace pollution (something
> > like "PT_SC_-").
>
> You might as well introduce yet another ptrace call which returns the
> number of system calls and for this ptrace call force user space to pass a
> complete bitmap. Sounds easier to me.

I thought to something such, but it's interesting to have auto-complete and I 
didn't like the idea of querying the syscall number... It's true that my 
suggestion wasn't (maybe) that marvellous either.



As a side note, I'd like to inform you that this patch made it to the LWN 
front page... I'm sorry that the article cannot yet be read (it's subscribers 
only for now and until next Thursday):

http://lwn.net/Articles/179829/

The article is positive about the patch and shows interest, on the wave of all 
the various existing virtualization ideas.

> > > The tracing process won't see
> > > any of the non existant syscalls it requested to see anyway.

> > No, you misunderstood the code, it does the opposite very different - the
> > loop

> Looks I missed a few "!"s :)
Don't worry! Bye
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
