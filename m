Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A4STk-0003kb-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Tue, 30 Sep 2003 14:56:20 -0700
Received: from shell.blacknet.de ([80.254.131.106])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A4STj-00043Z-JR
	for User-mode-linux-devel@lists.sourceforge.net; Tue, 30 Sep 2003 14:56:19 -0700
From: Goetz Bock <bock@blacknet.de>
Subject: Re: [uml-devel] Networking without tun/tap?
Message-ID: <20030930215459.GB18354@shell.blacknet.de>
References: <014801c3876e$aa712540$6f01a8c0@alex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <014801c3876e$aa712540$6f01a8c0@alex>
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
Date: Tue, 30 Sep 2003 23:54:59 +0200
To: User-mode-linux-devel@lists.sourceforge.net


> I like to install uml on a server running a 2.4.20 kernel but has no tun/tap
> configured in. Module support is disabled. Is their any way to get virtual
> networking running without rebooting the mashine? I have root access to the
> server.
That is definitely a uml-users question, but still:
You can get the uml-switch/daemon networking to work, but than your
uml's will be unable to access the real network. (you could also use the
pcap driver)
--
/"\ Goetz Bock at blacknet dot de  --  secure mobile Linux everNETting
\ /                     (c) 2003 as GNU FDL 1.1
 X   [ 1. Use descriptive subjects - 2. Edit a reply for brevity -  ]
/ \  [ 3. Reply to the list - 4. Read the archive *before* you post ]


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
