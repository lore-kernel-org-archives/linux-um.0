Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200412022017.iB2KH4bp003929@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Thu, 02 Dec 2004 15:32:59 +0530."
	<267988DEACEC5A4D86D5FCD780313FBB0238EB81@exch-03.noida.hcltech.com> 
References: <267988DEACEC5A4D86D5FCD780313FBB0238EB81@exch-03.noida.hcltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [uml-user] Telnet problem
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
Date: Thu, 02 Dec 2004 15:17:04 -0500
To: "Adil Mujeeb, Noida" <adilm@hcltech.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

adilm@hcltech.com said:
> sometimes it successfully get the login & password prompt to login on
> uml and sometimes get hanged and login: prompt doesn't appear. 

If only console 1 is enabled in inittab, and you telnet to localhost:9001 twice,
the first one will get the console, and the second will wait until the first
has disconnected.  At that point, you'll see the console 1 login prompt in
the second telnet.

				Jeff



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
