Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EPi3E-00047K-1c	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Oct 2005 07:57:52 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EPi35-0005fq-7a
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Oct 2005 07:57:49 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] swap problem
References: <229e70f20510120701r3d5698ccy992263fac8a8082a@mail.gmail.com>
In-Reply-To: <229e70f20510120701r3d5698ccy992263fac8a8082a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510121649.54816.blaisorblade@yahoo.it>
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
Date: Wed, 12 Oct 2005 16:49:54 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Etay Meiri <etay.meiri@gmail.com>

On Wednesday 12 October 2005 16:01, Etay Meiri wrote:
> Hi,
>
> I'm unable to get the swap file working with uml (2.6.13-bs2).
> I created a 512Mb file using dd and formatted it using 'mkswap ./swap'.
> I start uml with the command:

> vmlinux mem=128m ubd0d=root_fs.fc4 ubd1d=swap
> eth0=tuntap,,,10.10.20.6<http://10.10.20.6>
> I've got 8 devices under /dev/ubd and only /dev/ubd/0 seems to be working
> and used for the root partition.
> I see the following messages during the boot:
> .
> .
> [42949373.340000] ubda: unknown partition table
> [42949373.340000] ubdb: unknown partition table
That's normal, as there's no partition table on /dev/ubd0 (or let's call 
it /dev/ubda, it's the same thing). You normally mount /dev/hda1, 
not /dev/hda, but mount /dev/ubda, not /dev/ubda1.
> .
> .
> Enabling swap space: swapon: /dev/ubd/1: No such device or address [FAILED]

> Any idea?
Check the minor number. It should be 16, but there are around root_fs with 
number 1 (which was correct when UBD didn't support partitions). This would 
explain everything in your setup.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
