Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FM4Yu-00062Y-Vh for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Mar 2006 06:43:48 -0800
Received: from zproxy.gmail.com ([64.233.162.197])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FM4Yt-0007me-SZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Mar 2006 06:43:49 -0800
Received: by zproxy.gmail.com with SMTP id z31so171735nzd
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 22 Mar 2006 06:43:46 -0800 (PST)
Message-ID: <44216384.4070709@gmail.com>
From: Mikado <mikado4vn@gmail.com>
Reply-To: mikado4vn@gmail.com
MIME-Version: 1.0
Subject: Re: [uml-devel] Cannot debug UML
References: <44215200.8020708@gmail.com> <20060322135015.GC8115@SteX>
	<44215B8F.6060400@gmail.com> <20060322142820.GF8115@SteX>
In-Reply-To: <20060322142820.GF8115@SteX>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Wed, 22 Mar 2006 21:47:32 +0700
To: stefano.melchior@openlabs.it
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stefano Melchior wrote:
> On Wed, Mar 22, 2006 at 09:13:35PM +0700, Mikado wrote:
> Hi Mikado,
>>> same problem as mine:
>>> ./linux mode=tt debug ubd0=root_fs ubd1=swap mem=128MB eth0=tuntap,,,192.168.0.254
>>>
>>> You wrongly used "mem" option!
>> I've checked my UML's memory, it's exactly 128MB. But thank you, I will
>> follow UML rules.
> 
> what I meant is that you need to follow what man page states: with the
> "mem" option you need to follow the amount of memory (32, 64, 128, ...)
> with only "m" or "M", not "MB".
> Then in some cases it fails when you use mem=128M instead of mem=128m, for
> instance.
> First try without the "mem" option in the command line to see if it works;
> then try with  mem=128M and if it doesn't work, with  mem=128m.
> 
> Otherwise a patch it is needed :(
> 
> Cheers
> 
> SteX

I've tried below cases and the same problem is still there.

./linux mode=tt debug ubd0=root_fs ubd1=swap eth0=tuntap,,,192.168.0.254
./linux mode=tt debug ubd0=root_fs ubd1=swap mem=128m
eth0=tuntap,,,192.168.0.254
./linux mode=tt debug ubd0=root_fs ubd1=swap mem=128M
eth0=tuntap,,,192.168.0.254
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEIWOENWc9T2Wr2JcRAm0GAJ0TD0KOWpUuxOek6nFvGGYcDWvoTACeKFLX
k3B36hpIDLXZ1t/qQFgZ0eo=
=FcYY
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
