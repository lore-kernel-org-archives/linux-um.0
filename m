Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bwla2-0006Qx-R7 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Aug 2004 10:47:34 -0700
Received: from zrc2s0jx.nortelnetworks.com ([47.103.122.112])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bwla2-00025t-FX for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Aug 2004 10:47:34 -0700
Message-ID: <4120F325.9030401@nortelnetworks.com>
From: Joe Marzot <gmarzot@nortelnetworks.com>
MIME-Version: 1.0
References: <200408132147.i7DLlB2o003883@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: handle_trap - failed to wait at end of syscall [was
	Re: [uml- devel] debugging UML cores]
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
Date: Mon, 16 Aug 2004 13:47:17 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: Joe Marzot <gmarzot@nortelnetworks.com>, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> gmarzot@nortelnetworks.com said:
>  > WSTOPSIG(err) = SIGHUP
>  > does this give any clues...any ideas of what else to look at?
> 
> Do you have any idea how you're making this happen? 

unfortunately not...the UML instance is being used as a test harness for 
a complex set of interacting processes. all sorts of things are going 
prior to the crash.

> The userspace 
> process is
> getting a SIGHUP in the middle of having a system call nullified.  

what does it mean to nullify a system call?

I am also losing whether this is a simulated signal inside the UML 
userspace app or a host signal being delivered to the host resident UML 
usespace thread.

> This is OK
> since a SIGHUP can happen any time if you log out on it or something, but
> I'd like to know exactly what's going on so I can decide what the right 
> reaction
> to it is.

as it is a test harness there are lot's of scripts being invoked - 
shells are being spawned and exited. There may be expect scripts logging 
into the UML and logging out if that's what mean.

> 
> Simplistically, we could just handle it there and ignore it, since UML 
> probably
> got the SIGHUP as well, and will deal with it then.

something like this?

if((err < 0) || !WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP) || 
(WSTOPSIG(status) != SIGHUP)) {
    ....
} else {
    handle_syscall(regs);
}

regards, GSM

> 
>                                 Jeff
> 
> 
> 





-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
