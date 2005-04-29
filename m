Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRFeg-00012g-4n	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 13:30:38 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DRFed-0003SC-PY	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 13:30:38 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Kernel panic with 2.6.11.6
References: <20050427133324.7alyoigzdn74osg8@www.scgiservices.com>
In-Reply-To: <20050427133324.7alyoigzdn74osg8@www.scgiservices.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504292231.41440.blaisorblade@yahoo.it>
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
Date: Fri, 29 Apr 2005 22:31:41 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>
Cc: Anthony Brock <brocka@sterlingcgi.com>

On Wednesday 27 April 2005 22:33, Anthony Brock wrote:
> I have a 2.6.11.6 guest kernel (with the bs3 patches) running on a 2.6.10
> host kernel (with the SKAS3 v7 patches). The guest distribution is SuSE
> 9.1. For the most part, this UML functions perfectly.
>
> However, since upgrading the guest kernel from a 2.6.9 (bb4 patches)
> version, the guest will periodically abort with something like:
>
> Kernel panic - not syncing: Kernel mode fault at addr 0x19, ip 0x402eb2d2
>
> This only happens when I reconnect to the guest console by attaching to the
> associated "screen" session. Also, it is erradic at best and happens about
> once out of every 15-20 times I reconnect to the screen. Fortunately, the
> apparent trigger (connecting to the console) ensures that I'm aware of the
> crash and able to immediately restart the instance.
>
> Any ideas on how to troubleshoot this? Is it a known issue that I've
> somehow missed on the list? Thanks!
Hmm, maybe this could be related with the sigwinch problem that Jeff has a 
patch for ? It should be in the incrementals page.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
