Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AMc9e-00039Q-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 19 Nov 2003 15:54:38 -0800
Received: from [81.193.97.234] (helo=puma-vgertech.no-ip.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AMc8z-0008RE-NX
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 19 Nov 2003 15:53:58 -0800
Message-ID: <3FBC02BB.7040305@vgertech.com>
From: Nuno Silva <nuno.silva@vgertech.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] skas3-related crash of the week
References: <877k1w85vh.fsf@amaterasu.srvr.nix>	<3FBBD9CA.2010303@vgertech.com> <87wu9w6nnj.fsf@amaterasu.srvr.nix>
In-Reply-To: <87wu9w6nnj.fsf@amaterasu.srvr.nix>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Wed, 19 Nov 2003 23:54:35 +0000
To: Nix <nix@esperi.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net



Nix wrote:
> On Wed, 19 Nov 2003, Nuno Silva stipulated:
> 
>>The odd thing is that this seems to happen only with UMLs running
>>redhat. Debian UMLs never showed this...
> 
> 
> My UML is running a self-built-from-source stripped-down system with
> handwritten boot scripts and firewall; no RH in sight.
> 
> So there might be some commonality between that FS and the RH root
> filesystems that isn't shared by the Debian ones, but I'm not sure what
> it could be.
> 

Maybe it's just a coincidence... I'll try to reproduce this.

Regards,
Nuno Silva



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
