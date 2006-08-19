Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GESIT-0005Kh-PJ for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Aug 2006 07:59:38 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GESIT-0001FD-7A
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Aug 2006 07:59:37 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 19 Aug 2006 16:53:43 +0200
References: <200608171256.57196.peter@fusselt.net>
In-Reply-To: <200608171256.57196.peter@fusselt.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608191653.43641.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Strange behaviour in eth assignments
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Peter Hovorka <peter@fusselt.net>

On Thursday 17 August 2006 12:56, Peter Hovorka wrote:
> Hi,
>
> Jeff told me to drop a note here about the following occurence:
>
> Having compiled a 2.6.16.27 guest kernel with a bb1 patchset, I was
> unable to bring up an eth0 via tun/tap. The kernel runs well, but a
> command line of
>
> ./um2.6.16.27-bb1 ubd0=root_fs ubd1=swap_fs eth0=tuntap,tap112

Do you really mean "tap112"? Nobody I think tried this. I've checked for bugs 
in parsing, but there is none. Please give more details and try a saner 
setting, or elaborate on the reason of this strange setting. At least let's 
determine if changing it causes the bug not to show up.

The other possibility is that something in the guest image (I'm not talking 
about the kernel, but about the rootfs) is calling ifrename. But since some 
kernels don't do that, this is probably not the case.

> mem=100M 
You'd better use a round amount (128 or 96M), I don't know if that's a problem 
but that's strange.

> starts the instance well, but a command inside the instance of 'ifconfig
> -a' results in an 'eth2' device being ready to be brought up. I haven't
> found a way to bring up an 'eth0' or an 'eth1' device inside the
> instance.

> Has anyone had this kind of problem before? I've got no clue about its
> cause, this is what I found out until now:

> - The problem is not (!) present with older Kernels. I did run some
> tests with other Kernels, the following ones failed to bring up eth0:

> 2.6.16.27 with bb1
> 2.6.16.9 with bs2

> The following versions were ok in bringing up eth0 as usual:

> 2.6.14.3 with bs3
> 2.6.13.4 with bs5

> - I haven't tried non-SKAS3 usage yet

> As Jeff told me yesterday that there was possibly no change in that
> region of the UML code, I suspect that any kind of change in the recent
> Kernel sources has caused this artefact to show, sadly I haven't got
> the faintest idea of Kernel development myself, so I'm writing this to
> the devel list.

If this were, say, a buffer overflow, or a bug because tap112 does not exist, 
the source causes "unspecified behaviour", so totally unrelated changes can 
change the actual behaviour to change.

> Kind regards,
> Peter


-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
