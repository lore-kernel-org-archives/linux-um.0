Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BmQL8-0008E6-Is for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jul 2004 22:05:26 -0700
Received: from stateless.plumtree.co.nz ([202.89.35.97])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1BmQL8-0001Vz-0Q for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jul 2004 22:05:26 -0700
From: Nicholas Lee <nj.lee@plumtree.co.nz>
Message-ID: <20040719050519.GE23215@stateless>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [alydar@users.sourceforge.net: Re: user-mode-linux:
	upgrade hangs at "NET4: Linux TCP/IP 1.0 for NET4.0"]
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
Date: Mon, 19 Jul 2004 17:05:19 +1200
To: user-mode-linux-devel@lists.sourceforge.net

----- Forwarded message from Allen Chan <alydar@users.sourceforge.net> -----

From: Allen Chan <alydar@users.sourceforge.net>
To: 260111@bugs.debian.org
Subject: Re: user-mode-linux: upgrade hangs at "NET4: Linux TCP/IP 1.0 for NET4.0"
Date: Mon, 19 Jul 2004 00:20:59 -0400
Cc: nic@plumtree.co.nz

Confirming results from Nicolas Lee, the same 2.4.26-2um-1 guest 
kernel that failed earlier with the 2.6.6-1-k7 host kernel with the 
skas3 patch now works if the output from the command line is piped to 
"tee".

This guest kernel also appears to work if on the command line, the 
stdout is redirected to a file, or if it is piped to anything that 
does not require additional user interaction (i.e., piping to "cat" 
works, but piping to "more" caused some other, probably unrelated, 
problems).


----- End forwarded message -----


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
