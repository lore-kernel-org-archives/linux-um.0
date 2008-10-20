Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rmy@tigress.co.uk>) id 1Krwcm-00044J-0M
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Oct 2008 15:24:52 +0000
Received: from mail.tigress.co.uk ([195.172.168.163] helo=intgat.tigress.co.uk)
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Krwcf-0005ix-7E
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Oct 2008 15:24:51 +0000
From: Ron Yorston <rmy@tigress.co.uk>
Message-Id: <200810201524.m9KFOSPg024776@tiffany.internal.tigress.co.uk>
Date: Mon, 20 Oct 2008 16:24:26 +0100
References: <20081016115012.GK27881@redhat.com>
In-Reply-To: <20081016115012.GK27881@redhat.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [FW: [libvirt] PATCH: Experimental User Mode Linux
	driver for libvirt]
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net, berrange@redhat.com

I've now had a chance to try out the UML driver for libvirt.  My host
platform was CentOS 5 and the guest CentOS 4, with a 2.6.27.2 kernel
configured as 'make defconfig ARCH=um'.  I used uml:///session as an
unprivileged user.

The CVS snapshot tarball on the libvirt.org ftp site was out of date:
use the cvs command to fetch the source.

My host system hadn't been set up for UML before so virsh didn't work
until I'd:

   created the directory ~/.uml (which doesn't exist if you haven't
   run a UML instance yet);

   installed the UML utilities (because libvirt checks that uml_mconsole
   exists, even though it doesn't use it).

Once I'd figured that out I was able to start a virtual machine from
virsh and see it using the list command.

However, connecting to the guest's console was very unreliable (No
console available for domain).  Also, all attempts to shut down the
guest from virsh failed (libvir: Remote error :  socket closed
unexpectedly).  Once that had happened the domain was no longer shown
by the list command.

BTW, is there a way to disconnect from the guest console?

Ron

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
