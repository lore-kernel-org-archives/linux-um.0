Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A074s-0001n1-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Thu, 18 Sep 2003 15:16:42 -0700
Received: from esperi.demon.co.uk ([194.222.138.8] ident=0)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A074p-00063x-9r
	for User-mode-linux-devel@lists.sourceforge.net; Thu, 18 Sep 2003 15:16:41 -0700
Received: from esperi.demon.co.uk (1000@amaterasu.srvr.nix [192.168.1.14])
	by esperi.demon.co.uk (8.12.10/8.12.10) with ESMTP id h8IMFw7l002791
	for <User-mode-linux-devel@lists.sourceforge.net>; Thu, 18 Sep 2003 23:16:14 +0100
Subject: Re: [uml-devel] Re: redefinition of `struct ptrace_faultinfo' with
 uml-2.4.22-4 + skas3
References: <200309182043.h8IKh3l8028931@hongkong.cs.nmsu.edu>
From: Nix <nix@esperi.demon.co.uk>
In-Reply-To: <200309182043.h8IKh3l8028931@hongkong.cs.nmsu.edu> (Ross
 Combs's message of "Thu, 18 Sep 2003 14:43:03 -0600")
Message-ID: <8765jpu4iz.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 18 Sep 2003 23:15:48 +0100
To: User-mode-linux-devel@lists.sourceforge.net

On Thu, 18 Sep 2003, Ross Combs spake:
> I'm not sure it's TUN/TAP.  The io_thread error above looks like
> the problem I was having which was also sporadic.  Try Steve's patch
> or the merged patch I posted and see if it fixes that part.

Your merged patch seems to have fixed the problem. All is happy now.
Thank you! :)


(Now all I need to do is get TUN/TAP to work at all. `Device not
assigned an IP address', it says, shortly after *printing the damned IP
address out*. Still, that's a matter for -user, I'd say.)

-- 
`I treat debconf as a hostile imperialist agent.  "ALL CONFIGS YOURS
 NOW CONFIGS OURS ARE."' --- Stephen J. Turnbull


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
