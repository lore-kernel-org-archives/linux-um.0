Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CwwMT-00017U-S9 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Feb 2005 21:50:33 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CwwMQ-0007cI-1a for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Feb 2005 21:50:33 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20050113192817.2c0997f1.xraz@rwxr-xr-x.de>
In-Reply-To: <20050113192817.2c0997f1.xraz@rwxr-xr-x.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502040649.42422.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [uml-user] privilege escalation?
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
Date: Fri, 4 Feb 2005 06:49:42 +0100
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net
Cc: Frank 'xraz' Fricke <xraz@rwxr-xr-x.de>

On Thursday 13 January 2005 19:28, Frank 'xraz' Fricke wrote:
> Hi List!

> I built UML from 2.6.10 sources with no additional uml-specific patches.
> My Host is also 2.6.10 with skas. I discovered that when (my) uml is
> running as root _every_ user-id inside the uml may chmod _every_ file on a
> hostfs mount and therfore become root etc...
I've verified that what you say is indeed true and if it happens on other 
releases.

The current result, in fact, is that on both 2.6.9-bb4, 2.6.10 (I actually 
tested onto the -bs5, but there cannot be any difference), what 
you say does happen:

paolo@zion:~ (0)$ chmod 4755 /bin/bash
chmod: changing permissions of `/bin/bash': Operation not permitted

paolo@zion:~ (0)$ chmod 4755 /mnt/host/bin/bash
paolo@zion:~ (0)$ ll /mnt/host/bin/bash

-rwsr-xr-x  1 root root 662724 2004-10-20 02:15 /mnt/host/bin/bash*

> This also happens if the hostfs mount is not the root-fs.
> Is the following behaviour desired?

Surely not, I hope! However, remember that UML is often best run as 
unprivileged user and inside one chroot.

> If not: what could cause it? 

Well, there is little that you can setup about this issue, apart the fact of 
running UML itself as root - I've longly had the idea to add a check to 
prevent UML from being run as root... (or at least give a very verbose 
warning about the potential problems).

That said, this is one UML bug.

> xraz@net3:~$ grep root /proc/mounts
> rootfs / rootfs rw 0 0
> /dev/root / hostfs rw 0 0
>
> xraz@net3:~$ id
> uid=1000(xraz) gid=104(xraz) groups=104(xraz),9997(chefs)
>
> xraz@net3:~$ ls -la /bin/dash
> -rwxr-xr-x  1 root root 83960 Aug 22 20:28 /bin/dash
>
> xraz@net3:~$ chmod 4755 /bin/dash
>
> xraz@net3:~$ ls -la /bin/dash
> -rwsr-xr-x  1 root root 83960 Aug 22 20:28 /bin/dash
>
> xraz@net3:~$ /bin/dash -c id
> uid=1000(xraz) gid=104(xraz) euid=0(root) groups=104(xraz),9997(chefs)

> What is going wrong?
> Because i suppose this is a local error and not an uml-bug i don't yet
> include debuginfo about my uml & system here.

Well, this was not known to me, and surely is not intended... However I don't 
think for now that such info is needed.

That said, it has been longly-known that every user inside UML can create file 
as the user running UML, in hostfs, even if that is root - that is not 
considered to be a problem. I had tried to creat() a file with the S_ISUID 
(i.e. to make it suid) hoping that UML would have created a setuid file (as 
root since I ran UML as root), but the test failed because UML had an 
explicit check for such exploits, which disallowed this.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
