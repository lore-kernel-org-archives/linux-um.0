Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aj21J-0005OS-9d for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 11:58:41 -0800
Received: from mx1.elte.hu ([157.181.1.137])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Aj21I-0002i2-SR for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 11:58:41 -0800
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [uml-devel] Re: uml-patch-2.6.0
Message-ID: <20040120195922.GA2022@elte.hu>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<bu0gnf$ief$1@sea.gmane.org> <87y8sbbrup.fsf@bytesex.org>
	<200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org>
	<20040118162112.GA15509@elte.hu>
	<20040118235730.GC21046@ccure.user-mode-linux.org>
	<20040119075351.GA4088@elte.hu> <20040119082805.GA4412@elte.hu>
	<200401201722.i0KHMWDG003192@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401201722.i0KHMWDG003192@ccure.user-mode-linux.org>
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
Date: Tue, 20 Jan 2004 20:59:22 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: Gerd Knorr <kraxel@bytesex.org>, user-mode-linux-devel@lists.sourceforge.net


* Jeff Dike <jdike@addtoit.com> wrote:

> mingo@elte.hu said:
> > unfortunately, this is only the case if the kernel is below 2.5.69 and
> > has 'nptl' in the uname. Otherwise ld.so assumes full NPTL support.
> 
> So, it uses uname to figure out if the kernel has NPTL support?

yes. It goes roughly like this: if the kernel is a 2.4 one and the uname
string [extraversion] includes 'nptl' [and the first 'n' letter has to
be nptl's 'n' ...] then ld.so will try the TLS glibc. On 2.6 kernels,
glibc assumes that all the NPTL functionality is available. [the precise
rules are in the ld.so patches that Fedora's glibc srpm has.]

basically the goal was to 1) be able to boot stock 2.4 kernels and have
NPTL disabled, 2) be able to boot stock 2.6 kernels and have NPTL
enabled, 3) boot 2.4 kernels with the NPTL backport and have NPTL
enabled. (there are also tons of other checks in glibc itself that
selects between various versions of syscalls, eg. modify_ldt has
variants too. LD_ASSUME_KERNEL is taken into account as well.) It's not
simple.

(There was a failed attempt to get API versioning into the kernel to
clean up such interactions - but nothing really good was written so we
stuck with the above mechanism.)

	Ingo


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
