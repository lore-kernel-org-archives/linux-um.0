Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CCkgn-0004D6-VT for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Sep 2004 13:04:37 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CCkgl-0003uN-QK
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Sep 2004 13:04:37 -0700
Message-Id: <200409292110.i8TLAeLR003432@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Minor problems with interrupted systemcalls 
In-Reply-To: Your message of "Wed, 29 Sep 2004 18:34:14 +0200."
	<8B6FF516CBA0194AB0996705076B02520F7C3D@ABGEX01E.abg.fsc.net> 
References: <8B6FF516CBA0194AB0996705076B02520F7C3D@ABGEX01E.abg.fsc.net> 
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
Date: Wed, 29 Sep 2004 17:10:40 -0400
To: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

Bodo.Stroesser@fujitsu-siemens.com said:
> A small piece of code regarding SA_ONESHOT should be removed only. In
> 2.6.9 this is done in get_signal_to_deliver(), and since
> get_signal_to_deliver() writes a copy of the corresponding k_sigaction
> into caller's ka_copy, it is a real NOOP. 

Yup, I was looking at that when I was pulling your patch apart, but decided
to leave it alone for now.  I just got rid of it.

On the subject of escaping from UML, I have a exploit lying around from when
I fixed the bug in tt mode, and it fails to escape in skas mode.  I'm not
sure why, though.

I'm also uncertain about sysenter.  It should go through the same ptrace path
as int 0x80, and be intercepted in the same way, and a quick look at entry.S
indicates that it does.  The remaining question is whether syscall restarting
works the same, and I don't see any x86 code looking at the syscall instruction
before deciding to subtract 2 bytes from eip.

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
