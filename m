Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AMa5n-0007ql-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 19 Nov 2003 13:42:31 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=0)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AMa5n-00038i-3b
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 19 Nov 2003 13:42:31 -0800
Subject: Re: [uml-devel] skas3-related crash of the week
References: <877k1w85vh.fsf@amaterasu.srvr.nix>
	<3FBBD9CA.2010303@vgertech.com>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <3FBBD9CA.2010303@vgertech.com> (Nuno Silva's message of "Wed,
 19 Nov 2003 20:59:54 +0000")
Message-ID: <87wu9w6nnj.fsf@amaterasu.srvr.nix>
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
Date: Wed, 19 Nov 2003 21:42:24 +0000
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, 19 Nov 2003, Nuno Silva stipulated:
> The odd thing is that this seems to happen only with UMLs running
> redhat. Debian UMLs never showed this...

My UML is running a self-built-from-source stripped-down system with
handwritten boot scripts and firewall; no RH in sight.

So there might be some commonality between that FS and the RH root
filesystems that isn't shared by the Debian ones, but I'm not sure what
it could be.

-- 
`Me, I want exploding spaceships and pulverized worlds and clashes of
 billion-year-old empires *and* competently written sentences.'
                                                    --- Matt Austern


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
