Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIDgH-0003QR-T4 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Apr 2004 14:30:25 -0700
Received: from ice.mudshark.org ([66.119.199.39])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BIDgH-0004xP-Gx for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Apr 2004 14:30:25 -0700
From: Jack Cummings <jack-sf@mudshark.org>
Message-ID: <20040426213018.GM9167@ice.mudshark.org>
Reply-To: jack@mudshark.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] eth0=slirp,,/opt/bin/slirp and 2.6.4-1um
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
Date: Mon, 26 Apr 2004 14:30:18 -0700
To: user-mode-linux-devel@lists.sourceforge.net


I can't get SLiRP working with 2.6.4-1um. ( I had it working with 2.4.22-6um )

Putting SLiRP in debug mode yields:

...
IP stats:
       7 total packets received (0 were unaligned)
       7 with incorrect version
       0 with bad header checksum
...

Any ideas?

--Jack 

--
John ( Jack ) Cummings                     http://mudshark.org/jack 
Key fingerprint: 0774 D073 E386 B70B 6B16  2D2B 1DD8 F8B0 CCF0 FAEE
Now playing on Prime:    Kill The Rock -- Mindless Self Indulgence
Now playing on Remedial: I Think -- Days of the New


-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
