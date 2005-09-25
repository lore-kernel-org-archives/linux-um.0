Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EJabu-00061w-I2	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Sep 2005 10:48:22 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EJabs-0008LX-5p
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Sep 2005 10:48:22 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.6.13.2 + gcc 4.01 link error
References: <229e70f2050924085215707921@mail.gmail.com>
In-Reply-To: <229e70f2050924085215707921@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509251727.00589.blaisorblade@yahoo.it>
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
Date: Sun, 25 Sep 2005 17:27:00 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Etay Meiri <etay.meiri@gmail.com>

On Saturday 24 September 2005 17:52, Etay Meiri wrote:
> Hi,

> I'm trying to compile UML on FC4 using kernel source
> 2.6.13.2<http://2.6.13.2/> and gcc-4.0.1-4.fc4 and getting the following
> errors:

> CC lib/string.o
> CC lib/vsprintf.o
> AR lib/lib.a
> CC [M] lib/crc-ccitt.o
> CC [M] lib/libcrc32c.o
> GEN .version
> CHK include/linux/compile.h

> dnsdomainname: Unknown host
This error is not related to Uml at all and shouldn't give problems in itself, 
but why dnsdomainname doesn't work on your machine? You should probably fix 
that.

> UPD include/linux/compile.h
> CC init/version.o
> LD init/built-in.o
> LD .tmp_vmlinux1

> collect2: ld returned 1 exit status
> KSYM .tmp_kallsyms1.S
> nm: '.tmp_vmlinux1': No such file
> No valid symbol.
> make: *** [.tmp_kallsyms1.S] Error 1

> Any idea?
Read my previous answer, however if you want the fix it's in 2.6.13-bs2 - and 
it was already in 2.6.14 current Linus tree.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
