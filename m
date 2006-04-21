Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FX0X1-0000NS-Lj for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Apr 2006 11:39:03 -0700
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FX0X0-00060t-11
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Apr 2006 11:39:03 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [RFC] PATCH 3/4 - Time virtualization :
	PTRACE_SYSCALL_MASK
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
	<20060420090514.GA9452@osiris.boeblingen.de.ibm.com>
	<200604212016.36859.blaisorblade@yahoo.it>
In-Reply-To: <200604212016.36859.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604212038.53323.blaisorblade@yahoo.it>
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
Date: Fri, 21 Apr 2006 20:38:52 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org

On Friday 21 April 2006 20:16, Blaisorblade wrote:
> On Thursday 20 April 2006 11:05, Heiko Carstens wrote:

> The flags could be:
>
> MASK_DEFAULT_TRACE (set the default to 1 for remaining bits)
> MASK_DEFAULT_IGNORE (set the default to 0 for remaining bits)
> MASK_STRICT_VERIFY (return -EINVAL for bits exceeding NR_syscalls and set
> differently than the default).

Actually, for a more elegant API the default should be to check and there 
should be a flag PT_SC_MASK_IGNORE_UNKNOWN_SYSCALL (reworded in some clearer 
way, it doesn't mean to ignore the syscall but the bits - IGNORE should be 
something like "be comprehensive with me when you check". Maybe 
ACCEPT_UNKNOWN_SYSCALL).

> probably with a reasonable prefix to avoid namespace pollution (something
> like "PT_SC_-").

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Bolletta salata? Passa a Yahoo! Messenger with Voice 
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
