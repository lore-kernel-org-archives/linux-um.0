Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C1XE1-0002eF-I2 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Aug 2004 14:28:33 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C1XE0-0005Ca-TX for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Aug 2004 14:28:33 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Status of SKAS + TLS/NPTL
References: <E1ByqhP-0002h8-1n@sc8-sf-mx1.sourceforge.net>
In-Reply-To: <E1ByqhP-0002h8-1n@sc8-sf-mx1.sourceforge.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Message-Id: <200408292315.31057.blaisorblade_spam@yahoo.it>
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
Date: Sun, 29 Aug 2004 23:15:30 +0200
To: user-mode-linux-devel@lists.sourceforge.net, ralston@stral.net

Alle 13:39, domenica 22 agosto 2004, Michael Ralston ha scritto:
> Just a quick question...
>
> Wondering what the status of running a SKAS host with a user mode linux
> guest with a 2.6.x kernel and Thread-Local-Storage in Libc6...
>
> Does this still crash? If so what needs to be done to get this working?
Yes, it still crashes. I'm going to fix only for 2.6 hosts. Basically we need 
to handle the NPTL syscalls by forwarding them to the host. And only 2.6 
hosts can do what's needed. Anyway, if that is a problem we could fix it 
later.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
