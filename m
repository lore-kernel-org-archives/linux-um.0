Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHV5r-0005bN-KE for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Oct 2004 15:26:07 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CHV5n-0005Mh-Tp
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Oct 2004 15:26:07 -0700
Message-Id: <200410122334.i9CNYE3P004286@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Panic while core dumping in tt-mode 
In-Reply-To: Your message of "Thu, 07 Oct 2004 18:13:37 +0200."
	<8B6FF516CBA0194AB0996705076B02520F7C52@ABGEX01E.abg.fsc.net> 
References: <8B6FF516CBA0194AB0996705076B02520F7C52@ABGEX01E.abg.fsc.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Tue, 12 Oct 2004 19:34:14 -0400
To: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

Bodo.Stroesser@fujitsu-siemens.com said:
> No, silly speculation! The real reason is, that in signal delivery no
> fp-status is written and the pointer to the fp-status in the
> signalcontext is set to NULL, if a thread had never used the fp-regs.
> Easy to fix that, but what with the other issues: - In skas fpregs
> never are dumped. (Instead random data is written
>   to core) - dumping the register sets of other threads running in the
> same
>   thread group and mm is not supported - fpxregs are not dumped. They
> could be dumped "if (have_fpx_regs)"
>   (from arch/um/os-Linux/sys-i386/registers.c) Should I try a fix?
> Does it make sense to fix all this? 

It does.  I just haven't bothered because no one has complained about it and
the fp stuff is ugly.

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
