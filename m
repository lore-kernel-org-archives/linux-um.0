Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDA0I-00064t-B3 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Apr 2004 15:34:10 -0700
Received: from oetest.freeswan.org ([205.150.200.166]
	helo=noxmail.sandelman.ottawa.on.ca)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BDA0H-0000NV-ME
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Apr 2004 15:34:09 -0700
Received: from sandelman.ottawa.on.ca (dhcp-61.toronto.xelerance.com
	[209.112.44.61])
	by noxmail.sandelman.ottawa.on.ca (8.11.6p3/8.11.6) with ESMTP id
	i3CMXgq26292
	(using TLSv1/SSLv3 with cipher EDH-RSA-DES-CBC3-SHA (168 bits) verified
	OK) for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 12 Apr 2004 18:34:04 -0400 (EDT)
Received: from sandelman.ottawa.on.ca (marajade [127.0.0.1])
	by sandelman.ottawa.on.ca (8.12.3/8.12.3/Debian-6.6) with ESMTP id
	i3CMUR7L001540
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 12 Apr 2004 18:30:30 -0400
Received: from marajade.sandelman.ottawa.on.ca (mcr@localhost)
	by sandelman.ottawa.on.ca (8.12.3/8.12.3/Debian-6.6) with ESMTP id
	i3CFBSvR007713 for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 12 Apr 2004 11:11:28 -0400
Subject: Re: [uml-devel] Re: A quick humfs HOWTO 
In-Reply-To: Message from Gerd Knorr <kraxel@bytesex.org> 
	of "08 Apr 2004 14:03:49 +0200." <87smfevfq2.fsf@bytesex.org> 
References: <200404080207.i3827rbe009294@ccure.user-mode-linux.org>
	<87smfevfq2.fsf@bytesex.org> 
Message-ID: <7711.1081782688@marajade.sandelman.ottawa.on.ca>
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
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
Date: Mon, 12 Apr 2004 11:11:28 -0400
To: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "Gerd" == Gerd Knorr <kraxel@bytesex.org> writes:
    >> As the readers of uml-devel are aware by now, there is a new
    >> virtual UML filesystem called humfs.  This is a hostfs-like
    >> filesystem which does ownerships right, by separating them from
    >> the actual file, ala umsdos.

    Gerd> Hmm.  Why separate?  These days almost all filesystems in 2.6
    Gerd> support extended attributes, that would be the ideal place for
    Gerd> such metadata IMHO ...

  And, I can serious see running it on top of VFAT or NTFS, or even NFS
or CIFS.

  Why? because I would boot Knoppix in a classroom, then boot a UML on
top of that. The reason for this is to keep the classroom requirements
as simple as possible.

- --
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQHqxn4qHRg3pndX9AQFQNgQArdaZExzV7LhZB+52tZsOurPAi97vmxng
m27EIFQvBZBUoS7JC3BEpseSm4s/cf078wfKt/XfBmgMQMDRXhEoD+9mrx7hBDWB
6da0KQffaRI6PZswMfMc17McyKrZx5biqg39+l/0GsF/fmGVnzI/nYIbo5wzOURv
x+CooX9TNZ4=
=qKba
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
