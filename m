Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <berrange@redhat.com>) id 1Ks0AA-0001Tg-VC
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Oct 2008 19:11:34 +0000
Received: from mx1.redhat.com ([66.187.233.31])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ks09w-0003rZ-2A for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Oct 2008 19:11:34 +0000
Date: Mon, 20 Oct 2008 20:11:18 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20081020191118.GA20239@redhat.com>
References: <20081016115012.GK27881@redhat.com>
	<200810201524.m9KFOSPg024776@tiffany.internal.tigress.co.uk>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200810201524.m9KFOSPg024776@tiffany.internal.tigress.co.uk>
Subject: Re: [uml-devel] [FW: [libvirt] PATCH: Experimental User Mode Linux
	driver for libvirt]
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
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
To: Ron Yorston <rmy@tigress.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Oct 20, 2008 at 04:24:26PM +0100, Ron Yorston wrote:
> I've now had a chance to try out the UML driver for libvirt.  My host
> platform was CentOS 5 and the guest CentOS 4, with a 2.6.27.2 kernel
> configured as 'make defconfig ARCH=um'.  I used uml:///session as an
> unprivileged user.
> 
> The CVS snapshot tarball on the libvirt.org ftp site was out of date:
> use the cvs command to fetch the source.
> 
> My host system hadn't been set up for UML before so virsh didn't work
> until I'd:
> 
>    created the directory ~/.uml (which doesn't exist if you haven't
>    run a UML instance yet);

Ah, that's useful info - I would never have noticed that :-)

>    installed the UML utilities (because libvirt checks that uml_mconsole
>    exists, even though it doesn't use it).

Yep, that check is now obsolete, so I'll remove it.

> Once I'd figured that out I was able to start a virtual machine from
> virsh and see it using the list command.
> 
> However, connecting to the guest's console was very unreliable (No
> console available for domain).  Also, all attempts to shut down the
> guest from virsh failed (libvir: Remote error :  socket closed
> unexpectedly).  Once that had happened the domain was no longer shown
> by the list command.

Ok, that's a bug I'll look into.

> BTW, is there a way to disconnect from the guest console?

We follow the telnet defaults, and use 'Ctrl+]' sequence

Thanks for taking the time to test out this initial code, hopefully I'll 
get this polished up and incorporated in the next libvirt release.

Regards,
Daniel
-- 
|: Red Hat, Engineering, London   -o-   http://people.redhat.com/berrange/ :|
|: http://libvirt.org  -o-  http://virt-manager.org  -o-  http://ovirt.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: GnuPG: 7D3B9505  -o-  F3C9 553F A1DA 4AC2 5648 23C1 B3DF F742 7D3B 9505 :|

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
