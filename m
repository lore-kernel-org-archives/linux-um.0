Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GhwT6-0007lz-K1 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Nov 2006 15:04:28 -0800
Received: from newcod.sandelman.ca ([192.139.46.42] helo=cod.sandelman.ca)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GhwT5-0000nt-00
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Nov 2006 15:04:28 -0800
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
In-Reply-To: Message from Jeff Dike <jdike@addtoit.com> of "Wed,
	08 Nov 2006 13:10:25 EST."
	<20061108181025.GC5698@ccure.user-mode-linux.org> 
References: <eilvlj$b5r$1@sea.gmane.org> <eioacp$m4r$1@sea.gmane.org>
	<20061108181025.GC5698@ccure.user-mode-linux.org> 
Date: Wed, 08 Nov 2006 15:04:00 -0800
Message-ID: <10570.1163027040@sandelman.ottawa.on.ca>
Subject: Re: [uml-devel] problems with ifup-a on etch compiled kernels
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>>>>> "Jeff" == Jeff Dike <jdike@addtoit.com> writes:
    Jeff> On Mon, Nov 06, 2006 at 01:44:56PM -0800, Michael Richardson
    Jeff> wrote:
    >> I've tracked this down to a number of places. It looks like the
    >> ifa->ifa_dev is not valid when the notification chain is called:

    Jeff> Can you tell me how to reproduce this, or send me a filesystem
    Jeff> on which this happens?

  Unfortunately, I'm unable to determine what the key element is.
  It fails on my laptop, running identical user-mode-linux code and file
system that works on two devel machine I have.  My laptop is is
etch+2.6.17.4, (but I went back a 2.6.12.3 kernel I had, and it still
failed).  It works on a debian sarge+2.4.30 kernel, and a debian
sarge+2.6.18.16 system.

  I copied my / (not /usr) to the 2.6.18.16, setup a chroot, etc. and 
ran the binaries compiled on my laptop against the file system there. No
fault.

  My laptop while at IETF has a public IP, so if you want I could make
you an account...

- -- 
]            Bear: "Me, I'm just the shape of a bear."          |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Finger me for keys

iQEVAwUBRVJiXYCLcPvd0N1lAQI2pAgAlKjw0034ueE0cP2h4BfXZuJoMDrIplh5
OPUxX/KR7rFSTkSwxgHLYdxJrb/7WanRf72kfU+8FZVZRxs/GDMwYClHnCPW1ufs
IlrarkhKjTZVotE4Xt3CJGGqcjN5eyTDsWzikKDg0Gpkdn8icvZ/qVBFXsbygsMC
cEuPhkytPuPzhhxd4nfs0gW7MYtgkapPajJ/Vi0ADo3umMn4q1mpK3+zhnAm5ilB
frEfZVsojSsL9rmxllf3R05YfOCuDdN4CSAPBsijOZ2wtiR03dGY6aQ+dX1MGMQL
z1SniQSh39cKae/YVHw/pK9amt4iUe1JjrxCB+1wt1XupHzrxODEtA==
=iKlS
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
