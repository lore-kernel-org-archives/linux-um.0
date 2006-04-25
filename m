Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FYUP3-0003Up-NJ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Apr 2006 13:44:57 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FYUP2-0000MX-Eb
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Apr 2006 13:44:57 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: [RFC] PATCH 3/4 - Time virtualization :
	PTRACE_SYSCALL_MASK
Message-ID: <20060425183251.GB22977@ccure.user-mode-linux.org>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
	<20060420090514.GA9452@osiris.boeblingen.de.ibm.com>
	<444797F8.6020509@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444797F8.6020509@fujitsu-siemens.com>
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
Date: Tue, 25 Apr 2006 14:32:51 -0400
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Apr 20, 2006 at 04:17:28PM +0200, Bodo Stroesser wrote:
> Shouldn't 'len' better be the number of bits in the mask than the number of 
> chars?

Yup.

> OTOH, I think UML shouldn't send the entire mask, but relevant part only. 
> The missing end is filled with 0xff by host anyway. So it would be
> enough to send the mask up to the highest bit representing a
> syscall, that needs to be executed by host.  (currently, that is
> __NR_gettimeofday). If UML would do so, no more problem results from
> UML having a higher NR_syscall than the host (as long as the new
> syscalls are to be intercepted and executed by UML)

Yup, that was part of the intent of sending in the mask length.

> A greater problem might be a process in UML, that calls an invalid syscall 
> number. AFAICS syscall number (orig_eax) isn't checked before it is
> used in do_syscall_trace to address syscall_mask. This might result
> in a crash. 

Yeah, this needs fixing.

				Heff


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
