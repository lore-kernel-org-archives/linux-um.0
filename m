Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CFDon-0003is-Qm for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Oct 2004 08:35:05 -0700
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CFDoF-0006N8-5b for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Oct 2004 08:35:05 -0700
Message-ID: <008b01c4abba$b9e70b90$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <8B6FF516CBA0194AB0996705076B02520F7C4F@ABGEX01E.abg.fsc.net>
Subject: Re: [uml-devel] 2.4.27 + 2.4.26-3um - Kernel panic: handle_trap -
	failed to wait at end of syscall, errno = 4, status = 4479
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Wed, 6 Oct 2004 10:39:52 -0500
To: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

> Yes. That's exactly what happened with my uml 2.6.8.1 with the
> sysemu-patch. And I can see the same problem in the 2.4.26 sysemu-patch,
> that is used in your UML kernel (As the console prinout tells).
> If sysemu isn't used, but the patch is applied, the correct sequence of
> first nullifying a systemcall on the host and than calling
> handle_syscall() in handle_trap() is inverted, what causes the problem.
> In 2.6.9 sysemu is implemented correctly.
> The attached patch (sorry, can't inline it, due to my silly mailer ...)
> will correct the sequence and should let your kernel work with or
> without sysemu support.
> Please note, this is a patch against 2.6.8.1, you might need to adapt it
> a bit.

In my quick testing, this patch appears to have fixed the problem.

Thanks for patch and the fast reply!

-Chris


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
